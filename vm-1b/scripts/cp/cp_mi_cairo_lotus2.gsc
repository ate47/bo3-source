#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_elevator;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus2_fx;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_detention_center;
#using scripts/cp/lotus_pursuit;
#using scripts/cp/lotus_security_station;
#using scripts/cp/lotus_sky_bridge;
#using scripts/cp/lotus_util;
#using scripts/cp/voice/voice_lotus2;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_cairo_lotus2;

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x6923e35, Offset: 0x690
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0xb99770ef, Offset: 0x6d0
// Size: 0x19a
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(106);
    }
    savegame::function_8c0c4b3a("lotus");
    util::function_286a5010(3);
    init_clientfields();
    init_variables();
    function_673254cc();
    init_flags();
    collectibles::function_93523442("p7_nc_cai_lot_05", 45, (0, -20, 0));
    voice_lotus2::init_voice();
    callback::on_spawned(&on_player_spawned);
    cp_mi_cairo_lotus2_fx::main();
    cp_mi_cairo_lotus2_sound::main();
    load::main();
    skipto::function_f3e035ef();
    lotus_util::function_f80cafbd(0);
    lotus_util::function_77bfc3b2();
    lotus_accolades::function_66df416f();
    lotus_util::function_3b6587d6(1, "lotus2_tower2_umbra_gate");
    lotus_util::function_3b6587d6(1, "lotus2_tower1_debris_push_umbra_gate");
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x215067d6, Offset: 0x878
// Size: 0x282
function init_clientfields() {
    visionset_mgr::register_info("visionset", "cp_raven_hallucination", 1, 100, 1, 1);
    clientfield::register("vehicle", "mobile_shop_link_ents", 1, 1, "int");
    clientfield::register("world", "vtol_hallway_destruction_cleanup", 1, 1, "int");
    clientfield::register("toplayer", "snow_fog", 1, 1, "int");
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int");
    clientfield::register("toplayer", "skybridge_sand_fx", 1, 1, "int");
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int");
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_ravens", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_frozen_forest", 1, 1, "counter");
    clientfield::register("toplayer", "siegebot_fans", 1, 1, "int");
    clientfield::register("toplayer", "hide_pursuit_decals", 1, 1, "counter");
    clientfield::register("allplayers", "player_frost_breath", 1, 1, "int");
    clientfield::register("actor", "hendricks_frost_breath", 1, 1, "int");
    clientfield::register("scriptmover", "rogue_bot_fx", 1, 1, "int");
    clientfield::register("scriptmover", "mobile_shop_fxanims", 1, 3, "int");
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0xcb354da1, Offset: 0xb08
// Size: 0xa
function init_variables() {
    level.var_173c585e = 1;
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x7d1d947b, Offset: 0xb20
// Size: 0xf2
function init_flags() {
    level flag::init("security_station_breach_ai_cleared");
    level flag::init("prometheus_otr_cleared");
    level flag::init("zipline_done");
    level flag::init("hendricks_reached_vtol_hallway_door");
    level flag::init("mobile_shop2_start_trigger_enabled");
    level flag::init("sb1_initial_battle_done");
    level flag::init("skybridge_debris_cleared");
    level flag::init("play_wwz_vtol_crash");
    level flag::init("wwz_vtol_crash_done");
    level flag::init("mobile_shop_2_vo_done");
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc20
// Size: 0x2
function on_player_spawned() {
    
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x72928b79, Offset: 0xc30
// Size: 0x332
function function_673254cc() {
    skipto::function_d68e678e("prometheus_otr", &lotus_security_station::function_5d64afc3, undefined, &lotus_security_station::function_a1a139dc);
    skipto::function_d68e678e("vtol_hallway", &lotus_detention_center::function_ddf518df, undefined, &lotus_detention_center::function_eef4fda8);
    skipto::function_d68e678e("mobile_shop_ride2", &lotus_detention_center::function_9c0f8169, undefined, &lotus_detention_center::mobile_shop_ride2_done);
    skipto::function_d68e678e("bridge_battle", &lotus_detention_center::function_57e7a8c9, undefined, &lotus_detention_center::bridge_battle_done);
    skipto::function_d68e678e("up_to_detention_center", &lotus_detention_center::function_5b4279a3, undefined, &lotus_detention_center::up_to_detention_center_done);
    skipto::function_d68e678e("detention_center", &lotus_detention_center::function_acdf71f3, undefined, &lotus_detention_center::function_5730accc);
    skipto::function_d68e678e("stand_down", &lotus_pursuit::function_e44d217a, undefined, &lotus_pursuit::function_470ca661);
    skipto::add("pursuit", &lotus_pursuit::main, undefined, &lotus_pursuit::function_9c97dac4);
    skipto::function_d68e678e("industrial_zone", &lotus_sky_bridge::function_99c7c24f, undefined, &lotus_sky_bridge::function_3ec62858);
    skipto::function_d68e678e("sky_bridge1", &lotus_sky_bridge::function_4e9c70f, undefined, &lotus_sky_bridge::function_ac629618);
    skipto::function_d68e678e("sky_bridge2", &lotus_sky_bridge::function_38aca7a, undefined, &lotus_sky_bridge::function_664a4f61);
    /#
        skipto::add_dev("<dev string:x28>", &function_cb714d39);
        skipto::add_dev("<dev string:x3f>", &function_97304dac);
        skipto::add_dev("<dev string:x5f>", &function_9e911591);
        skipto::add_dev("<dev string:x7b>", &function_662ff925);
        skipto::add_dev("<dev string:x9f>", &function_14a292be);
    #/
}

/#

    // Namespace cp_mi_cairo_lotus2
    // Params 2, eflags: 0x0
    // Checksum 0x87030e53, Offset: 0xf70
    // Size: 0x42
    function function_cb714d39(str_objective, var_74cd64bc) {
        switchmap_load("<dev string:xba>");
        wait 0.05;
        switchmap_switch();
    }

    // Namespace cp_mi_cairo_lotus2
    // Params 2, eflags: 0x0
    // Checksum 0xd638485d, Offset: 0xfc0
    // Size: 0x2a
    function function_97304dac(str_objective, var_74cd64bc) {
        function_3330eab6("<dev string:xcd>");
    }

    // Namespace cp_mi_cairo_lotus2
    // Params 2, eflags: 0x0
    // Checksum 0xc133cc01, Offset: 0xff8
    // Size: 0x2a
    function function_9e911591(str_objective, var_74cd64bc) {
        function_3330eab6("<dev string:xf1>");
    }

    // Namespace cp_mi_cairo_lotus2
    // Params 2, eflags: 0x0
    // Checksum 0x754b1e88, Offset: 0x1030
    // Size: 0x2a
    function function_662ff925(str_objective, var_74cd64bc) {
        function_3330eab6("<dev string:x11c>");
    }

    // Namespace cp_mi_cairo_lotus2
    // Params 2, eflags: 0x0
    // Checksum 0x3b8f0278, Offset: 0x1068
    // Size: 0x2a
    function function_14a292be(str_objective, var_74cd64bc) {
        function_3330eab6("<dev string:x148>");
    }

    // Namespace cp_mi_cairo_lotus2
    // Params 1, eflags: 0x0
    // Checksum 0x95b93578, Offset: 0x10a0
    // Size: 0x32
    function function_3330eab6(str_anim) {
        level flag::wait_till("<dev string:x16d>");
        scene::play(str_anim);
    }

#/
