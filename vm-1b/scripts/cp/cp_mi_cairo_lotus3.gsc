#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_elevator;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus3_fx;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_boss_battle;
#using scripts/cp/lotus_t2_ascent;
#using scripts/cp/voice/voice_lotus3;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;

#namespace cp_mi_cairo_lotus3;

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xf3a4551f, Offset: 0x440
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x38016ab8, Offset: 0x480
// Size: 0x162
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(29);
    }
    savegame::function_8c0c4b3a("lotus");
    util::function_286a5010(4);
    init_clientfields();
    init_variables();
    function_673254cc();
    function_e5037c3();
    voice_lotus3::init_voice();
    callback::on_spawned(&on_player_spawned);
    cp_mi_cairo_lotus3_fx::main();
    cp_mi_cairo_lotus3_sound::main();
    load::main();
    lotus_accolades::function_66df416f();
    objectives::complete("cp_level_lotus_hakim_assassinate");
    objectives::complete("cp_level_lotus_capture_security_station");
    objectives::set("cp_level_lotus_capture_taylor");
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xec9e583e, Offset: 0x5f0
// Size: 0x142
function init_clientfields() {
    clientfield::register("toplayer", "sand_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_left_outer_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_left_inner_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_right_inner_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_right_outer_fx", 1, 1, "int");
    clientfield::register("vehicle", "gunship_rumble_off", 1, 1, "int");
    clientfield::register("vehicle", "play_raps_trail_fx", 1, 1, "int");
    clientfield::register("world", "t2a_paper_burst", 1, 1, "int");
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xcb354da1, Offset: 0x740
// Size: 0xa
function init_variables() {
    level.var_173c585e = 1;
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x161688bb, Offset: 0x758
// Size: 0x8b
function function_e5037c3() {
    var_f29f9112 = getentarray("roof_ammo_caches", "prefabname");
    foreach (cache in var_f29f9112) {
        cache hide();
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xce8840f2, Offset: 0x7f0
// Size: 0x12
function on_player_spawned() {
    self thread function_be673574();
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xc5766886, Offset: 0x810
// Size: 0x62
function function_be673574() {
    level flag::wait_till("boss_battle");
    self clientfield::set_to_player("sand_fx", 1);
    level flag::wait_till("old_friend");
    self clientfield::set_to_player("sand_fx", 0);
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x55269ea0, Offset: 0x880
// Size: 0x11a
function function_673254cc() {
    skipto::function_d68e678e("tower_2_ascent", &lotus_t2_ascent::function_c4ecc384, undefined, &lotus_t2_ascent::function_c276f97f);
    skipto::function_d68e678e("prometheus_intro", &lotus_boss_battle::function_ccc2baba, undefined, &lotus_boss_battle::function_ec70e2a1);
    skipto::add("boss_battle", &lotus_boss_battle::function_faf62cf1, undefined, &lotus_boss_battle::boss_battle_done);
    skipto::function_d68e678e("old_friend", &lotus_boss_battle::function_babb1dd5, undefined, &lotus_boss_battle::function_5b067572);
    skipto::add_dev("dev_pip_movie_capture", &lotus_t2_ascent::function_283f872d, undefined, &lotus_t2_ascent::function_df51a037);
}

