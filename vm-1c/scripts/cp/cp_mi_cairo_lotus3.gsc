#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_elevator;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus3_fx;
#using scripts/cp/cp_mi_cairo_lotus3_patch;
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
// Checksum 0x7dbf69f1, Offset: 0x470
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x2756617b, Offset: 0x4b0
// Size: 0x18c
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
    cp_mi_cairo_lotus3_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x5eb61d2, Offset: 0x648
// Size: 0x1b4
function init_clientfields() {
    clientfield::register("toplayer", "sand_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_left_outer_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_left_inner_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_right_inner_fx", 1, 1, "int");
    clientfield::register("vehicle", "boss_right_outer_fx", 1, 1, "int");
    clientfield::register("vehicle", "gunship_rumble_off", 1, 1, "int");
    clientfield::register("vehicle", "play_raps_trail_fx", 1, 1, "int");
    clientfield::register("world", "t2a_paper_burst", 1, 1, "int");
    clientfield::register("world", "city_sky", 1, 1, "int");
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x16739896, Offset: 0x808
// Size: 0x10
function init_variables() {
    level.var_173c585e = 1;
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0x6d093d72, Offset: 0x820
// Size: 0xb2
function function_e5037c3() {
    var_f29f9112 = getentarray("roof_ammo_caches", "prefabname");
    foreach (cache in var_f29f9112) {
        cache hide();
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xe8ae65fb, Offset: 0x8e0
// Size: 0x1c
function on_player_spawned() {
    self thread function_be673574();
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xb68d9dfc, Offset: 0x908
// Size: 0x84
function function_be673574() {
    level flag::wait_till("boss_battle");
    self clientfield::set_to_player("sand_fx", 1);
    level flag::wait_till("old_friend");
    self clientfield::set_to_player("sand_fx", 0);
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xb176aff9, Offset: 0x998
// Size: 0x11c
function function_673254cc() {
    skipto::function_d68e678e("tower_2_ascent", &lotus_t2_ascent::function_c4ecc384, undefined, &lotus_t2_ascent::function_c276f97f);
    skipto::function_d68e678e("prometheus_intro", &lotus_boss_battle::function_ccc2baba, undefined, &lotus_boss_battle::function_ec70e2a1);
    skipto::add("boss_battle", &lotus_boss_battle::function_faf62cf1, undefined, &lotus_boss_battle::boss_battle_done);
    skipto::function_d68e678e("old_friend", &lotus_boss_battle::function_babb1dd5, undefined, &lotus_boss_battle::function_5b067572);
    skipto::add_dev("dev_pip_movie_capture", &lotus_t2_ascent::function_283f872d, undefined, &lotus_t2_ascent::function_df51a037);
}

