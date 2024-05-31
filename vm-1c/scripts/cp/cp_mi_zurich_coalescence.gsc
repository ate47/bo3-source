#using scripts/cp/cp_mi_zurich_coalescence_patch;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_fx;
#using scripts/cp/cp_mi_zurich_coalescence_outro;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_root_zurich;
#using scripts/cp/cp_mi_zurich_coalescence_root_singapore;
#using scripts/cp/cp_mi_zurich_coalescence_root_cairo;
#using scripts/cp/cp_mi_zurich_coalescence_clearing;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_server_room;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_sacrifice;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_rails;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_street;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_city;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_accolades;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_collectibles;
#using scripts/shared/callbacks_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace namespace_f165e60d;

// Namespace namespace_f165e60d
// Params 0, eflags: 0x0
// namespace_f165e60d<file_0>::function_243693d4
// Checksum 0xba3f0c8e, Offset: 0xc30
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x1 linked
// namespace_f165e60d<file_0>::function_d290ebfa
// Checksum 0xbd4bd025, Offset: 0xc70
// Size: 0x234
function main() {
    init_clientfields();
    function_673254cc();
    init_level_vars();
    flag_init();
    level.var_75ba074a = 1;
    util::function_286a5010(9);
    namespace_2ebd997a::main();
    namespace_b301a1fd::main();
    namespace_bbb4ee72::main();
    namespace_3d19ef22::main();
    namespace_6a04e6cd::main();
    namespace_73dbe018::main();
    namespace_29799936::main();
    namespace_1beb9396::main();
    skipto::function_272e1c8d();
    level.var_d086f08f = 1;
    collectibles::function_93523442("p7_nc_zur_coa_01", 30, (0, 0, 10));
    collectibles::function_93523442("p7_nc_zur_coa_03", 60, (-10, 0, -10));
    collectibles::function_93523442("p7_nc_zur_coa_04", 60, (0, 0, 10));
    namespace_e9d9fb34::function_4d39a2af();
    level thread namespace_8e9083ff::function_4e396e71();
    level thread namespace_8e9083ff::function_be06d646();
    level thread namespace_8e9083ff::function_91d852fa();
    level thread namespace_8e9083ff::function_a7b5b565();
    load::main();
    namespace_98d4ffda::function_7403e82b();
    level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x1 linked
// namespace_f165e60d<file_0>::function_2ea898a8
// Checksum 0xd2c8647f, Offset: 0xeb0
// Size: 0x124
function init_clientfields() {
    clientfield::register("world", "intro_ambience", 1, 1, "int");
    clientfield::register("world", "plaza_battle_amb_wasps", 1, 1, "int");
    clientfield::register("world", "hq_amb", 1, 1, "int");
    clientfield::register("world", "decon_spray", 1, 1, "int");
    clientfield::register("world", "clearing_hide_lotus_tower", 1, 1, "int");
    clientfield::register("world", "clearing_hide_ferris_wheel", 1, 1, "int");
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x1 linked
// namespace_f165e60d<file_0>::function_673254cc
// Checksum 0x9b586f68, Offset: 0xfe0
// Size: 0x614
function function_673254cc() {
    skipto::add("zurich", &namespace_f815059a::function_9c1fc2fd, "Zurich", &namespace_f815059a::function_1a4dfaaa);
    skipto::add("intro_igc", &namespace_f815059a::function_9940e82f, "Intro IGC", &namespace_f815059a::function_40b9b738);
    skipto::add("intro_pacing", &namespace_f815059a::function_8fb45492, "Intro Pacing", &namespace_f815059a::function_cf4ddc29);
    skipto::function_d68e678e("street", &namespace_1beb9396::function_9c1fc2fd, "Don't Panic", &namespace_1beb9396::function_1a4dfaaa);
    skipto::function_d68e678e("garage", &namespace_1beb9396::function_568e2e07, "Don't Panic 2", &namespace_1beb9396::function_5b6ddf20);
    skipto::function_d68e678e("rails", &namespace_f3d05f86::function_9c1fc2fd, "Off the Rails", &namespace_f3d05f86::function_1a4dfaaa);
    skipto::function_d68e678e("plaza_battle", &namespace_ca56958::function_9c1fc2fd, "Coalescence Plaza", &namespace_ca56958::function_1a4dfaaa);
    skipto::function_d68e678e("hq", &namespace_b73b0f52::function_9c1fc2fd, "HQ", &namespace_b73b0f52::function_1a4dfaaa);
    skipto::function_d68e678e("sacrifice", &namespace_68404a06::function_9c1fc2fd, "Sacrifice", &namespace_68404a06::function_1a4dfaaa);
    skipto::function_d68e678e("server_room", &namespace_e0fbc9fc::function_9c1fc2fd, "Server Room", &namespace_e0fbc9fc::function_1a4dfaaa);
    skipto::add("clearing_start", &namespace_29799936::function_5bcd68f2, "Clearing Start", &namespace_29799936::function_c68a0705);
    skipto::function_d68e678e("clearing_waterfall", &namespace_29799936::function_5be0c18c, "Clearing Waterfall", &namespace_29799936::function_132beeb7);
    skipto::function_d68e678e("clearing_path_choice", &namespace_29799936::function_21b82e1f, "Clearing Path Choice", undefined);
    skipto::add("clearing_hub", &namespace_29799936::function_1270c207, "Clearing Hub", &namespace_29799936::function_44c2b6a);
    skipto::function_d68e678e("root_zurich_start", &namespace_6a04e6cd::function_9c1fc2fd, "Zurich Root", undefined);
    skipto::function_d68e678e("root_zurich_vortex", &namespace_6a04e6cd::function_95b88092, "Zurich Root Vortex", &namespace_6a04e6cd::function_1a4dfaaa);
    skipto::function_d68e678e("clearing_hub_2", &namespace_29799936::function_1270c207, "Clearing Hub", &namespace_29799936::function_600acf3f);
    skipto::function_d68e678e("root_cairo_start", &namespace_73dbe018::function_9c1fc2fd, "Cairo Root", undefined);
    skipto::function_d68e678e("root_cairo_vortex", &namespace_73dbe018::function_95b88092, "Cairo Root Vortex", &namespace_73dbe018::function_1a4dfaaa);
    skipto::function_d68e678e("clearing_hub_3", &namespace_29799936::function_1270c207, "Clearing Hub", &namespace_29799936::function_b42e7a80);
    skipto::function_d68e678e("root_singapore_start", &namespace_3d19ef22::function_9c1fc2fd, "Singapore Root", &namespace_3d19ef22::function_c68a0705);
    skipto::function_d68e678e("root_singapore_vortex", &namespace_3d19ef22::function_95b88092, "Singapore Root Vortex", &namespace_3d19ef22::function_53a05865);
    skipto::function_d68e678e("outro_movie", &namespace_34c3982c::function_8c381165, "Outro Movie", &namespace_34c3982c::function_7c294f88);
    skipto::add("server_interior", &namespace_34c3982c::function_618d5a98, "Server Interior", &namespace_34c3982c::function_d9ccb9e3);
    skipto::add("zurich_outro", &namespace_34c3982c::function_313f113, "Outro", &namespace_34c3982c::function_f2f0f1ec);
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x1 linked
// namespace_f165e60d<file_0>::function_cb3d951d
// Checksum 0x536589f2, Offset: 0x1600
// Size: 0x24
function init_level_vars() {
    setdvar("player_swimTime", 5000);
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x1 linked
// namespace_f165e60d<file_0>::function_487d2c0
// Checksum 0xce7f4080, Offset: 0x1630
// Size: 0x404
function flag_init() {
    level flag::init("intro_squad_ready_move");
    level flag::init("flag_enable_zurich_ending");
    level flag::init("flag_start_zurich_outro");
    level flag::init("flag_enable_waterfall_vine_burn");
    level flag::init("flag_hq_security_room_clear");
    level flag::init("flag_hq_siege_bot_dead");
    level flag::init("flag_hq_security_room_move_upstairs");
    level flag::init("flag_hq_hack_door_open");
    level flag::init("flag_decon_door_open");
    level flag::init("flag_start_kane_sacrifice_igc");
    level flag::init("flag_move_kane_into_sacrifice_start");
    level flag::init("flag_clearing_start");
    level flag::init("flag_zurich_root_final_encounter_complete");
    level flag::init("flag_cairo_arena_complete");
    level flag::init("flag_start_elevator_siege_bot");
    level flag::init("flag_hq_move_kane_to_locker_room");
    level flag::init("flag_hq_move_to_airlock");
    level flag::init("flag_hall_sing_intro_vo_done");
    level flag::init("flag_diaz_first_path_complete_vo_done");
    level flag::init("flag_taylor_outro_vo_01");
    level flag::init("flag_taylor_outro_vo_02");
    level flag::init("flag_taylor_outro_vo_03");
    level flag::init("flag_salim_cognititve_neural_vo_done");
    level flag::init("flag_kane_sacrifice_door_closed");
    level flag::init("flag_start_kane_it_won_t_vo_done");
    level flag::init("flag_fill_purging_bar_40");
    level flag::init("flag_fill_purging_bar_60");
    level flag::init("flag_fill_purging_bar_80");
    level flag::init("flag_singapore_root_monologue_02_done");
    level flag::init("flag_singapore_root_monologue_04_done");
    level flag::init("flag_cairo_root_monologue_04_done");
    level flag::init("flag_monologue_zurich_root_04_done");
}

