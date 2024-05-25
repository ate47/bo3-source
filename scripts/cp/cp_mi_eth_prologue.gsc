#using scripts/cp/voice/voice_prologue;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_ending;
#using scripts/cp/cp_prologue_player_sacrifice;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_bridge;
#using scripts/cp/cp_prologue_dark_battle;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_hostage_rescue;
#using scripts/cp/cp_prologue_security_camera;
#using scripts/cp/cp_prologue_enter_base;
#using scripts/cp/cp_prologue_intro;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_collectibles;
#using scripts/cp/_util;
#using scripts/cp/_turret_sentry;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_accolades;
#using scripts/codescripts/struct;

#namespace cp_mi_eth_prologue;

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x31b3a6e5, Offset: 0x2348
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf5f6feff, Offset: 0x2388
// Size: 0x11
function main() {
    // Can't decompile export cp_mi_eth_prologue::main Unknown operator 0x9d
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xfe1ae157, Offset: 0x25f0
// Size: 0x3
function function_7bf018c5() {
    // Can't decompile export cp_mi_eth_prologue::function_7bf018c5 Unknown operator 0xe2
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x479dd4e9, Offset: 0x2618
// Size: 0x54
function function_d446a137() {
    // Can't decompile export cp_mi_eth_prologue::function_d446a137 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x817bf7fb, Offset: 0x2700
// Size: 0x9
function init_flags() {
    // Can't decompile export cp_mi_eth_prologue::init_flags Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf68a8de9, Offset: 0x2da0
// Size: 0x1a
function on_player_connect() {
    self flag::init("custom_loadout");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xaf347e19, Offset: 0x2dc8
// Size: 0x49
function on_player_spawned() {
    // Can't decompile export cp_mi_eth_prologue::on_player_spawned Unknown operator 0xdd
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x49c40327, Offset: 0x30b0
// Size: 0x11
function on_player_loadout() {
    // Can't decompile export cp_mi_eth_prologue::on_player_loadout Unknown operator 0x16
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xc7b7618b, Offset: 0x3138
// Size: 0x3a
function function_3fe38b8a() {
    // Can't decompile export cp_mi_eth_prologue::function_3fe38b8a Unknown operator 0x6a
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x9dd5c4b2, Offset: 0x31e0
// Size: 0x9
function init_clientfields() {
    // Can't decompile export cp_mi_eth_prologue::init_clientfields Unknown operator 0xe2
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3560
// Size: 0x2
function precache() {
    
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x6968cbb6, Offset: 0x3570
// Size: 0x582
function function_673254cc() {
    skipto::add("skipto_air_traffic_controller", &function_f30178fc, "Air Traffic Controller", &function_f0e11b0f);
    skipto::function_d68e678e("skipto_nrc_knocking", &function_5bf6196d, "NRC Knocking", &function_99e8b2fa);
    skipto::add("skipto_blend_in", &function_9afd1f40, "Blend In", &function_a856a753);
    skipto::function_d68e678e("skipto_take_out_guards", &function_6977d5a4, "Take Out Guards", &function_33e74d97);
    skipto::function_d68e678e("skipto_security_camera", &function_57c4f8a7, "Security Camera", &function_e9c19f80);
    skipto::function_d68e678e("skipto_hostage_1", &function_f70ba4de, "Fuel Depot", &function_b8ac064d);
    skipto::function_d68e678e("skipto_prison", &function_563809d0, "Prison", &function_c5e740c3);
    skipto::function_d68e678e("skipto_security_desk", &function_cb5e9ce9, "Security Desk", &function_9a16286);
    skipto::function_d68e678e("skipto_lift_escape", &function_129dd7aa, "Lift Escape", &function_874e4009);
    skipto::function_d68e678e("skipto_intro_cyber_soldiers", &function_8b6d4df5, "Intro Cyber Soldiers", &function_2cf07fc2);
    skipto::function_d68e678e("skipto_hangar", &function_5eddb104, "Hangar", &function_45eb05f7);
    skipto::function_d68e678e("skipto_vtol_collapse", &function_d797037e, "VTOL Collapse", &function_9af4a8ed);
    skipto::function_d68e678e("skipto_jeep_alley", &function_ddf114c9, "Jeep Alley", &function_fea8bf66);
    skipto::add("skipto_bridge_battle", &function_d714762b, "Bridge Battle", &function_47b85bb4);
    skipto::function_d68e678e("skipto_dark_battle", &function_32dc1c24, "Dark Battle", &function_5ee97c17);
    skipto::function_d68e678e("skipto_vtol_tackle", &function_30f4cc7b, "Vtol Tackle", &function_c16332e4);
    skipto::function_d68e678e("skipto_robot_horde", &function_34495a26, "Robot Horde", &function_b91214d5);
    skipto::function_d68e678e("skipto_apc", &apc::function_61ebdfad, "APC", &apc::function_c92883a);
    skipto::function_d68e678e("skipto_apc_rail", &apc::function_c1b99214, "APC Rail", &apc::function_961480e7);
    skipto::add("skipto_apc_rail_stall", &apc::function_2ac0c49, "APC Rail Stall", &apc::function_fbfbaee6);
    skipto::function_d68e678e("skipto_robot_defend", &function_373c7d0a, "Robot Defend", &function_d287c569);
    skipto::add("skipto_prologue_ending", &namespace_b7c5904::function_48700afe, "Player Prologue Ending", &namespace_b7c5904::function_cc36a86d);
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x23fda9e4, Offset: 0x3b00
// Size: 0x3a
function function_f30178fc(str_objective, var_74cd64bc) {
    function_77d9dff("objective_air_traffic_controller_init");
    namespace_93c87ad0::function_dc04ece5();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x68359e10, Offset: 0x3b48
// Size: 0x22
function function_f0e11b0f(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_f0e11b0f Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xd3d4ea1, Offset: 0x3ba8
// Size: 0x12
function function_5bf6196d(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_5bf6196d Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb8708424, Offset: 0x3ca0
// Size: 0x3a
function function_99e8b2fa(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_99e8b2fa Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xa995e749, Offset: 0x3dd0
// Size: 0x12
function function_9afd1f40(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_9afd1f40 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xd74ec893, Offset: 0x3f80
// Size: 0x22
function function_a856a753(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_a856a753 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x2f8a8d98, Offset: 0x4030
// Size: 0x2a
function function_6977d5a4(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_6977d5a4 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xe48d9c13, Offset: 0x4140
// Size: 0x41
function function_33e74d97(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_33e74d97 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xf3c80cf7, Offset: 0x4268
// Size: 0x2a
function function_57c4f8a7(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_57c4f8a7 Unknown operator 0xfa
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xac54bfa8, Offset: 0x4408
// Size: 0x4b
function function_e9c19f80(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_e9c19f80 Unknown operator 0x76
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x49eb39ec, Offset: 0x4520
// Size: 0x12
function function_f70ba4de(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_f70ba4de Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb94976e6, Offset: 0x4610
// Size: 0x42
function function_b8ac064d(name, var_a334437f, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_b8ac064d Unknown operator 0x77
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x5d1757b1, Offset: 0x46d0
// Size: 0x12
function function_563809d0(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_563809d0 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb55bbf1, Offset: 0x4778
// Size: 0x22
function function_c5e740c3(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_c5e740c3 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x71eceb00, Offset: 0x4828
// Size: 0x22
function function_cb5e9ce9(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_cb5e9ce9 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xaaa3f907, Offset: 0x4a10
// Size: 0x29
function function_9a16286(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_9a16286 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xfe24c77d, Offset: 0x4a70
// Size: 0x12
function function_129dd7aa(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_129dd7aa Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x4b983019, Offset: 0x4b50
// Size: 0x2b
function function_874e4009(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_874e4009 Unknown operator 0xe2
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x886a9207, Offset: 0x4d20
// Size: 0x2a
function function_8b6d4df5(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_8b6d4df5 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x9256d17a, Offset: 0x4f08
// Size: 0x29
function function_2cf07fc2(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_2cf07fc2 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x43033a60, Offset: 0x5070
// Size: 0x72
function function_5eddb104(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_5eddb104 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x3bbc8684, Offset: 0x52d8
// Size: 0x29
function function_45eb05f7(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_45eb05f7 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x9d509f4e, Offset: 0x5358
// Size: 0x32
function function_d797037e(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_d797037e Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x6f5eabc2, Offset: 0x55c0
// Size: 0xd5
function function_9af4a8ed(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_9af4a8ed Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x3d7f59b8, Offset: 0x5778
// Size: 0x32
function function_ddf114c9(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_ddf114c9 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x1afbaeb2, Offset: 0x58e0
// Size: 0x3a
function function_fea8bf66(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("jeep_alley_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xab8787bf, Offset: 0x5928
// Size: 0x85
function function_d714762b(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_d714762b Unknown operator 0x98
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x44542c09, Offset: 0x5bf8
// Size: 0xe4
function function_47b85bb4(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_47b85bb4 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x64f0eea4, Offset: 0x5e10
// Size: 0x1a
function function_32dc1c24(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_32dc1c24 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x5cb08be2, Offset: 0x5fe0
// Size: 0x81
function function_5ee97c17(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_5ee97c17 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x6fe962cb, Offset: 0x6358
// Size: 0x3a
function function_30f4cc7b(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_30f4cc7b Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x8f29a91b, Offset: 0x6648
// Size: 0x3a
function function_c16332e4(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("vtol_tackle_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xaf672c82, Offset: 0x6690
// Size: 0x52
function function_34495a26(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_34495a26 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xa6494444, Offset: 0x6890
// Size: 0x3a
function function_b91214d5(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("robot_horde_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xb54c9ba7, Offset: 0x68d8
// Size: 0x32
function function_373c7d0a(str_objective, var_74cd64bc) {
    // Can't decompile export cp_mi_eth_prologue::function_373c7d0a Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xd82e2ca8, Offset: 0x6bb0
// Size: 0x7c
function function_b5502f69() {
    // Can't decompile export cp_mi_eth_prologue::function_b5502f69 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x72973546, Offset: 0x6cb8
// Size: 0x41
function function_d287c569(name, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export cp_mi_eth_prologue::function_d287c569 Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xa499e3c5, Offset: 0x6d08
// Size: 0xa
function function_77d9dff(msg) {
    // Can't decompile export cp_mi_eth_prologue::function_77d9dff Unknown operator 0x67
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x4a97eb28, Offset: 0x6d40
// Size: 0x5d
function function_bff1a867(var_a7fcc91d) {
    // Can't decompile export cp_mi_eth_prologue::function_bff1a867 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xbac41de4, Offset: 0x6e08
// Size: 0x32
function function_211ff3c7(var_a7fcc91d) {
    // Can't decompile export cp_mi_eth_prologue::function_211ff3c7 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x60175324, Offset: 0x6ed0
// Size: 0x32
function function_c117302b(var_a7fcc91d) {
    // Can't decompile export cp_mi_eth_prologue::function_c117302b Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x14a8ab2c, Offset: 0x6f58
// Size: 0x21
function function_16f6b7f1(var_c335265b) {
    // Can't decompile export cp_mi_eth_prologue::function_16f6b7f1 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xbb43831f, Offset: 0x6fd0
// Size: 0xa
function function_b6ef2c4e(str_group) {
    // Can't decompile export cp_mi_eth_prologue::function_b6ef2c4e Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xec8f7be4, Offset: 0x6ff0
// Size: 0x34
function function_6a77bdd4(str_group) {
    // Can't decompile export cp_mi_eth_prologue::function_6a77bdd4 Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x31dfbc16, Offset: 0x70a0
// Size: 0xb
function function_899f174d(str_group) {
    // Can't decompile export cp_mi_eth_prologue::function_899f174d Unknown operator 0x5d
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x8fd588f0, Offset: 0x70c8
// Size: 0x9
function function_4d4f1d4f() {
    // Can't decompile export cp_mi_eth_prologue::function_4d4f1d4f Unknown operator 0xd4
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf1989ff0, Offset: 0x7100
// Size: 0x9
function function_7072c5d8() {
    // Can't decompile export cp_mi_eth_prologue::function_7072c5d8 Unknown operator 0xd4
}

