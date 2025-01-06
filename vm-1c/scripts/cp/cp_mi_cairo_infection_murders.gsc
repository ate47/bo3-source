#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace namespace_47ecfa2f;

// Namespace namespace_47ecfa2f
// Params 4, eflags: 0x0
// Checksum 0xcb950bd1, Offset: 0x868
// Size: 0x24
function cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xed352d8e, Offset: 0x898
// Size: 0x24
function main() {
    init_clientfields();
    function_7b244c18();
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0x69764644, Offset: 0x8c8
// Size: 0x44
function function_d7cb3668() {
    level scene::init("cin_inf_07_04_sarah_vign_03");
    level scene::init("cin_inf_08_blackstation_3rd_sh010");
}

// Namespace namespace_47ecfa2f
// Params 2, eflags: 0x0
// Checksum 0xf728beaa, Offset: 0x918
// Size: 0x184
function function_fbe0ab05(str_objective, var_74cd64bc) {
    objectives::complete("cp_level_infection_cross_chasm");
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread scene::init("cin_inf_07_04_sarah_vign_03");
        level thread scene::init("cin_inf_08_blackstation_3rd_sh010");
        load::function_a2995f22();
    }
    level clientfield::set("black_station_ceiling_fxanim", 1);
    function_95f80417();
    level thread namespace_bed101ee::function_973b77f9();
    array::thread_all(level.players, &infection_util::function_9f10c537);
    function_a8cc5d8b();
    level thread function_7c2393b7();
    wait 4;
    array::thread_all(level.players, &infection_util::function_e905c73c);
    function_b269e5f1();
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xf1430b36, Offset: 0xaa8
// Size: 0xf4
function init_clientfields() {
    clientfield::register("world", "black_station_ceiling_fxanim", 1, 2, "int");
    clientfield::register("world", "igc_blackscreen_fade_in", 1, 1, "counter");
    clientfield::register("world", "igc_blackscreen_fade_in_immediate", 1, 1, "counter");
    clientfield::register("world", "igc_blackscreen_fade_out_immediate", 1, 1, "counter");
    clientfield::register("toplayer", "japanese_graphic_content_hide", 1, 1, "int");
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0x686a8dda, Offset: 0xba8
// Size: 0x364
function function_7b244c18() {
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh010", &function_70177a8f, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh020", &function_4ab8e4b4, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh030", &function_5251f741, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh040", &function_96207ff6, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh050", &function_d3ac4bc3, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh060", &function_f3d43a48, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh070", &function_fc3ad105, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh080", &function_8b88528a, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh090", &function_af410d87, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh090", &function_a11ffce1, "done");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh100", &function_bfb1dfd1, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh100", &function_2aa72adb, "done");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh110", &function_96221944, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh110", &function_b1fccc96, "play");
    scene::add_scene_func("cin_inf_08_blackstation_3rd_sh110", &function_86c218d2, "done");
    scene::add_scene_func("cin_inf_08_03_blackstation_vign_aftermath", &function_46acf97b, "init");
    scene::add_scene_func("cin_inf_08_03_blackstation_vign_aftermath", &function_65ce0def, "play");
    scene::add_scene_func("cin_inf_08_03_blackstation_vign_aftermath", &function_faca1b91, "done");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x5b40a8a6, Offset: 0xf18
