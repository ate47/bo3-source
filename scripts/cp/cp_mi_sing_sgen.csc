#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_fx;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/shared/exploder_shared;
#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_4bf13193;

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x9cd26713, Offset: 0x1370
// Size: 0x3
function main() {
    // Can't decompile export namespace_4bf13193::main Unknown operator 0xe2
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0xd78734e1, Offset: 0x14a0
// Size: 0x23
function on_player_spawned(localclientnum) {
    // Can't decompile export namespace_4bf13193::on_player_spawned Unknown operator 0x76
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xa948bfc, Offset: 0x1580
// Size: 0x3
function init_clientfields() {
    // Can't decompile export namespace_4bf13193::init_clientfields Unknown operator 0x76
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xaa43f87a, Offset: 0x2010
// Size: 0x3a
function function_fe72942e() {
    // Can't decompile export namespace_4bf13193::function_fe72942e Unknown operator 0x2f
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xb4442cfe, Offset: 0x20b8
// Size: 0x4e2
function function_673254cc() {
    skipto::add("intro", &function_c1c92a60, "Intro");
    skipto::add("exterior", &function_f591a5d3, "Exterior");
    skipto::add("enter_sgen", &function_41d43f98, "Enter SGEN");
    skipto::add("enter_lobby", &function_64b835d1, "QTank Fight", &function_8903df94);
    skipto::add("discover_data", &function_b5bc2e86, "Discover Data");
    skipto::add("aquarium_shimmy", &function_d70d27cf, "Aquarium Shimmy");
    skipto::add("gen_lab", &function_b8453b40, "Genetics Lab");
    skipto::add("post_gen_lab", &function_c9a9671f, "Post Gen Lab");
    skipto::add("chem_lab", &function_69d3873d, "Chemical Lab");
    skipto::add("post_chem_lab", &function_7f2d460, "Post Chem Lab");
    skipto::add("silo_floor", &function_7ed6c252, "Silo Floor Battle", &function_e3f81a25);
    skipto::add("under_silo", &function_82a600e0, "Under Silo");
    skipto::add("fallen_soldiers", &function_6a18d1d4, "Fallen Soldiers");
    skipto::add("testing_lab_igc", &function_6a18d1d4, "Human Testing Lab");
    skipto::add("dark_battle", &function_70fafd70, "Dark Battle");
    skipto::add("charging_station", &function_6a18d1d4, "Charging Station");
    skipto::add("descent", &function_6a18d1d4, "Descent");
    skipto::add("pallas_start", &function_1eba9086, "pallas start");
    skipto::add("pallas_end", &function_6a18d1d4, "Pallas Death");
    skipto::add("twin_revenge", &function_8a68f6ae, "Twin Revenge", &function_9dd018de);
    skipto::add("flood_combat", &function_12a6900b, "Flood Combat");
    skipto::add("flood_defend", &function_12a6900b, "Flood Defend");
    skipto::add("underwater_battle", &function_12a6900b, "Underwater Battle");
    skipto::add("underwater_rail", &function_12a6900b, "Underwater Rail");
    skipto::add("silo_swim", &function_12a6900b, "Silo Swim");
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x20643a14, Offset: 0x25a8
// Size: 0x12
function function_6a18d1d4(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xf593029e, Offset: 0x25c8
// Size: 0x12
function function_70fafd70(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_70fafd70 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xe2780fe0, Offset: 0x2600
// Size: 0x12
function function_12a6900b(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_12a6900b Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x463dc76f, Offset: 0x2640
// Size: 0x19
function function_1eba9086(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_1eba9086 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x7fc39cbd, Offset: 0x2678
// Size: 0x13
function function_c1c92a60(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_c1c92a60 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xe7812b51, Offset: 0x26a8
// Size: 0x12
function function_f591a5d3(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_f591a5d3 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x452b27a7, Offset: 0x26e0
// Size: 0x12
function function_41d43f98(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_41d43f98 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xba966f22, Offset: 0x2718
// Size: 0x12
function function_64b835d1(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_64b835d1 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xb8a9d25d, Offset: 0x2750
// Size: 0x12
function function_8903df94(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xf7cace28, Offset: 0x2770
// Size: 0x12
function function_b5bc2e86(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_b5bc2e86 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xf16ab0d6, Offset: 0x27a8
// Size: 0x12
function function_d70d27cf(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_d70d27cf Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x217832eb, Offset: 0x27e0
// Size: 0x12
function function_b8453b40(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_b8453b40 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x82334a91, Offset: 0x2818
// Size: 0x12
function function_c9a9671f(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_c9a9671f Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xacc9db6c, Offset: 0x2850
// Size: 0x12
function function_69d3873d(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_69d3873d Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x301722fb, Offset: 0x2888
// Size: 0x12
function function_7f2d460(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_7f2d460 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x33107d89, Offset: 0x28c0
// Size: 0x12
function function_7ed6c252(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_7ed6c252 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xf28240a6, Offset: 0x28f8
// Size: 0x12
function function_e3f81a25(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_e3f81a25 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xf9c692c3, Offset: 0x2980
// Size: 0x12
function function_82a600e0(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_4bf13193::function_82a600e0 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0x232ca234, Offset: 0x29b8
// Size: 0x12
function function_8a68f6ae(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xa2746baa, Offset: 0x29d8
// Size: 0x12
function function_9dd018de(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x4f11f877, Offset: 0x29f8
// Size: 0x9
function function_6dddaec0() {
    // Can't decompile export namespace_4bf13193::function_6dddaec0 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xf1808b83, Offset: 0x2a38
// Size: 0x9
function function_941e3519() {
    // Can't decompile export namespace_4bf13193::function_941e3519 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x1cd147a7, Offset: 0x2a60
// Size: 0x9
function function_32a8709a() {
    // Can't decompile export namespace_4bf13193::function_32a8709a Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xe53e8092, Offset: 0x2a88
// Size: 0x3a
function function_1561b96d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_1561b96d Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x2235e62d, Offset: 0x2b18
// Size: 0x3a
function function_8b62fa9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_8b62fa9d Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xa1bc1e6f, Offset: 0x2bb0
// Size: 0x3a
function function_47257e43(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_47257e43 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 4, eflags: 0x0
// Checksum 0xef7426f7, Offset: 0x2c28
// Size: 0x22
function function_2370f00f(localclientnum, newval, str_value, str_key) {
    // Can't decompile export namespace_4bf13193::function_2370f00f Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x35993abc, Offset: 0x2ca0
// Size: 0x49
function function_2f6bc99e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_2f6bc99e Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xa88b5e0c, Offset: 0x2d08
// Size: 0x41
function function_73dfc2c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_73dfc2c8 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x60dce56, Offset: 0x2d68
// Size: 0x41
function function_e0e27617(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_e0e27617 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xad5a9bdf, Offset: 0x2dc8
// Size: 0x9
function function_4b788e97() {
    // Can't decompile export namespace_4bf13193::function_4b788e97 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xc68dc5e4, Offset: 0x2df0
// Size: 0x3a
function function_b309e328(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_b309e328 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x1c8ad028, Offset: 0x2e50
// Size: 0x3a
function function_19ebac1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_19ebac1e Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xaf8fa9ad, Offset: 0x2eb0
// Size: 0x3a
function function_39252d24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_39252d24 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x4d10b358, Offset: 0x2f18
// Size: 0x3b
function function_d69a238f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_d69a238f Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x38ea3e21, Offset: 0x2f78
// Size: 0x3a
function function_6a3af99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_6a3af99 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x58e7a5ec, Offset: 0x2fe0
// Size: 0x4a
function function_fe61b5f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_fe61b5f4 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x7e26786e, Offset: 0x3208
// Size: 0x3a
function function_ba68067e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_ba68067e Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0xe70d11de, Offset: 0x3298
// Size: 0x2a
function function_248868ae(localclientnum) {
    // Can't decompile export namespace_4bf13193::function_248868ae jump with invalid delta: 0x71ed
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x7c2b8fb0, Offset: 0x3498
// Size: 0x41
function function_f8965920(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_f8965920 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xcbb0f68a, Offset: 0x3540
// Size: 0x5b
function function_ef39e6b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_ef39e6b6 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xcbbcfcbd, Offset: 0x35f8
// Size: 0x3a
function function_66617c6c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_66617c6c Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x7da22e3c, Offset: 0x3668
// Size: 0x49
function function_e76aa170(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_e76aa170 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0x75c8f0f6, Offset: 0x3788
// Size: 0x59
function function_cacf88e6(localclientnum) {
    // Can't decompile export namespace_4bf13193::function_cacf88e6 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x250050eb, Offset: 0x38b8
// Size: 0x9
function function_5799c6c0() {
    // Can't decompile export namespace_4bf13193::function_5799c6c0 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x6bddc31d, Offset: 0x3918
// Size: 0x29
function function_39b5ac35() {
    // Can't decompile export namespace_4bf13193::function_39b5ac35 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0xb66ea8c8, Offset: 0x3a00
// Size: 0x41
function function_b84a3557(localclientnum) {
    // Can't decompile export namespace_4bf13193::function_b84a3557 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0xaef2c15, Offset: 0x3af0
// Size: 0x39
function function_6f15ec64(localclientnum) {
    // Can't decompile export namespace_4bf13193::function_6f15ec64 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xe84dec68, Offset: 0x3b98
// Size: 0x3a
function function_6be6da89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_6be6da89 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xc3279bea, Offset: 0x3c10
// Size: 0x3a
function function_3fd63c17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_3fd63c17 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x3d339638, Offset: 0x3cf0
// Size: 0x3a
function function_43174f13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_43174f13 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x901d9e91, Offset: 0x3d58
// Size: 0x3a
function function_1d14d4aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_1d14d4aa Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xee67f6c, Offset: 0x3dc0
// Size: 0xa1
function function_5ac1b440(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_5ac1b440 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xd88063b1, Offset: 0x3f40
// Size: 0x3a
function function_34e88b9c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_34e88b9c Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xa673dc80, Offset: 0x3fa0
// Size: 0x49
function function_a30fa29c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_a30fa29c Unknown operator 0x18
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x110575a5, Offset: 0x4168
// Size: 0x3a
function function_31d56bb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_31d56bb1 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xdd618c35, Offset: 0x4250
// Size: 0x3a
function function_492309fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_492309fc Unknown operator 0xfa
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x7cc1fb5b, Offset: 0x42e8
// Size: 0x49
function function_2b219c66(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_2b219c66 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x21a13e1a, Offset: 0x4350
// Size: 0x49
function function_51f21fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_51f21fd Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x42bd41fe, Offset: 0x43b8
// Size: 0x49
function function_df1ca794(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_df1ca794 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x1e152fd7, Offset: 0x4420
// Size: 0x42
function function_be719f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_be719f1 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xb441b3c0, Offset: 0x4480
// Size: 0x3a
function function_4fdcffa3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_4fdcffa3 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x7b64a0a, Offset: 0x4508
// Size: 0x3a
function function_594a4308(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_594a4308 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 3, eflags: 0x0
// Checksum 0xc0c7a9cb, Offset: 0x4588
// Size: 0xc1
function primarygroup(arg1, arg2, arg3) {
    // Can't decompile export namespace_4bf13193::primarygroup Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 3, eflags: 0x0
// Checksum 0x25a7a65a, Offset: 0x4a58
// Size: 0x21
function function_c87bd675(ent1, ent2, ent3) {
    // Can't decompile export namespace_4bf13193::function_c87bd675 Unknown operator 0xd4
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x603ee351, Offset: 0x4ab8
// Size: 0x3a
function function_c9e9a72c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_c9e9a72c Unknown operator 0x98
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x16aca5b3, Offset: 0x4b68
// Size: 0x3a
function function_5cefaf77(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_5cefaf77 Unknown operator 0x98
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x25bb2dd8, Offset: 0x4c18
// Size: 0x3a
function function_a93a4b6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_a93a4b6a Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xddb156b0, Offset: 0x4cf0
// Size: 0x42
function function_6688e3e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_6688e3e0 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x0
// Checksum 0xc233ed7a, Offset: 0x4da0
// Size: 0xa
function function_71f88fc(n_zone) {
    // Can't decompile export namespace_4bf13193::function_71f88fc Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x6950f464, Offset: 0x5078
// Size: 0x3a
function weakpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::weakpoint Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x11945061, Offset: 0x5130
// Size: 0x3a
function function_f81dc3f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_f81dc3f2 Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x43df546a, Offset: 0x5190
// Size: 0x3a
function function_95af50c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_95af50c Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xa95f4829, Offset: 0x5208
// Size: 0x6a
function function_fb081b8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_fb081b8c Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x0
// Checksum 0xc0745115, Offset: 0x5300
// Size: 0x23
function function_df9260b7(trigger, alias) {
    // Can't decompile export namespace_4bf13193::function_df9260b7 Unknown operator 0x76
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x81ec3c8d, Offset: 0x53b0
// Size: 0x41
function function_59c47b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_59c47b1 Unknown operator 0x18
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xf0c813cb, Offset: 0x5458
// Size: 0x41
function function_21197c95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_21197c95 Unknown operator 0x18
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0xdaf8a1e4, Offset: 0x5550
// Size: 0x62
function function_ff1a4bbc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_ff1a4bbc Unknown operator 0x5d
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x0
// Checksum 0x533df231, Offset: 0x5690
// Size: 0x3a
function function_1e832062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_4bf13193::function_1e832062 Unknown operator 0x5d
}

