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

#namespace namespace_9ac99a6e;

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x9509f345, Offset: 0x6a8
// Size: 0x3a
function main() {
    /#
        iprintlnbold("c_spc_decayman_stage3_fb");
    #/
    init_client_field_callback_funcs();
    function_7b244c18();
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x19cc8ee0, Offset: 0x6f0
// Size: 0xca
function init_client_field_callback_funcs() {
    clientfield::register("world", "sgen_test_chamber_pod_graphics", 1, 1, "int");
    clientfield::register("world", "sgen_test_chamber_time_lapse", 1, 1, "int");
    clientfield::register("scriptmover", "sgen_test_guys_decay", 1, 1, "int");
    clientfield::register("world", "fxanim_hive_cluster_break", 1, 1, "int");
    clientfield::register("world", "fxanim_time_lapse_objects", 1, 1, "int");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x1db39b6c, Offset: 0x7c8
// Size: 0x152
function function_7b244c18() {
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh090", &function_fd16dd41, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh140", &function_ee093b22, "done");
    scene::add_scene_func("cin_inf_05_taylorinfected_3rd_sh010", &function_6b291c0d, "play");
    scene::add_scene_func("cin_inf_05_taylorinfected_3rd_sh080", &function_6089d98, "done");
    scene::add_scene_func("cin_inf_04_02_sarah_vign_01", &function_11c1cade, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh140", &function_eabb935c, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_c43d862, "play");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x61dc954a, Offset: 0x928
// Size: 0x6b
function function_c467cbf() {
    foreach (player in level.players) {
        player playrumbleonentity("damage_heavy");
    }
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0x54b2984d, Offset: 0x9a0
// Size: 0x13
function function_ee093b22(var_38fa6e84) {
    level notify(#"hash_b4468c2e");
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0x94bb160b, Offset: 0x9c0
// Size: 0x1a
function function_eabb935c(var_38fa6e84) {
    level util::function_d8eaed3d(6);
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0xd9d423f5, Offset: 0x9e8
// Size: 0x4a
function function_c43d862(var_38fa6e84) {
    level waittill(#"hash_ee361e18");
    if (isdefined(var_38fa6e84["wire"])) {
        e_wire = var_38fa6e84["wire"];
        e_wire setmodel("p7_sgen_dni_testing_pod_wires_01_off");
    }
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0x941d703a, Offset: 0xa40
// Size: 0x103
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

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x6375ba67, Offset: 0xb50
// Size: 0x1a
function function_a29f7cbd() {
    level scene::init("cin_inf_04_humanlabdeath_3rd_sh010");
}

// Namespace namespace_9ac99a6e
// Params 2, eflags: 0x0
// Checksum 0xb885904, Offset: 0xb78
// Size: 0x1ea
function function_c568c95b(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<unknown string>");
    #/
    level clientfield::set("sgen_test_chamber_pod_graphics", 1);
    if (var_74cd64bc) {
        load::function_73adcefc();
        array::thread_all(level.players, &namespace_36cbf523::function_9f10c537);
        level thread scene::init("cin_inf_04_humanlabdeath_3rd_sh010");
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
    level thread scene::play("cin_inf_04_humanlabdeath_3rd_sh010");
    level waittill(#"hash_b4468c2e");
    skipto::function_be8adfb8("sgen_test_chamber");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0xd6aebf6a, Offset: 0xd70
// Size: 0x52
function function_7711faaf() {
    videostart("cp_infection_env_dnimainmonitor", 1);
    level waittill(#"fx_explosion");
    videostop("cp_infection_env_dnimainmonitor");
    videostart("cp_infection_env_timelapse_fail", 1);
}

/#

    // Namespace namespace_9ac99a6e
    // Params 4, eflags: 0x0
    // Checksum 0xadd0743f, Offset: 0xdd0
    // Size: 0x3a
    function function_7985eb71(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
        iprintlnbold("<unknown string>");
    }

#/

// Namespace namespace_9ac99a6e
// Params 2, eflags: 0x0
// Checksum 0xd6648e62, Offset: 0xe18
// Size: 0x10a
function function_21e8c919(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<unknown string>");
    #/
    if (!var_74cd64bc) {
        videostop("cp_infection_env_timelapse_fail");
    }
    if (var_74cd64bc) {
        load::function_73adcefc();
        level util::function_d8eaed3d(9);
        array::thread_all(level.players, &namespace_36cbf523::function_9f10c537);
        load::function_a2995f22();
    }
    videostart("cp_infection_env_raventimelapse_ravens", 1);
    level thread function_b99b8b97();
    level thread function_27249631();
    level waittill(#"hash_d469a3e9");
    level thread util::clear_streamer_hint();
    skipto::function_be8adfb8("time_lapse");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x6cb820fb, Offset: 0xf30
// Size: 0xa2
function function_b99b8b97() {
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_888bbd49, "play");
    scene::add_scene_func("cin_inf_04_humanlabdeath_3rd_sh150", &function_d469a3e9, "done");
    level thread scene::play("cin_inf_04_humanlabdeath_3rd_sh150");
    level waittill(#"hash_c6e56c65");
    wait(1);
    clientfield::set("sgen_test_chamber_time_lapse", 1);
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0xb2790a59, Offset: 0xfe0
// Size: 0x7a
function function_888bbd49(a_ents) {
    /#
        iprintlnbold("<unknown string>");
    #/
    level thread function_a2b1036();
    var_bc282e3d = a_ents["decayedman"];
    var_bc282e3d thread function_ccc1a59f();
    level waittill(#"hash_5e798509");
    util::screen_fade_out(0, "white");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0xa36de143, Offset: 0x1068
// Size: 0x112
function function_ccc1a59f() {
    level endon(#"hash_d469a3e9");
    self waittill(#"hash_21b0eee7");
    level notify(#"hash_c6e56c65");
    wait(1);
    self setmodel("c_spc_decayman_stage1_tout_fb");
    self clientfield::set("sgen_test_guys_decay", 1);
    wait(1);
    self setmodel("c_spc_decayman_stage2_tin_fb");
    wait(1);
    self setmodel("c_spc_decayman_stage2_fb");
    wait(1);
    self setmodel("c_spc_decayman_stage2_tout_fb");
    wait(1);
    self setmodel("c_spc_decayman_stage3_tin_fb");
    wait(1);
    self setmodel("c_spc_decayman_stage3_fb");
    wait(1.5);
    self setmodel("c_spc_decayman_stage4_fb");
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0x7abd1aa2, Offset: 0x1188
// Size: 0x13
function function_d469a3e9(a_ents) {
    level notify(#"hash_d469a3e9");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x22f7a8ef, Offset: 0x11a8
// Size: 0x1a
function function_27249631() {
    level thread clientfield::set("fxanim_time_lapse_objects", 1);
}

// Namespace namespace_9ac99a6e
// Params 4, eflags: 0x0
// Checksum 0xb39ce91e, Offset: 0x11d0
// Size: 0x52
function function_f7f4cbd3(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("<unknown string>");
    #/
    videostop("cp_infection_env_raventimelapse_ravens");
}

// Namespace namespace_9ac99a6e
// Params 0, eflags: 0x0
// Checksum 0x90144e51, Offset: 0x1230
// Size: 0x1a
function function_a2b1036() {
    level scene::init("cin_inf_04_02_sarah_vign_01");
}

// Namespace namespace_9ac99a6e
// Params 2, eflags: 0x0
// Checksum 0x21861aee, Offset: 0x1258
// Size: 0x1a2
function function_621e0975(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<unknown string>");
    #/
    level util::function_d8eaed3d(3);
    videostart("cp_infection_env_timelapse_fail", 1);
    if (var_74cd64bc) {
        util::screen_fade_out(0, "white");
        array::thread_all(level.players, &namespace_36cbf523::function_9f10c537);
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
    }
    level thread util::clear_streamer_hint();
    skipto::function_be8adfb8("cyber_soliders_invest");
}

// Namespace namespace_9ac99a6e
// Params 4, eflags: 0x0
// Checksum 0x37b6e709, Offset: 0x1408
// Size: 0x52
function function_790aa7af(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("<unknown string>");
    #/
    videostop("cp_infection_env_timelapse_fail");
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0x96ecd40, Offset: 0x1468
// Size: 0x52
function function_11c1cade(var_38fa6e84) {
    level scene::init("cin_inf_05_taylorinfected_3rd_sh010");
    level waittill(#"hash_849f7f99");
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(1, "white");
    }
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0xadcf626c, Offset: 0x14c8
// Size: 0x5a
function function_6b291c0d(var_38fa6e84) {
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("set_exposure_bank", 3);
        level waittill(#"hash_60ced02");
        level thread util::screen_fade_in(1.5, "white");
    }
}

// Namespace namespace_9ac99a6e
// Params 1, eflags: 0x0
// Checksum 0xea7dae9c, Offset: 0x1530
// Size: 0x32
function function_6089d98(var_38fa6e84) {
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("set_exposure_bank", 1);
    }
}