// Size: 0x104
function function_95f80417(str_objective) {
    if (isdefined(level.var_3df977be)) {
        level thread [[ level.var_3df977be ]]();
    }
    util::delay(0.5, undefined, &function_cd24b21);
    level thread namespace_bed101ee::function_973b77f9();
    scene::add_scene_func("cin_inf_07_04_sarah_vign_03", &function_e53568f3, "play");
    level thread scene::play("cin_inf_07_04_sarah_vign_03");
    level waittill(#"hash_e4b0eeea");
    util::screen_fade_out(0, "black");
    level thread util::screen_fade_in(1, "black");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xbb39fa84, Offset: 0x1028
// Size: 0x2c
function function_e53568f3(a_ents) {
    level thread util::screen_fade_in(1, "black");
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0x126dbf3e, Offset: 0x1060
// Size: 0x64
function function_cd24b21() {
    level thread util::clear_streamer_hint();
    var_7d116593 = struct::get("tag_align_infection_blackstation", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0x7900e722, Offset: 0x10d0
// Size: 0x144
function function_a8cc5d8b() {
    if (isdefined(level.var_5145b404)) {
        level thread [[ level.var_5145b404 ]]();
    }
    level thread namespace_bed101ee::function_c4d41b74();
    level thread japanese_graphic_content_hide();
    level thread scene::play("cin_inf_08_blackstation_3rd_sh010");
    level waittill(#"hash_90d6ffa3");
    skipto::teleport_players("black_station");
    level thread scene::play("cin_inf_08_03_blackstation_vign_aftermath");
    array::thread_all(level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0);
    level thread scene::init("cin_inf_10_01_foy_aie_reversemortar");
    level thread scene::init("cin_inf_10_02_foy_aie_reversewallexplosion_suppressor");
    level waittill(#"hash_e6a81b1c");
    level thread namespace_bed101ee::function_973b77f9();
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xf67717cb, Offset: 0x1220
// Size: 0xa0
function japanese_graphic_content_hide() {
    level endon(#"hash_90d6ffa3");
    while (true) {
        level waittill(#"hash_b95052ad");
        array::thread_all(level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 1);
        level waittill(#"hash_aefb6286");
        array::thread_all(level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0);
    }
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xf413c780, Offset: 0x12c8
// Size: 0x44
function function_7c2393b7() {
    level clientfield::set("black_station_ceiling_fxanim", 2);
    wait 0.8;
    exploder::exploder("lgt_bstation_probe_ceiling_change");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x6874a92e, Offset: 0x1318
// Size: 0x2c
function function_8b29fc51(a_ents) {
    level scene::function_9e5b8cdb("p7_fxanim_cp_infection_reverse_house_01_bundle");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x792d89e2, Offset: 0x1350
// Size: 0x8c
function function_bc8265b7(a_ents) {
    level thread util::clear_streamer_hint();
    level thread village::function_1bf08d19();
    var_7d116593 = struct::get("s_foy_lighting_hint", "targetname");
    level thread infection_util::function_7aca917c(var_7d116593.origin);
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xe05216d7, Offset: 0x13e8
// Size: 0x84
function function_b269e5f1() {
    level scene::add_scene_func("cin_inf_09_01_flippingworld_1st_risefal", &function_bc8265b7, "play");
    level scene::add_scene_func("cin_inf_09_01_flippingworld_1st_risefal", &function_8b29fc51, "done");
    level scene::play("cin_inf_09_01_flippingworld_1st_risefal");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x86dc9fc5, Offset: 0x1478
// Size: 0x13a
function function_46acf97b(a_ents) {
    level.var_9db198cc = a_ents;
    foreach (ent in a_ents) {
        if (isdefined(ent.targetname)) {
            if (ent.targetname != "sarah" && ent.targetname != "taylor" && ent.targetname != "diaz" && ent.targetname != "maretti") {
                ent ghost();
            }
            continue;
        }
        ent ghost();
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xf3404643, Offset: 0x15c0
// Size: 0xa2
function function_b1fccc96(a_ents) {
    if (isdefined(level.var_9db198cc)) {
        foreach (ent in level.var_9db198cc) {
            ent show();
        }
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xe850ad8e, Offset: 0x1670
// Size: 0x10a
function function_65ce0def(a_ents) {
    a_ents["sarah"] ai::set_ignoreall(1);
    a_ents["taylor"] ai::set_ignoreall(1);
    a_ents["maretti"] ai::set_ignoreall(1);
    foreach (ent in a_ents) {
        ent show();
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x8a0e7046, Offset: 0x1788
// Size: 0xba
function function_faca1b91(a_ents) {
    level flag::wait_till("black_station_completed");
    foreach (ent in a_ents) {
        if (isdefined(ent)) {
            ent delete();
        }
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x6fa165ba, Offset: 0x1850
// Size: 0x14c
function function_23ab5175(a_ents) {
    level dialog::remote("hall_the_said_they_needed_0", 0);
    level dialog::remote("hall_we_were_marked_for_t_0", 0);
    level dialog::remote("hall_but_by_the_time_w_0", 0);
    level dialog::remote("hall_we_knew_they_d_send_0", 1);
    level dialog::function_13b3b16a("plyr_that_wasn_t_what_hap_0", 0);
    level dialog::function_13b3b16a("plyr_we_saw_the_footage_f_0", 0);
    level dialog::function_13b3b16a("plyr_you_denied_them_thei_0", 1);
    level dialog::remote("hall_oh_my_god_0", 0);
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x2dbcd549, Offset: 0x19a8
// Size: 0x9c
function function_70177a8f(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot010");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot010");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x417fcb25, Offset: 0x1a50
// Size: 0x9c
function function_4ab8e4b4(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot020");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot020");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x75f2654a, Offset: 0x1af8
// Size: 0x9c
function function_5251f741(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot030");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot030");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x861ad500, Offset: 0x1ba0
// Size: 0x9c
function function_96207ff6(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot040");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot040");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xc33a335d, Offset: 0x1c48
// Size: 0x9c
function function_d3ac4bc3(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot050");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot050");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xae9b74ba, Offset: 0x1cf0
// Size: 0x9c
function function_f3d43a48(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot060");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot060");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x27d47c8f, Offset: 0x1d98
// Size: 0x9c
function function_fc3ad105(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot070");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot070");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xc9d76c4e, Offset: 0x1e40
// Size: 0x9c
function function_8b88528a(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot080");
        level clientfield::increment("igc_blackscreen_fade_in", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot080");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xdb40403d, Offset: 0x1ee8
// Size: 0x74
function function_af410d87(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot090");
        level clientfield::increment("igc_blackscreen_fade_in_immediate", 1);
    }
    level scene::init("cin_inf_08_03_blackstation_vign_aftermath");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x9cc895a2, Offset: 0x1f68
// Size: 0x34
function function_a11ffce1(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder_stop("inf_bs_shot090");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x392def38, Offset: 0x1fa8
// Size: 0x34
function function_bfb1dfd1(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot100");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0x5dfe785, Offset: 0x1fe8
// Size: 0x34
function function_2aa72adb(a_ents) {
    if (!scene::function_b1f75ee9()) {
        exploder::exploder_stop("inf_bs_shot100");
    }
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xbaf48f41, Offset: 0x2028
// Size: 0xcc
function function_96221944(a_ents) {
    level util::function_d8eaed3d(2);
    if (!scene::function_b1f75ee9()) {
        exploder::exploder("inf_bs_shot110");
        level clientfield::increment("igc_blackscreen_fade_in_immediate", 1);
        level waittill(#"start_blackscreen");
        level clientfield::increment("igc_blackscreen_fade_out_immediate", 1);
        exploder::exploder_stop("inf_bs_shot110");
    }
    exploder::exploder("lgt_bstation_probe_igc_to_gameplay");
}

// Namespace namespace_47ecfa2f
// Params 1, eflags: 0x0
// Checksum 0xd160ec68, Offset: 0x2100
// Size: 0x2c
function function_86c218d2(a_ents) {
    level clientfield::increment("igc_blackscreen_fade_in_immediate", 1);
}

