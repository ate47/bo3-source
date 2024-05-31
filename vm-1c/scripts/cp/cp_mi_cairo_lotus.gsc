#using scripts/cp/cp_mi_cairo_lotus_patch;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/cp/voice/voice_lotus1;
#using scripts/cp/lotus_util;
#using scripts/cp/lotus_start_riot;
#using scripts/cp/lotus_security_station;
#using scripts/cp/lotus_accolades;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cp_mi_cairo_lotus_sound;
#using scripts/cp/cp_mi_cairo_lotus_fx;
#using scripts/cp/cp_mi_cairo_lotus_anim;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_elevator;
#using scripts/cp/_collectibles;
#using scripts/cp/_ammo_cache;

#namespace namespace_7cb27be0;

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x0
// namespace_7cb27be0<file_0>::function_243693d4
// Checksum 0x3dcb24ca, Offset: 0x6b0
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_70a1a72e
// Checksum 0xe7c23907, Offset: 0x6f0
// Size: 0x10c
function function_70a1a72e() {
    var_a7be1923 = getnode("start_mobile_0_top_across_128", "targetname");
    linktraversal(var_a7be1923);
    unlinktraversal(var_a7be1923);
    var_7d15b22d = getnode("start_mobile_0_across_128", "targetname");
    linktraversal(var_7d15b22d);
    unlinktraversal(var_7d15b22d);
    var_ba891ade = getnode("start_mobile_0_up_160", "targetname");
    linktraversal(var_ba891ade);
    unlinktraversal(var_ba891ade);
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_d290ebfa
// Checksum 0x89f00c47, Offset: 0x808
// Size: 0x2dc
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(23);
    }
    function_70a1a72e();
    savegame::function_8c0c4b3a("lotus");
    if (!sessionmodeiscampaignzombiesgame()) {
        level.var_173c585e = 1;
        callback::on_spawned(&on_player_spawned);
    }
    namespace_f95714f2::init_voice();
    util::function_286a5010(3);
    precache();
    init_clientfields();
    init_flags();
    function_673254cc();
    function_e8474b63();
    collectibles::function_93523442("p7_nc_cai_lot_05", 45, (0, -20, 0));
    namespace_90072e58::main();
    namespace_9bdf8ed1::main();
    namespace_9750c824::main();
    namespace_3b39ab74::init();
    namespace_8e4b89e2::init();
    load::main();
    skipto::function_f3e035ef();
    level thread namespace_431cac9::function_d720c23e("atrium_battle_a");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_b");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_c");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_d");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_e");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_f");
    level thread namespace_431cac9::function_d720c23e("atrium_battle_g");
    level.var_dc236bc8 = 1;
    level.var_6e1075a2 = 0;
    namespace_f4ff722a::function_66df416f();
    namespace_91f7aee3::function_7403e82b();
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0xaf0
// Size: 0x4
function precache() {
    
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_37af8a07
// Checksum 0x84e2a78c, Offset: 0xb00
// Size: 0x84
function init_flags() {
    level flag::init("hendricks_breach_line_done");
    level flag::init("mobile_shop_vo_done");
    level flag::init("security_shop_unload");
    level flag::init("security_shop_stopped");
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_e8474b63
// Checksum 0xc90e1d55, Offset: 0xb90
// Size: 0x24
function function_e8474b63() {
    level scene::init("p7_fxanim_cp_lotus_monitors_atrium_fall_bundle");
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_2ea898a8
// Checksum 0x35906219, Offset: 0xbc0
// Size: 0x334
function init_clientfields() {
    visionset_mgr::register_info("visionset", "cp_raven_hallucination", 1, 100, 1, 1);
    clientfield::register("world", "hs_fxinit_vent", 1, 1, "int");
    clientfield::register("world", "hs_fxanim_vent", 1, 1, "int");
    clientfield::register("world", "swap_crowd_to_riot", 1, 1, "int");
    clientfield::register("world", "crowd_anims_off", 1, 1, "int");
    clientfield::register("scriptmover", "mobile_shop_fxanims", 1, 3, "int");
    clientfield::register("scriptmover", "raven_decal", 1, 1, "int");
    clientfield::register("toplayer", "snow_fog", 1, 1, "int");
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_ravens", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_frozen_forest", 1, 1, "counter");
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int");
    clientfield::register("allplayers", "player_frost_breath", 1, 1, "int");
    clientfield::register("actor", "hendricks_frost_breath", 1, 1, "int");
    clientfield::register("toplayer", "pickup_hakim_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "mobile_shop_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int");
}

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_673254cc
// Checksum 0x7fba356f, Offset: 0xf00
// Size: 0x25c
function function_673254cc() {
    skipto::add("plan_b", &namespace_3b39ab74::function_e86a5395, undefined, &namespace_3b39ab74::function_88b5ab32);
    skipto::add("start_the_riots", &namespace_3b39ab74::function_5fb7ec5, undefined, &namespace_3b39ab74::function_a3cc6d62);
    skipto::function_d68e678e("general_hakim", &namespace_3b39ab74::function_92206070, undefined, &namespace_3b39ab74::function_14166bcb);
    skipto::function_d68e678e("apartments", &namespace_8e4b89e2::function_cd269efc, undefined, &namespace_8e4b89e2::function_46593e07);
    skipto::function_d68e678e("atrium_battle", &namespace_8e4b89e2::function_963d89c4, undefined, &namespace_8e4b89e2::function_57b2d9ef);
    skipto::function_d68e678e("to_security_station", &namespace_8e4b89e2::function_41534d2a, undefined, &namespace_8e4b89e2::function_2d424c3d);
    skipto::function_d68e678e("hack_the_system", &namespace_8e4b89e2::function_f5f5e18e, undefined, &namespace_8e4b89e2::function_2f8e8d25);
    /#
        skipto::add_dev("atrium_battle_a", &function_a56ed2d0);
        skipto::add_dev("atrium_battle_a", &function_cb714d39);
        skipto::add_dev("atrium_battle_a", &function_50499b8);
        skipto::add_dev("atrium_battle_a", &function_770c08f3);
        skipto::add_dev("atrium_battle_a", &function_51098e8a);
    #/
}

/#

    // Namespace namespace_7cb27be0
    // Params 2, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_a56ed2d0
    // Checksum 0x176dcd81, Offset: 0x1168
    // Size: 0x4c
    function function_a56ed2d0(str_objective, var_74cd64bc) {
        switchmap_load("atrium_battle_a");
        wait(0.05);
        switchmap_switch();
    }

    // Namespace namespace_7cb27be0
    // Params 2, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_cb714d39
    // Checksum 0x464b35, Offset: 0x11c0
    // Size: 0x4c
    function function_cb714d39(str_objective, var_74cd64bc) {
        switchmap_load("atrium_battle_a");
        wait(0.05);
        switchmap_switch();
    }

    // Namespace namespace_7cb27be0
    // Params 2, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_50499b8
    // Checksum 0xb4fc3e77, Offset: 0x1218
    // Size: 0x34
    function function_50499b8(str_objective, var_74cd64bc) {
        function_3330eab6("atrium_battle_a");
    }

    // Namespace namespace_7cb27be0
    // Params 2, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_770c08f3
    // Checksum 0x3ecabd1c, Offset: 0x1258
    // Size: 0x34
    function function_770c08f3(str_objective, var_74cd64bc) {
        function_3330eab6("atrium_battle_a");
    }

    // Namespace namespace_7cb27be0
    // Params 2, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_51098e8a
    // Checksum 0x15f684e1, Offset: 0x1298
    // Size: 0x34
    function function_51098e8a(str_objective, var_74cd64bc) {
        function_3330eab6("atrium_battle_a");
    }

    // Namespace namespace_7cb27be0
    // Params 1, eflags: 0x1 linked
    // namespace_7cb27be0<file_0>::function_3330eab6
    // Checksum 0xd7a2bd42, Offset: 0x12d8
    // Size: 0x44
    function function_3330eab6(str_anim) {
        level flag::wait_till("atrium_battle_a");
        scene::play(str_anim);
    }

#/

// Namespace namespace_7cb27be0
// Params 0, eflags: 0x1 linked
// namespace_7cb27be0<file_0>::function_aebcf025
// Checksum 0x99ec1590, Offset: 0x1328
// Size: 0x4
function on_player_spawned() {
    
}

