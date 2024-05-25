#using scripts/cp/_accolades;
#using scripts/shared/trigger_shared;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f25bd8c8;

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc11546be, Offset: 0x528
// Size: 0x20a
function function_66df416f() {
    accolades::register("MISSION_INFECTION_UNTOUCHED");
    accolades::register("MISSION_INFECTION_SCORE");
    accolades::register("MISSION_INFECTION_COLLECTIBLE");
    accolades::register("MISSION_INFECTION_CHALLENGE3", "ch03_quick_kills_complete");
    accolades::register("MISSION_INFECTION_CHALLENGE4", "ch04_theia_battle_no_damage_completed");
    accolades::register("MISSION_INFECTION_HATTRICK", "ch05_helmet_shot");
    accolades::register("MISSION_INFECTION_CHALLENGE6", "ch06_mg42_kill");
    accolades::register("MISSION_INFECTION_CHALLENGE9", "ch09_wolf_midair_kills_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE10", "ch10_wolf_melee_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE11", "ch11_wolf_bite_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE12", "ch12_tank_killer_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE14", "ch14_cathedral_untouchable_grant");
    accolades::register("MISSION_INFECTION_CHALLENGE15", "ch15_zombies_untouchable_grant");
    accolades::register("MISSION_INFECTION_CHALLENGE16", "ch16_zombie_bonfire");
    accolades::register("MISSION_INFECTION_CHALLENGE17", "ch17_confirmed_hit");
    accolades::register("MISSION_INFECTION_CHALLENGE18", "ch18_sarah_grenaded");
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x54b93aa4, Offset: 0x740
// Size: 0x12
function on_player_connect() {
    self function_804e65bb();
}

// Namespace namespace_f25bd8c8
// Params 3, eflags: 0x0
// Checksum 0xbfaad7ee, Offset: 0x760
// Size: 0x1b
function function_5a97e5bd(var_8e087689, e_player, var_70b01bd3) {
    // Can't decompile export namespace_f25bd8c8::function_5a97e5bd Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x5e4cf9ab, Offset: 0x798
// Size: 0x2
function function_804e65bb() {
    // Can't decompile export namespace_f25bd8c8::function_804e65bb Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x3e72f9a6, Offset: 0x7d8
// Size: 0x2a
function function_346b87d1() {
    // Can't decompile export namespace_f25bd8c8::function_346b87d1 Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x85b08863, Offset: 0x880
// Size: 0x2b
function function_ba00a6fc(params) {
    // Can't decompile export namespace_f25bd8c8::function_ba00a6fc Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xd909aa8c, Offset: 0x9b8
// Size: 0x2
function function_ad15914d() {
    // Can't decompile export namespace_f25bd8c8::function_ad15914d Unknown operator 0xe2
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xef0f5080, Offset: 0x9f0
// Size: 0x11
function function_6427aa57() {
    // Can't decompile export namespace_f25bd8c8::function_6427aa57 Unknown operator 0xd4
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x33d22381, Offset: 0xa30
// Size: 0x19
function function_9d23c86c() {
    // Can't decompile export namespace_f25bd8c8::function_9d23c86c Unknown operator 0xd4
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x703b6466, Offset: 0xa78
// Size: 0x22
function function_15b29a5a() {
    callback::on_actor_killed(&function_918d0428);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x7de13714, Offset: 0xaa8
// Size: 0xa
function function_918d0428(params) {
    // Can't decompile export namespace_f25bd8c8::function_918d0428 Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdce46e04, Offset: 0xb30
// Size: 0x22
function function_ecd2ed4() {
    callback::remove_on_actor_killed(&function_918d0428);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x519bac18, Offset: 0xb60
// Size: 0x22
function function_c081e535() {
    callback::on_actor_killed(&function_e7e68fa2);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xcd043e7, Offset: 0xb90
// Size: 0xa
function function_e7e68fa2(params) {
    // Can't decompile export namespace_f25bd8c8::function_e7e68fa2 Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdacaabbc, Offset: 0xc10
// Size: 0x22
function function_a0f567cb() {
    callback::remove_on_actor_killed(&function_e7e68fa2);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x2b8c1072, Offset: 0xc40
// Size: 0x42
function function_341d8f7a() {
    callback::on_ai_killed(&function_423d8d8c);
    callback::on_ai_spawned(&function_21f98ad9);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x4fbf4f4d, Offset: 0xc90
// Size: 0x21
function function_423d8d8c(params) {
    // Can't decompile export namespace_f25bd8c8::function_423d8d8c Unknown operator 0x57
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x933becfe, Offset: 0xd08
// Size: 0x11
function function_21f98ad9() {
    // Can't decompile export namespace_f25bd8c8::function_21f98ad9 Unknown operator 0x28
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc456167e, Offset: 0xd38
// Size: 0x11
function function_a12f3181() {
    // Can't decompile export namespace_f25bd8c8::function_a12f3181 Unknown operator 0xd4
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x9b50f2ea, Offset: 0xd90
// Size: 0x42
function function_a2179c84() {
    callback::remove_on_ai_killed(&function_423d8d8c);
    callback::remove_on_ai_spawned(&function_21f98ad9);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xe985324c, Offset: 0xde0
// Size: 0x62
function function_8c0b0cd0() {
    // Can't decompile export namespace_f25bd8c8::function_8c0b0cd0 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x8dd886c, Offset: 0xe98
// Size: 0x2
function function_b59240f2() {
    // Can't decompile export namespace_f25bd8c8::function_b59240f2 Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x433aeb50, Offset: 0xeb8
// Size: 0x19
function function_20c5379e(params) {
    // Can't decompile export namespace_f25bd8c8::function_20c5379e Unknown operator 0x57
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xf34108cf, Offset: 0xf50
// Size: 0xa
function function_3dc86a1(params) {
    // Can't decompile export namespace_f25bd8c8::function_3dc86a1 Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x7ab4f9d5, Offset: 0xff0
// Size: 0x62
function function_74b401d8() {
    // Can't decompile export namespace_f25bd8c8::function_74b401d8 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x359d2f50, Offset: 0x10b0
// Size: 0x62
function function_aea367c1() {
    // Can't decompile export namespace_f25bd8c8::function_aea367c1 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x48cd2392, Offset: 0x1158
// Size: 0x2
function function_6bc56950() {
    // Can't decompile export namespace_f25bd8c8::function_6bc56950 Unknown operator 0xe2
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x2427434e, Offset: 0x1170
// Size: 0x6b
function function_d9aaed7d() {
    // Can't decompile export namespace_f25bd8c8::function_d9aaed7d Unknown operator 0xe2
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x520c7089, Offset: 0x1240
// Size: 0x62
function function_b3cf52bf() {
    // Can't decompile export namespace_f25bd8c8::function_b3cf52bf Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x9dae1a22, Offset: 0x1300
// Size: 0xb
function function_7356f9fd() {
    // Can't decompile export namespace_f25bd8c8::function_7356f9fd Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbbfad6f7, Offset: 0x1340
// Size: 0x2a
function function_2c3b4c78() {
    // Can't decompile export namespace_f25bd8c8::function_2c3b4c78 Unknown operator 0xc0
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdc695d62, Offset: 0x13c8
// Size: 0x42
function function_211b07c5() {
    // Can't decompile export namespace_f25bd8c8::function_211b07c5 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x4f69803f, Offset: 0x1450
// Size: 0x12
function function_9f9141fd() {
    // Can't decompile export namespace_f25bd8c8::function_9f9141fd Unknown operator 0xc0
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x5856b04, Offset: 0x1478
// Size: 0x42
function function_2c8ffdaf() {
    // Can't decompile export namespace_f25bd8c8::function_2c8ffdaf Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xf9bb3cc7, Offset: 0x1510
// Size: 0x22
function function_6c777c8d() {
    // Can't decompile export namespace_f25bd8c8::function_6c777c8d Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbce969bb, Offset: 0x1590
// Size: 0x1a
function function_335ecd05() {
    // Can't decompile export namespace_f25bd8c8::function_335ecd05 Unknown operator 0xc0
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x26d706ec, Offset: 0x15c0
// Size: 0x22
function function_e9c21474() {
    // Can't decompile export namespace_f25bd8c8::function_e9c21474 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xa2d6293c, Offset: 0x1638
// Size: 0x62
function function_a0fb8ca9() {
    // Can't decompile export namespace_f25bd8c8::function_a0fb8ca9 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc3e360f2, Offset: 0x16e0
// Size: 0x2
function function_7eac16b1() {
    // Can't decompile export namespace_f25bd8c8::function_7eac16b1 Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x8d161564, Offset: 0x16f8
// Size: 0x19
function function_98c5c5a1(params) {
    // Can't decompile export namespace_f25bd8c8::function_98c5c5a1 Unknown operator 0x28
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xb9d4cdfe, Offset: 0x1778
// Size: 0x62
function function_bbb224b7() {
    // Can't decompile export namespace_f25bd8c8::function_bbb224b7 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbd46bbdc, Offset: 0x1830
// Size: 0x22
function function_70cafec1() {
    // Can't decompile export namespace_f25bd8c8::function_70cafec1 Unknown operator 0xfa
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x85088839, Offset: 0x18e0
// Size: 0x2
function function_f6215929() {
    // Can't decompile export namespace_f25bd8c8::function_f6215929 Unknown operator 0x76
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xd880f418, Offset: 0x18f8
// Size: 0x12
function function_7dfda27d(params) {
    // Can't decompile export namespace_f25bd8c8::function_7dfda27d Unknown operator 0x5d
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x4f5abf3d, Offset: 0x19c0
// Size: 0x22
function function_cce60169() {
    // Can't decompile export namespace_f25bd8c8::function_cce60169 Unknown operator 0xfa
}

