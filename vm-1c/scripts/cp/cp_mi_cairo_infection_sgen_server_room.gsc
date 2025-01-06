#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_forest;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sgen_server_room;

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0xa2322cac, Offset: 0x618
// Size: 0xb4
function main() {
    /#
        iprintlnbold("<dev string:x28>");
    #/
    clientfield::register("world", "infection_sgen_server_debris", 1, 2, "int");
    clientfield::register("world", "infection_sgen_xcam_models", 1, 1, "int");
    clientfield::register("actor", "infection_taylor_eye_shader", 1, 1, "int");
}

// Namespace sgen_server_room
// Params 2, eflags: 0x0
// Checksum 0x45706f8d, Offset: 0x6d8
// Size: 0x344
function function_2fcfe223(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<dev string:x3f>");
    #/
    load::function_73adcefc();
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh010", &function_29252437, "play");
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh050", &function_761c4a4f, "play");
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh060", &function_b7bf88e1, "play");
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh090", &function_bf2e0e2b, "play");
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh080", &function_c705ea04, "done");
    level scene::add_scene_func("cin_inf_05_taylorinfected_server_3rd_sh090", &function_f1d98a99, "done");
    level thread scene::init("cin_inf_05_taylorinfected_server_3rd_sh010");
    level util::function_d8eaed3d(5);
    level thread clientfield::set("infection_sgen_server_debris", 1);
    level thread scene::init("p7_fxanim_cp_infection_sgen_floor_drop_bundle");
    load::function_a2995f22();
    util::screen_fade_out(0);
    level thread namespace_bed101ee::function_33f72a8a();
    util::delay(0.25, undefined, &util::screen_fade_in, 1);
    if (isdefined(level.var_c388df1d)) {
        level thread [[ level.var_c388df1d ]]();
    }
    level thread scene::play("cin_inf_05_taylorinfected_server_3rd_sh010");
    level waittill(#"hash_60a79028");
    util::screen_fade_out(0.5, (0.32, 0.33, 0.32));
    level thread util::clear_streamer_hint();
    exploder::exploder("sgen_server_room_fall");
    skipto::teleport_players(str_objective);
    level thread scene::init("cin_inf_06_02_bastogne_vign_intro");
    level function_6d20ff4e();
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0xb4382f6f, Offset: 0xa28
// Size: 0x2c
function function_29252437(var_38fa6e84) {
    level clientfield::set("set_exposure_bank", 3);
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0x6d60b053, Offset: 0xa60
// Size: 0x2c
function function_c705ea04(var_38fa6e84) {
    level clientfield::set("set_exposure_bank", 1);
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0x7e004534, Offset: 0xa98
// Size: 0x74
function function_761c4a4f(var_38fa6e84) {
    level waittill(#"hash_814b4ba1");
    var_e4ac5229 = var_38fa6e84["taylor"];
    if (isdefined(var_e4ac5229)) {
        var_e4ac5229 clientfield::set("infection_taylor_eye_shader", 1);
        var_e4ac5229 cybercom::function_f8669cbf(1);
    }
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0x1cb88809, Offset: 0xb18
// Size: 0x54
function function_bf2e0e2b(var_38fa6e84) {
    level waittill(#"hash_814b4ba1");
    var_34c69af9 = var_38fa6e84["sarah"];
    if (isdefined(var_34c69af9)) {
        var_34c69af9 cybercom::function_f8669cbf(1);
    }
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0xc87e6558, Offset: 0xb78
// Size: 0x54
function function_b7bf88e1(a_ents) {
    var_7d116593 = struct::get("s_bastogne_lighting_hint", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0x1ce191ba, Offset: 0xbd8
// Size: 0x24
function function_f1d98a99(a_ents) {
    level thread forest::function_e8608118();
}

// Namespace sgen_server_room
// Params 4, eflags: 0x0
// Checksum 0x54ebf4f6, Offset: 0xc08
// Size: 0x25c
function function_3ef23469(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("<dev string:x55>");
    #/
    level thread clientfield::set("infection_sgen_server_debris", 3);
    var_3edb0ecc = getentarray("bastogne_world_falls_away", "script_noteworthy");
    array::run_all(var_3edb0ecc, &hide);
    var_ce40c475 = getentarray("world_falls_away_chasm", "targetname");
    array::run_all(var_ce40c475, &hide);
    var_9653358 = getent("fallaway_115", "targetname");
    var_9653358 show();
    var_9653358 = getent("fallaway_118", "targetname");
    var_9653358 show();
    var_9653358 = getent("fallaway_119", "targetname");
    var_9653358 show();
    var_9653358 = getent("fallaway_123", "targetname");
    var_9653358 show();
    var_9653358 = getent("fallaway_134", "targetname");
    var_9653358 show();
    var_9653358 = getent("fallaway_135", "targetname");
    var_9653358 show();
}

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0x8214484a, Offset: 0xe70
// Size: 0x44
function function_76a77098() {
    level thread clientfield::set("infection_sgen_server_debris", 2);
    level thread scene::play("p7_fxanim_cp_infection_sgen_floor_drop_bundle");
}

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0x659a481d, Offset: 0xec0
// Size: 0x134
function function_6d20ff4e() {
    temp_anchor = util::spawn_model("tag_origin", level.players[0].origin, level.players[0].angles);
    temp_anchor.targetname = "server_fall_align";
    util::wait_network_frame();
    level thread function_76a77098();
    util::delay(0.25, undefined, &util::screen_fade_in, 1, "white");
    level thread scene::play("cin_inf_05_02_infection_1st_crumblefall");
    level waittill(#"hash_9eab0e5b");
    level waittill(#"hash_786e266e");
    level thread clientfield::set("infection_sgen_xcam_models", 1);
    skipto::function_be8adfb8("sgen_server_room");
}

