#using scripts/cp/_load;
#using scripts/cp/_collectibles;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cp_mi_sing_vengeance_patch;
#using scripts/cp/cp_mi_sing_vengeance_safehouse;
#using scripts/cp/cp_mi_sing_vengeance_market;
#using scripts/cp/cp_mi_sing_vengeance_garage;
#using scripts/cp/cp_mi_sing_vengeance_dogleg_2;
#using scripts/cp/cp_mi_sing_vengeance_temple;
#using scripts/cp/cp_mi_sing_vengeance_quadtank_alley;
#using scripts/cp/cp_mi_sing_vengeance_dogleg_1;
#using scripts/cp/cp_mi_sing_vengeance_killing_streets;
#using scripts/cp/cp_mi_sing_vengeance_intro;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_fx;
#using scripts/shared/stealth;
#using scripts/shared/vehicles/_wasp;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicles/_hunter;
#using scripts/cp/_objectives;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_spawn_manager;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/cp/_oed;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_5a0096b2;

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0x4b0e731a, Offset: 0x14a8
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0xe8be100d, Offset: 0x14e8
// Size: 0x4bc
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(116);
    }
    namespace_523da15d::function_4d39a2af();
    precache();
    init_clientfields();
    init_flags();
    function_673254cc();
    namespace_a1cfe497::main();
    namespace_7c587e3e::main();
    util::function_286a5010(8);
    savegame::function_8c0c4b3a("vengeance");
    load::main();
    namespace_465859d::function_7403e82b();
    namespace_63b4601c::function_60ce6396();
    setdvar("vengeance_save", "1");
    level thread namespace_628b256b::function_38bcd0();
    level thread namespace_e6a038a0::function_bd50a158();
    spawners = getentarray();
    foreach (spawner in spawners) {
        if (isspawner(spawner)) {
            spawner notify(#"aigroup_spawner_death");
        }
    }
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "hanging_body_loop_civ";
    var_6a07eb6c[1] = "hanging_body_loop_civ_rope";
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ02", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ03", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ05", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ06", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ07", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ07ropeshort", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ08", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_hanging_body_loop_vign_civ09", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    collectibles::function_93523442("p7_nc_sin_ven_01", 60, (0, 0, 15));
    collectibles::function_93523442("p7_nc_sin_ven_02", 90, (15, 0, 15));
    collectibles::function_93523442("p7_nc_sin_ven_03", 90, (-15, -15, 35));
    collectibles::function_93523442("p7_nc_sin_ven_04", 60, (0, 0, 15));
    collectibles::function_37aecd21();
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0x245caa5e, Offset: 0x19b0
// Size: 0xaa
function precache() {
    level._effect["fx_exp_grenade_emp"] = "explosions/fx_exp_grenade_emp";
    level._effect["fx_elec_enemy_juiced_shotgun"] = "electric/fx_elec_enemy_juiced_shotgun";
    level._effect["fx_elec_sparks_plane_sm_runner"] = "electric/fx_elec_sparks_plane_sm_runner";
    level._effect["fx_exp_emp_siegebot_veng"] = "explosions/fx_exp_emp_siegebot_veng";
    level._effect["fx_trail_missile_vista_veng"] = "weapon/fx_trail_missile_vista_veng";
    level._effect["fx_fuel_pour_far_ven"] = "water/fx_fuel_pour_far_ven";
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0xea4d93bc, Offset: 0x1a68
// Size: 0x2a4
function init_clientfields() {
    clientfield::register("toplayer", "play_client_igc", 1, 4, "int");
    clientfield::register("scriptmover", "normal_hide", 1, 1, "int");
    clientfield::register("actor", "normal_hide", 1, 1, "int");
    clientfield::register("scriptmover", "mature_hide", 1, 1, "int");
    clientfield::register("actor", "mature_hide", 1, 1, "int");
    clientfield::register("toplayer", "apartment_light_fire_fx", 1, 1, "int");
    clientfield::register("toplayer", "kill_qt_alley_light", 1, 1, "int");
    clientfield::register("scriptmover", "xiulan_face_burn", 1, 1, "int");
    clientfield::register("world", "fxanims_intro", 1, 1, "int");
    clientfield::register("world", "fxanims_killing_streets", 1, 1, "int");
    clientfield::register("world", "fxanims_dogleg_1", 1, 1, "int");
    clientfield::register("world", "fxanims_dogleg_2", 1, 1, "int");
    clientfield::register("world", "fxanims_garage_igc", 1, 1, "int");
    clientfield::register("world", "fxanims_safehouse_explodes", 1, 1, "int");
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0x69e89b61, Offset: 0x1d18
// Size: 0xbc4
function init_flags() {
    level flag::init("intro_wall_done");
    level flag::init("apartment_entrance_door_open");
    level flag::init("set_breadcrumb_apartment1");
    level flag::init("set_breadcrumb_apartment2");
    level flag::init("set_breadcrumb_apartment3");
    level flag::init("breadcrumb_apartment1");
    level flag::init("breadcrumb_apartment2");
    level flag::init("breadcrumb_apartment3");
    level flag::init("hendricks_move_to_apartment_building");
    level flag::init("apartment_begin");
    level flag::init("player_looking");
    level flag::init("apartment_enemies_dead");
    level flag::init("apartment_enemy_dead");
    level flag::init("apartment_enemies_alerted");
    level flag::init("do_not_stop_apartment_scene");
    level flag::init("synckill_scene_complete");
    level flag::init("bedroom_scene_complete");
    level flag::init("apartment_complete");
    level flag::init("takedown_begin");
    level flag::init("takedown_moment_get_in_place");
    level flag::init("takedown_intro_anims_finished");
    level flag::init("all_players_ready_for_takedown");
    level flag::init("takedown_complete");
    level flag::init("takedown_backup_truck_stopped_flag");
    level flag::init("combat_enemies_retreating");
    level flag::init("move_hendricks_to_meat_market");
    level flag::init("hendricks_says_stay_down");
    level flag::init("killing_streets_begin");
    level flag::init("killing_streets_end");
    level flag::init("hendricks_break_ally_stealth");
    level flag::init("move_killing_streets_hendricks_node_05");
    level flag::init("move_killing_streets_hendricks_node_10");
    level flag::init("move_killing_streets_hendricks_node_15");
    level flag::init("killing_streets_intro_patroller_spawners_cleared");
    level flag::init("killing_streets_lineup_civilian_spawners_cleared");
    level flag::init("killing_streets_lineup_patroller_spawners_cleared");
    level flag::init("cin_ven_03_20_storelineup_vign_fire_done");
    level flag::init("killing_streets_lineup_patrollers_alerted");
    level flag::init("hendricks_cleared_meat_market_door");
    level flag::init("killing_streets_civilian_sniped");
    level flag::init("cin_ven_03_15_killingstreets_vign_done");
    level flag::init("dogleg_1_intro_taylor_vo_over");
    level flag::init("killing_streets_pre_apothecary_vo_done");
    level flag::init("cin_ven_04_10_cafedoor_3rd_enter_finished");
    level flag::init("dogleg_1_begin");
    level flag::init("dogleg_1_end");
    level flag::init("cafe_execution_thug_dead");
    level flag::init("cafe_molotov_thugs_alerted");
    level flag::init("cafe_burning_match_thrown");
    level flag::init("quadtank_alley_begin");
    level flag::init("quadtank_alley_end");
    level flag::init("show_temple_gather");
    level flag::init("temple_begin");
    level flag::init("temple_end");
    level flag::init("temple_stealth_broken");
    level flag::init("temple_hendricks_done");
    level flag::init("enable_arena_street_end_trigger");
    level flag::init("streets_begin");
    level flag::init("hendricks_out");
    level flag::init("dogleg_2_begin");
    level flag::init("dogleg_2_at_end");
    level flag::init("garage_igc_done");
    level flag::init("hendricks_at_market");
    level flag::init("players_at_market");
    level flag::init("players_in_market");
    level flag::init("in_veh_before_vo");
    level flag::init("technical_01_entered");
    level flag::init("technical_02_entered");
    level flag::init("start_obj_technicals");
    level flag::init("kill_sniper_nags");
    level flag::init("garage_main_snipers_cleared");
    level flag::init("garage_extra_snipers_cleared");
    level flag::init("quad_tank_start_anim");
    level flag::init("quad_battle_starts");
    level flag::init("quad_tank_wall_broken");
    level flag::init("qt_left_side");
    level flag::init("qt_right_side");
    level flag::init("quad_tank_downstairs");
    level flag::init("quad_tank_dead");
    level flag::init("quadtank_hijacked");
    level flag::init("qt_hijack_warlords_dead");
    level flag::init("qt_hijack_grunts_dead");
    level flag::init("qt_hijack_enemies_dead");
    level flag::init("quad_battle_ends");
    level flag::init("quad_enemies_done");
    level flag::init("hendricks_exiting_market");
    level flag::init("exiting_market");
    level flag::init("hendricks_at_plaza");
    level flag::init("players_at_plaza");
    level flag::init("start_plaza_wave_2");
    level flag::init("plaza_hendricks_jump");
    level flag::init("plaza_combat_live");
    level flag::init("plaza_cleared");
    level flag::init("starting_igc_12");
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0x41f345b7, Offset: 0x28e8
// Size: 0x538
function function_673254cc() {
    skipto::add("intro", &namespace_8776ed6e::function_62616b71, "Intro", &namespace_8776ed6e::function_19a68bdb);
    skipto::add_dev("dev_apartment", &namespace_8776ed6e::function_5cb54255, "Apartment", &namespace_8776ed6e::function_4762cf8f);
    skipto::function_d68e678e("takedown", &namespace_8776ed6e::function_20681e14, "Takedown", &namespace_8776ed6e::function_fcdc57ea);
    skipto::function_d68e678e("killing_streets", &namespace_62b73aed::function_5b3d7d44, "Killing Streets", &namespace_62b73aed::function_e416ac3a);
    skipto::function_d68e678e("dogleg_1", &namespace_445ee992::function_36184f5d, "Dogleg 1", &namespace_445ee992::function_8db83207);
    skipto::function_d68e678e("quadtank_alley", &namespace_6f44bbbf::function_f9314d0e, "Quadtank Alley", &namespace_6f44bbbf::function_1dc027c8);
    skipto::function_d68e678e("temple", &namespace_628b256b::function_80032d7e, "Temple Arena", &namespace_628b256b::function_299dec58);
    skipto::function_d68e678e("dogleg_2", &namespace_1e5c6f29::function_bfca9cc4, "Dogleg 2", &namespace_1e5c6f29::function_48a3cbba);
    skipto::function_d68e678e("garage_igc", &namespace_22334037::function_b17357cc, "Parking Garage IGC", &namespace_22334037::function_608352d2);
    skipto::add_dev("dev_garage", &namespace_22334037::function_63a4033a, "Parking Garage Arena", &namespace_22334037::function_a55eff44);
    skipto::function_d68e678e("quad_battle", &namespace_e6a038a0::function_7b65c5ac, "Quad Tank Battle", &namespace_e6a038a0::function_463cdeb2);
    skipto::function_d68e678e("safehouse_plaza", &namespace_e6a038a0::function_6e671181, "Plaza Combat", &namespace_e6a038a0::function_e5fb7f0b);
    skipto::function_d68e678e("safehouse_explodes", &namespace_ce9d9fc1::function_26524bc8, "Safehouse Explodes", &namespace_ce9d9fc1::function_683ab16e);
    skipto::add_dev("dev_safehouse_interior", &namespace_ce9d9fc1::function_29dad6e8, "Safehouse Interior", &namespace_ce9d9fc1::function_6bc33c8e);
    skipto::function_d68e678e("panic_room", &namespace_ce9d9fc1::function_6d9a830c, "Panic Room Scene", &namespace_ce9d9fc1::function_c328b12);
    /#
        skipto::add_dev("kill_qt_alley_light", &namespace_8776ed6e::function_616e9ab6, "apartment_enemy_dead");
        skipto::add_dev("move_killing_streets_hendricks_node_05", &namespace_8776ed6e::function_8771151f, "show_temple_gather");
        skipto::add_dev("kill_sniper_nags", &namespace_8776ed6e::function_7d5fbc40, "plaza_hendricks_jump");
    #/
    level.var_6b6097c5 = [];
    a_trigs = getentarray("objective", "targetname");
    foreach (trig in a_trigs) {
        if (isdefined(trig.script_objective)) {
            level.var_6b6097c5[trig.script_objective] = trig;
        }
    }
}

// Namespace namespace_5a0096b2
// Params 0, eflags: 0x0
// Checksum 0xe1251636, Offset: 0x2e28
// Size: 0x4c
function on_player_loadout() {
    if (level.var_31aefea8 === "dogleg_1") {
        self namespace_63b4601c::give_hero_weapon(1);
        self thread namespace_63b4601c::function_12a1b6a0();
    }
}

