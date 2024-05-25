#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cp_mi_sing_sgen_flood;
#using scripts/cp/cp_mi_sing_sgen_water_ride;
#using scripts/cp/cp_mi_sing_sgen_uw_battle;
#using scripts/cp/cp_mi_sing_sgen_silo_swim;
#using scripts/cp/cp_mi_sing_sgen_revenge_igc;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_fallen_soldiers;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_dark_battle;
#using scripts/cp/cp_mi_sing_sgen_enter_silo;
#using scripts/cp/cp_mi_sing_sgen_exterior;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_fx;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/_collectibles;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_load;
#using scripts/cp/_ammo_cache;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fa13d4ba;

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x5dd0ff28, Offset: 0x19e8
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x118db7a6, Offset: 0x1a28
// Size: 0x21
function main() {
    // Can't decompile export namespace_fa13d4ba::main Unknown operator 0x9d
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x6595dda8, Offset: 0x1c48
// Size: 0x642
function function_673254cc() {
    skipto::add("intro", &namespace_5da6b440::function_62616b71, "Intro", &namespace_5da6b440::function_19a68bdb);
    skipto::add("exterior", &namespace_5da6b440::function_d43e5685, "Exterior", &namespace_5da6b440::function_91e8545f);
    skipto::function_d68e678e("enter_lobby", &namespace_5da6b440::function_2c76d8aa, "Enter Lobby", &namespace_5da6b440::function_8903df94);
    skipto::function_d68e678e("discover_data", &namespace_9c567844::function_aa390943, "Discover Data", &namespace_9c567844::function_e59a6c89);
    skipto::function_d68e678e("aquarium_shimmy", &namespace_9c567844::function_17b49f2c, "Aquarium Shimmy", &namespace_9c567844::function_e28bb832);
    skipto::function_d68e678e("gen_lab", &namespace_9c567844::function_ab2e4091, "Genetics Lab", &namespace_9c567844::function_627360fb);
    skipto::function_d68e678e("post_gen_lab", &namespace_9c567844::function_d26cae1c, "Post Gen Lab", &namespace_9c567844::function_dcc3e542);
    skipto::function_d68e678e("chem_lab", &namespace_9c567844::function_f6774f56, "Chemical Lab", &namespace_9c567844::function_79f1dc0);
    skipto::function_d68e678e("post_chem_lab", &namespace_9c567844::function_4843e971, "Post Chem Lab", &namespace_9c567844::function_ff8909db);
    skipto::function_d68e678e("silo_floor", &namespace_9c567844::function_6926cd7f, "Silo Floor Battle", &namespace_9c567844::function_e3f81a25);
    skipto::function_d68e678e("under_silo", &namespace_9c567844::function_77964ef1, "Under Silo", &namespace_9c567844::function_2edb6f5b);
    skipto::function_d68e678e("fallen_soldiers", &namespace_ed09da6e::function_73eb52a7, "Fallen Soldiers", &namespace_ed09da6e::function_51f4af5d);
    skipto::function_d68e678e("testing_lab_igc", &namespace_a5e80dc::function_74581061, "Human Testing Lab", &namespace_a5e80dc::function_bfad6ceb);
    skipto::function_d68e678e("dark_battle", &namespace_4c73eafb::function_32dc1c24, "Dark Battle", &namespace_4c73eafb::function_bbb54b1a);
    skipto::function_d68e678e("charging_station", &namespace_4c73eafb::function_5f76850f, "Charging Station", &namespace_4c73eafb::function_9724b9d5);
    skipto::function_d68e678e("descent", &namespace_646f304f::function_1a420bcd, "Descent", &namespace_646f304f::function_d15424d7);
    skipto::add("pallas_start", &namespace_646f304f::function_1f2baf43, "pallas start", &namespace_646f304f::function_5a8d1289);
    skipto::add("pallas_end", &namespace_646f304f::function_bf36708e, "Pallas Death", &namespace_646f304f::function_e3c54b48);
    skipto::function_d68e678e("twin_revenge", &namespace_19d629e::function_cc756659, "Twin Revenge", &namespace_19d629e::function_b2f95c13);
    skipto::function_d68e678e("flood_combat", &namespace_caee6f4a::function_37c559db, "Flood Combat", &namespace_caee6f4a::function_ebe27bf1);
    skipto::add("flood_defend", &namespace_caee6f4a::function_ba34fbda, "Flood Defend", &namespace_caee6f4a::function_e2a342e4);
    skipto::function_d68e678e("underwater_battle", &namespace_b1c45cf3::function_297ca3c6, "Underwater Battle", &namespace_b1c45cf3::function_ceb4ae50);
    skipto::function_d68e678e("underwater_rail", &namespace_bfe2abac::function_b2f17f19, "Underwater Rail", &namespace_bfe2abac::function_88fd81d3);
    skipto::function_d68e678e("silo_swim", &namespace_da397ec0::function_d64c7d65, "Silo Swim", &namespace_da397ec0::function_9670e43f);
    skipto::add_dev("dev_flood_combat", &namespace_caee6f4a::function_37c559db, "Flood Combat", &namespace_caee6f4a::function_ebe27bf1);
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0xb11737a6, Offset: 0x2298
// Size: 0x19b
function precache() {
    level._effect["current_effect"] = "debris/fx_debris_underwater_current_sgen_os";
    level._effect["decon_mist"] = "steam/fx_steam_decon_fill_elevator_sgen";
    level._effect["drone_breadcrumb"] = "light/fx_temp_glow_cookie_crumb_sgen";
    level._effect["drone_sparks"] = "destruct/fx_dest_drone_mapper";
    level._effect["red_flare"] = "light/fx_light_emergency_flare_red";
    level._effect["water_spout"] = "water/fx_water_leak_torrent_md";
    level._effect["coolant_fx"] = "fog/fx_fog_coolant_jet_pallas_sgen";
    level._effect["fake_depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["tidal_wave"] = "water/fx_temp_water_tidal_wave_sgen";
    level._effect["drone_splash"] = "water/fx_water_splash_25v25";
    level._effect["rock_explosion"] = "explosions/fx_exp_generic_lg";
    level._effect["coolant_tower_unleash"] = "fog/fx_fog_coolant_release_column_sgen";
    level._effect["coolant_tower_damage_minor"] = "fog/fx_fog_coolant_leak_md";
    level._effect["coolant_tower_damage_major"] = "fog/fx_fog_coolant_leak_lg";
    level._effect["depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["underwater_flare"] = "light/fx_light_flare_ground_sgen";
    level._effect["weakspot_impact"] = "impacts/fx_bul_impact_metal_tower_core_sgen";
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0xe4985f16, Offset: 0x2440
// Size: 0x9
function init_clientfields() {
    // Can't decompile export namespace_fa13d4ba::init_clientfields Unknown operator 0xe2
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x9177a4f9, Offset: 0x2bc8
// Size: 0x31
function init_flags() {
    // Can't decompile export namespace_fa13d4ba::init_flags Unknown operator 0xd4
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0xe0bfad16, Offset: 0x34a0
// Size: 0x51
function function_4b0856b() {
    // Can't decompile export namespace_fa13d4ba::function_4b0856b Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x0
// Checksum 0x556762a3, Offset: 0x3610
// Size: 0xa
function function_bff1a867(str_objective) {
    // Can't decompile export namespace_fa13d4ba::function_bff1a867 Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x2c412ec6, Offset: 0x36d0
// Size: 0xa
function function_3fbd8c78() {
    // Can't decompile export namespace_fa13d4ba::function_3fbd8c78 Unknown operator 0xe2
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x3d120780, Offset: 0x3968
// Size: 0x4c
function function_aba4c411() {
    // Can't decompile export namespace_fa13d4ba::function_aba4c411 Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x36a069d2, Offset: 0x3a08
// Size: 0x9
function on_player_spawned() {
    // Can't decompile export namespace_fa13d4ba::on_player_spawned Unknown operator 0xd4
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x16529a72, Offset: 0x3a48
// Size: 0x11
function function_ec9fa3fe() {
    // Can't decompile export namespace_fa13d4ba::function_ec9fa3fe Unknown operator 0xd4
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x6e2554a4, Offset: 0x3b10
// Size: 0x11
function function_7a4e1da3() {
    // Can't decompile export namespace_fa13d4ba::function_7a4e1da3 Unknown operator 0x18
}

// Namespace namespace_fa13d4ba
// Params 3, eflags: 0x0
// Checksum 0x65f2185, Offset: 0x3bb0
// Size: 0x2a
function function_5dd1ccff(b_enable, var_5b1ec2c2, e_player) {
    // Can't decompile export namespace_fa13d4ba::function_5dd1ccff Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x0
// Checksum 0x8d34ce2c, Offset: 0x3db8
// Size: 0x1a
function function_ff4dec72(a_ents) {
    // Can't decompile export namespace_fa13d4ba::function_ff4dec72 Unknown operator 0x41
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x0
// Checksum 0x54a0f11b, Offset: 0x3e38
// Size: 0x1a
function function_e860d344(a_ents) {
    // Can't decompile export namespace_fa13d4ba::function_e860d344 Unknown operator 0x74
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0xee3b0239, Offset: 0x3eb8
// Size: 0xa
function function_db43be1e() {
    // Can't decompile export namespace_fa13d4ba::function_db43be1e Unknown operator 0xe2
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x0
// Checksum 0xde9480c2, Offset: 0x3f10
// Size: 0x11
function function_8084e40a(e_player) {
    // Can't decompile export namespace_fa13d4ba::function_8084e40a Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0x541e43f5, Offset: 0x3fb0
// Size: 0x2d
function function_d481b315() {
    // Can't decompile export namespace_fa13d4ba::function_d481b315 Unknown operator 0xe2
}

// Namespace namespace_fa13d4ba
// Params 2, eflags: 0x0
// Checksum 0xcd46a046, Offset: 0x4008
// Size: 0x22
function function_1f0515fa(str_name, n_index) {
    // Can't decompile export namespace_fa13d4ba::function_1f0515fa Unknown operator 0x5d
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// Checksum 0xd325147, Offset: 0x40d0
// Size: 0x2d
function function_dedf5ad3() {
    // Can't decompile export namespace_fa13d4ba::function_dedf5ad3 Unknown operator 0x98
}

