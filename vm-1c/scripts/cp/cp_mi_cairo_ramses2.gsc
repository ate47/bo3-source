#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_patch;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_alley;
#using scripts/cp/cp_mi_cairo_ramses_arena_defend;
#using scripts/cp/cp_mi_cairo_ramses_quad_tank_plaza;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_igc;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses2;

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x19af30d3, Offset: 0xd20
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x964320a4, Offset: 0xd60
// Size: 0x34c
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(116);
    }
    setailimit(40);
    savegame::function_8c0c4b3a("ramses");
    namespace_38256252::function_4d39a2af();
    namespace_38256252::function_43898266();
    namespace_38256252::function_e1862c87();
    namespace_38256252::function_6f52c808();
    namespace_38256252::function_7f657f7a();
    namespace_38256252::function_fec73937();
    namespace_38256252::function_a17fa88e();
    namespace_38256252::function_8e872dc8();
    namespace_38256252::function_3484502e();
    util::function_286a5010(5);
    init_clientfields();
    init_flags();
    function_673254cc();
    objectives::complete("cp_level_ramses_determine_what_salim_knows");
    objectives::complete("cp_level_ramses_interrogate_salim");
    objectives::complete("cp_level_ramses_protect_salim");
    objectives::complete("cp_level_ramses_eastern_checkpoint");
    objectives::set("cp_level_ramses_demolish_arena_defend");
    getent("lgt_shadow_block_trans", "targetname") hide();
    ramses_util::function_1903e7dc();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_loadout(&on_player_loadout);
    callback::on_laststand(&on_player_last_stand);
    cp_mi_cairo_ramses2_fx::main();
    cp_mi_cairo_ramses2_sound::main();
    load::main();
    cp_mi_cairo_ramses2_patch::function_7403e82b();
    setdvar("compassmaxrange", "12000");
    setdvar("scr_security_breach_lose_contact_distance", 36000);
    setdvar("scr_security_breach_lost_contact_distance", 72000);
    /#
        execdevgui("<dev string:x28>");
    #/
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x4844d70c, Offset: 0x10b8
// Size: 0x214
function init_clientfields() {
    clientfield::register("toplayer", "player_spike_plant_postfx", 1, 1, "counter");
    clientfield::register("world", "arena_defend_fxanim_hunters", 1, 1, "int");
    clientfield::register("world", "arena_defend_mobile_wall_damage", 1, 1, "int");
    clientfield::register("world", "alley_fxanim_hunters", 1, 1, "int");
    clientfield::register("world", "alley_fog_banks", 1, 1, "int");
    clientfield::register("world", "alley_fxanim_curtains", 1, 1, "int");
    clientfield::register("world", "vtol_igc_fxanim_hunter", 1, 1, "int");
    clientfield::register("world", "qt_plaza_fxanim_hunters", 1, 1, "int");
    clientfield::register("world", "theater_fxanim_swap", 1, 1, "int");
    clientfield::register("world", "qt_plaza_outro_exposure", 1, 1, "int");
    clientfield::register("world", "hide_statue_rubble", 1, 1, "int");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xe1bc3712, Offset: 0x12d8
// Size: 0x1e4
function init_flags() {
    level flag::init("vtol_igc_trigger_used");
    level flag::init("intro_igc_done");
    level flag::init("dead_turret_stop_station_ambients");
    level flag::init("station_walk_cleanup");
    level flag::init("weak_points_objective_active");
    level flag::init("sinkhole_charges_detonated");
    level flag::init("arena_defend_sinkhole_outro");
    level flag::init("player_has_dead_control");
    level flag::init("start_vtol_robot_drop_1");
    level flag::init("start_vtol_robot_drop_2");
    level flag::init("vtol_igc_done");
    level flag::init("freeway_battle_cleared");
    level flag::init("flak_vtol_ride_stop");
    level flag::init("flak_arena_defend_stop");
    level flag::init("flak_alley_stop");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x187b7cdc, Offset: 0x14c8
// Size: 0x2e4
function function_673254cc() {
    skipto::function_d68e678e("arena_defend_intro", &arena_defend::intro, "Arena Defend", &arena_defend::intro_done);
    skipto::add("arena_defend", &arena_defend::main, "Arena Defend", &arena_defend::done);
    skipto::function_d68e678e("sinkhole_collapse", &arena_defend::function_4451e1bd, "Sinkhole Collapse", &arena_defend::function_82a50f67);
    skipto::add_dev("dev_weak_point_test", &arena_defend::dev_weak_point_test, "Weak Point Test", &arena_defend::dev_weak_point_test, "", "");
    skipto::add_dev("dev_sinkhole_test", &arena_defend::dev_sinkhole_test, "Sinkhole Test", &arena_defend::function_893047b8, "", "alley");
    skipto::function_d68e678e("alley", &function_8392bfa, "Alley", &function_76333904);
    skipto::function_d68e678e("vtol_igc", &function_5478458c, "VTOL IGC", &function_f3104d92);
    skipto::function_d68e678e("quad_tank_plaza", &function_277a2ec5, "Quad Tank Plaza", &function_fe70e19f);
    skipto::add_dev("dev_statue_fall", &function_f723d487, "Statue Fall Test", &function_b966133d);
    skipto::add_dev("dev_hacked_quadtank", &function_5d8a2262, "Test Hacked Quadtank", &function_c7cac5c);
    skipto::add_dev("dev_qt_plaza_outro", &function_969d795a, "QT PLAZA OUTRO", &function_bf0bc064);
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xfbc7c4a4, Offset: 0x17b8
// Size: 0x44
function on_player_connect() {
    self flag::init("linked_to_truck");
    self flag::init("spike_launcher_tutorial_complete");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x6608ce93, Offset: 0x1808
// Size: 0x1c
function on_player_spawned() {
    self ramses_util::function_ff06e7ac();
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xdf79d088, Offset: 0x1830
// Size: 0x84
function on_player_loadout() {
    if (level.var_31aefea8 === "arena_defend_intro" || level.var_31aefea8 === "arena_defend" || level.var_31aefea8 == "sinkhole_collapse" || level.var_31aefea8 === "dev_weak_point_test" || level.var_31aefea8 === "dev_sinkhole_test") {
        self ramses_util::function_ad67ec60(1);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x81f04159, Offset: 0x18c0
// Size: 0x1e
function on_player_last_stand() {
    self notify(#"last_stand_detonate");
    self notify(#"hash_a426d615");
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xf7fa489, Offset: 0x18e8
// Size: 0x18c
function function_8392bfa(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        hidemiscmodels("alley_doors_open");
        ramses_util::function_22e1a261();
        ramses_util::function_f2f98cfc();
        ramses_util::function_1aeb2873();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        load::function_a2995f22();
        level thread util::function_d8eaed3d(5);
    }
    objectives::set("cp_level_ramses_go_to_safiya");
    if (isdefined(level.var_1b3f87f7)) {
        level.var_1b3f87f7 delete();
    }
    ramses_util::function_7255e66(1, "alley_mobile_armory");
    level.var_2fd26037 colors::enable();
    level.var_2fd26037 colors::set_force_color("o");
    vtol_igc::function_fc9630cb();
    alley::alley_main();
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0xcae3adf9, Offset: 0x1a80
// Size: 0xa4
function function_76333904(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        arena_defend::function_d92a2132();
        level ramses_util::function_22e1a261();
    }
    ramses_util::function_7255e66(0, "alley_mobile_armory");
    setailimit(35);
    hidemiscmodels("qtp_vtol_nose");
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xc65592ed, Offset: 0x1b30
// Size: 0x1d4
function function_5478458c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_2fd26037 colors::set_force_color("o");
        skipto::teleport_ai(str_objective);
        ramses_util::function_f2f98cfc();
        level scene::init("cin_ram_06_05_safiya_1st_friendlydown_init");
        level thread namespace_a6a248fc::function_6b994041();
        load::function_a2995f22();
    }
    if (isdefined(level.var_b0c4695a)) {
        level.var_b0c4695a delete();
    }
    callback::remove_on_loadout(&on_player_loadout);
    level.players ramses_util::function_25439df2();
    function_340269e0();
    function_54b31e43();
    level flag::set("flak_alley_stop");
    level thread alley::function_9f94867c();
    level thread quad_tank_plaza::function_4492caaa();
    vtol_igc::function_fc9630cb();
    vtol_igc::function_f72dae68(var_74cd64bc);
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0x4554fa82, Offset: 0x1d10
// Size: 0x84
function function_f3104d92(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        objectives::complete("cp_level_ramses_go_to_safiya");
    }
    objectives::complete("cp_level_ramses_vtol_use");
    exploder::kill_exploder("transition");
    ramses_util::function_fb967724();
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xc7dd5b24, Offset: 0x1da0
// Size: 0x1a4
function function_277a2ec5(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &function_7cfa94ff, "init");
        scene::init("cin_ram_06_05_safiya_1st_friendlydown");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        battlechatter::function_d9f49fba(0);
        callback::remove_on_loadout(&on_player_loadout);
        level thread function_7aef65a5();
        load::function_a2995f22();
        level thread quad_tank_plaza::function_4492caaa();
        quad_tank_plaza::function_ffea6b5();
        util::clientnotify("pst");
        function_340269e0();
        function_54b31e43();
    } else {
        battlechatter::function_d9f49fba(1);
    }
    vtol_igc::function_fc9630cb();
    quad_tank_plaza::function_b39397dc();
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xda592e04, Offset: 0x1f50
// Size: 0x244
function function_7aef65a5() {
    level thread quad_tank_plaza::function_5a4025b4();
    level thread vtol_igc::function_35210922();
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc::function_e78f7ba0, "play");
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc::vtol_igc_done, "done");
    level thread vtol_igc::function_f3a727ef(1);
    s_scene = struct::get("truck_flip_vtol", "targetname");
    s_scene thread scene::skipto_end();
    level waittill(#"level_is_go");
    level thread vtol_igc::function_6ee65e7a();
    level util::screen_fade_out(0, "black", "skipto_fade");
    util::delay(1.5, undefined, &util::screen_fade_in, 1, "black", "skipto_fade");
    level scene::skipto_end("cin_ram_06_05_safiya_1st_friendlydown", undefined, undefined, 0.88, 1);
    battlechatter::function_d9f49fba(1);
    level flag::set("vtol_igc_done");
    exploder::exploder_stop("fx_expl_qtplaza_hotel");
    array::run_all(getentarray("lgt_vtol_block", "targetname"), &hide);
    util::clear_streamer_hint();
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xdb47d6e6, Offset: 0x21a0
// Size: 0xcc
function function_7cfa94ff(a_ents) {
    var_2aa82b86 = a_ents["cin_ram_06_05_safiya_1st_friendlydown_vtol01"];
    var_2aa82b86 vtol_igc::function_1e5c6903(1, "");
    var_2aa82b86 vtol_igc::function_1e5c6903(1, "_d1");
    var_2aa82b86 vtol_igc::function_1e5c6903(0, "_d2");
    level waittill(#"hash_6f5e60c5");
    var_2aa82b86 hidepart("tag_glass4_d2_animate");
    var_2aa82b86 showpart("tag_glass4_d3_animate");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x20feec1c, Offset: 0x2278
// Size: 0x24
function function_340269e0() {
    level scene::init("p7_fxanim_cp_ramses_mobile_wall_explode_bundle");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xe23d841a, Offset: 0x22a8
// Size: 0x94
function function_54b31e43() {
    exploder::exploder("fx_expl_qtplaza_hotel");
    exploder::exploder("fx_expl_qtplaza_main");
    exploder::exploder("fx_expl_qtplaza_tracers");
    exploder::exploder("fx_expl_qtplaza_vista");
    exploder::exploder("ramses_vtol_down");
    exploder::exploder("LGT_theater");
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0x29365680, Offset: 0x2348
// Size: 0x3c
function function_fe70e19f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_ramses_destroy_quadtank");
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xda5960b0, Offset: 0x2390
// Size: 0x3c
function function_f723d487(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        vtol_igc::function_fc9630cb();
        quad_tank_plaza::function_7d4abfb6();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0x5936a9d, Offset: 0x23d8
// Size: 0x24
function function_b966133d(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xb69a1c91, Offset: 0x2408
// Size: 0x2c
function function_5d8a2262(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        quad_tank_plaza::function_fb5c1d72();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0x37466756, Offset: 0x2440
// Size: 0x24
function function_c7cac5c(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_cairo_ramses2
// Params 2, eflags: 0x0
// Checksum 0xfe7d90f1, Offset: 0x2470
// Size: 0x1a4
function function_969d795a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level ramses_util::function_c20af84a();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        level flag::init("qt_plaza_outro_igc_started");
        level flag::init("qt_plaza_statue_destroyed");
        level flag::init("qt_plaza_rocket_building_destroyed");
        level flag::init("qt_plaza_mobile_wall_destroyed");
        quad_tank_plaza::function_5cb0384();
        function_54b31e43();
        level scene::skipto_end("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle");
        level scene::skipto_end("p7_fxanim_cp_ramses_cinema_collapse_bundle");
        exploder::exploder("fx_expl_bldg_rocket");
        level flag::wait_till("all_players_spawned");
        quad_tank_plaza::function_f9e42df5(1);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4, eflags: 0x0
// Checksum 0xc077932c, Offset: 0x2620
// Size: 0x24
function function_bf0bc064(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

