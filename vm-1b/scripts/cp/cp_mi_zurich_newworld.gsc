#using scripts/cp/cp_mi_zurich_newworld_underground;
#using scripts/cp/cp_mi_zurich_newworld_train;
#using scripts/cp/cp_mi_zurich_newworld_rooftops;
#using scripts/cp/cp_mi_zurich_newworld_lab;
#using scripts/cp/cp_mi_zurich_newworld_factory;
#using scripts/cp/cp_mi_zurich_newworld_accolades;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_fx;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_collectibles;
#using scripts/cp/_ammo_cache;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_b78a5cd7;

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_243693d4
// Checksum 0x1dbf0795, Offset: 0xea0
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_d290ebfa
// Checksum 0xc635e347, Offset: 0xee0
// Size: 0x17a
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(29);
    }
    level.disableclassselection = 1;
    level.friendlyfiredisabled = 1;
    namespace_37a1dc33::function_4d39a2af();
    savegame::function_8c0c4b3a("newworld");
    init_clientfields();
    init_flags();
    init_fx();
    namespace_bbfcd64f::main();
    namespace_b5a65bd6::main();
    function_673254cc();
    util::function_286a5010(10);
    callback::on_spawned(&on_player_spawn);
    callback::on_connect(&on_player_connect);
    callback::on_loadout(&namespace_ce0e5f06::on_player_loadout);
    load::main();
    level thread function_4b0856b();
    namespace_ce0e5f06::function_3383b379();
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_f53e79d4
// Checksum 0x961d60a, Offset: 0x1068
// Size: 0x1b
function init_fx() {
    level._effect["smk_idle_cauldron"] = "smoke/fx_smk_idle_cauldron";
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_2ea898a8
// Checksum 0x8a4dcaee, Offset: 0x1090
// Size: 0x84a
function init_clientfields() {
    clientfield::register("actor", "diaz_camo_shader", 1, 2, "int");
    clientfield::register("vehicle", "name_diaz_wasp", 1, 1, "int");
    clientfield::register("scriptmover", "weakpoint", 1, 1, "int");
    clientfield::register("world", "factory_exterior_vents", 1, 1, "int");
    clientfield::register("scriptmover", "open_vat_doors", 1, 1, "int");
    clientfield::register("world", "chase_pedestrian_blockers", 1, 1, "int");
    clientfield::register("toplayer", "chase_train_rumble", 1, 1, "int");
    clientfield::register("world", "spinning_vent_fxanim", 1, 1, "int");
    clientfield::register("world", "crane_fxanim", 1, 1, "int");
    clientfield::register("world", "underground_subway_debris", 1, 2, "int");
    clientfield::register("toplayer", "ability_wheel_tutorial", 1, 1, "int");
    clientfield::register("world", "underground_subway_wires", 1, 1, "int");
    clientfield::register("world", "inbound_igc_glass", 1, 2, "int");
    clientfield::register("world", "train_robot_swing_glass_left", 1, 2, "int");
    clientfield::register("world", "train_robot_swing_glass_right", 1, 2, "int");
    clientfield::register("world", "train_robot_swing_left_extra", 1, 1, "int");
    clientfield::register("world", "train_robot_swing_right_extra", 1, 1, "int");
    clientfield::register("world", "train_dropdown_glass", 1, 2, "int");
    clientfield::register("world", "train_lockdown_glass_left", 1, 2, "int");
    clientfield::register("world", "train_lockdown_glass_right", 1, 2, "int");
    clientfield::register("world", "train_lockdown_shutters_1", 1, 1, "int");
    clientfield::register("world", "train_lockdown_shutters_2", 1, 1, "int");
    clientfield::register("world", "train_lockdown_shutters_3", 1, 1, "int");
    clientfield::register("world", "train_lockdown_shutters_4", 1, 1, "int");
    clientfield::register("world", "train_lockdown_shutters_5", 1, 1, "int");
    clientfield::register("actor", "train_throw_robot_corpses", 1, 1, "int");
    clientfield::register("scriptmover", "train_throw_robot_corpses", 1, 1, "int");
    clientfield::register("world", "train_brake_flaps", 1, 2, "int");
    clientfield::register("world", "waterplant_rotate_fans", 1, 1, "int");
    clientfield::register("world", "train_main_fx_occlude", 1, 1, "int");
    clientfield::register("world", "sndTrainContext", 1, 2, "int");
    clientfield::register("world", "set_fog_bank", 1, 2, "int");
    clientfield::register("actor", "derez_ai_deaths", 1, 1, "int");
    clientfield::register("actor", "chase_suspect_fx", 1, 1, "int");
    clientfield::register("actor", "wall_run_fx", 1, 1, "int");
    clientfield::register("actor", "cs_rez_in_fx", 1, 2, "counter");
    clientfield::register("actor", "cs_rez_out_fx", 1, 2, "counter");
    clientfield::register("scriptmover", "derez_ai_deaths", 1, 1, "int");
    clientfield::register("scriptmover", "truck_explosion_fx", 1, 1, "int");
    clientfield::register("scriptmover", "derez_model_deaths", 1, 1, "int");
    clientfield::register("scriptmover", "emp_door_fx", 1, 1, "int");
    clientfield::register("scriptmover", "smoke_grenade_fx", 1, 1, "int");
    clientfield::register("scriptmover", "frag_grenade_fx", 1, 1, "int");
    clientfield::register("scriptmover", "wall_break_fx", 1, 1, "int");
    clientfield::register("scriptmover", "train_explosion_fx", 1, 1, "int");
    clientfield::register("scriptmover", "wasp_hack_fx", 1, 1, "int");
    clientfield::register("scriptmover", "train_fx_occlude", 1, 1, "int");
    clientfield::register("vehicle", "wasp_hack_fx", 1, 1, "int");
    clientfield::register("vehicle", "emp_vehicles_fx", 1, 1, "int");
    clientfield::register("world", "player_snow_fx", 1, 4, "int");
    clientfield::register("allplayers", "player_spawn_fx", 1, 1, "int");
    clientfield::register("scriptmover", "emp_generator_fx", 1, 1, "int");
    clientfield::register("toplayer", "train_rumble_loop", 1, 1, "int");
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_37af8a07
// Checksum 0x2b692a5d, Offset: 0x18e8
// Size: 0x7a
function init_flags() {
    level flag::init("foundry_remote_hijack_enabled");
    level flag::init("ptsd_active");
    level flag::init("ptsd_area_clear");
    level flag::init("chase_train_station_glass_ceiling");
    level flag::init("infinite_white_transition");
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_4b0856b
// Checksum 0x9161c39, Offset: 0x1970
// Size: 0xf2
function function_4b0856b() {
    spawner::add_spawn_function_group("civilian", "script_noteworthy", &function_efcad701);
    spawner::add_global_spawn_function("axis", &namespace_ce0e5f06::function_e340d355);
    spawner::add_spawn_function_ai_group("factory_allies", &util::magic_bullet_shield);
    spawner::add_spawn_function_ai_group("factory_allies", &namespace_ce0e5f06::function_e340d355);
    spawner::add_spawn_function_ai_group("factory_intro_die", &namespace_ce0e5f06::function_e340d355);
    callback::on_ai_killed(&namespace_ce0e5f06::function_606dbca2);
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_72a45412
// Checksum 0xe6ae8efa, Offset: 0x1a70
// Size: 0x4a
function on_player_spawn() {
    self namespace_ce0e5f06::function_1943bf79();
    if (!self namespace_ce0e5f06::function_c633d8fe()) {
        self.var_fe7a7fe4 = 1;
        self clientfield::set_player_uimodel("hudItems.cybercoreSelectMenuDisabled", 1);
    }
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_fb4f96b5
// Checksum 0x5a1b822, Offset: 0x1ac8
// Size: 0x12
function on_player_connect() {
    self namespace_ce0e5f06::function_70176ad6();
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_673254cc
// Checksum 0xc9dddd33, Offset: 0x1ae8
// Size: 0x6f2
function function_673254cc() {
    skipto::function_d68e678e("white_infinite_igc", &namespace_c7062b04::function_7ce22dd3, "White Infinite IGC", &namespace_c7062b04::function_ccad2ef9);
    skipto::function_d68e678e("factory_factory_intro_igc", &namespace_f8b9e1f8::function_e0b1e88a, "Factory \226 Factory Intro IGC", &namespace_f8b9e1f8::function_54113b74);
    skipto::add("factory_factory_exterior", &namespace_f8b9e1f8::function_5c3934c2, "Factory \226 Factory Exterior", &namespace_f8b9e1f8::function_8b155bc);
    skipto::function_d68e678e("factory_alley", &namespace_f8b9e1f8::function_8392bfa, "Factory \226 Alley", &namespace_f8b9e1f8::function_76333904);
    skipto::function_d68e678e("factory_warehouse", &namespace_f8b9e1f8::function_beff78dc, "Factory \226 Warehouse", &namespace_f8b9e1f8::function_e028fc02);
    skipto::function_d68e678e("factory_foundry", &namespace_f8b9e1f8::function_e886dd9a, "Factory \226 Foundry", &namespace_f8b9e1f8::function_5680eaa4);
    skipto::function_d68e678e("factory_vat_room", &namespace_f8b9e1f8::function_6aeb594c, "Factory \226 Vat Room", &namespace_f8b9e1f8::function_19fb5452);
    skipto::function_d68e678e("factory_inside_man_igc", &namespace_f8b9e1f8::function_6d9440c2, "Factory \226 Inside Man IGC", &namespace_f8b9e1f8::function_1a0c61bc);
    skipto::add("chase_apartment_igc", &namespace_36358f9c::function_c862f707, "Chase \226 Apartment IGC", &namespace_36358f9c::function_8aa535bd);
    skipto::function_d68e678e("chase_chase_start", &namespace_36358f9c::function_35d96059, "Chase \226 Chase Start", &namespace_36358f9c::function_1c5d5613);
    skipto::add("chase_bridge_collapse", &namespace_36358f9c::function_ec6ea2d4, "Chase \226 Bridge Collapse", &namespace_36358f9c::function_9ca3cbaa);
    skipto::add("chase_rooftops", &namespace_36358f9c::function_61decb2d, "Chase \226 Rooftops", &namespace_36358f9c::function_18f0e437);
    skipto::function_d68e678e("chase_old_zurich", &namespace_36358f9c::function_a7ce33a6, "Chase \226 Old Zurich", &namespace_36358f9c::function_4d063e30);
    skipto::add("chase_construction_site", &namespace_36358f9c::function_af48bb3e, "Chase \226 Construction Site", &namespace_36358f9c::function_2f1ed218);
    skipto::function_d68e678e("chase_glass_ceiling_igc", &namespace_36358f9c::function_9262d885, "Chase \226 Glass Ceiling IGC", &namespace_36358f9c::function_500cd65f);
    skipto::add("underground_pinned_down_igc", &namespace_2f45a7a1::function_78f1dce, "Underground \226 Pinned Down IGC", &namespace_2f45a7a1::function_2595088);
    skipto::add("underground_subway", &namespace_2f45a7a1::function_ec466e32, "Underground \226 Subway", &namespace_2f45a7a1::function_41f657cc);
    skipto::function_d68e678e("underground_crossroads", &namespace_2f45a7a1::function_95c9ad6c, "Underground \226 Crossroads", &namespace_2f45a7a1::function_1b150072);
    skipto::function_d68e678e("underground_construction", &namespace_2f45a7a1::function_c83c689a, "Underground \226 Construction Area", &namespace_2f45a7a1::function_363675a4);
    skipto::function_d68e678e("underground_maintenance", &namespace_2f45a7a1::function_984152f8, "Underground \226 Maintenance", &namespace_2f45a7a1::function_19da6b7e);
    skipto::function_d68e678e("underground_water_plant", &namespace_2f45a7a1::function_105344d6, "Underground \226 Water Treatment Plant", &namespace_2f45a7a1::function_217b1340);
    skipto::function_d68e678e("underground_staging_room_igc", &namespace_2f45a7a1::function_9f911334, "Underground \226 Staging Room IGC", &namespace_2f45a7a1::function_5240a50a);
    skipto::add("train_inbound_igc", &namespace_c7062b04::function_ab92d4b4, "Train \226 Inbound IGC", &namespace_c7062b04::function_5e42668a);
    skipto::add("train_train_start", &namespace_c7062b04::function_158a9a65, "Train \226 Train Start", &namespace_c7062b04::function_d5af013f);
    skipto::function_d68e678e("train_train_roof", &namespace_c7062b04::function_dbb1e1e3, "Train \226 Train Roof", &namespace_c7062b04::function_ead43429);
    skipto::function_d68e678e("train_detach_bomb_igc", &namespace_c7062b04::function_143fa139, "Train \226 Detach Bomb IGC", &namespace_c7062b04::function_ea4ba3f3);
    skipto::add("waking_up_igc", &namespace_d2831417::function_6383d314, "Waking Up IGC", &namespace_d2831417::function_3ff80cea);
    skipto::add_dev("dev_lab", &namespace_d2831417::function_8f94ea53, "DEV:  Lab");
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_efcad701
// Checksum 0x839d64e5, Offset: 0x21e8
// Size: 0x7a
function function_efcad701() {
    self.health = 1;
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self disableaimassist();
    self.var_69dd5d62 = 0;
    self ai::set_behavior_attribute("panic", 0);
    self thread function_1554ffe9();
    self thread namespace_ce0e5f06::function_523cdc93();
}

// Namespace namespace_b78a5cd7
// Params 1, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_3840d81a
// Checksum 0x9de7939b, Offset: 0x2270
// Size: 0x8a
function function_3840d81a(var_368248f2) {
    self endon(#"death");
    if (!isalive(self)) {
        return;
    }
    self ai::set_behavior_attribute("panic", 1);
    self playloopsound("vox_civ_panic_loop");
    self ai::force_goal(var_368248f2, 8);
    self waittill(#"goal");
    namespace_ce0e5f06::function_523cdc93(0);
}

// Namespace namespace_b78a5cd7
// Params 0, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_1554ffe9
// Checksum 0xe166bb9a, Offset: 0x2308
// Size: 0x69
function function_1554ffe9() {
    self endon(#"death");
    while (true) {
        var_efb53e77 = self waittill(#"touch");
        if (var_efb53e77.script_noteworthy === "civilian") {
            continue;
        }
        if (self.var_a0f70d54 === var_efb53e77) {
            continue;
        }
        namespace_ce0e5f06::function_523cdc93(0);
        break;
    }
}

// Namespace namespace_b78a5cd7
// Params 1, eflags: 0x0
// namespace_b78a5cd7<file_0>::function_2740a464
// Checksum 0x75095c0c, Offset: 0x2380
// Size: 0x22
function function_2740a464(var_56c18f67) {
    self waittill(#"death");
    var_56c18f67 util::self_delete();
}

