#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/cp_mi_cairo_ramses_nasser_interview;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_fight;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_ride;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses;

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0xe3891e86, Offset: 0x958
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0xdc070ec, Offset: 0x998
// Size: 0x1ea
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(23);
    }
    savegame::function_8c0c4b3a("ramses");
    namespace_38256252::function_4d39a2af();
    namespace_38256252::function_43898266();
    namespace_38256252::function_e1862c87();
    precache();
    init_clientfields();
    init_flags();
    init_level();
    function_673254cc();
    util::function_286a5010(3);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    vehicle::add_spawn_function("station_fight_turret", &function_66f28952);
    cp_mi_cairo_ramses_fx::main();
    cp_mi_cairo_ramses_sound::main();
    load::main();
    setdvar("compassmaxrange", "12000");
    level clientfield::set("ramses_station_lamps", 1);
    /#
        execdevgui("<dev string:x28>");
    #/
    level thread function_2b543535();
    level.var_dc236bc8 = 1;
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xb90
// Size: 0x2
function precache() {
    
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x6a1a04f4, Offset: 0xba0
// Size: 0x16a
function init_clientfields() {
    clientfield::register("world", "hide_station_miscmodels", 1, 1, "int");
    clientfield::register("world", "turn_on_rotating_fxanim_fans", 1, 1, "int");
    clientfield::register("world", "turn_on_rotating_fxanim_lights", 1, 1, "int");
    clientfield::register("world", "delete_fxanim_fans", 1, 1, "int");
    clientfield::register("toplayer", "nasser_interview_extra_cam", 1, 1, "int");
    clientfield::register("toplayer", "rap_blood_on_player", 1, 1, "counter");
    clientfield::register("world", "ramses_station_lamps", 1, 1, "int");
    clientfield::register("world", "staging_area_intro", 1, 1, "int");
    clientfield::register("toplayer", "filter_ev_interference_toggle", 1, 1, "int");
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0xe8680261, Offset: 0xd18
// Size: 0x182
function init_flags() {
    level flag::init("dead_turrets_initialized");
    level flag::init("dead_turret_stop_station_ambients");
    level flag::init("station_walk_past_stairs");
    level flag::init("station_walk_complete");
    level flag::init("station_walk_cleanup");
    level flag::init("raps_intro_done");
    level flag::init("pod_hits_floor");
    level flag::init("ceiling_collapse_complete");
    level flag::init("drop_pod_opened_and_spawned");
    level flag::init("station_fight_completed");
    level flag::init("mobile_wall_fxanim_start");
    level flag::init("vtol_ride_started");
    level flag::init("vtol_ride_done");
    level flag::init("hendricks_jumpdirect_looping");
    level flag::init("khalil_jumpdirect_looping");
    level flag::init("flak_vtol_ride_stop");
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0xdcd2966c, Offset: 0xea8
// Size: 0xaa
function init_level() {
    skipto::function_f3e035ef();
    level.var_1e983b11 = 0;
    level.var_d829fe9f = 0;
    battlechatter::function_d9f49fba(0, "bc");
    var_69e9c588 = getentarray("mobile_armory", "script_noteworthy");
    var_301cff54 = getentarray("ammo_cache", "script_noteworthy");
    level.var_2b205f01 = arraycombine(var_69e9c588, var_301cff54, 0, 0);
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x9d807331, Offset: 0xf60
// Size: 0x12
function function_66f28952() {
    self.team = "allies";
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x60b05c3b, Offset: 0xf80
// Size: 0x192
function function_673254cc() {
    skipto::add("level_start", &function_e4f36ca2, "level_start", &function_781ed89c);
    skipto::add("rs_walk_through", &function_4513d788, "rs_walk_through", &function_86fc3d2e);
    skipto::function_d68e678e("interview_dr_nasser", &function_ac4ae5cc, "interview_dr_nasser", &function_5b5ae0d2);
    skipto::function_d68e678e("defend_ramses_station", &namespace_bedc6a60::init, "defend_ramses_station", &namespace_bedc6a60::done);
    skipto::function_d68e678e("vtol_ride", &vtol_ride::init, "vtol_ride", &vtol_ride::done);
    skipto::add_dev("dev_defend_station_test", &namespace_bedc6a60::function_f27ea617, "Defend Station Test", &namespace_bedc6a60::function_93364e1b, "", "");
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x4011698b, Offset: 0x1120
// Size: 0x1a
function on_player_connect() {
    self flag::init("linked_to_truck");
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x1ed5565d, Offset: 0x1148
// Size: 0x12
function on_player_spawned() {
    self ramses_util::function_ff06e7ac();
}

// Namespace cp_mi_cairo_ramses
// Params 2, eflags: 0x0
// Checksum 0xfef46b48, Offset: 0x1168
// Size: 0x142
function function_e4f36ca2(str_objective, var_74cd64bc) {
    callback::on_spawned(&level_start::function_e9d1564a);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level_start::function_e29f0dd6(str_objective);
        ramses_util::function_75734d29();
    }
    objectives::set("cp_level_ramses_determine_what_salim_knows");
    objectives::set("cp_level_ramses_meet_with_khalil");
    array::thread_all(level.var_2b205f01, &oed::function_14ec2d71);
    level.var_2fd26037 setdedicatedshadow(1);
    level.var_2fd26037 sethighdetail(1);
    level.var_7a9855f3 sethighdetail(1);
    namespace_bedc6a60::function_f7abd273();
    namespace_bedc6a60::function_f21c9162("_combat");
    level_start::main();
}

// Namespace cp_mi_cairo_ramses
// Params 4, eflags: 0x0
// Checksum 0x8dd263c8, Offset: 0x12b8
// Size: 0xb2
function function_781ed89c(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        objectives::set("cp_level_ramses_determine_what_salim_knows");
        objectives::set("cp_level_ramses_meet_with_khalil");
    }
    namespace_bedc6a60::function_f7abd273();
    namespace_bedc6a60::function_f21c9162("_combat");
    ramses_util::function_75734d29();
    level scene::init("cin_ram_04_02_easterncheck_vign_jumpdirect");
    level thread ramses_util::function_a0a9f927();
}

// Namespace cp_mi_cairo_ramses
// Params 2, eflags: 0x0
// Checksum 0x43a94923, Offset: 0x1378
// Size: 0x14a
function function_4513d788(str_objective, var_74cd64bc) {
    level.var_9db406db = util::function_740f8516("khalil");
    level.var_9db406db sethighdetail(1);
    if (var_74cd64bc) {
        load::function_73adcefc();
        callback::on_spawned(&level_start::function_e9d1564a);
        cp_mi_cairo_ramses_station_walk::function_e29f0dd6(str_objective);
        array::thread_all(level.var_2b205f01, &oed::function_14ec2d71);
        load::function_a2995f22();
        util::screen_fade_out(0, "black", "skipto_fade");
        util::delay(1, undefined, &util::screen_fade_in, 1, "black", "skipto_fade");
    }
    cp_mi_cairo_ramses_nasser_interview::function_c99967dc(0);
    ramses_util::function_7255e66(0);
    cp_mi_cairo_ramses_station_walk::main();
}

// Namespace cp_mi_cairo_ramses
// Params 4, eflags: 0x0
// Checksum 0x438c5c4e, Offset: 0x14d0
// Size: 0x52
function function_86fc3d2e(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_ramses_go_to_holding_room");
    objectives::complete("cp_level_ramses_meet_with_khalil");
}

// Namespace cp_mi_cairo_ramses
// Params 2, eflags: 0x0
// Checksum 0x54bed0eb, Offset: 0x1530
// Size: 0x102
function function_ac4ae5cc(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_cairo_ramses_nasser_interview::function_e29f0dd6();
        callback::on_spawned(&cp_mi_cairo_ramses_nasser_interview::function_1bcd464b);
        array::thread_all(level.var_2b205f01, &oed::function_14ec2d71);
        level.var_9db406db sethighdetail(1);
        level.var_7a9855f3 sethighdetail(1);
        level.var_2fd26037 sethighdetail(1);
    }
    objectives::set("cp_level_ramses_interrogate_salim");
    ramses_util::function_7255e66(1);
    cp_mi_cairo_ramses_nasser_interview::main(var_74cd64bc);
}

// Namespace cp_mi_cairo_ramses
// Params 4, eflags: 0x0
// Checksum 0x898a5890, Offset: 0x1640
// Size: 0x12a
function function_5b5ae0d2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        array::thread_all(getentarray("mobile_armory", "script_noteworthy"), &oed::function_e228c18a, 1);
        objectives::complete("cp_level_ramses_interrogate_salim");
        objectives::complete("cp_level_ramses_determine_what_salim_knows");
        objectives::set("cp_level_ramses_protect_salim");
    }
    cp_mi_cairo_ramses_station_walk::function_51f408f1();
    level util::clientnotify("walla_off");
    oed::function_f0f40bb5();
    oed::function_b3c589a6();
    ramses_util::function_eabc6e2f();
    ramses_util::function_d4a0bb54();
    ramses_util::function_e7ebe596(0);
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x0
// Checksum 0x507790bd, Offset: 0x1778
// Size: 0x22
function function_2b543535() {
    level waittill(#"hash_c7cc2fd");
    level util::clientnotify("sndIGC");
}

