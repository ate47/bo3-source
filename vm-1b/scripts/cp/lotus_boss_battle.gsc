#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace lotus_boss_battle;

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x1a5c492b, Offset: 0x12c0
// Size: 0x20a
function function_ccc2baba(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        var_4b8428ba = getent("p_intro_glass_window", "targetname");
        var_4b8428ba delete();
        level scene::init("cin_lot_11_tower2ascent_3rd_sh060_halfway");
    }
    level function_fc9a646b("hide");
    level thread function_66b6b1c7();
    level.var_1df069b5 = 0;
    level.var_2e49e915 = 0;
    function_428ff2f();
    function_750a4f4c();
    level scene::add_scene_func("cin_lot_15_taylorintro_3rd_sh050", &function_1d2443e2, "done");
    level scene::add_scene_func("cin_lot_11_tower2ascent_3rd_sh120", &function_a7f02ddb, "done");
    if (var_74cd64bc) {
        load::function_a2995f22();
        if (isdefined(level.var_f16c27e6)) {
            level thread [[ level.var_f16c27e6 ]]();
        }
        level scene::play("cin_lot_11_tower2ascent_3rd_sh060_halfway");
    }
    level waittill(#"hash_a7f02ddb");
    if (isdefined(level.var_f48af665)) {
        level thread [[ level.var_f48af665 ]]();
    }
    level waittill(#"hash_59f31b4d");
    level thread function_c40186f4();
    level waittill(#"hash_41bb6835");
    level util::function_93831e79("boss_battle");
    skipto::function_be8adfb8("prometheus_intro");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x3ce6d198, Offset: 0x14d8
// Size: 0x8b
function function_750a4f4c() {
    var_7b183fd7 = getentarray("atrium01_mobile_shop", "targetname");
    foreach (e_item in var_7b183fd7) {
        e_item delete();
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x486f128f, Offset: 0x1570
// Size: 0x5a
function function_c40186f4() {
    var_dc105c2b = lotus_util::function_8108bdb8("shed_explosion_a", "hero_shed_piece", undefined);
    var_dc105c2b lotus_util::function_aabc561a("mobile_shop_fall_explosion");
    level function_fc9a646b("show");
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x4452fc53, Offset: 0x15d8
// Size: 0x113
function function_fc9a646b(var_158cd2ca) {
    if (!isdefined(var_158cd2ca)) {
        var_158cd2ca = "hide";
    }
    a_debris = getentarray("area_shed_debris_1", "targetname");
    if (var_158cd2ca == "show") {
        foreach (piece in a_debris) {
            if (isdefined(piece)) {
                piece show();
            }
        }
        return;
    }
    foreach (piece in a_debris) {
        if (isdefined(piece)) {
            piece hide();
        }
    }
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x224a4c57, Offset: 0x16f8
// Size: 0x13
function function_a7f02ddb(a_ents) {
    level notify(#"hash_a7f02ddb");
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x73158a9a, Offset: 0x1718
// Size: 0x13
function function_1d2443e2(a_ents) {
    level notify(#"hash_41bb6835");
}

// Namespace lotus_boss_battle
// Params 4, eflags: 0x0
// Checksum 0x4e881390, Offset: 0x1738
// Size: 0x22
function function_ec70e2a1(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x9a32fd01, Offset: 0x1768
// Size: 0x642
function function_babb1dd5(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_428ff2f();
    }
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh190", &function_eaf57a3, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh070", &function_90b04eba, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh080", &function_623303f2, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh090", &function_90b04eba, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh140", &function_623303f2, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh150", &function_90b04eba, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh160", &function_623303f2, "done");
    level scene::add_scene_func("cin_lot_17_oldfriend_3rd_sh220", &function_90b04eba, "done");
    scene::add_scene_func("cin_lot_17_01_oldfriend_1st_wakeup", &function_203a65ec, "skip_started");
    scene::add_scene_func("cin_lot_17_01_oldfriend_1st_wakeup", &function_4d425f2a, "done");
    var_8e1ab582 = getentarray("of_igc_railing", "targetname");
    foreach (var_d1610bbf in var_8e1ab582) {
        var_d1610bbf hide();
    }
    if (isdefined(level.var_38a4277e)) {
        level.var_38a4277e delete();
    }
    s_scene = struct::get("gunship_down_fxanim", "targetname");
    if (var_74cd64bc) {
        s_scene scene::init();
        level scene::init("cin_lot_17_oldfriend_3rd_sh010");
        load::function_a2995f22();
    }
    foreach (player in level.players) {
        player player::switch_to_primary_weapon(1);
        player.script_ignoreme = 1;
    }
    level thread namespace_3bad5a01::function_dae48a54();
    level scene::play("cin_lot_17_oldfriend_3rd_sh010");
    level waittill(#"hash_65ad50c6");
    if (isdefined(level.var_36848938)) {
        level thread [[ level.var_36848938 ]]();
    }
    s_scene thread scene::play();
    var_9541c781 = getentarray("gunship_fall", "targetname");
    foreach (var_e9d5eee1 in var_9541c781) {
        var_e9d5eee1 hide();
    }
    level waittill(#"hash_c2926439");
    var_182ef0f0 = getent("taylor", "targetname");
    var_182ef0f0 setmodel("c_hro_taylor_base_bullet_wound");
    level waittill(#"hash_4868cda0");
    level thread function_5bb13a75();
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(3, "black", "old_friend_hospital_transition");
    }
    level waittill(#"hash_e43285f9");
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_in(3, "black", "old_friend_hospital_transition");
    }
    level thread audio::unlockfrontendmusic("mus_lotus_theme_intro");
    level thread namespace_3bad5a01::function_6be50b2c();
    if (isdefined(level.var_7c5276b2)) {
        level thread [[ level.var_7c5276b2 ]]();
    }
    level waittill(#"hash_4f90f275");
    var_4af4348c = getent("rachel", "targetname");
    var_4af4348c detach("c_hro_rachel_egypt_scarf");
    level waittill(#"hash_6adfba7a");
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("sndIGCsnapshot", 4);
        level thread util::screen_fade_out(1, "white");
    }
    streamerrequest("clear");
    skipto::function_be8adfb8("old_friend");
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x767358c6, Offset: 0x1db8
// Size: 0x22
function function_4d425f2a(a_ents) {
    skipto::function_be8adfb8("old_friend");
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x2af3423a, Offset: 0x1de8
// Size: 0x82
function function_203a65ec(a_ents) {
    foreach (player in level.activeplayers) {
        player setlowready(1);
    }
    util::screen_fade_out(0, "black");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x410feaed, Offset: 0x1e78
// Size: 0x2da
function function_eaf57a3() {
    cin_lot_debris_piece_01 = getent("cin_lot_debris_piece_01", "targetname");
    cin_lot_debris_piece_02 = getent("cin_lot_debris_piece_02", "targetname");
    cin_lot_debris_piece_03 = getent("cin_lot_debris_piece_03", "targetname");
    cin_lot_debris_piece_04 = getent("cin_lot_debris_piece_04", "targetname");
    cin_lot_debris_piece_05 = getent("cin_lot_debris_piece_05", "targetname");
    cin_lot_debris_piece_06 = getent("cin_lot_debris_piece_06", "targetname");
    cin_lot_debris_piece_07 = getent("cin_lot_debris_piece_07", "targetname");
    cin_lot_debris_piece_08 = getent("cin_lot_debris_piece_08", "targetname");
    cin_lot_debris_piece_09 = getent("cin_lot_debris_piece_09", "targetname");
    cin_lot_debris_piece_10 = getent("cin_lot_debris_piece_10", "targetname");
    cin_lot_debris_piece_11 = getent("cin_lot_debris_piece_11", "targetname");
    cin_lot_debris_piece_12 = getent("cin_lot_debris_piece_12", "targetname");
    cin_lot_debris_piece_13 = getent("cin_lot_debris_piece_13", "targetname");
    cin_lot_debris_piece_01 delete();
    cin_lot_debris_piece_02 delete();
    cin_lot_debris_piece_03 delete();
    cin_lot_debris_piece_04 delete();
    cin_lot_debris_piece_05 delete();
    cin_lot_debris_piece_06 delete();
    cin_lot_debris_piece_07 delete();
    cin_lot_debris_piece_08 delete();
    cin_lot_debris_piece_09 delete();
    cin_lot_debris_piece_10 delete();
    cin_lot_debris_piece_11 delete();
    cin_lot_debris_piece_12 delete();
    cin_lot_debris_piece_13 delete();
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x304de3dd, Offset: 0x2160
// Size: 0x6a
function function_d9f5f2cf() {
    self vehicle::toggle_sounds(0);
    self vehicle::toggle_exhaust_fx(0);
    self turret::disable(0);
    self vehicle::toggle_lights_group(1, 0);
    self vehicle::toggle_lights_group(2, 0);
    self clientfield::set("gunship_rumble_off", 1);
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x59098c19, Offset: 0x21d8
// Size: 0x22
function function_90b04eba(a_ents) {
    a_ents["mothership"] ghost();
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xe55f5ff4, Offset: 0x2208
// Size: 0x22
function function_623303f2(a_ents) {
    a_ents["mothership"] show();
}

// Namespace lotus_boss_battle
// Params 4, eflags: 0x0
// Checksum 0x2375f1a5, Offset: 0x2238
// Size: 0x22
function function_5b067572(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xa1f5fff1, Offset: 0x2268
// Size: 0x3a
function function_5bb13a75() {
    wait 3;
    var_f9749701 = spawn("script_origin", (0, 0, 0));
    var_f9749701 playloopsound("amb_heart_monitor_2d", 1);
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x4bb2943e, Offset: 0x22b0
// Size: 0x21a
function function_faf62cf1(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_428ff2f();
        level thread function_c40186f4();
        level thread function_66b6b1c7();
    } else {
        if (isalive(level.var_2fd26037)) {
            level.var_2fd26037 delete();
        }
        skipto::teleport(str_objective);
    }
    s_scene = struct::get("gunship_down_fxanim", "targetname");
    s_scene scene::init();
    objectives::complete("cp_level_lotus_capture_taylor");
    objectives::set("cp_level_lotus_leviathan");
    level thread function_b727a42a();
    lotus_accolades::function_a2c4c634();
    function_335a1753();
    function_f5bbb458();
    var_15025f5b = "ms_r4";
    level thread function_ad67b293(var_15025f5b);
    if (var_74cd64bc) {
        load::function_a2995f22();
    }
    level.var_38a4277e = spawner::simple_spawn_single("gunship");
    level.var_38a4277e thread function_82e92a08();
    level notify(#"hash_a450f864");
    exploder::exploder("fx_boss_battle_ambients");
    level thread function_49249bff();
    level waittill(#"hash_4c66c579");
    level thread namespace_3bad5a01::function_973b77f9();
    wait 2;
    skipto::function_be8adfb8("boss_battle");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x1c3c14c6, Offset: 0x24d8
// Size: 0xa2
function function_49249bff() {
    level thread namespace_3bad5a01::function_d6e5b30();
    wait 0.5;
    level flag::set("ready_to_move_first_armory_vo");
    level dialog::remote("kane_leviathans_are_heavy_0");
    level dialog::remote("kane_mobile_armories_on_t_0");
    objectives::set("cp_level_lotus_leviathan_destroy");
    level flag::set("story_vo_completed");
    wait 5;
    level thread function_eb80777c();
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0xc9fe22a8, Offset: 0x2588
// Size: 0x99
function function_309d7a5a(var_24d48af, wait_time) {
    if (!isdefined(level.var_2e49e915)) {
        level.var_2e49e915 = 0;
    }
    if (level flag::get("story_vo_completed") && !isdefined(level.var_1d581e7) && level.var_2e49e915 == 0) {
        level.var_1d581e7 = var_24d48af;
        level.var_1df069b5 = 1;
        dialog::remote(var_24d48af);
        level.var_1df069b5 = 0;
        if (!isdefined(wait_time)) {
            wait_time = 5;
        }
        wait wait_time;
        level.var_1d581e7 = undefined;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xc65289fc, Offset: 0x2630
// Size: 0x1cb
function function_335a1753() {
    level flag::init("call_next_mobile_shop");
    level flag::init("call_next_mobile_armory");
    level flag::init("gunship_in_transition");
    level flag::init("story_vo_completed");
    level flag::init("gunship_high_out_of_battle");
    level flag::set("flag_roof_battle_kill_trigger_enable");
    level.var_6c0436ff = 0;
    level flag::init("first_missile_fired_vo");
    level flag::init("first_mobile_armory_vo");
    level flag::init("ready_to_move_first_armory_vo");
    level flag::init("stop_dialog_remote");
    level.var_fadf752 = [];
    level.var_fadf752[0] = "plyr_kane_you_telling_me_0";
    level.var_fadf752[1] = "plyr_kane_you_telling_me_1";
    level.var_af475f02 = [];
    level.var_af475f02[0] = "kane_leviathan_deploying_1";
    level.var_af475f02[1] = "kane_grab_cover_incoming_0";
    level.var_af475f02[2] = "kane_missiles_incoming_0";
    level.var_ead3caed = [];
    level.var_ead3caed[0] = "kane_leviathan_deploying_0";
    level.var_ead3caed[1] = "kane_incoming_raps_0";
    level.var_ead3caed[2] = "kane_nrc_airship_deployin_0";
    level.var_4483235d = [];
    level.var_4483235d[0] = "kane_leviathan_deploying_2";
    level.var_4483235d[1] = "kane_heads_up_hounds_inc_0";
    level.var_4483235d[2] = "kane_nrc_airship_sending_0";
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x5de50d6f, Offset: 0x2808
// Size: 0x57a
function function_eb80777c() {
    wait 8;
    level function_80fdeb82();
    level.var_2e49e915 = 1;
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_welcome_back_2");
    }
    level.var_2e49e915 = 0;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_taylor_you_need_to_0");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_do_you_know_what_s_h_1");
    }
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_i_know_you_can_hear_0");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_you_ve_got_a_long_wa_1");
    }
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_what_s_happening_to_1");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_your_dni_may_show_yo_1");
    }
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_you_don_t_have_to_be_0");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_you_were_with_sarah_0");
    }
    level.var_2e49e915 = 0;
    wait 0.5;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_you_re_right_i_was_0");
    }
    level.var_2e49e915 = 0;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_i_also_know_it_wasn_0");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_clock_s_ticking_new_1");
    }
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_you_know_me_you_can_2");
    }
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint(5);
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::function_13b3b16a("plyr_it_s_not_too_late_to_2");
    }
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    if (!level flag::get("stop_dialog_remote")) {
        level dialog::remote("tayr_sometimes_you_have_1");
    }
    level.var_2e49e915 = 0;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x62df9c9, Offset: 0x2d90
// Size: 0x21
function function_80fdeb82() {
    level endon(#"hash_4c66c579");
    while (level.var_1df069b5 == 1) {
        wait 0.1;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x5e6760e0, Offset: 0x2dc0
// Size: 0x193
function function_66b6b1c7() {
    var_912c35b = getentarray("hero_shed_piece", "targetname");
    foreach (var_f29b0bec in var_912c35b) {
        if (var_f29b0bec.script_fxid != "shed_explosion_a") {
            var_f29b0bec thread lotus_util::function_cdf9cde7("mobile_shop_fall_explosion");
        }
    }
    var_912c35b = getentarray("roof_shed_piece_l", "targetname");
    foreach (var_f29b0bec in var_912c35b) {
        var_f29b0bec thread lotus_util::function_cdf9cde7("mobile_shop_fall_explosion");
    }
    var_912c35b = getentarray("roof_shed_piece_r", "targetname");
    foreach (var_f29b0bec in var_912c35b) {
        var_f29b0bec thread lotus_util::function_cdf9cde7("mobile_shop_fall_explosion");
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x7c6302b9, Offset: 0x2f60
// Size: 0x2c
function function_849fa351() {
    player_hunters = getentarray("boss_player_hunter", "targetname");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x45d94039, Offset: 0x2f98
// Size: 0x223
function function_f5bbb458() {
    level.var_217caec4 = [];
    function_87c0d86f("ms_l1", 0);
    function_87c0d86f("ms_l2", 1);
    function_87c0d86f("ms_l3", 5);
    function_87c0d86f("ms_l4", 3);
    function_87c0d86f("ms_r1", 3);
    function_87c0d86f("ms_r2", 2);
    function_87c0d86f("ms_r3", 4);
    function_87c0d86f("ms_r4", 0);
    level.var_b774ab1 = [];
    level.var_7f35354d = [];
    function_a1307751("ms_l1");
    function_a1307751("ms_l2");
    function_a1307751("ms_l3");
    function_a1307751("ms_l4");
    function_a1307751("ms_r1");
    function_a1307751("ms_r2");
    function_a1307751("ms_r3");
    function_a1307751("ms_r4");
    var_c92cac0f = getentarray("raps_slow", "targetname");
    foreach (var_91fc4ce in var_c92cac0f) {
        var_91fc4ce triggerenable(0);
    }
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x7db7e5d8, Offset: 0x31c8
// Size: 0x6f
function function_a1307751(str_name) {
    level.var_7f35354d[str_name] = lotus_util::function_b26ca094(str_name + "_group", 1, 0, 1, undefined, 1);
    var_ca404144 = new class_fa0d90fd();
    [[ var_ca404144 ]]->init(str_name, str_name + "_start_up");
    level.var_b774ab1[str_name] = var_ca404144;
}

// Namespace lotus_boss_battle
// Params 3, eflags: 0x0
// Checksum 0xc5616688, Offset: 0x3240
// Size: 0xae
function function_87c0d86f(str_name, var_a550bf45, str_location) {
    level.var_217caec4[str_name] = spawnstruct();
    level.var_217caec4[str_name].var_c957ee7 = 0;
    level.var_217caec4[str_name].var_69a938b4 = 0;
    level.var_217caec4[str_name].var_a550bf45 = var_a550bf45;
    var_20eebd31 = struct::get(str_name + "_1", "targetname");
    level.var_217caec4[str_name].v_origin = var_20eebd31.origin;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xd440ed4f, Offset: 0x32f8
// Size: 0xca
function function_ad67b293(var_15025f5b) {
    level.var_33df5678 = level.var_217caec4[var_15025f5b];
    level flag::wait_till("first_player_spawned");
    level flag::wait_till("ready_to_move_first_armory_vo");
    level thread function_396f2a6e("ms_r2", "other");
    level thread function_396f2a6e("ms_r3", "minigun");
    level thread function_396f2a6e("ms_l1", "other");
    level thread function_396f2a6e("ms_l4", "minigun");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xe870e17a, Offset: 0x33d0
// Size: 0x161
function gunship_first_missile_target() {
    self.var_cfe2cc2c = getent("gunship_first_missile_target", "targetname");
    mdl_weapon_clip = getent("bb_start_weapon_clip", "targetname");
    mdl_weapon_clip setcandamage(1);
    mdl_weapon_clip.health = 10000;
    mdl_weapon_clip endon(#"death");
    while (true) {
        mdl_weapon_clip waittill(#"damage", n_damage, e_attacker, var_a3382de1, v_point, str_means_of_death, var_c4fe462, var_e64d69f9, var_c04aef90, w_weapon);
        if (str_means_of_death == "MOD_PROJECTILE" || e_attacker.vehicletype === "veh_bo3_mil_gunship_nrc" && str_means_of_death == "MOD_PROJECTILE_SPLASH") {
            self.var_cfe2cc2c delete();
            self.var_cfe2cc2c = undefined;
            mdl_weapon_clip delete();
        }
        mdl_weapon_clip.health = 10000;
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x273d57e2, Offset: 0x3540
// Size: 0x4a
function function_b2b695fd() {
    level flag::wait_till("ready_to_move_first_armory_vo");
    level thread function_309d7a5a("kane_mobile_armories_on_t_0");
    level flag::set("first_mobile_armory_vo");
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0xa852fc91, Offset: 0x3598
// Size: 0x823
function function_396f2a6e(str_name, var_4e8cfdc6) {
    level.var_217caec4[str_name].str_state = "normal";
    level.var_217caec4[str_name].var_c957ee7 = 1;
    level.var_33df5678 = level.var_217caec4[str_name];
    var_959da48b = str_name + "_group";
    var_526507d5 = str_name + "_gate";
    var_7b6485f6 = getentarray(var_526507d5, "targetname");
    var_59dc7746 = 0;
    if (var_4e8cfdc6 == "minigun") {
        var_59dc7746 = 1;
    }
    var_f9a1ddd6 = level.var_7f35354d[str_name];
    if (var_4e8cfdc6 == "minigun") {
        foreach (var_83f53318 in var_f9a1ddd6.var_75cccf1) {
            var_409f4c83 = var_83f53318 lotus_util::function_c7b0a169(1, 1);
            var_409f4c83 linkto(var_f9a1ddd6);
        }
    } else {
        foreach (e_weapon in var_f9a1ddd6.a_weapons) {
            var_1c023cce = e_weapon lotus_util::function_bc5f7909(e_weapon.script_string);
            var_1c023cce linkto(var_f9a1ddd6);
        }
    }
    var_158e4f91 = level.var_b774ab1[str_name];
    var_23abba9c = [[ var_158e4f91 ]]->function_9bc3d62a();
    var_23abba9c resetdestructible();
    var_23abba9c clearvehgoalpos();
    [[ var_158e4f91 ]]->function_845aae7f(str_name + "_start_up");
    trigger::use("trig_" + str_name, "script_noteworthy");
    level waittill("vehicle_platform_" + str_name + "_stop");
    foreach (var_a43047cf in var_7b6485f6) {
        var_a43047cf thread function_d2dd0256(38, 0.5);
    }
    var_5f7e5fb4 = [];
    if (!isdefined(var_5f7e5fb4)) {
        var_5f7e5fb4 = [];
    } else if (!isarray(var_5f7e5fb4)) {
        var_5f7e5fb4 = array(var_5f7e5fb4);
    }
    var_5f7e5fb4[var_5f7e5fb4.size] = getnode(str_name + "_in_begin", "targetname");
    if (!isdefined(var_5f7e5fb4)) {
        var_5f7e5fb4 = [];
    } else if (!isarray(var_5f7e5fb4)) {
        var_5f7e5fb4 = array(var_5f7e5fb4);
    }
    var_5f7e5fb4[var_5f7e5fb4.size] = getnode(str_name + "_out_begin", "targetname");
    foreach (var_c2c49b4c in var_5f7e5fb4) {
        if (isdefined(var_c2c49b4c)) {
            linktraversal(var_c2c49b4c);
        }
    }
    var_91fc4ce = getent("trig_slow_" + str_name, "script_noteworthy");
    var_91fc4ce triggerenable(1);
    level notify(#"hash_4ccf207");
    if (var_4e8cfdc6 == "minigun") {
        var_8b943ba8 = 1;
        foreach (player in level.activeplayers) {
            if (issubstr(player.currentweapon.name, "minigun")) {
                var_8b943ba8 = 0;
            }
        }
        if (var_8b943ba8) {
            level thread function_309d7a5a("kane_get_that_minigun_fro_0");
        }
    }
    level waittill(#"hash_4c66c579");
    function_c4bfe365(str_name);
    foreach (var_a43047cf in var_7b6485f6) {
        var_a43047cf thread function_ee5df555(38, 0.5);
    }
    var_23abba9c clearvehgoalpos();
    [[ var_158e4f91 ]]->function_845aae7f(str_name + "_start_down");
    trigger::use("trig_" + str_name, "script_noteworthy");
    var_91fc4ce = getent("trig_slow_" + str_name, "script_noteworthy");
    var_91fc4ce triggerenable(0);
    if (var_4e8cfdc6 == "minigun") {
        foreach (var_83f53318 in var_f9a1ddd6.var_75cccf1) {
            if (isdefined(var_83f53318)) {
                if (isdefined(var_83f53318.var_409f4c83)) {
                    var_83f53318.var_409f4c83 delete();
                }
            }
        }
    }
    foreach (var_c2c49b4c in var_5f7e5fb4) {
        if (isdefined(var_c2c49b4c)) {
            unlinktraversal(var_c2c49b4c);
        }
    }
    level waittill("vehicle_platform_" + str_name + "_stop");
    if (var_4e8cfdc6 == "minigun") {
        foreach (var_83f53318 in var_f9a1ddd6.var_75cccf1) {
            if (isdefined(var_83f53318)) {
                var_83f53318 notify(#"hash_28a4f84e");
            }
        }
    }
    foreach (var_33723053 in var_f9a1ddd6.var_bcf73ab6) {
        var_33723053 show();
        var_33723053 solid();
    }
    foreach (e_weapon in var_f9a1ddd6.a_weapons) {
        e_weapon hide();
    }
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x5805f0b4, Offset: 0x3dc8
// Size: 0x32
function function_ee5df555(distance, move_time) {
    self moveto(self.origin + (0, 0, distance), move_time);
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x1d085cb2, Offset: 0x3e08
// Size: 0x32
function function_d2dd0256(distance, move_time) {
    self moveto(self.origin - (0, 0, distance), move_time);
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x7fb7a1b6, Offset: 0x3e48
// Size: 0x19e
function function_aa06c2d7() {
    var_d264ae0a = array("none", "none", "minigun");
    w_minigun = getweapon("minigun_lotus");
    var_7098dcba = 0;
    foreach (player in level.players) {
        if (player hasweapon(w_minigun)) {
            var_7098dcba++;
        }
    }
    if (var_7098dcba != level.players.size) {
        if (!isdefined(var_d264ae0a)) {
            var_d264ae0a = [];
        } else if (!isarray(var_d264ae0a)) {
            var_d264ae0a = array(var_d264ae0a);
        }
        var_d264ae0a[var_d264ae0a.size] = "minigun";
    }
    var_4e8cfdc6 = array::random(var_d264ae0a);
    if (var_4e8cfdc6 != "none") {
        level.var_6c0436ff = 0;
    } else {
        level.var_6c0436ff++;
        if (level.var_6c0436ff > 2) {
            arrayremovevalue(var_d264ae0a, "none");
            var_4e8cfdc6 = array::random(var_d264ae0a);
        }
    }
    return var_4e8cfdc6;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xcfc272be, Offset: 0x3ff0
// Size: 0x108
function function_9981be4a(str_name) {
    n_dist_sq_closest = distance2dsquared(level.players[0].origin, level.var_217caec4[str_name].v_origin);
    foreach (player in level.players) {
        n_dist_sq = distance2dsquared(player.origin, level.var_217caec4[str_name].v_origin);
        if (n_dist_sq < n_dist_sq_closest) {
            n_dist_sq_closest = n_dist_sq;
        }
    }
    var_4996fe37 = spawnstruct();
    var_4996fe37.str_name = str_name;
    var_4996fe37.n_dist_sq = n_dist_sq_closest;
    return var_4996fe37;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x837f6328, Offset: 0x4100
// Size: 0x11d
function function_c4bfe365(str_name) {
    e_volume = getent("vol_" + str_name, "targetname");
    var_60be00cb = 1;
    while (isdefined(var_60be00cb) && var_60be00cb) {
        var_23541867 = 0;
        var_c7a9ddc2 = getentarray("gunship_raps_ai", "targetname");
        var_c7a9ddc2 = arraycombine(var_c7a9ddc2, level.players, 0, 0);
        foreach (var_ad931ecf in var_c7a9ddc2) {
            if (var_ad931ecf istouching(e_volume)) {
                break;
            }
            var_23541867++;
        }
        if (var_23541867 == var_c7a9ddc2.size) {
            var_60be00cb = 0;
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xa77ebbdc, Offset: 0x4228
// Size: 0x30a
function function_82e92a08() {
    self endon(#"death");
    level thread function_e0652cc();
    setsaveddvar("vehicle_selfCollision", 1);
    self useanimtree(#generic);
    self.n_health_min = self.health * 0.01;
    self.var_eb0aa568 = 0;
    self.var_c753fc26 = 0;
    self.var_9d040270 = 0;
    self.var_9db475fa = level.var_33df5678.var_a550bf45;
    self.overridevehicledamage = &function_a3869b68;
    self.var_af439c86 = 0;
    self.var_e7f801f1 = 0;
    self.goalradius = 999999;
    self.goalheight = 4000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self setneargoalnotifydist(self.radius * 0.5);
    self.nocybercom = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self vehicle::toggle_lights_group(1, 1);
    self vehicle::toggle_lights_group(2, 1);
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    self.var_7f956758 = [];
    self flag::init("gunship_can_shoot");
    self flag::init("missiles_not_firing");
    self flag::init("gunship_over_roof");
    self flag::set("gunship_can_shoot");
    self flag::set("missiles_not_firing");
    var_70518e6d = getent("gunship_body", "targetname");
    var_70518e6d enablelinkto();
    var_70518e6d linkto(self);
    var_70518e6d thread function_69c5f9ce(self);
    self thread function_1e767c06();
    self thread function_fe22bc30();
    self thread gunship_weakpoint();
    self.var_c3733510 = 0;
    self thread function_d41b2661();
    self.var_f7041287 = 0;
    self thread function_a113ef2c();
    self thread function_4c66c579();
    self function_a5223a12();
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x3e7d42d5, Offset: 0x4540
// Size: 0x125
function function_e0652cc() {
    while (true) {
        level waittill(#"save_restore");
        wait 1;
        if (isdefined(level.var_38a4277e)) {
            if (level.var_38a4277e.var_e507c83f["tag_target_fan_right_outer"]) {
                level.var_38a4277e globallogic_ui::function_8ee5a301(%tag_target_fan_right_outer, 4000, 7500);
            }
            if (level.var_38a4277e.var_e507c83f["tag_target_fan_right_inner"]) {
                level.var_38a4277e globallogic_ui::function_8ee5a301(%tag_target_fan_right_inner, 4000, 7500);
            }
            if (level.var_38a4277e.var_e507c83f["tag_target_fan_left_inner"]) {
                level.var_38a4277e globallogic_ui::function_8ee5a301(%tag_target_fan_left_inner, 4000, 7500);
            }
            if (level.var_38a4277e.var_e507c83f["tag_target_fan_left_outer"]) {
                level.var_38a4277e globallogic_ui::function_8ee5a301(%tag_target_fan_left_outer, 4000, 7500);
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x5c925797, Offset: 0x4670
// Size: 0xe
function function_d41b2661() {
    wait 10;
    self.var_c3733510 = 1;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xf5df0841, Offset: 0x4688
// Size: 0x5e2
function getnextmoveposition_tactical() {
    selfdisttotarget = distance2d(self.origin, self.e_target.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (self.settings.engagementheightmax - self.settings.engagementheightmin);
    randomness = 300;
    queryresult = positionquery_source_navigation(self.origin, self.radius + 500, 10000, 1000, self.radius * 0.4, self, self.radius * 0.4);
    if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav) && !level flag::get("gunship_high_out_of_battle")) {
        var_5740256e = self getclosestpointonnavvolume(self.origin, self.radius + 500);
        if (isdefined(var_5740256e)) {
            self.var_ec9be5b1 = queryresult.centeronnav;
            /#
                iprintlnbold("<dev string:x28>");
            #/
            return var_5740256e;
        }
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.e_target, self.settings.engagementdistmin, self.settings.engagementdistmax);
    goalheight = self.e_target.origin[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x4c>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x53>"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x62>"] = distfrompreferredheight * -1;
            #/
            point.score += distfrompreferredheight * -1;
        }
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    positionquery_filter_sight(queryresult, self.e_target.origin, self geteye() - self.origin, self, 1, self.e_target);
    best_point = undefined;
    foreach (point in queryresult.data) {
        if (isdefined(point.visibility) && point.visibility) {
            best_point = point;
            break;
        }
    }
    if (!isdefined(best_point)) {
        if (isdefined(queryresult.data[0])) {
            best_point = queryresult.data[0];
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("<dev string:x69>")) && getdvarint("<dev string:x69>")) {
            if (isdefined(best_point)) {
                recordline(self.origin, best_point.origin, (0.3, 1, 0));
            }
            recordline(self.origin, self.e_target.origin, (1, 0, 0.4));
        }
    #/
    returnpoint = self.origin;
    self.var_ec9be5b1 = queryresult.centeronnav;
    if (isdefined(best_point)) {
        returnpoint = best_point.origin;
    }
    return returnpoint;
}

// Namespace lotus_boss_battle
// Params 3, eflags: 0x0
// Checksum 0xbe35c927, Offset: 0x4c78
// Size: 0x182
function function_ea4bbd0d(point, enemy, var_5e1bf73c) {
    self endon(#"death");
    enemy endon(#"death");
    enemy endon(#"disconnect");
    if (!isdefined(self.var_fa144784)) {
        self.var_fa144784 = spawn("script_origin", point);
    }
    self.var_fa144784 unlink();
    self.var_fa144784.origin = point;
    self setturrettargetent(self.var_fa144784);
    self waittill(#"turret_on_target");
    timestart = gettime();
    offset = (0, 0, 0);
    if (issentient(enemy)) {
        offset = enemy geteye() - enemy.origin;
    }
    while (gettime() < timestart + var_5e1bf73c * 1000) {
        self.var_fa144784.origin = lerpvector(point, enemy.origin + offset, (gettime() - timestart) / var_5e1bf73c * 1000);
        wait 0.05;
    }
    self.var_fa144784.origin = enemy.origin + offset;
    wait 0.05;
    self.var_fa144784 linkto(enemy);
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xf3867b49, Offset: 0x4e08
// Size: 0x15d
function function_e2183396() {
    self endon(#"death");
    self endon(#"hash_2e91796b");
    while (true) {
        if (!level flag::get("gunship_high_out_of_battle")) {
            enemy = self.e_target;
            if (isdefined(enemy)) {
                if (self function_4246bc05(enemy)) {
                    vectorfromenemy = vectornormalize(((self.origin - enemy.origin)[0], (self.origin - enemy.origin)[1], 0));
                    self thread function_ea4bbd0d(enemy.origin + vectorfromenemy * -56, enemy, 1);
                    self waittill(#"turret_on_target");
                    self vehicle_ai::fire_for_time(1.5 + randomfloat(0.5));
                    wait 2 + randomfloat(0.4);
                } else {
                    wait 0.1;
                }
            } else {
                self clearturrettarget();
                wait 0.2;
            }
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x3c3753a2, Offset: 0x4f70
// Size: 0x385
function function_a5223a12() {
    self endon(#"death");
    self endon(#"hash_b72bd855");
    self.var_16f2fd07 = 0;
    var_85191bfb = level.var_33df5678;
    var_29eaa707 = 0;
    var_64e13df2 = 0;
    self thread function_e2183396();
    while (true) {
        if (self.var_16f2fd07) {
            wait 0.05;
            continue;
        }
        if (level flag::get("gunship_high_out_of_battle")) {
            var_ef088aca = struct::get_array("gunship_out_of_fight_point", "targetname");
            dist_sq = 1955032704;
            foreach (position in var_ef088aca) {
                if (distancesquared(position.origin, self.origin) < dist_sq) {
                    var_1b28c94b = position;
                    dist_sq = distancesquared(position.origin, self.origin);
                }
            }
            self setvehgoalpos(var_1b28c94b.origin, 1, 0);
            self vehicle_ai::waittill_pathing_done();
            wait 0.05;
            continue;
        }
        if (isdefined(level.var_33df5678)) {
            if (isdefined(self.var_b5b6b568) && isdefined(self.var_d24de693) && randomint(100) < 100 && self.var_d24de693 && self.var_b5b6b568) {
                self.var_1e900bbc = 1;
            }
            self setspeed(self.settings.defaultmovespeed);
            if (isdefined(self.inpain) && self.inpain) {
                wait 0.1;
                continue;
            }
            if (!isdefined(self.e_target)) {
                wait 0.25;
                continue;
            }
            if (isdefined(self.var_f7041287) && self.var_f7041287) {
                self function_313b72be();
                self.var_f7041287 = 0;
            }
            if (isdefined(self.var_7c83c7b9) && self.var_7c83c7b9) {
                self function_aa03c076();
                continue;
            }
            returnpoint = getnextmoveposition_tactical();
            self.current_pathto_pos = returnpoint;
            if (isdefined(self.current_pathto_pos)) {
                if (isdefined(self.var_ec9be5b1) && self.var_ec9be5b1) {
                    self setvehgoalpos(self.current_pathto_pos, 1, 1);
                    self vehicle_ai::waittill_pathing_done();
                } else {
                    self setvehgoalpos(self.current_pathto_pos, 1, 0);
                    self vehicle_ai::waittill_pathing_done();
                }
            }
            if (self.var_c3733510 && randomint(100) < 30) {
                self function_313b72be();
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xb8f4320e, Offset: 0x5300
// Size: 0x7f
function function_52fd8e0c() {
    var_930421fd = getentarray("gunship_raps_ai", "targetname");
    level.var_36a074b0 = gettime();
    while (var_930421fd.size > 2 && gettime() - level.var_36a074b0 < 20000) {
        wait 0.05;
        var_930421fd = getentarray("gunship_raps_ai", "targetname");
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x483c5797, Offset: 0x5388
// Size: 0x7f
function function_7a689af4() {
    var_b9229bcd = getentarray("gunship_amws_ai", "targetname");
    level.var_5b028c20 = gettime();
    while (var_b9229bcd.size > 2 && gettime() - level.var_5b028c20 < 20000) {
        wait 0.05;
        var_b9229bcd = getentarray("gunship_amws_ai", "targetname");
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x8281964e, Offset: 0x5410
// Size: 0x62
function function_fabd65a5() {
    self.var_16f2fd07 = 1;
    self setvehgoalpos(self.origin + (0, 0, 3000), 1, 1);
    self vehicle_ai::waittill_pathing_done();
    self.var_16f2fd07 = 0;
    level flag::set_val("gunship_high_out_of_battle", 0);
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x41621cfc, Offset: 0x5480
// Size: 0x217
function gunship_weakpoint() {
    level flag::wait_till("all_players_spawned");
    wait 0.5;
    self globallogic_ui::function_8ee5a301(%tag_target_fan_right_outer, 4000, 7500);
    self globallogic_ui::function_8ee5a301(%tag_target_fan_right_inner, 4000, 7500);
    self globallogic_ui::function_8ee5a301(%tag_target_fan_left_inner, 4000, 7500);
    self globallogic_ui::function_8ee5a301(%tag_target_fan_left_outer, 4000, 7500);
    self.var_e507c83f = [];
    self.var_e507c83f["tag_target_fan_right_outer"] = 1;
    self.var_e507c83f["tag_target_fan_right_inner"] = 1;
    self.var_e507c83f["tag_target_fan_left_inner"] = 1;
    self.var_e507c83f["tag_target_fan_left_outer"] = 1;
    var_c9f0ffa0 = getentarray("gunship_weakpoint", "targetname");
    self.var_c9f0ffa0 = var_c9f0ffa0;
    self.var_fd056e61 = [];
    foreach (var_d23e13a5 in var_c9f0ffa0) {
        var_d23e13a5 linkto(self);
        target_set(var_d23e13a5);
        var_f4bd5505 = "fan_" + var_d23e13a5.script_noteworthy + "_hurt";
        level.destructible_callbacks[var_f4bd5505] = &function_9eab29c4;
        var_ce9e1adb = "fan_" + var_d23e13a5.script_noteworthy + "_destroyed";
        level.destructible_callbacks[var_ce9e1adb] = &function_6c18838;
        self.var_fd056e61[var_ce9e1adb] = var_d23e13a5;
    }
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x7e09eca8, Offset: 0x56a0
// Size: 0x6a
function function_6c18838(var_ffec1daa, e_attacker) {
    self function_118e623c(self.var_fd056e61[var_ffec1daa].script_int);
    self.var_af439c86 = self.var_af439c86 + 1;
    self.var_e7f801f1 = self.var_e7f801f1 + 1;
    self.var_fd056e61[var_ffec1daa] delete();
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x7fcff472, Offset: 0x5718
// Size: 0x22
function function_9eab29c4(var_ffec1daa, e_attacker) {
    self.var_e7f801f1 = self.var_e7f801f1 + 1;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x7ef37969, Offset: 0x5748
// Size: 0xe9
function function_118e623c(n_id) {
    switch (n_id) {
    case 1:
        self globallogic_ui::function_d66e4079(%tag_target_fan_right_outer);
        self.var_e507c83f["tag_target_fan_right_outer"] = 0;
        break;
    case 2:
        self globallogic_ui::function_d66e4079(%tag_target_fan_right_inner);
        self.var_e507c83f["tag_target_fan_right_inner"] = 0;
        break;
    case 3:
        self globallogic_ui::function_d66e4079(%tag_target_fan_left_inner);
        self.var_e507c83f["tag_target_fan_left_inner"] = 0;
        break;
    case 4:
        self globallogic_ui::function_d66e4079(%tag_target_fan_left_outer);
        self.var_e507c83f["tag_target_fan_left_outer"] = 0;
        break;
    default:
        break;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xeacd412a, Offset: 0x5840
// Size: 0x313
function function_4c66c579() {
    while (self.var_af439c86 < 4) {
        wait 0.05;
    }
    a_flags = [];
    if (!isdefined(a_flags)) {
        a_flags = [];
    } else if (!isarray(a_flags)) {
        a_flags = array(a_flags);
    }
    a_flags[a_flags.size] = "gunship_can_shoot";
    if (!isdefined(a_flags)) {
        a_flags = [];
    } else if (!isarray(a_flags)) {
        a_flags = array(a_flags);
    }
    a_flags[a_flags.size] = "missiles_not_firing";
    self flag::wait_till_all(a_flags);
    self notify(#"hash_478d205f");
    self notify(#"hash_9d463a5c");
    self notify(#"hash_b72bd855");
    self turret::disable(0);
    var_c9f0ffa0 = getentarray("gunship_weakpoint", "targetname");
    foreach (var_d23e13a5 in var_c9f0ffa0) {
        self function_118e623c(var_d23e13a5.script_int);
    }
    self notify(#"hash_cd4fad51");
    self setspeed(50);
    s_position = struct::get("of_gunship_start_pos");
    self function_bcfeb18(s_position.origin, 1, 0);
    self waittill(#"near_goal");
    level notify(#"hash_4c66c579");
    level flag::set("stop_dialog_remote");
    var_930421fd = getentarray("gunship_raps_ai", "targetname");
    foreach (var_388753bb in var_930421fd) {
        var_388753bb delete();
    }
    var_b9229bcd = getentarray("gunship_amws_ai", "targetname");
    foreach (var_31e90922 in var_b9229bcd) {
        var_31e90922 delete();
    }
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xb5a2e046, Offset: 0x5b60
// Size: 0x61
function function_69c5f9ce(var_38a4277e) {
    var_38a4277e endon(#"hash_6d2412ee");
    while (true) {
        self waittill(#"trigger", triggerer);
        if (isplayer(triggerer)) {
            triggerer util::show_hint_text(%CP_MI_CAIRO_LOTUS_LEVIATHAN_HINT, 1);
        }
        wait 30;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xa8db0f, Offset: 0x5bd0
// Size: 0xc1
function function_fe22bc30() {
    self endon(#"death");
    n_health_percent = self.n_health_min;
    var_1082952f = self.health - n_health_percent;
    var_8feca2ee = self.health / 2;
    var_2f7d2047 = self.health * 0.75;
    self thread function_66246a8b();
    while (true) {
        if (self.health < var_1082952f) {
            self notify(#"hash_6105d0b5");
            var_1082952f = self.health - n_health_percent;
        }
        if (self.var_e7f801f1 >= 4) {
            self notify(#"hash_6d2412ee");
        }
        if (self.var_e7f801f1 >= 2) {
            self notify(#"hash_cf300440");
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x7e992819, Offset: 0x5ca0
// Size: 0x5a
function function_a113ef2c() {
    self endon(#"death");
    self.n_acceleration = 30;
    self waittill(#"hash_6d2412ee");
    self.var_d24de693 = 1;
    self.n_acceleration = 54;
    self thread function_16ed7b4();
    level scene::init("cin_lot_17_oldfriend_3rd_sh010");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x66b42fa3, Offset: 0x5d08
// Size: 0x21
function function_16ed7b4() {
    self endon(#"death");
    while (true) {
        self notify(#"hash_8d85c04a");
        wait 10;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x94d164ff, Offset: 0x5d38
// Size: 0x61
function function_66246a8b() {
    self endon(#"death");
    self waittill(#"hash_cf300440");
    while (true) {
        self.var_7c83c7b9 = 1;
        self waittill(#"hash_fe14afa0");
        function_52fd8e0c();
        function_7a689af4();
        self function_fabd65a5();
        wait 40;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x1bc730ed, Offset: 0x5da8
// Size: 0x4ae
function function_aa03c076() {
    self setspeed(3 * self.settings.defaultmovespeed);
    var_166cf772 = [];
    var_34168a41 = [];
    var_736e1fad = [];
    var_e612786e = getentarray("raps_ship_pos", "targetname");
    var_b78c14cc = getentarray("raps_aim_pos", "targetname");
    var_3df07ee9 = arraysortclosest(var_e612786e, self.origin);
    var_3d2fc9e7 = arraysortclosest(var_b78c14cc, self.origin);
    if (randomint(100) < 50) {
        str_side = "left";
    } else {
        str_side = "right";
    }
    var_e296d6b4 = function_8f336df2() * level.players.size;
    foreach (var_2b86b404 in var_3df07ee9) {
        if (var_2b86b404.script_string == str_side) {
            var_34168a41[var_34168a41.size] = var_e296d6b4 / (3 - var_166cf772.size);
            var_e296d6b4 -= var_34168a41[var_34168a41.size - 1];
            var_736e1fad[var_736e1fad.size] = var_2b86b404;
        }
    }
    foreach (var_2b86b404 in var_3d2fc9e7) {
        if (var_2b86b404.script_string == str_side) {
            var_166cf772[var_166cf772.size] = var_2b86b404;
        }
    }
    if (self setvehgoalpos(var_736e1fad[randomint(2)].origin, 1, 1)) {
        self setlookatent(var_736e1fad[2]);
        self.var_77116e68 = 1;
        self vehicle_ai::waittill_pathing_done();
    }
    wait 2;
    level notify(#"hash_2f1e81");
    var_7099d5e = function_8a8d7d66();
    if (isdefined(self.var_b5b6b568) && isdefined(self.var_1e900bbc) && self.var_1e900bbc && self.var_b5b6b568) {
        for (j = 0; j < 3; j++) {
            var_b9229bcd = getentarray("gunship_amws_ai", "targetname");
            if (var_b9229bcd.size < var_7099d5e) {
                self.var_3e8f6c24 = var_166cf772[j].origin;
                self.var_6ded64ae = var_34168a41[j];
                self function_1f2b3ab5();
            }
        }
        wait 2;
    }
    for (j = 0; j < 3; j++) {
        var_930421fd = getentarray("gunship_raps_ai", "targetname");
        if (var_930421fd.size < var_7099d5e) {
            self.var_3e8f6c24 = var_166cf772[j].origin;
            self.var_6ded64ae = var_34168a41[j];
            self function_41d6059d();
        }
    }
    wait 2;
    for (j = 0; j < 3; j++) {
        var_930421fd = getentarray("gunship_raps_ai", "targetname");
        if (var_930421fd.size < var_7099d5e) {
            self.var_3e8f6c24 = var_166cf772[j].origin;
            self.var_6ded64ae = var_34168a41[j];
            self function_41d6059d();
        }
    }
    n_wait = 0.05;
    wait n_wait;
    self notify(#"hash_fe14afa0");
    self.var_77116e68 = 0;
    self.var_b5b6b568 = 1;
    if (isdefined(self.var_894468a1) && self.var_894468a1) {
        self.var_1e900bbc = 0;
    }
    self.var_7c83c7b9 = 0;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xbe4c668a, Offset: 0x6260
// Size: 0x152
function function_db5569bf() {
    self endon(#"death");
    self flag::set("gunship_over_roof");
    array::run_all(level.players, &playrumbleonentity, "damage_light");
    wait 0.25;
    while (self flag::get("gunship_over_roof")) {
        array::run_all(level.players, &playrumbleonentity, "damage_heavy");
        foreach (player in level.players) {
            earthquake(0.5, 0.15, player.origin, 64);
        }
        wait 0.15;
    }
    array::run_all(level.players, &playrumbleonentity, "damage_light");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xfa805b8a, Offset: 0x63c0
// Size: 0x22
function function_37e6d832() {
    self endon(#"death");
    wait 2;
    self flag::clear("gunship_over_roof");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x949a4276, Offset: 0x63f0
// Size: 0x48
function function_5f92c323() {
    var_537a4b22 = (self.var_9db475fa + 3) % 6;
    if (var_537a4b22 == 0) {
        var_eca3a58a = 1;
    } else {
        var_eca3a58a = 2;
    }
    return var_eca3a58a;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xeaeef18e, Offset: 0x6440
// Size: 0x17
function function_68aeee69(n_wait) {
    wait n_wait;
    level notify(#"hash_79414051");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xf4cec8f4, Offset: 0x6460
// Size: 0x135
function function_e9e10dcf() {
    self endon(#"death");
    while (true) {
        v_tag_origin = self gettagorigin("tag_rocket1");
        var_95a39498 = bullettrace(v_tag_origin, level.players[0].origin, 0, self);
        util::debug_line(v_tag_origin, level.players[0].origin, (1, 0, 0), 0.8, 0, 1);
        v_tag_origin = self gettagorigin("tag_rocket2");
        var_7ab03d3 = bullettrace(v_tag_origin, level.players[0].origin, 0, self);
        util::debug_line(v_tag_origin, level.players[0].origin, (1, 0, 0), 0.8, 0, 1);
        if (var_95a39498["fraction"] < 0.59 || var_7ab03d3["fraction"] < 0.59) {
            iprintlnbold("don't shoot");
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xd4e486f, Offset: 0x65a0
// Size: 0x301
function function_4ea99800() {
    self endon(#"death");
    var_c6da11b8 = getentarray("boss_wasp", "targetname");
    var_dc416322 = [];
    while (true) {
        level waittill(#"hash_14f52a04");
        if (isdefined(self.e_target) && self.e_target.sessionstate == "playing") {
            var_dc416322 = array::remove_undefined(var_dc416322);
            var_b8c96ec3 = 4 * level.players.size;
            var_df9ad083 = level.players;
            foreach (e_player in level.players) {
                if (e_player != self.e_target) {
                    if (!isdefined(var_df9ad083)) {
                        var_df9ad083 = [];
                    } else if (!isarray(var_df9ad083)) {
                        var_df9ad083 = array(var_df9ad083);
                    }
                    var_df9ad083[var_df9ad083.size] = e_player;
                }
            }
            var_5908c36e = 0;
            for (i = 0; i < var_b8c96ec3; i++) {
                var_69e69694 = arraysortclosest(var_c6da11b8, var_df9ad083[var_5908c36e].origin);
                var_aaefedf3 = spawner::simple_spawn_single(var_69e69694[0]);
                var_aaefedf3.origin = self gettagorigin("tag_bomb");
                var_aaefedf3.angles = self gettagangles("tag_bomb");
                n_x_offset = randomint(2) ? 256 : -256;
                n_y_offset = randomint(2) ? 256 : -256;
                var_bc5fb476 = var_df9ad083[var_5908c36e].origin + (n_x_offset, n_y_offset, 64);
                var_4d7cb886 = var_aaefedf3 setgoal(var_bc5fb476, 1);
                var_aaefedf3 thread function_5d39689d();
                if (!isdefined(var_dc416322)) {
                    var_dc416322 = [];
                } else if (!isarray(var_dc416322)) {
                    var_dc416322 = array(var_dc416322);
                }
                var_dc416322[var_dc416322.size] = var_aaefedf3;
                var_5908c36e++;
                if (var_5908c36e == var_df9ad083.size) {
                    var_5908c36e = 0;
                }
            }
            wait 15;
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xb1692870, Offset: 0x68b0
// Size: 0x22
function function_5d39689d() {
    self endon(#"death");
    self waittill(#"goal");
    self clearforcedgoal();
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xcbe4c2f0, Offset: 0x68e0
// Size: 0x18a
function function_a6b9e99b() {
    if (isdefined(self.e_target)) {
        var_9cb05100 = getentarray("boss_minion_hunter", "targetname");
        self.var_5a36be60 = function_f8f08291();
        for (i = 0; i < function_f8f08291(); i++) {
            var_782205f8 = spawner::simple_spawn_single(var_9cb05100[0]);
            var_782205f8 thread watch_for_death(self);
            var_782205f8 thread watch_for_team_change(self);
            var_782205f8 vehicle_ai::set_state("scripted");
            var_782205f8.origin = self gettagorigin("tag_bomb");
            var_782205f8.angles = self gettagangles("tag_bomb");
            var_63055781 = (var_782205f8.origin[0], var_782205f8.origin[1], var_782205f8.origin[2] - 600);
            var_782205f8 function_bcfeb18(var_63055781, 1, 1);
            var_782205f8 waittill(#"near_goal");
            var_782205f8 vehicle_ai::set_state("combat");
            wait 0.05;
        }
        self.var_382c873 = 1;
    }
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x513f0a7d, Offset: 0x6a78
// Size: 0x1e
function watch_for_death(gunship) {
    self waittill(#"death");
    gunship.var_5a36be60--;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xba5c6902, Offset: 0x6aa0
// Size: 0x4a
function watch_for_team_change(gunship) {
    self endon(#"death");
    oldteam = self.team;
    while (true) {
        if (oldteam != self.team) {
            break;
        }
        wait 5;
    }
    gunship.var_5a36be60--;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xdf405289, Offset: 0x6af8
// Size: 0x1aa
function function_41d6059d() {
    if (isdefined(self.e_target) && isplayer(self.e_target) && self.e_target.sessionstate == "playing") {
        assert(isdefined(self.var_3e8f6c24));
        assert(isdefined(self.var_6ded64ae));
        var_6ee22718 = self.var_6ded64ae;
        self playsound("veh_raps_launch");
        for (i = 0; i < var_6ee22718; i++) {
            var_3e32f05a = spawner::simple_spawn_single("gunship_raps");
            if (var_3e32f05a.archetype == "raps") {
                var_3e32f05a.var_2f8cff2 = 1;
            }
            var_3e32f05a.origin = self gettagorigin("tag_origin") + (0, 0, 512);
            var_3e32f05a util::function_e218424d();
            var_3e32f05a clientfield::set("play_raps_trail_fx", 1);
            var_3e32f05a thread function_853d3b2b(self.var_3e8f6c24);
            wait 0.15;
        }
        level flag::set_val("gunship_high_out_of_battle", 1);
        level thread function_309d7a5a(array::random(level.var_ead3caed));
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x58c6fcc8, Offset: 0x6cb0
// Size: 0x17a
function function_1f2b3ab5() {
    if (isdefined(self.e_target) && isplayer(self.e_target) && self.e_target.sessionstate == "playing") {
        assert(isdefined(self.var_3e8f6c24));
        assert(isdefined(self.var_6ded64ae));
        var_483569a0 = self.var_6ded64ae;
        self playsound("veh_raps_launch");
        for (i = 0; i < var_483569a0; i++) {
            var_31e90922 = spawner::simple_spawn_single("gunship_amws");
            var_31e90922.origin = self gettagorigin("tag_origin") + (0, 0, 512);
            var_31e90922 util::function_e218424d();
            var_31e90922 thread function_853d3b2b(self.var_3e8f6c24);
            wait 0.15;
        }
        level flag::set_val("gunship_high_out_of_battle", 1);
        level thread function_309d7a5a(array::random(level.var_4483235d));
    }
    self.var_894468a1 = 1;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0xd3924c79, Offset: 0x6e38
// Size: 0x8a
function function_853d3b2b(var_ff72f147) {
    self endon(#"death");
    self vehicle_ai::set_state("scripted");
    self launchvehicle((0, 0, 200));
    wait 1;
    self applyballistictarget(var_ff72f147);
    self thread function_15e66414(var_ff72f147);
    wait 5.5;
    self vehicle_ai::set_state("combat");
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x7df52901, Offset: 0x6ed0
// Size: 0xa2
function function_15e66414(var_b748b5a5) {
    self endon(#"death");
    self vehicle::toggle_sounds(0);
    while (distance(self.origin, var_b748b5a5) > 400) {
        wait 0.1;
    }
    if (isdefined(self.var_2f8cff2)) {
        self.var_2f8cff2 = 0;
    }
    self playsound("veh_raps_first_land");
    self clientfield::set("play_raps_trail_fx", 0);
    self vehicle::toggle_sounds(1);
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x94700b82, Offset: 0x6f80
// Size: 0x8f
function function_8f336df2() {
    switch (level.players.size) {
    case 1:
        n_count = 3;
        break;
    case 2:
        n_count = 2;
        break;
    case 3:
        n_count = 2;
        break;
    case 4:
        n_count = 2;
        break;
    default:
        break;
    }
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x43cfeed8, Offset: 0x7018
// Size: 0x6f
function function_8a8d7d66() {
    switch (level.players.size) {
    case 1:
        n_count = 12;
        break;
    case 2:
        n_count = 20;
        break;
    case 3:
        n_count = 24;
        break;
    case 4:
        n_count = 32;
        break;
    default:
        break;
    }
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xf3467d69, Offset: 0x7090
// Size: 0x8f
function function_f8f08291() {
    switch (level.players.size) {
    case 1:
        n_count = 1;
        break;
    case 2:
        n_count = 2;
        break;
    case 3:
        n_count = 2;
        break;
    case 4:
        n_count = 3;
        break;
    default:
        break;
    }
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xbbec0fae, Offset: 0x7128
// Size: 0x373
function function_313b72be() {
    self endon(#"death");
    self endon(#"hash_9d463a5c");
    var_6bffcc7a = level.activeplayers.size;
    if (isdefined(self.var_7f956758) && self.var_7f956758.size != 0) {
        var_6bffcc7a = self.var_7f956758.size;
    }
    self function_6e075bdf(0, 1);
    self function_6e075bdf(1, 1);
    var_7fd6892d = 0;
    self.var_c1d01bf8 = 0;
    if (isdefined(self.e_target) && !level flag::get("gunship_high_out_of_battle")) {
        playsoundatposition("evt_boss_rocket_prime", self.origin);
        self notify(#"hash_2e91796b");
        self playsoundwithnotify("evt_boss_rocket_charge", "sound_done");
        self waittill(#"sound_done");
        level thread function_309d7a5a(array::random(level.var_af475f02));
        if (!level flag::get("first_missile_fired_vo")) {
            level flag::set("first_missile_fired_vo");
        }
        v_forward = anglestoforward(self.angles);
        var_840a016a = self gettagorigin("tag_gunner_turret1");
        var_68880690 = var_840a016a + v_forward * 1024;
        self function_6521eb5d(var_68880690, 0);
        var_5e078701 = self gettagorigin("tag_gunner_turret2");
        var_da8f75cb = var_5e078701 + v_forward * 1024;
        self function_6521eb5d(var_da8f75cb, 1);
        self waittill(#"gunner_turret_on_target");
        for (i = 0; i < var_6bffcc7a; i++) {
            wait 0.1;
            self function_d7bfd7f(0);
            wait 0.1;
            self function_d7bfd7f(1);
        }
        wait 1;
        foreach (e_player in level.players) {
            if (isdefined(e_player.var_c5b310a6)) {
                e_player.var_c5b310a6 unlink();
            }
        }
        self util::waittill_notify_or_timeout("all_missiles_destroyed", 6.45);
        self thread function_e2183396();
        var_7fd6892d = 0;
        foreach (e_player in level.players) {
            if (isdefined(e_player.var_c5b310a6)) {
                e_player.var_c5b310a6 delete();
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xaec54fe7, Offset: 0x74a8
// Size: 0x137
function function_b5e3704e() {
    v_tag_origin = self gettagorigin("tag_rocket1");
    var_95a39498 = bullettrace(v_tag_origin, self.e_target.origin, 0, self);
    v_tag_origin = self gettagorigin("tag_rocket2");
    for (var_7ab03d3 = bullettrace(v_tag_origin, self.e_target.origin, 0, self); var_95a39498["fraction"] < 0.59 || var_7ab03d3["fraction"] < 0.59; var_7ab03d3 = bullettrace(v_tag_origin, self.e_target.origin, 0, self)) {
        wait 0.05;
        v_tag_origin = self gettagorigin("tag_rocket1");
        var_95a39498 = bullettrace(v_tag_origin, self.e_target.origin, 0, self);
        v_tag_origin = self gettagorigin("tag_rocket2");
    }
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x98d5b7b, Offset: 0x75e8
// Size: 0xca
function function_d7bfd7f(var_1fe9bd0c) {
    e_target = self function_5b0cea0a();
    var_e6ad0ba4 = var_1fe9bd0c + 1;
    str_tag = "tag_rocket" + var_e6ad0ba4;
    v_tag_origin = self gettagorigin(str_tag);
    var_429f87f7 = getweapon("gunship_cannon");
    e_missile = magicbullet(var_429f87f7, v_tag_origin, v_tag_origin + (0, 0, 1024), self, e_target);
    e_missile thread function_7ec8c202(self);
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xfd4b06dd, Offset: 0x76c0
// Size: 0x108
function function_5b0cea0a() {
    var_9dcd387d = undefined;
    if (isdefined(self.var_cfe2cc2c)) {
        var_9dcd387d = self.var_cfe2cc2c;
    } else {
        a_targets = arraysortclosest(self.var_7f956758, level.var_33df5678.v_origin);
        n_mod = int(self.var_c1d01bf8 / 2);
        if (n_mod >= a_targets.size) {
            n_mod = a_targets.size - 1;
        }
        e_target = a_targets[n_mod];
        if (!isdefined(e_target.var_c5b310a6)) {
            e_target.var_c5b310a6 = spawn("script_model", e_target.origin, 0);
            e_target.var_c5b310a6 linkto(e_target);
        }
        var_9dcd387d = e_target.var_c5b310a6;
    }
    self.var_c1d01bf8++;
    return var_9dcd387d;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x4744daf7, Offset: 0x77d0
// Size: 0x38
function function_7ec8c202(var_38a4277e) {
    self waittill(#"death");
    var_38a4277e.var_c1d01bf8--;
    if (var_38a4277e.var_c1d01bf8 == 0) {
        var_38a4277e notify(#"all_missiles_destroyed");
    }
}

// Namespace lotus_boss_battle
// Params 3, eflags: 0x0
// Checksum 0x716ad044, Offset: 0x7810
// Size: 0x62
function function_bcfeb18(v_origin, var_da005640, var_8c59a8de) {
    var_d620769c = self setvehgoalpos(v_origin, var_da005640);
    /#
        if (!(isdefined(var_d620769c) && var_d620769c)) {
            iprintlnbold("<dev string:x81>");
        }
    #/
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x3a49f4b6, Offset: 0x7880
// Size: 0x2e9
function function_68e67780(var_9db475fa) {
    self endon(#"death");
    self notify(#"hash_cd4fad51");
    self endon(#"hash_cd4fad51");
    self.var_9db475fa = var_9db475fa;
    var_91c497de = "gunship_pos_" + self.var_9db475fa;
    var_4e9a9978 = var_91c497de;
    var_5013796b = "clockwise";
    var_9c8616bd = struct::get("gunship_pos_" + self.var_c753fc26, "targetname");
    if (self.var_c753fc26 != self.var_9db475fa) {
        self flag::clear("gunship_can_shoot");
        var_5013796b = self function_cf3bbe02();
        if (var_5013796b == "counterclockwise") {
            var_4e9a9978 = self function_c38d5af4(var_9c8616bd, var_91c497de);
        } else {
            var_4e9a9978 = self function_cdb12f14(var_9c8616bd, var_91c497de);
        }
        self flag::set("gunship_can_shoot");
    }
    s_position = struct::get(var_4e9a9978, "targetname");
    var_697e3556 = struct::get(s_position.target, "targetname");
    var_216bf22d = struct::get(s_position.script_string, "targetname");
    while (true) {
        self notify(#"hash_8e5e255b");
        self.var_9d040270 = s_position.script_int;
        self function_bcfeb18(s_position.origin, 0, 1);
        self waittill(#"near_goal");
        self.var_eb0aa568 = self.var_c753fc26;
        self.var_c753fc26 = s_position.script_int;
        if (var_5013796b == "counterclockwise") {
            self.var_9d040270 = var_216bf22d.script_int;
            self function_bcfeb18(var_216bf22d.origin, 1, 1);
            self waittill(#"near_goal");
            self.var_eb0aa568 = self.var_c753fc26;
            self.var_c753fc26 = var_216bf22d.script_int;
            var_5013796b = "clockwise";
        } else {
            self.var_9d040270 = var_697e3556.script_int;
            self function_bcfeb18(var_697e3556.origin, 1, 1);
            self waittill(#"near_goal");
            self.var_eb0aa568 = self.var_c753fc26;
            self.var_c753fc26 = var_697e3556.script_int;
            var_5013796b = "counterclockwise";
        }
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x31f93882, Offset: 0x7b78
// Size: 0xa6
function function_cf3bbe02() {
    var_3c8b0726 = 5 - self.var_c753fc26;
    if (self.var_c753fc26 > self.var_9db475fa) {
        var_3c8b0726 += self.var_9db475fa + 1;
    }
    var_d0e7904a = self.var_c753fc26 - self.var_9db475fa;
    if (self.var_c753fc26 < self.var_9db475fa) {
        var_d0e7904a += 6;
    }
    if (var_d0e7904a < var_3c8b0726) {
        var_5013796b = "counterclockwise";
    } else {
        var_5013796b = "clockwise";
    }
    return var_5013796b;
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0xce2bb5ad, Offset: 0x7c28
// Size: 0xc1
function function_cdb12f14(var_9c8616bd, var_91c497de) {
    for (var_4e9a9978 = var_9c8616bd.target; var_4e9a9978 != var_91c497de; var_4e9a9978 = s_position.target) {
        s_position = struct::get(var_4e9a9978, "targetname");
        self.var_9d040270 = s_position.script_int;
        self function_bcfeb18(s_position.origin, 0, 1);
        self waittill(#"near_goal");
        self.var_eb0aa568 = self.var_c753fc26;
        self.var_c753fc26 = s_position.script_int;
    }
    return var_4e9a9978;
}

// Namespace lotus_boss_battle
// Params 2, eflags: 0x0
// Checksum 0x51ce15f0, Offset: 0x7cf8
// Size: 0xc1
function function_c38d5af4(var_9c8616bd, var_91c497de) {
    for (var_4e9a9978 = var_9c8616bd.script_string; var_4e9a9978 != var_91c497de; var_4e9a9978 = s_position.script_string) {
        s_position = struct::get(var_4e9a9978, "targetname");
        self.var_9d040270 = s_position.script_int;
        self function_bcfeb18(s_position.origin, 0, 1);
        self waittill(#"near_goal");
        self.var_eb0aa568 = self.var_c753fc26;
        self.var_c753fc26 = s_position.script_int;
    }
    return var_4e9a9978;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x4
// Checksum 0x280a0803, Offset: 0x7dc8
// Size: 0xdd
function private function_c60bcf77(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return false;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    if (self.team == target.team) {
        return false;
    }
    return true;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x92166755, Offset: 0x7eb0
// Size: 0xe2
function function_965c000c() {
    self endon(#"death");
    var_df348736 = [];
    do {
        target_list = arraycombine(level.players, getaiteamarray("allies"), 0, 0);
        if (target_list.size > 0) {
            foreach (var_738974f1 in target_list) {
                if (function_c60bcf77(var_738974f1)) {
                    var_df348736[var_df348736.size] = var_738974f1;
                }
            }
        }
        wait 0.05;
    } while (var_df348736.size == 0);
    self.var_7f956758 = var_df348736;
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xe8d32af8, Offset: 0x7fa0
// Size: 0x21d
function function_1e767c06() {
    self endon(#"death");
    self function_965c000c();
    self.e_target = self.var_7f956758[0];
    if (!(isdefined(self.var_77116e68) && self.var_77116e68) && isdefined(self.e_target)) {
        self setlookatent(self.e_target);
    }
    while (!isdefined(level.var_33df5678)) {
        wait 0.05;
    }
    while (true) {
        self function_965c000c();
        var_e370f4cd = self.var_7f956758[0];
        if (isdefined(var_e370f4cd)) {
            n_dist_sq_min = distance2dsquared(var_e370f4cd.origin, level.var_33df5678.v_origin);
        }
        foreach (target in self.var_7f956758) {
            n_dist_sq = distance2dsquared(target.origin, level.var_33df5678.v_origin);
            if (n_dist_sq < n_dist_sq_min) {
                var_e370f4cd = target;
                n_dist_sq_min = n_dist_sq;
            }
        }
        if (isdefined(self.e_target) && isdefined(var_e370f4cd) && var_e370f4cd != self.e_target) {
            self.e_target = var_e370f4cd;
        } else if (!function_c60bcf77(self.e_target)) {
            self.e_target = undefined;
            if (isdefined(var_e370f4cd)) {
                self.e_target = var_e370f4cd;
            }
        }
        if (!(isdefined(self.var_77116e68) && self.var_77116e68) && isdefined(self.e_target)) {
            self setlookatent(self.e_target);
        }
        wait 0.5;
    }
}

// Namespace lotus_boss_battle
// Params 15, eflags: 0x0
// Checksum 0x5825377f, Offset: 0x81c8
// Size: 0x1e3
function function_a3869b68(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, var_46043680, psoffsettime, var_3bc96147, var_269779a, var_829b9480, var_eca96ec1) {
    switch (level.players.size) {
    case 1:
        n_damage = int(n_damage * 3);
        break;
    case 2:
        n_damage = int(n_damage * 2.25);
        break;
    case 3:
        n_damage = int(n_damage * 1.5);
        break;
    case 4:
        n_damage = int(n_damage * 1);
        break;
    default:
        break;
    }
    n_health_after_damage = self.health - n_damage;
    if (self.health < self.n_health_min) {
        n_damage = 0;
    } else if (n_health_after_damage < self.n_health_min) {
        n_damage = self.health - self.n_health_min + 1;
    }
    if (isdefined(self.var_e507c83f[var_829b9480]) && self.var_e507c83f[var_829b9480]) {
        if (n_damage > 0) {
            self thread function_1ccd0b11(var_829b9480);
        }
    } else {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x0
// Checksum 0x2fb50853, Offset: 0x83b8
// Size: 0x185
function function_1ccd0b11(part_name) {
    self endon(#"death");
    switch (part_name) {
    case "tag_target_fan_left_outer":
        if (!self clientfield::get("boss_left_outer_fx")) {
            self clientfield::set("boss_left_outer_fx", 1);
            wait 0.2;
            self clientfield::set("boss_left_outer_fx", 0);
        }
        break;
    case "tag_target_fan_left_inner":
        if (!self clientfield::get("boss_left_inner_fx")) {
            self clientfield::set("boss_left_inner_fx", 1);
            wait 0.2;
            self clientfield::set("boss_left_inner_fx", 0);
        }
        break;
    case "tag_target_fan_right_inner":
        if (!self clientfield::get("boss_right_inner_fx")) {
            self clientfield::set("boss_right_inner_fx", 1);
            wait 0.2;
            self clientfield::set("boss_right_inner_fx", 0);
        }
        break;
    case "tag_target_fan_right_outer":
        if (!self clientfield::get("boss_right_outer_fx")) {
            self clientfield::set("boss_right_outer_fx", 1);
            wait 0.2;
            self clientfield::set("boss_right_outer_fx", 0);
        }
        break;
    }
}

// Namespace lotus_boss_battle
// Params 4, eflags: 0x0
// Checksum 0xd6cf365d, Offset: 0x8548
// Size: 0x52
function boss_battle_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_leviathan");
    objectives::complete("cp_level_lotus_leviathan_destroy");
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0xc8db117e, Offset: 0x85a8
// Size: 0x8b
function function_428ff2f() {
    var_f29f9112 = getentarray("roof_ammo_caches", "prefabname");
    foreach (cache in var_f29f9112) {
        cache show();
    }
}

// Namespace lotus_boss_battle
// Params 0, eflags: 0x0
// Checksum 0x9a8ee56a, Offset: 0x8640
// Size: 0xa5
function function_b727a42a() {
    level waittill(#"hash_2f1e81");
    var_80120d96 = 0.1;
    fade_in_time = 4;
    var_2fbcffed = 0.6;
    var_baa794af = var_2fbcffed - var_80120d96;
    var_15dfe09e = fade_in_time / 0.05;
    var_363e9b28 = var_baa794af / var_15dfe09e;
    while (var_80120d96 < var_2fbcffed) {
        var_80120d96 += var_363e9b28;
        setsaveddvar("r_skyTransition", var_80120d96);
        wait 0.05;
    }
}

