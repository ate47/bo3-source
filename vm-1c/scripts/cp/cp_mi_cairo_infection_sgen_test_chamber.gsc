#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/player_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace sgen_test_chamber;

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xc6f15873, Offset: 0x730
// Size: 0x44
function main() {
    /#
        iprintlnbold("<dev string:x28>");
    #/
    init_client_field_callback_funcs();
    function_7b244c18();
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x8efa7230, Offset: 0x780
// Size: 0xf4
function init_client_field_callback_funcs() {
    clientfield::register("world", "sgen_test_chamber_pod_graphics", 1, 1, "int");
    clientfield::register("world", "sgen_test_chamber_time_lapse", 1, 1, "int");
    clientfield::register("scriptmover", "sgen_test_guys_decay", 1, 1, "int");
    clientfield::register("world", "fxanim_hive_cluster_break", 1, 1, "int");
    clientfield::register("world", "fxanim_time_lapse_objects", 1, 1, "int");
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x88401077, Offset: 0x880
// Size: 0x154
function function_7b244c18() {
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh090", &function_fd16dd41, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh140", &function_ee093b22, "done");
    scene::add_scene_func("cin_inf_05_taylorinfected_3rd_sh010", &function_6b291c0d, "play");
    scene::add_scene_func("cin_inf_05_taylorinfected_3rd_sh080", &function_6089d98, "done");
    scene::add_scene_func("cin_inf_04_02_sarah_vign_01", &function_11c1cade, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh140", &function_eabb935c, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_c43d862, "play");
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x80a263a, Offset: 0x9e0
// Size: 0x92
function function_c467cbf() {
    foreach (player in level.players) {
        player playrumbleonentity("damage_heavy");
    }
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0xc2defd5d, Offset: 0xa80
// Size: 0x1a
function function_ee093b22(var_38fa6e84) {
    level notify(#"hash_b4468c2e");
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x6e8ea94c, Offset: 0xaa8
// Size: 0x24
function function_eabb935c(var_38fa6e84) {
    level util::function_d8eaed3d(6);
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0xbd654854, Offset: 0xad8
// Size: 0x64
function function_c43d862(var_38fa6e84) {
    level waittill(#"hash_ee361e18");
    if (isdefined(var_38fa6e84["wire"])) {
        e_wire = var_38fa6e84["wire"];
        e_wire setmodel("p7_sgen_dni_testing_pod_wires_01_off");
    }
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x62ac1071, Offset: 0xb48
// Size: 0x152
function function_fd16dd41(var_38fa6e84) {
    var_a9aa9f1c = getentarray("inf_test_chamber_flashlight", "script_noteworthy");
    if (isdefined(var_38fa6e84["flashlight"])) {
        e_origin = var_38fa6e84["flashlight"] gettagorigin("tag_origin");
        foreach (var_e0a1e3dd in var_a9aa9f1c) {
            var_e0a1e3dd.origin = var_38fa6e84["flashlight"] gettagorigin("tag_light_position");
            var_e0a1e3dd linkto(var_38fa6e84["flashlight"], "tag_origin");
        }
    }
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x467bd71, Offset: 0xca8
// Size: 0x3c
function function_a29f7cbd() {
    level scene::init("cin_inf_04_humanlabdeath_3rd_sh010");
    level util::function_d8eaed3d(9);
}

// Namespace sgen_test_chamber
// Params 2, eflags: 0x1 linked
// Checksum 0x6c06b18f, Offset: 0xcf0
// Size: 0x30c
function function_c568c95b(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<dev string:x40>");
    #/
    level clientfield::set("sgen_test_chamber_pod_graphics", 1);
    if (var_74cd64bc) {
        load::function_73adcefc();
        array::thread_all(level.players, &infection_util::function_9f10c537);
        function_a29f7cbd();
        level util::streamer_wait();
        load::function_a2995f22();
    }
    level thread namespace_eccdd5d1::function_6ef2bfc6();
    level thread util::delay("start_fade", undefined, &util::screen_fade_in, 2, "white");
    level thread util::delay("fx_explosion", undefined, &function_c467cbf);
    level thread util::delay("fx_explosion", undefined, &clientfield::set, "fxanim_hive_cluster_break", 0);
    level clientfield::set("fxanim_hive_cluster_break", 1);
    array::thread_all(level.players, &clientfield::increment_to_player, "stop_post_fx", 1);
    level thread function_7711faaf();
    if (isdefined(level.var_af6a0d17)) {
        level thread [[ level.var_af6a0d17 ]]();
    }
    level scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh010", &function_e3124fd9, "skip_completed");
    level scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh020", &function_e3124fd9, "skip_completed");
    level scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh030", &function_e3124fd9, "skip_completed");
    level scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh040", &function_e3124fd9, "skip_completed");
    level thread scene::play("cin_inf_04_humanlabdeath_3rd_sh010");
    level waittill(#"hash_b4468c2e");
    skipto::function_be8adfb8("sgen_test_chamber");
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x33735771, Offset: 0x1008
// Size: 0x84
function function_e3124fd9(a_ents) {
    util::screen_fade_out(0);
    level util::function_7d553ac6();
    level util::streamer_wait();
    util::screen_fade_in(0);
    level util::function_f7beb173();
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x648bac69, Offset: 0x1098
// Size: 0x6c
function function_7711faaf() {
    videostart("cp_infection_env_dnimainmonitor", 1);
    level waittill(#"fx_explosion");
    videostop("cp_infection_env_dnimainmonitor");
    videostart("cp_infection_env_timelapse_fail", 1);
}

/#

    // Namespace sgen_test_chamber
    // Params 4, eflags: 0x1 linked
    // Checksum 0xcedeec44, Offset: 0x1110
    // Size: 0x44
    function function_7985eb71(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
        iprintlnbold("<dev string:x57>");
    }

#/

// Namespace sgen_test_chamber
// Params 2, eflags: 0x1 linked
// Checksum 0x40969d9f, Offset: 0x1160
// Size: 0x144
function function_21e8c919(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<dev string:x6e>");
    #/
    if (!var_74cd64bc) {
        videostop("cp_infection_env_timelapse_fail");
    }
    if (var_74cd64bc) {
        load::function_73adcefc();
        level util::function_d8eaed3d(9);
        array::thread_all(level.players, &infection_util::function_9f10c537);
        load::function_a2995f22();
    }
    videostart("cp_infection_env_raventimelapse_ravens", 1);
    level thread function_b99b8b97();
    level thread function_27249631();
    level waittill(#"hash_d469a3e9");
    level thread util::clear_streamer_hint();
    skipto::function_be8adfb8("time_lapse");
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xc5d161f, Offset: 0x12b0
// Size: 0xb4
function function_b99b8b97() {
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_888bbd49, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_d469a3e9, "done");
    level thread scene::play("cin_inf_04_humanlabdeath_3rd_sh150");
    level waittill(#"hash_c6e56c65");
    wait 1;
    clientfield::set("sgen_test_chamber_time_lapse", 1);
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x7f6003f4, Offset: 0x1370
// Size: 0x9c
function function_888bbd49(a_ents) {
    /#
        iprintlnbold("<dev string:x7e>");
    #/
    level thread function_a2b1036();
    var_bc282e3d = a_ents["decayedman"];
    var_bc282e3d thread function_ccc1a59f();
    level waittill(#"hash_5e798509");
    util::screen_fade_out(0, "white");
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x60d6e322, Offset: 0x1418
// Size: 0x164
function function_ccc1a59f() {
    level endon(#"hash_d469a3e9");
    self waittill(#"hash_21b0eee7");
    level notify(#"hash_c6e56c65");
    wait 1;
    self setmodel("c_spc_decayman_stage1_tout_fb");
    self clientfield::set("sgen_test_guys_decay", 1);
    wait 1;
    self setmodel("c_spc_decayman_stage2_tin_fb");
    wait 1;
    self setmodel("c_spc_decayman_stage2_fb");
    wait 1;
    self setmodel("c_spc_decayman_stage2_tout_fb");
    wait 1;
    self setmodel("c_spc_decayman_stage3_tin_fb");
    wait 1;
    self setmodel("c_spc_decayman_stage3_fb");
    wait 1.5;
    self setmodel("c_spc_decayman_stage4_fb");
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x524a45b8, Offset: 0x1588
// Size: 0x2c
function function_d469a3e9(a_ents) {
    level notify(#"hash_d469a3e9");
    level thread util::clear_streamer_hint();
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x566af97b, Offset: 0x15c0
// Size: 0x24
function function_27249631() {
    level thread clientfield::set("fxanim_time_lapse_objects", 1);
}

// Namespace sgen_test_chamber
// Params 4, eflags: 0x1 linked
// Checksum 0xac2137d9, Offset: 0x15f0
// Size: 0x5c
function function_f7f4cbd3(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("<dev string:x8b>");
    #/
    videostop("cp_infection_env_raventimelapse_ravens");
}

// Namespace sgen_test_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xf82f6bb1, Offset: 0x1658
// Size: 0x24
function function_a2b1036() {
    level scene::init("cin_inf_04_02_sarah_vign_01");
}

// Namespace sgen_test_chamber
// Params 2, eflags: 0x1 linked
// Checksum 0x6672dc28, Offset: 0x1688
// Size: 0x22c
function function_621e0975(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<dev string:x9b>");
    #/
    level util::function_d8eaed3d(3);
    videostart("cp_infection_env_timelapse_fail", 1);
    if (var_74cd64bc) {
        util::screen_fade_out(0, "white");
        array::thread_all(level.players, &infection_util::function_9f10c537);
    }
    level thread util::screen_fade_in(1.5, "white");
    if (isdefined(level.var_f31e5abc)) {
        level thread [[ level.var_f31e5abc ]]();
    }
    level scene::play("cin_inf_04_02_sarah_vign_01");
    if (isdefined(level.var_1852dcea)) {
        level thread [[ level.var_1852dcea ]]();
    }
    level thread namespace_eccdd5d1::function_e0a3aca4();
    level thread scene::play("cin_inf_05_taylorinfected_3rd_sh010");
    level waittill(#"hash_90395238");
    if (scene::function_b1f75ee9()) {
        util::screen_fade_out(0, "black", "end_level_fade");
    } else {
        util::screen_fade_out(1, "black", "end_level_fade");
        level clientfield::set("sndIGCsnapshot", 4);
    }
    level thread util::clear_streamer_hint();
    skipto::function_be8adfb8("cyber_soliders_invest");
}

// Namespace sgen_test_chamber
// Params 4, eflags: 0x1 linked
// Checksum 0x129b07d4, Offset: 0x18c0
// Size: 0x5c
function function_790aa7af(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("<dev string:xb6>");
    #/
    videostop("cp_infection_env_timelapse_fail");
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x334b82c8, Offset: 0x1928
// Size: 0x6c
function function_11c1cade(var_38fa6e84) {
    level scene::init("cin_inf_05_taylorinfected_3rd_sh010");
    level waittill(#"hash_849f7f99");
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(1, "white");
    }
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x30243166, Offset: 0x19a0
// Size: 0x6c
function function_6b291c0d(var_38fa6e84) {
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("set_exposure_bank", 3);
        level waittill(#"hash_60ced02");
        level thread util::screen_fade_in(1.5, "white");
    }
}

// Namespace sgen_test_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0xc5d7b982, Offset: 0x1a18
// Size: 0x3c
function function_6089d98(var_38fa6e84) {
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("set_exposure_bank", 1);
    }
}

