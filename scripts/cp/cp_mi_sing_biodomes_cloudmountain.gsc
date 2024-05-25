#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_squad_control;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_laststand;
#using scripts/cp/_hacking;
#using scripts/cp/_dialog;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_f5edec75;

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x26c0
// Size: 0x2
function precache() {
    
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xd6bea320, Offset: 0x26d0
// Size: 0x183
function main() {
    // Can't decompile export namespace_f5edec75::main Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8a783b3a, Offset: 0x2870
// Size: 0x2a2
function function_710c7f6a() {
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_warehouse"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
    objectives::hide("cp_waypoint_breadcrumb");
    trigger::wait_till("trig_level_2_enemy_spawns_1");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_03");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_04");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_04"));
    trigger::wait_till("trig_level_3_catwalk_reinforcements");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain04"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_end");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0xf7b0437d, Offset: 0x2b20
// Size: 0x32
function function_34f37fe(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_f5edec75::function_34f37fe Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x2d509463, Offset: 0x2ca0
// Size: 0x3
function function_6da34baf() {
    // Can't decompile export namespace_f5edec75::function_6da34baf Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x609ae444, Offset: 0x2e28
// Size: 0x9
function function_9a10cb7d() {
    // Can't decompile export namespace_f5edec75::function_9a10cb7d Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x63257102, Offset: 0x2e60
// Size: 0x65
function function_efae47c8() {
    // Can't decompile export namespace_f5edec75::function_efae47c8 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x13a87593, Offset: 0x2f90
// Size: 0x21
function function_7ec07da9() {
    // Can't decompile export namespace_f5edec75::function_7ec07da9 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xcff45138, Offset: 0x30c0
// Size: 0x12
function function_1932917(var_f7824075) {
    // Can't decompile export namespace_f5edec75::function_1932917 Unknown operator 0xc0
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xd3f8a20f, Offset: 0x3188
// Size: 0x31
function function_f6a70610(var_c81e3075) {
    // Can't decompile export namespace_f5edec75::function_f6a70610 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x95bd4102, Offset: 0x3220
// Size: 0x9
function function_a1fa89a2() {
    // Can't decompile export namespace_f5edec75::function_a1fa89a2 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x82082c44, Offset: 0x32a8
// Size: 0x3
function function_a234f527() {
    // Can't decompile export namespace_f5edec75::function_a234f527 Unknown operator 0x76
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x26766307, Offset: 0x3368
// Size: 0xa
function function_b2ae6383(var_b146902) {
    // Can't decompile export namespace_f5edec75::function_b2ae6383 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x3a0f4267, Offset: 0x3498
// Size: 0x42
function function_170b0353(var_b146902) {
    // Can't decompile export namespace_f5edec75::function_170b0353 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0xda1f9b21, Offset: 0x3810
// Size: 0x5a
function function_e2e19ed7(var_69e64c43, var_2148cdcc) {
    // Can't decompile export namespace_f5edec75::function_e2e19ed7 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xc50c863f, Offset: 0x39a0
// Size: 0x11
function function_333f5b5b() {
    // Can't decompile export namespace_f5edec75::function_333f5b5b Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x97d22ed0, Offset: 0x3a98
// Size: 0xb
function function_a288e474() {
    // Can't decompile export namespace_f5edec75::function_a288e474 Unknown operator 0xa7
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8058a9ef, Offset: 0x3b08
// Size: 0x21
function function_7dffd386() {
    // Can't decompile export namespace_f5edec75::function_7dffd386 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0x4afee5c0, Offset: 0x3b60
// Size: 0x3a
function function_ace9f6d8(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("objective_cloudmountain_done");
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0x24b5fc14, Offset: 0x3ba8
// Size: 0x32
function function_8ce887a2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export namespace_f5edec75::function_8ce887a2 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0xfe71535c, Offset: 0x3dc0
// Size: 0x3a
function function_2013f39c(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("objective_cloudmountain_level_2_done");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x9bbb2325, Offset: 0x3e08
// Size: 0x35
function function_8232942d() {
    // Can't decompile export namespace_f5edec75::function_8232942d Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8f7c7570, Offset: 0x3e88
// Size: 0x4c
function function_56019233() {
    // Can't decompile export namespace_f5edec75::function_56019233 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xddfd1b4f, Offset: 0x3f40
// Size: 0x19
function function_9d75973(var_b49710a9) {
    // Can't decompile export namespace_f5edec75::function_9d75973 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xee7b9d4e, Offset: 0x4078
// Size: 0x4d
function function_11f04863() {
    // Can't decompile export namespace_f5edec75::function_11f04863 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x1541a707, Offset: 0x4130
// Size: 0x39
function function_d532cc21() {
    // Can't decompile export namespace_f5edec75::function_d532cc21 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xbea1deb7, Offset: 0x4280
// Size: 0x19
function function_45d0a02a() {
    // Can't decompile export namespace_f5edec75::function_45d0a02a Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xaa061277, Offset: 0x4338
// Size: 0xc
function function_715d6f43() {
    // Can't decompile export namespace_f5edec75::function_715d6f43 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x48a9fada, Offset: 0x4360
// Size: 0x14
function function_ec47b2e6() {
    // Can't decompile export namespace_f5edec75::function_ec47b2e6 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x3f7f8ca5, Offset: 0x43e8
// Size: 0x13
function function_2c36cacd() {
    // Can't decompile export namespace_f5edec75::function_2c36cacd Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xf8e95051, Offset: 0x44d0
// Size: 0x5c
function function_e99db423() {
    // Can't decompile export namespace_f5edec75::function_e99db423 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x2fe2b6ea, Offset: 0x46e0
// Size: 0x11
function function_d7238641() {
    // Can't decompile export namespace_f5edec75::function_d7238641 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8c731424, Offset: 0x4710
// Size: 0x5a
function function_a52ff7c1() {
    function_6f311542();
    trigger::wait_till("trig_cloudmountain_elevators");
    spawner::simple_spawn("cloudmountain_elevator_enemy", &function_f5170df1, "cloudmountain");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xbdc07084, Offset: 0x4778
// Size: 0x34
function function_7c81648() {
    // Can't decompile export namespace_f5edec75::function_7c81648 Unknown operator 0x76
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x6233141c, Offset: 0x47f0
// Size: 0x2
function function_84f859bf() {
    // Can't decompile export namespace_f5edec75::function_84f859bf Unknown operator 0xa7
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x291fd4c0, Offset: 0x4808
// Size: 0x4c
function function_a36395f0() {
    // Can't decompile export namespace_f5edec75::function_a36395f0 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8027e7a5, Offset: 0x48b0
// Size: 0x92
function function_85070883() {
    trigger::wait_till("trig_cloud_mountain_reinforcements");
    spawner::add_spawn_function_group("sp_cloud_mountain_reinforcements_wasps", "targetname", &function_947a1ae8);
    spawn_manager::enable("sm_cloud_mountain_reinforcements");
    spawn_manager::enable("sm_cloud_mountain_reinforcements_wasps");
    spawn_manager::enable("sm_cloud_mountain_retreaters");
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0xbe11d848, Offset: 0x4950
// Size: 0x59
function function_df51ef25(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_f5edec75::function_df51ef25 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x779cf6a7, Offset: 0x4bc0
// Size: 0x41
function function_3679c70a() {
    // Can't decompile export namespace_f5edec75::function_3679c70a Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x4d8a872c, Offset: 0x4d70
// Size: 0x29
function function_f52ce87b() {
    // Can't decompile export namespace_f5edec75::function_f52ce87b Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x75e37903, Offset: 0x4ea0
// Size: 0x82
function function_de8fde30() {
    exploder::exploder("turret_light");
    trigger::wait_till("trig_turret_lights_damaged", "targetname");
    exploder::kill_exploder("turret_light");
    exploder::exploder("fx_turrethallway_turret_smk");
    scene::play("p7_fxanim_gp_floodlight_01_bundle");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x78241098, Offset: 0x4f30
// Size: 0x3
function function_2c72fa5a() {
    // Can't decompile export namespace_f5edec75::function_2c72fa5a Unknown operator 0x76
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x4396abab, Offset: 0x4fe8
// Size: 0x11
function function_d8eaa27f(var_9d979b27) {
    // Can't decompile export namespace_f5edec75::function_d8eaa27f Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x65cb48d5, Offset: 0x5038
// Size: 0x29
function function_c80e1213(var_3199aef) {
    // Can't decompile export namespace_f5edec75::function_c80e1213 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8efdb2c7, Offset: 0x5110
// Size: 0x31
function function_ee13f890() {
    // Can't decompile export namespace_f5edec75::function_ee13f890 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xbd359ed3, Offset: 0x5218
// Size: 0xa
function function_58b4a5d6() {
    // Can't decompile export namespace_f5edec75::function_58b4a5d6 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xf5695825, Offset: 0x5250
// Size: 0x74
function function_50c932d0() {
    // Can't decompile export namespace_f5edec75::function_50c932d0 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0x6009ce63, Offset: 0x5318
// Size: 0xca
function function_9cfbecff(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_biodomes_destroy_hallway_turrets");
    objectives::set("cp_level_biodomes_awaiting_update");
    namespace_27a45d31::function_ddb0eeea("turret_hallway_done");
    getent("trig_turret_hallway_enemy_spawns", "targetname") delete();
    getent("trig_turret_hallway_defender_spawns", "targetname") delete();
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0xf8c2674a, Offset: 0x53f0
// Size: 0x69
function function_e696b86c(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_f5edec75::function_e696b86c Unknown operator 0x76
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xf422a424, Offset: 0x56a8
// Size: 0x3
function function_cd4c4257() {
    // Can't decompile export namespace_f5edec75::function_cd4c4257 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x1807e1ad, Offset: 0x5720
// Size: 0x1a
function function_e638433c() {
    // Can't decompile export namespace_f5edec75::function_e638433c Unknown operator 0xc0
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x1d1c9c26, Offset: 0x57a8
// Size: 0x2
function function_a0e7b9b7() {
    // Can't decompile export namespace_f5edec75::function_a0e7b9b7 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x95496a48, Offset: 0x57c0
// Size: 0x29
function function_9c35b4f7() {
    // Can't decompile export namespace_f5edec75::function_9c35b4f7 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x4732238b, Offset: 0x5a78
// Size: 0xb
function function_934481ae(e_door) {
    // Can't decompile export namespace_f5edec75::function_934481ae Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x84cc733d, Offset: 0x5aa8
// Size: 0x12
function function_9a82e132(e_player) {
    // Can't decompile export namespace_f5edec75::function_9a82e132 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x7e9888b5, Offset: 0x5b38
// Size: 0x2a
function function_2db7566e(a_ents) {
    // Can't decompile export namespace_f5edec75::function_2db7566e Unknown operator 0xfa
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xfac1435b, Offset: 0x5bc8
// Size: 0x11
function function_7dedb1f0(a_ents) {
    // Can't decompile export namespace_f5edec75::function_7dedb1f0 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xb3f6c709, Offset: 0x5c18
// Size: 0x11
function function_d065fdd0(a_ents) {
    // Can't decompile export namespace_f5edec75::function_d065fdd0 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 3, eflags: 0x0
// Checksum 0xc8ade4cf, Offset: 0x5c90
// Size: 0x22
function function_4a1b1d4c(team, player, success) {
    // Can't decompile export namespace_f5edec75::function_4a1b1d4c Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xfbb47a30, Offset: 0x5d48
// Size: 0x22
function function_3de47a8b(a_ents) {
    videostart("cp_biodomes_env_serverhackvid1");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x9d9075a4, Offset: 0x5d78
// Size: 0x22
function function_cbdd0b50(a_ents) {
    videostart("cp_biodomes_env_serverhackvid2");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xb3f08ab9, Offset: 0x5da8
// Size: 0x22
function function_f1df85b9(a_ents) {
    videostart("cp_biodomes_env_serverhackvid3");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x8fb905e4, Offset: 0x5dd8
// Size: 0x34
function function_a91388d2(b_open) {
    // Can't decompile export namespace_f5edec75::function_a91388d2 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0x78d8062e, Offset: 0x5e58
// Size: 0x84
function function_6be20b72(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export namespace_f5edec75::function_6be20b72 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x8f2965df, Offset: 0x5f88
// Size: 0x31
function function_d28364c1() {
    // Can't decompile export namespace_f5edec75::function_d28364c1 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0x6cb8d0d0, Offset: 0x6188
// Size: 0xab
function function_8dacf956(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_f5edec75::function_8dacf956 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x3d2159da, Offset: 0x6448
// Size: 0x9
function function_17d3780e() {
    // Can't decompile export namespace_f5edec75::function_17d3780e Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x2b3a5165, Offset: 0x6488
// Size: 0x19
function function_a78ec4a() {
    // Can't decompile export namespace_f5edec75::function_a78ec4a Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x29a65d87, Offset: 0x6560
// Size: 0x32
function function_2d01c10e() {
    // Can't decompile export namespace_f5edec75::function_2d01c10e Unknown operator 0x1c
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x2b4d9dc0, Offset: 0x6ef8
// Size: 0x14
function function_229a8bc9() {
    // Can't decompile export namespace_f5edec75::function_229a8bc9 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x0
// Checksum 0x8b74a14, Offset: 0x6ff8
// Size: 0x75
function function_ca5f1131(a_enemies, var_7bcec858) {
    // Can't decompile export namespace_f5edec75::function_ca5f1131 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x25e95f18, Offset: 0x7170
// Size: 0x35
function function_560d15cf() {
    // Can't decompile export namespace_f5edec75::function_560d15cf Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xea1aaa4e, Offset: 0x7278
// Size: 0x52
function function_7ed3a33e() {
    // Can't decompile export namespace_f5edec75::function_7ed3a33e Unknown operator 0x1c
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x1ff4dc25, Offset: 0x73e0
// Size: 0x19
function function_451e55d0(var_190535de) {
    // Can't decompile export namespace_f5edec75::function_451e55d0 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x450db729, Offset: 0x74b8
// Size: 0x45
function function_7f9c1afd() {
    // Can't decompile export namespace_f5edec75::function_7f9c1afd Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x2a91727, Offset: 0x7608
// Size: 0x19
function function_d813e7f(var_74cd64bc) {
    // Can't decompile export namespace_f5edec75::function_d813e7f Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x0
// Checksum 0x735e6e22, Offset: 0x7750
// Size: 0x43
function function_9ed4c7c0(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export namespace_f5edec75::function_9ed4c7c0 Unknown operator 0xfa
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x24f4380f, Offset: 0x7870
// Size: 0x95
function function_f5170df1(str_location) {
    // Can't decompile export namespace_f5edec75::function_f5170df1 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x5b0b931a, Offset: 0x7b48
// Size: 0x75
function function_40ff4c80() {
    // Can't decompile export namespace_f5edec75::function_40ff4c80 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xfbd057a8, Offset: 0x7c70
// Size: 0x4c
function function_88e395d2() {
    // Can't decompile export namespace_f5edec75::function_88e395d2 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x771d9400, Offset: 0x7d10
// Size: 0x19
function function_8bf5e64e(str_location) {
    // Can't decompile export namespace_f5edec75::function_8bf5e64e Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x60e2e010, Offset: 0x7dd8
// Size: 0x62
function function_28931f52() {
    // Can't decompile export namespace_f5edec75::function_28931f52 Unknown operator 0xfa
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xccc301aa, Offset: 0x7f60
// Size: 0x23
function function_7b66a225() {
    // Can't decompile export namespace_f5edec75::function_7b66a225 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x82dcde73, Offset: 0x8090
// Size: 0x2d
function function_d2bb2597() {
    // Can't decompile export namespace_f5edec75::function_d2bb2597 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x91bba039, Offset: 0x80e0
// Size: 0x35
function function_13ed10e0() {
    // Can't decompile export namespace_f5edec75::function_13ed10e0 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x899faba1, Offset: 0x8230
// Size: 0x9
function function_564d6426() {
    // Can't decompile export namespace_f5edec75::function_564d6426 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xdb219a56, Offset: 0x8260
// Size: 0x31
function function_963807b1() {
    // Can't decompile export namespace_f5edec75::function_963807b1 Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x308e00e0, Offset: 0x8420
// Size: 0x9
function function_72d7b33c() {
    // Can't decompile export namespace_f5edec75::function_72d7b33c Unknown operator 0xd4
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x96b28a4a, Offset: 0x86e8
// Size: 0x85
function function_dde40552() {
    // Can't decompile export namespace_f5edec75::function_dde40552 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xb742df57, Offset: 0x89e8
// Size: 0x11
function function_f879ebc4(var_c312dab9) {
    // Can't decompile export namespace_f5edec75::function_f879ebc4 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0x8f1007cf, Offset: 0x8a28
// Size: 0x3a
function function_e87de176(var_4ca5dd1f) {
    // Can't decompile export namespace_f5edec75::function_e87de176 Unknown operator 0xc0
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x98a918ba, Offset: 0x8ad8
// Size: 0x22
function function_c81145c2() {
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x25664197, Offset: 0x8b08
// Size: 0x22
function function_6a4cb712() {
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x41ebbef, Offset: 0x8b38
// Size: 0x3
function function_4df7264d() {
    // Can't decompile export namespace_f5edec75::function_4df7264d Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 3, eflags: 0x0
// Checksum 0x943ff4a, Offset: 0x8b98
// Size: 0x1b
function function_c9d85cf6(var_9ae72db, var_7da22691, var_91c4d84f) {
    // Can't decompile export namespace_f5edec75::function_c9d85cf6 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xa9f6b2b4, Offset: 0x8c40
// Size: 0x19
function function_524e3ee1(var_9ae72db) {
    // Can't decompile export namespace_f5edec75::function_524e3ee1 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x80f64269, Offset: 0x8cd0
// Size: 0x55
function function_6f311542() {
    // Can't decompile export namespace_f5edec75::function_6f311542 Unknown operator 0x5d
}

// Namespace namespace_f5edec75
// Params 6, eflags: 0x0
// Checksum 0x54fbc0fa, Offset: 0x8d50
// Size: 0x32
function function_dbcb1086(var_fc05da5a, n_timer, var_32af39a0, var_a4b6a8db, var_7eb42e72, var_f0bb9dad) {
    // Can't decompile export namespace_f5edec75::function_dbcb1086 Unknown operator 0xe2
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x20f4c86d, Offset: 0x8ec0
// Size: 0x35
function function_947a1ae8() {
    // Can't decompile export namespace_f5edec75::function_947a1ae8 Unknown operator 0xe2
}

