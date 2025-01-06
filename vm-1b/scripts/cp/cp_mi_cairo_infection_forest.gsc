#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_forest_surreal;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace forest;

// Namespace forest
// Params 0, eflags: 0x2
// Checksum 0x7afdac9e, Offset: 0x1300
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("infection_forest", &__init__, undefined, undefined);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xeeaaae90, Offset: 0x1338
// Size: 0x42
function __init__() {
    level.var_990970fb = "cin_inf_06_02_bastogne_vign_intro";
    level.var_81285d39 = "cin_inf_06_02_bastogne_vign_sarahintro";
    level.var_d29b7e91 = "cin_inf_06_02_bastogne_vign_playerintro";
    function_49eb92b9();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xfa68e535, Offset: 0x1388
// Size: 0x11a
function init_client_field_callback_funcs() {
    clientfield::register("world", "forest_mortar_index", 1, 3, "int");
    clientfield::register("world", "forest_surreal_exposure", 1, 1, "int");
    clientfield::register("toplayer", "pstfx_frost_up", 1, 1, "counter");
    clientfield::register("toplayer", "pstfx_frost_down", 1, 1, "counter");
    clientfield::register("scriptmover", "wfa_steam_sound", 1, 1, "counter");
    clientfield::register("scriptmover", "cp_infection_world_falls_break_rumble", 1, 1, "counter");
    clientfield::register("scriptmover", "cp_infection_world_falls_away_rumble", 1, 1, "counter");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x22567ce2, Offset: 0x14b0
// Size: 0x5a
function function_e8608118() {
    function_c4110989();
    level thread scene::init(level.var_990970fb);
    level thread scene::init(level.var_81285d39);
    level thread scene::init(level.var_d29b7e91);
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x2ab4c67e, Offset: 0x1518
// Size: 0x15a
function intro_main(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c4110989();
        level thread scene::init(level.var_990970fb);
        level thread scene::init(level.var_81285d39);
        level thread scene::init(level.var_d29b7e91);
        level util::function_d8eaed3d(12);
        load::function_a2995f22();
        exploder::exploder("sgen_server_room_fall");
    }
    level thread function_9346c4d4();
    infection_util::function_1cdb9014();
    if (true) {
        level thread function_5f026a1d();
    }
    level thread function_c064d28b();
    battlechatter::function_d9f49fba(0);
    level thread function_8d291f3b();
    function_6527f47d();
    if (var_74cd64bc) {
        level thread util::clear_streamer_hint();
    }
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest
// Params 4, eflags: 0x0
// Checksum 0x99e47093, Offset: 0x1680
// Size: 0x22
function function_dcdf9aa0(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x13e6cb0, Offset: 0x16b0
// Size: 0x3e2
function function_a683b99a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c4110989();
        level.var_990970fb = "cin_inf_06_02_bastogne_vign_intro";
        level scene::init(level.var_990970fb);
        level scene::init("p7_fxanim_cp_infection_sgen_floor_debris_bundle");
        load::function_a2995f22();
        if (true) {
            level thread function_9901d769();
        }
        level thread function_6c690b17();
        infection_util::function_1cdb9014();
        level thread scene::skipto_end(level.var_990970fb);
        level thread scene::skipto_end("p7_fxanim_cp_infection_sgen_floor_debris_bundle");
        level thread namespace_bed101ee::function_245384ac();
    }
    collectibles::function_93523442("p7_nc_cai_inf_02", -6, (-20, -15, 0));
    collectibles::function_37aecd21();
    objectives::set("cp_level_infection_follow_sarah");
    namespace_f25bd8c8::function_15b29a5a();
    namespace_f25bd8c8::function_c081e535();
    battlechatter::function_d9f49fba(1);
    if (isdefined(0) && 0) {
        num_players = getplayers().size;
        if (num_players == 1) {
            level.var_4aa3708c = 1;
        }
    }
    level thread infection_util::function_3fe1f72("t_sarah_bastogne_objective_", 0, &forest_surreal::function_32a538b9);
    level thread function_80ec016e();
    level thread function_eba8cedd();
    level thread function_14c76b8f();
    level thread function_5656b048();
    level thread function_a5529de2();
    level thread function_c60eab85();
    level thread function_b19769e8();
    level thread function_42caf3d5();
    level thread function_d03371f7();
    level thread function_2c145384("t_2nd_hill_rienforcements", "sp_2nd_hill_reinforcements", "sm_2nd_hill_reinforcements");
    level thread function_2c145384("t_2nd_hill_rienforcements", "sp_2nd_hill_reinforcements_mg_side", "sm_2nd_hill_reinforcements_mg_side");
    level thread function_cc4e1226();
    level thread function_b3e5e4b5();
    level thread function_8d291f3b();
    level thread function_e44e0c61();
    level thread function_6f3844fd();
    level thread function_d165773d();
    level thread function_dfa07cd7("t_mg_turret_1", "bastogne_turret_1", 0, "s_turret_kill", "fx_expl_mg_bullet_impacts01");
    level thread function_dfa07cd7("t_mg_turret_1", "bastogne_turret_2", 0, "s_turret_kill_2", undefined);
    level thread function_247f1864();
    level thread function_afb42159();
    trigger::wait_till("bastogne_complete");
    level notify(#"bastogne_complete");
    level.var_4aa3708c = undefined;
    function_82ddc1bc();
    infection_util::function_aa0ddbc3(0);
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x24b5aba7, Offset: 0x1aa0
// Size: 0x52
function function_80ec016e() {
    var_3c8b682 = getent("t_sarah_bastogne_objective_0", "targetname");
    wait 2;
    if (isdefined(var_3c8b682)) {
        trigger::use("t_sarah_bastogne_objective_0", "targetname");
    }
}

// Namespace forest
// Params 4, eflags: 0x0
// Checksum 0x3dc7b935, Offset: 0x1b00
// Size: 0x92
function cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_f25bd8c8::function_a0f567cb();
    hidemiscmodels("hide_me_from_wolves");
    var_3edb0ecc = getentarray("bastogne_world_falls_away", "script_noteworthy");
    level thread array::run_all(var_3edb0ecc, &show);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x51b41424, Offset: 0x1ba0
// Size: 0x14b
function function_82ddc1bc() {
    var_de34b497 = [];
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        var_1152223f = infection_util::function_9e5ed1ac(a_ai);
        for (i = 0; i < var_1152223f.size; i++) {
            e_ent = var_1152223f[i];
            if (i + 7 >= var_1152223f.size) {
                var_de34b497[var_de34b497.size] = e_ent;
                continue;
            }
            e_ent infection_util::function_e66c8377();
        }
    }
    for (i = 0; i < var_de34b497.size; i++) {
        e_ent = var_de34b497[i];
        e_ent thread function_963f4e85();
    }
    colors::kill_color_replacements();
    a_ai = getaiteamarray("allies");
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            if (!a_ai[i] util::is_hero()) {
                a_ai[i] infection_util::function_5e78ab8c();
            }
        }
    }
    level notify(#"hash_49c1fc58");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x3e19b719, Offset: 0x1cf8
// Size: 0x22
function function_963f4e85() {
    self endon(#"death");
    wait 60;
    self infection_util::function_e66c8377();
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x2e27ea8a, Offset: 0x1d28
// Size: 0x2a
function function_20456e21(str_trigger, var_7ae256a) {
    self thread function_cfcac97e(str_trigger, var_7ae256a);
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x29a43458, Offset: 0x1d60
// Size: 0x32
function function_cfcac97e(str_trigger, var_7ae256a) {
    trigger::wait_till(str_trigger);
    infection_util::function_c8d7e76(var_7ae256a);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x11c2fc69, Offset: 0x1da0
// Size: 0x272
function function_49eb92b9() {
    scene::add_scene_func(level.var_990970fb, &infection_util::function_9f64d290, "play", 0);
    scene::add_scene_func(level.var_990970fb, &function_ae9a24ef, "play");
    scene::add_scene_func(level.var_990970fb, &infection_util::function_9f64d290, "done", 1);
    scene::add_scene_func(level.var_81285d39, &infection_util::function_9f64d290, "play", 0);
    scene::add_scene_func(level.var_81285d39, &infection_util::function_9f64d290, "done", 1);
    scene::add_scene_func(level.var_81285d39, &function_a634a43, "play");
    scene::add_scene_func(level.var_81285d39, &function_1527ec64, "done");
    scene::add_scene_func(level.var_81285d39, &infection_util::function_23e59afd, "play");
    scene::add_scene_func(level.var_81285d39, &infection_util::function_e2eba6da, "done");
    scene::add_scene_func(level.var_81285d39, &function_e9f0e4b1, "play");
    scene::add_scene_func(level.var_81285d39, &function_54e62fbb, "done");
    scene::add_scene_func(level.var_d29b7e91, &function_7d84ce4b, "play");
    scene::add_scene_func(level.var_d29b7e91, &function_44af09ad, "done");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x60c9f520, Offset: 0x2020
// Size: 0x34a
function function_c4110989() {
    infection_util::function_aa0ddbc3(1);
    spawner::add_spawn_function_group("bastogne_friendly_guys", "script_noteworthy", &function_8b13f33c);
    spawner::add_spawn_function_group("bastogne_tiger_tank_1_guys", "script_noteworthy", &infection_util::function_b86426b1);
    spawner::add_spawn_function_group("sm_bastogne_reinforcements", "script_noteworthy", &infection_util::function_b86426b1);
    spawner::add_spawn_function_group("sp_bastogne_battle_start", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_bastogne_reinforcements_left_guys", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_bastogne_reinforcements_right_guys", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_bastogne_reinforcements", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_bastogne_reinforcements_2", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_bastogne_final_guys", "targetname", &function_d307bf85);
    spawner::add_spawn_function_group("sp_wakamole_start", "targetname", &function_8e9f617f, 64, 0);
    spawner::add_spawn_function_group("sp_bastogne_ww2_mg_wakamole", "targetname", &function_8e9f617f, 64, 0);
    spawner::add_spawn_function_group("sp_bastogne_hill_running_group", "targetname", &function_8e9f617f, 512, 0);
    spawner::add_spawn_function_group("sp_bastogne_right_side_runners", "targetname", &function_8e9f617f, 512, 0);
    spawner::add_spawn_function_group("sp_bastogne_right_side_wave2", "targetname", &function_8e9f617f, 512, 0);
    spawner::add_spawn_function_group("sp_bastogne_high_ground_rpg", "targetname", &function_8e9f617f, 64, 1);
    spawner::add_spawn_function_group("sp_left_side_rocks_fallback", "targetname", &function_8e9f617f, 512, 0);
    infection_util::function_c8d7e76("bastogne_reverse_anim");
    function_20456e21("init_bastogne_reverse_anims_2", "bastogne_reverse_anim_2");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x57b80cdd, Offset: 0x2378
// Size: 0x8a
function function_eba8cedd() {
    var_f8447754 = "sm_bastogne_battle_start";
    spawn_manager::enable(var_f8447754);
    e_trigger = getent("t_bastogne_battle_startup", "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    if (spawn_manager::is_enabled(var_f8447754)) {
        spawn_manager::disable(var_f8447754);
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x328579b6, Offset: 0x2410
// Size: 0x13b
function function_6527f47d() {
    level notify(#"hash_1f663a67");
    level thread function_c7c2668();
    array::thread_all(level.players, &infection_util::function_9f10c537);
    if (isdefined(level.var_584f2510)) {
        level thread [[ level.var_584f2510 ]]();
    }
    level thread scene::play(level.var_990970fb);
    level thread scene::play(level.var_d29b7e91);
    level waittill(#"hash_d885008c");
    level scene::play(level.var_81285d39);
    level thread function_88bd9811();
    trigger::use("bastogne_intro_reverse_anims_start", "targetname", undefined, 0);
    infection_util::function_3ea445de();
    util::wait_network_frame();
    infection_util::function_1cdb9014();
    array::thread_all(level.players, &infection_util::function_e905c73c);
    level notify(#"hash_784610e5");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xfe0298c7, Offset: 0x2558
// Size: 0x119
function function_88bd9811() {
    start_time = gettime();
    var_136cddb7 = 0;
    var_203e4c9c = 0;
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > 0.5) {
            if (!var_136cddb7) {
                /#
                    iprintlnbold("<dev string:x28>");
                #/
                var_136cddb7 = 1;
                a_spawners = getentarray("sp_sarah_intro_attacker", "targetname");
                for (i = 0; i < a_spawners.size; i++) {
                    spawner::simple_spawn_single(a_spawners[i]);
                    util::wait_network_frame();
                }
            }
        }
        if (dt > 1) {
            if (!var_203e4c9c) {
                level thread scene::play("bastogne_reverse_anim_intro_1");
                var_203e4c9c = 1;
            }
        }
        if (dt >= 4) {
            return;
        }
        wait 0.05;
    }
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x19a84099, Offset: 0x2680
// Size: 0xc7
function function_e9f0e4b1(a_ents) {
    a_ents["sarah"] thread infection_util::function_9110a277(1);
    level thread util::screen_fade_in(1, "white");
    a_ents["sarah"] waittill(#"hash_74fab6ea");
    a_ents["sarah"] thread infection_util::function_9110a277(0);
    a_ents["sarah"] waittill(#"hash_57d5c381");
    a_ents["sarah"] setignorepauseworld(1);
    level notify(#"hash_8290505");
    a_ents["sarah"] waittill(#"hash_21d2f3");
    level notify(#"hash_b5daeaaf");
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xea5ba95e, Offset: 0x2750
// Size: 0xa
function function_54e62fbb(a_ents) {
    
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x6cad6eea, Offset: 0x2768
// Size: 0x10a
function function_7d84ce4b(a_ents) {
    foreach (player in level.players) {
    }
    level waittill(#"hash_b18bf2cb");
    foreach (player in level.players) {
        player playrumbleonentity("cp_infection_floor_break");
        player shellshock("default", 2.5);
    }
    exploder::stop_exploder("sgen_server_room_fall");
    level thread function_1e925d59();
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xa6667dad, Offset: 0x2880
// Size: 0x1a
function function_44af09ad(a_ents) {
    level thread infection_util::function_efa09886();
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xef9e2585, Offset: 0x28a8
// Size: 0x2a
function function_1e925d59(a_ents) {
    wait 6.35;
    level thread scene::play("p7_fxanim_cp_infection_sgen_floor_debris_bundle");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x3a79ea05, Offset: 0x28e0
// Size: 0x1b2
function function_b3e5e4b5() {
    level thread function_61f7878c();
    function_f47ebfe9("info_bastogne_fallback_1");
    level notify(#"hash_8bede1bc");
    e_volume = getent("t_bastogne_fallback_1_volume", "targetname");
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        a_ai[i] thread function_70228179(e_volume);
    }
    a_players = getplayers();
    if (a_players.size > 1) {
        return;
    }
    function_f47ebfe9("info_bastogne_fallback_2");
    e_volume = getent("t_bastogne_fallback_2_volume", "targetname");
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        a_ai[i] thread function_70228179(e_volume);
    }
    if (spawn_manager::is_enabled("sm_bastogne_reinforcements_left")) {
        spawn_manager::disable("sm_bastogne_reinforcements_left");
    }
    if (spawn_manager::is_enabled("sm_bastogne_reinforcements_right")) {
        spawn_manager::disable("sm_bastogne_reinforcements_right");
    }
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x5709f82b, Offset: 0x2aa0
// Size: 0x142
function function_f47ebfe9(var_e0525846) {
    if (isdefined(level.var_a88de977)) {
        assertmsg("<dev string:x3e>");
    }
    level.var_a88de977 = 1;
    var_912ac17e = getent(var_e0525846, "targetname");
    while (true) {
        var_f04bd8f5 = 0;
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            if (e_player istouching(var_912ac17e)) {
                e_player.var_9a01b8b2 = 1;
            }
            if (isdefined(e_player.var_9a01b8b2)) {
                var_f04bd8f5++;
            }
        }
        if (var_f04bd8f5 >= a_players.size) {
            break;
        }
        wait 0.05;
    }
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i].var_9a01b8b2 = undefined;
    }
    level.var_a88de977 = undefined;
    var_912ac17e delete();
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xbe640e72, Offset: 0x2bf0
// Size: 0x96
function function_70228179(e_volume) {
    self endon(#"death");
    if (isdefined(self.script_string) && self.script_string == "no_fallback") {
        return;
    }
    if (isdefined(self.var_a4652398) && self.var_a4652398) {
        return;
    }
    wait randomfloatrange(0.1, 0.5);
    self.goalradius = -128;
    self setgoal(e_volume);
    self waittill(#"goal");
    self.goalradius = 1024;
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xc6ee70e1, Offset: 0x2c90
// Size: 0xa2
function function_61f7878c() {
    level thread function_4e907fea("s_fallback_wakamole_start", "vol_wakamole_start", "volume_wakamole_fallback");
    level thread function_4e907fea("s_fallback_wakamole_middle", "volume_wakamole_middle", "volume_wakamole_fallback");
    level thread function_4e907fea("s_fallback_wakamole_right_middle", "volume_wakamole_right_middle", "volume_wakamole_fallback");
    level thread function_4e907fea("s_fallback_wakamole_end", "volume_wakamole_end", "volume_wakamole_fallback");
}

// Namespace forest
// Params 3, eflags: 0x0
// Checksum 0x2e8f305c, Offset: 0x2d40
// Size: 0xe9
function function_4e907fea(var_9301f47d, var_613278fd, var_f8ae0594) {
    infection_util::function_8420d8cd(var_9301f47d);
    var_e55e65d5 = getent(var_613278fd, "targetname");
    var_203d6b6c = getent(var_f8ae0594, "targetname");
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            e_ent = a_ai[i];
            if (e_ent istouching(var_e55e65d5)) {
                e_ent thread function_70228179(var_203d6b6c);
            }
        }
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x227c66cc, Offset: 0x2e38
// Size: 0x72
function function_e44e0c61() {
    spawn_manager::enable("sm_friendly_guys_bastogne");
    if (false) {
        return;
    }
    trigger::use("forest_color_start");
    level waittill(#"bastogne_complete");
    spawn_manager::kill("sm_friendly_guys_bastogne");
    spawn_manager::kill("sm_friendly_guys_bastogne_2");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x7503d731, Offset: 0x2eb8
// Size: 0x82
function function_8b13f33c() {
    self.goalradius = 256;
    if (isdefined(1) && 1) {
        num_players = getplayers().size;
        if (num_players > 1) {
            self.script_accuracy = 0.8;
        }
    }
    if (false) {
        self.ignoreall = 1;
        return;
    }
    self.overrideactordamage = &function_cf3cdda5;
    self thread function_59f8a32e();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x320b3fd6, Offset: 0x2f48
// Size: 0x4a
function function_59f8a32e() {
    self endon(#"death");
    e_trigger = getent("color_trigger_3", "targetname");
    e_trigger waittill(#"trigger");
    self.goalradius = 2048;
}

// Namespace forest
// Params 12, eflags: 0x0
// Checksum 0x56a2ac26, Offset: 0x2fa0
// Size: 0xdc
function function_cf3cdda5(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (!isdefined(level.var_c7d84f4f)) {
        level.var_c7d84f4f = 0;
    }
    if (isdefined(eattacker) && isplayer(eattacker)) {
        idamage = 0;
    }
    if (self.health > 0 && idamage >= self.health) {
        if (level.var_c7d84f4f > 3) {
            idamage = self.health - 1;
        } else {
            level.var_c7d84f4f++;
        }
    }
    return idamage;
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xaaec58a3, Offset: 0x3088
// Size: 0x4a
function function_ae9a24ef(a_ents) {
    level waittill(#"hash_b5daeaaf");
    a_ents["friendly_guys_bastogne_01"] dialog::say("hall_congratulations_priv_0", 5);
    level thread function_79ce4af7();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x631a8a74, Offset: 0x30e0
// Size: 0x32
function function_79ce4af7() {
    level dialog::function_13b3b16a("plyr_how_is_this_possible_0", 1);
    level dialog::function_13b3b16a("plyr_this_has_to_be_an_il_0", 6);
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x5b42bf30, Offset: 0x3120
// Size: 0x3a
function function_a634a43(a_ents) {
    var_34c69af9 = a_ents["sarah"];
    if (isdefined(var_34c69af9)) {
        var_34c69af9 setteam("allies");
    }
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0xc64ebe12, Offset: 0x3168
// Size: 0x7a
function function_1527ec64(a_ents) {
    level thread namespace_bed101ee::function_245384ac();
    wait 1;
    var_e9020a33 = getent("sarah_ai", "targetname");
    if (isdefined(var_e9020a33)) {
        infection_util::function_637cd603();
        var_e9020a33 thread dialog::say("hall_follow_me_i_ll_sh_0", 0);
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x90b69918, Offset: 0x31f0
// Size: 0x102
function function_c064d28b() {
    clientfield::set("forest_mortar_index", 1);
    level waittill(#"hash_8290505");
    foreach (player in level.players) {
        player setignorepauseworld(1);
    }
    var_e9020a33 = getent("sarah_ai", "targetname");
    level thread infection_util::function_7b8c138f(var_e9020a33, 2000, 18);
    setpauseworld(1);
    level waittill(#"hash_b5daeaaf");
    setpauseworld(0);
    level waittill(#"hash_784610e5");
    level thread function_6c690b17();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xef20ca24, Offset: 0x3300
// Size: 0x122
function function_6c690b17() {
    clientfield::set("forest_mortar_index", 2);
    e_trigger = getent("t_background_mortar_3", "targetname");
    e_trigger waittill(#"trigger");
    clientfield::set("forest_mortar_index", 3);
    e_trigger = getent("t_background_mortar_4", "targetname");
    e_trigger waittill(#"trigger");
    clientfield::set("forest_mortar_index", 4);
    e_trigger = getent("t_background_mortar_5", "targetname");
    e_trigger waittill(#"trigger");
    clientfield::set("forest_mortar_index", 5);
    e_trigger = getent("t_background_mortar_6", "targetname");
    e_trigger waittill(#"trigger");
    clientfield::set("forest_mortar_index", 6);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x52549a3, Offset: 0x3430
// Size: 0x81
function function_c7c2668() {
    a_ents = getentarray("sp_falling_intro_enemy", "targetname");
    for (i = 0; i < a_ents.size; i++) {
        e_ent = spawner::simple_spawn_single(a_ents[i], &function_f3343cbc);
        util::wait_network_frame();
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x561f1338, Offset: 0x34c0
// Size: 0x59
function function_bbaffb87() {
    a_ents = getentarray("sp_falling_intro_enemy_ai", "targetname");
    for (i = 0; i < a_ents.size; i++) {
        a_ents[i] delete();
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xe735918c, Offset: 0x3528
// Size: 0x5a
function function_f3343cbc() {
    self endon(#"death");
    self.goalradius = 64;
    self ai::set_ignoreall(1);
    level waittill(#"hash_8290505");
    self dodamage(self.health + 100, self.origin);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xd1629f8c, Offset: 0x3590
// Size: 0x52
function function_5f026a1d() {
    level waittill(#"hash_1f663a67");
    level thread function_3770504e("bastogne_large_falling_piece_6", 4);
    level thread function_3770504e("bastogne_large_falling_piece_2", 10);
    level waittill(#"hash_b5daeaaf");
    level thread function_9901d769();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x7dbd521, Offset: 0x35f0
// Size: 0xa2
function function_9901d769() {
    initial_delay = 2;
    level thread function_3770504e("bastogne_large_falling_piece_2", initial_delay + 2);
    level thread function_3770504e("bastogne_large_falling_piece_4", initial_delay + 5);
    level thread function_3770504e("bastogne_large_falling_piece_3", initial_delay + 6);
    level thread function_3770504e("bastogne_large_falling_piece_6", initial_delay + 10);
    level thread function_3770504e("bastogne_large_falling_piece_1", initial_delay + 13);
    level thread function_3770504e("bastogne_large_falling_piece_5", initial_delay + 16);
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x7d4d4dde, Offset: 0x36a0
// Size: 0x1fa
function function_3770504e(struct_name, var_d5107b6) {
    s_struct = struct::get(struct_name, "targetname");
    a_debris = getentarray("bastogne_large_debris", "targetname");
    closest_dist = 1e+06;
    e_closest = a_debris[0];
    for (i = 0; i < a_debris.size; i++) {
        dist = distance(s_struct.origin, a_debris[i].origin);
        if (dist < closest_dist) {
            closest_dist = dist;
            e_closest = a_debris[i];
        }
    }
    v_offset = (0, 0, 2000);
    e_closest moveto(e_closest.origin + v_offset, 0.05);
    e_closest hide();
    wait var_d5107b6;
    e_closest show();
    e_closest playsound("evt_metal_incoming");
    e_closest moveto(e_closest.origin - v_offset, 1);
    wait 1;
    var_ab2048f4 = 0.5;
    var_f92960c = randomfloatrange(1, 1.2);
    var_dd43e5e9 = 3000;
    earthquake(var_ab2048f4, var_f92960c, e_closest.origin, var_dd43e5e9);
    e_closest playsound("evt_metal_impact");
}

/#

    // Namespace forest
    // Params 0, eflags: 0x0
    // Checksum 0xed232981, Offset: 0x38a8
    // Size: 0x2e9
    function function_8e09156() {
        while (true) {
            data = spawnstruct();
            while (true) {
                var_cef024c7 = -56;
                var_5900d140 = 80;
                data.ai_types = [];
                data.var_4fb6d85a = [];
                data.hud = [];
                e_player = getplayers()[0];
                a_ai = getaiteamarray("<dev string:x8f>");
                for (i = 0; i < a_ai.size; i++) {
                    found = 0;
                    e_ent = a_ai[i];
                    if (isdefined(e_ent.targetname)) {
                        for (j = 0; j < data.ai_types.size; j++) {
                            if (data.ai_types[j] == e_ent.targetname) {
                                data.var_4fb6d85a[j]++;
                                found = 1;
                                break;
                            }
                        }
                    }
                    if (!found && isdefined(e_ent.targetname)) {
                        data.ai_types[data.ai_types.size] = e_ent.targetname;
                        data.var_4fb6d85a[data.var_4fb6d85a.size] = 1;
                        hud_elem = infection_util::function_e02dee76(e_player, "<dev string:x94>", var_cef024c7, var_5900d140, 1);
                        if (issubstr(e_ent.targetname, "<dev string:x95>")) {
                            hud_elem.color = (0, 1, 0);
                        } else if (issubstr(e_ent.targetname, "<dev string:x9b>")) {
                            hud_elem.color = (1, 0, 0);
                        }
                        data.hud[data.hud.size] = hud_elem;
                        var_5900d140 += 12;
                    }
                }
                for (i = 0; i < data.ai_types.size; i++) {
                    hud_elem = data.hud[i];
                    str_text = data.ai_types[i] + "<dev string:x9f>" + data.var_4fb6d85a[i];
                    hud_elem settext(str_text);
                }
                wait 0.1;
                for (i = 0; i < data.hud.size; i++) {
                    data.hud[i] destroy();
                }
            }
            wait 0.05;
        }
    }

#/

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xeef1ce98, Offset: 0x3ba0
// Size: 0x10a
function function_9346c4d4() {
    level.var_6ef9dbc7 = [];
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break01";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break02";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break03";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break04";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break05";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break06";
    level.var_6ef9dbc7[level.var_6ef9dbc7.size] = "fxanim_tree_break07";
    for (i = 0; i < level.var_6ef9dbc7.size; i++) {
        level thread scene::init(level.var_6ef9dbc7[i], "targetname");
        util::wait_network_frame();
    }
    level.var_d005d08 = 1;
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x6c78749a, Offset: 0x3cb8
// Size: 0x64
function function_6f3844fd() {
    if (!isdefined(level.var_d005d08)) {
        function_9346c4d4();
    }
    for (i = 0; i < level.var_6ef9dbc7.size; i++) {
        level thread function_f3fafb74(level.var_6ef9dbc7[i], 1000);
    }
    level waittill(#"hash_49c1fc58");
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x6851ebc8, Offset: 0x3d28
// Size: 0x9a
function function_f3fafb74(str_targetname, trigger_radius) {
    level endon(#"hash_49c1fc58");
    s_tree = struct::get(str_targetname, "targetname");
    while (true) {
        dist = infection_util::function_9f0ad974(s_tree.origin);
        if (dist < trigger_radius) {
            break;
        }
        wait 0.1;
    }
    level thread scene::play(str_targetname, "targetname");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x5939aa41, Offset: 0x3dd0
// Size: 0x6a
function function_14c76b8f() {
    spawn_manager::enable("sm_wakamole_start");
    e_trigger = getent("bastogne_intro_mortar_group_2", "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    spawn_manager::enable("sm_bastogne_ww2_mg_wakamole");
}

// Namespace forest
// Params 2, eflags: 0x0
// Checksum 0x239ef6e4, Offset: 0x3e48
// Size: 0x56
function function_8e9f617f(var_84fffedf, var_a4652398) {
    self endon(#"death");
    self function_d307bf85();
    if (var_a4652398) {
        self.var_a4652398 = 1;
    }
    self.goalradius = 64;
    self waittill(#"goal");
    self.goalradius = var_84fffedf;
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x2b43265, Offset: 0x3ea8
// Size: 0x8a
function function_5656b048() {
    level endon(#"bastogne_complete");
    e_trigger = getent("t_bastogne_hill_running_group", "targetname");
    e_trigger waittill(#"trigger");
    /#
        iprintlnbold("<dev string:xa3>");
    #/
    spawn_manager::enable("sm_bastogne_hill_running_group");
    util::delay_notify(3, "forest_sniper_spawn");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x124248c1, Offset: 0x3f40
// Size: 0x72
function function_42caf3d5() {
    level endon(#"bastogne_complete");
    e_trigger = getent("t_bastogne_right_side_runners", "targetname");
    e_trigger waittill(#"trigger");
    /#
        iprintlnbold("<dev string:xbf>");
    #/
    spawn_manager::enable("sm_bastogne_right_side_runners");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xfb8dfb6d, Offset: 0x3fc0
// Size: 0x72
function function_d03371f7() {
    level endon(#"bastogne_complete");
    e_trigger = getent("t_bastogne_right_side_wave2", "targetname");
    e_trigger waittill(#"trigger");
    /#
        iprintlnbold("<dev string:xdb>");
    #/
    spawn_manager::enable("sm_bastogne_right_side_wave2");
}

// Namespace forest
// Params 3, eflags: 0x0
// Checksum 0xfa27ab35, Offset: 0x4040
// Size: 0xa2
function function_2c145384(str_trigger, var_a9ea049a, var_f3a8e7d6) {
    level endon(#"bastogne_complete");
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill(#"trigger");
    /#
        iprintlnbold("<dev string:xf5>");
    #/
    spawner::add_spawn_function_group(var_a9ea049a, "targetname", &function_8e9f617f, 512, 0);
    spawn_manager::enable(var_f3a8e7d6);
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xaedb8208, Offset: 0x40f0
// Size: 0xa2
function function_cc4e1226() {
    e_trigger = getent("t_2nd_hill_rienforcements", "targetname");
    e_trigger waittill(#"trigger");
    spawn_manager::enable("sm_bastogne_final_guys");
    infection_util::function_8420d8cd("s_turret_kill_2");
    if (spawn_manager::is_enabled("sm_bastogne_final_guys")) {
        spawn_manager::disable("sm_bastogne_final_guys");
    }
    level thread namespace_bed101ee::function_bf117816();
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xb3f6c047, Offset: 0x41a0
// Size: 0x3a
function function_a5529de2() {
    level waittill(#"forest_sniper_spawn");
    spawn_manager::enable("sm_bastogne_rocks_sniper");
    infection_util::function_3c363cb3("sniper_infection");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x588e976d, Offset: 0x41e8
// Size: 0x3a
function function_c60eab85() {
    level waittill(#"hash_8bede1bc");
    spawn_manager::enable("sm_bastogne_high_ground_rpg");
    infection_util::function_3c363cb3("rpg_ridge");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x1da7a062, Offset: 0x4230
// Size: 0x52
function function_b19769e8() {
    e_trigger = getent("t_left_side_rocks_fallback", "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
        spawn_manager::enable("sm_left_side_rocks_fallback");
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x340fd081, Offset: 0x4290
// Size: 0x2a
function function_d307bf85() {
    if (isdefined(level.var_4aa3708c) && level.var_4aa3708c) {
        self.script_accuracy = 0.8;
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x7dcdef94, Offset: 0x42c8
// Size: 0xa2
function function_d165773d() {
    scene::init("p7_fxanim_cp_infection_reverse_rocks_01_bundle");
    util::wait_network_frame();
    scene::init("p7_fxanim_cp_infection_reverse_rocks_02_bundle");
    e_trigger = getent("t_reverse_rocks_01_bundle", "targetname");
    e_trigger waittill(#"trigger");
    level thread scene::play("p7_fxanim_cp_infection_reverse_rocks_02_bundle");
    level thread scene::play("p7_fxanim_cp_infection_reverse_rocks_01_bundle");
}

// Namespace forest
// Params 5, eflags: 0x0
// Checksum 0xd6b6c990, Offset: 0x4378
// Size: 0x15a
function function_dfa07cd7(str_trigger, var_eb446787, var_516487a, var_48e51237, var_2a33a821) {
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill(#"trigger");
    e_turret = vehicle::simple_spawn_single(var_eb446787);
    e_turret.turret_index = 0;
    e_turret turret::set_burst_parameters(0.75, 1.5, 0.25, 0.75, e_turret.turret_index);
    e_turret turret::enable(0, 1);
    if (var_516487a) {
        e_turret thread function_e10ca4e3();
    } else {
        e_turret turret::enable_auto_use(1);
    }
    e_turret thread function_4f4119d3();
    if (isdefined(var_48e51237)) {
        infection_util::function_8420d8cd(var_48e51237);
        e_turret turret::enable_auto_use(0);
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x5ee6ef6b, Offset: 0x44e0
// Size: 0x14d
function function_4f4119d3() {
    e_volume = getent("volume_turret_introduction", "targetname");
    while (true) {
        b_has_user = turret::does_have_user(self.turret_index);
        if (b_has_user) {
            a_players = getplayers();
            for (i = 0; i < a_players.size; i++) {
                e_player = a_players[i];
                if (e_player istouching(e_volume)) {
                    v_dir = vectornormalize(self.origin - e_player.origin);
                    v_forward = anglestoforward(e_player.angles);
                    dp = vectordot(v_dir, v_forward);
                    if (dp > 0.95) {
                        exploder::exploder("fx_expl_mg_bullet_impacts01");
                        return;
                    }
                }
            }
        }
        wait 0.05;
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x59d444ec, Offset: 0x4638
// Size: 0xd1
function function_e10ca4e3() {
    level endon(#"bastogne_complete");
    var_cf0db380 = undefined;
    turret_mode = "looking_for_gunner";
    while (true) {
        switch (turret_mode) {
        case "looking_for_gunner":
            var_cf0db380 = function_a3606244();
            turret_mode = "gunner_running_to_turret";
            break;
        case "gunner_running_to_turret":
            alive = self function_4ba17e6e(var_cf0db380);
            if (alive) {
                turret_mode = "gunner_manning_turret";
            } else {
                turret_mode = "looking_for_gunner";
            }
            break;
        case "gunner_manning_turret":
            self function_aa881573(var_cf0db380);
            turret_mode = "looking_for_gunner";
            break;
        }
        wait 0.05;
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0xf1ddb8d0, Offset: 0x4718
// Size: 0xc7
function function_a3606244() {
    e_closest = undefined;
    while (true) {
        a_ai = getaiteamarray("axis");
        closest_dist = 99999.9;
        if (isdefined(a_ai)) {
            for (i = 0; i < a_ai.size; i++) {
                dist = distance(a_ai[i].origin, self.origin);
                if (dist < 2500 && dist < closest_dist) {
                    closest_dist = dist;
                    e_closest = a_ai[i];
                }
            }
        }
        if (isdefined(e_closest)) {
            break;
        }
        wait 0.5;
    }
    return e_closest;
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x20b1c9a2, Offset: 0x47e8
// Size: 0x8c
function function_4ba17e6e(var_cf0db380) {
    self.var_be0f3878 = undefined;
    var_cf0db380 thread function_ca1e4e64(self);
    while (true) {
        if (!isalive(var_cf0db380)) {
            return false;
        }
        if (isdefined(self.var_be0f3878)) {
            break;
        }
        wait 0.05;
    }
    self turret::enable(0, 1);
    var_cf0db380 vehicle::get_in(self, "driver", 1);
    return true;
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x5d3e2666, Offset: 0x4880
// Size: 0x52
function function_ca1e4e64(e_turret) {
    self endon(#"death");
    self.goalradius = 64;
    self setgoal(e_turret.origin);
    self waittill(#"goal");
    e_turret.var_be0f3878 = 1;
}

// Namespace forest
// Params 1, eflags: 0x0
// Checksum 0x2863d7e6, Offset: 0x48e0
// Size: 0x41
function function_aa881573(var_cf0db380) {
    while (isalive(var_cf0db380)) {
        wait 0.01;
    }
    self turret::disable(0);
    self.var_be0f3878 = undefined;
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x166961e8, Offset: 0x4930
// Size: 0xa2
function function_247f1864() {
    wait 1;
    infection_util::function_3c363cb3("bastogne_intro");
    e_trigger = getent("t_vo_multiple_routes", "targetname");
    e_trigger waittill(#"trigger");
    infection_util::function_3c363cb3("multiple_routes");
    e_trigger = getent("t_vo_regroup_halftracks", "targetname");
    e_trigger waittill(#"trigger");
    infection_util::function_3c363cb3("regroup_halftracks");
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x1d584322, Offset: 0x49e0
// Size: 0x103
function function_8d291f3b() {
    if (isdefined(level.var_5b47055f)) {
        return;
    }
    level.var_5b47055f = 1;
    var_1105cabf = struct::get_array("bastogne_frozen_soldier", "targetname");
    foreach (scriptbundle in var_1105cabf) {
        if (math::cointoss()) {
            var_76c674e0 = util::spawn_model("c_ger_winter_soldier_1");
        } else {
            var_76c674e0 = util::spawn_model("c_ger_winter_soldier_2");
        }
        var_76c674e0.script_objective = "forest";
        level thread scene::play(scriptbundle.scriptbundlename, var_76c674e0);
        util::wait_network_frame();
    }
}

// Namespace forest
// Params 0, eflags: 0x0
// Checksum 0x48327bb6, Offset: 0x4af0
// Size: 0x72
function function_afb42159() {
    trigger::wait_till("t_checkpoint_bastogne_mid", "targetname");
    savegame::checkpoint_save();
    var_7d116593 = struct::get("s_forest_surreal_lighting_hint", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
}

