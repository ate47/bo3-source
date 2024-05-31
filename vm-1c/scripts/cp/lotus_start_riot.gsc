#using scripts/cp/lotus_security_station;
#using scripts/cp/cp_mi_cairo_lotus_sound;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai/phalanx;
#using scripts/shared/colors_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/lotus_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#namespace namespace_3b39ab74;

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c35e6aab
// Checksum 0xb1f35afd, Offset: 0x1150
// Size: 0x104
function init() {
    level flag::init("intro_igc_done");
    level flag::init("start_hakim_speech");
    level flag::init("hakim_seen");
    level flag::init("hakim_assassination_start");
    level flag::init("khalil_in_door_vignette");
    level flag::init("hakim_security_door_open");
    clientfield::register("world", "sndHakimPaVox", 1, 3, "int");
    namespace_431cac9::function_77bfc3b2();
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_e86a5395
// Checksum 0x3a56c62f, Offset: 0x1260
// Size: 0x2e4
function function_e86a5395(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    level scene::add_scene_func("cin_lot_01_planb_3rd_sh160", &function_1320bd25, "done");
    level scene::init("cin_lot_01_planb_3rd_sh020");
    function_35dc675a();
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_9db406db = util::function_740f8516("khalil");
    battlechatter::function_d9f49fba(0);
    function_47dcfae8();
    level thread namespace_431cac9::function_484bc3aa(1);
    objectives::set("cp_level_lotus_hakim_assassinate");
    objectives::set("cp_level_lotus_hakim_locate");
    level clientfield::set("sndIGCsnapshot", 1);
    load::function_c32ba481();
    level util::function_46d3a558(%CP_MI_CAIRO_LOTUS_INTRO_LINE_1_FULL, "", %CP_MI_CAIRO_LOTUS_INTRO_LINE_2_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_2_SHORT, %CP_MI_CAIRO_LOTUS_INTRO_LINE_3_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_3_SHORT, %CP_MI_CAIRO_LOTUS_INTRO_LINE_4_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_4_SHORT);
    level util::screen_fade_out(0, "black", "lotus_fade_in");
    level thread namespace_66fe78fb::play_intro();
    level thread scene::play("cin_lot_01_planb_3rd_sh020");
    level waittill(#"hash_9a9d029a");
    level util::screen_fade_in(1, "black", "lotus_fade_in");
    level clientfield::set("gameplay_started", 1);
    if (isdefined(level.var_19d8bbf0)) {
        level thread [[ level.var_19d8bbf0 ]]();
    }
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_siege1st", &function_b73b584a, "init");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm_siege1st");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_1320bd25
// Checksum 0x316944df, Offset: 0x1550
// Size: 0x9c
function function_1320bd25(a_ents) {
    skipto::function_be8adfb8("plan_b");
    level thread util::clear_streamer_hint();
    level util::function_93831e79("start_the_riots");
    level clientfield::set("sndIGCsnapshot", 0);
    level flag::set("intro_igc_done");
}

// Namespace namespace_3b39ab74
// Params 4, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_88b5ab32
// Checksum 0x9b3a3393, Offset: 0x15f8
// Size: 0xa4
function function_88b5ab32(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread util::delay(1, undefined, &namespace_431cac9::function_6fc3995f);
    getent("kill_after_mobileride", "targetname") triggerenable(0);
    level thread scene::play("p7_fxanim_cp_lotus_atrium_ravens_bundle");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_35dc675a
// Checksum 0x75a5354d, Offset: 0x16a8
// Size: 0x17c
function function_35dc675a() {
    function_6bf216f3();
    level scene::init("cin_lot_02_01_startriots_vign_open_door");
    level scene::init("cin_lot_04_05_security_vign_melee_variation2");
    level scene::init("cin_lot_02_01_startriots_vign_scuffle_loop");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm_siege2nd");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm_alt");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm_alt2");
    level scene::init("cin_lot_02_01_startriots_vign_takeout");
    level scene::init("cin_lot_02_01_startriots_vign_subdued");
    var_5cf8a2dd = getent("start_dead_scene", "targetname");
    var_5cf8a2dd trigger::use(undefined, undefined, var_5cf8a2dd);
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_5fb7ec5
// Checksum 0x7225aa05, Offset: 0x1830
// Size: 0x504
function function_5fb7ec5(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        function_47dcfae8();
        level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_siege1st", &function_b73b584a, "init");
        level scene::init("cin_lot_02_01_startriots_vign_overwhelm_siege1st");
        function_35dc675a();
        skipto::teleport_ai(str_objective);
        objectives::set("cp_level_lotus_hakim_assassinate");
        objectives::set("cp_level_lotus_hakim_locate");
        level flag::wait_till("all_players_spawned");
        level thread namespace_66fe78fb::function_973b77f9();
        level flag::set("intro_igc_done");
        load::function_a2995f22();
    }
    level thread namespace_66fe78fb::function_973b77f9();
    level scene::init("hakim_assassination_ravens", "targetname");
    function_c5116fb2();
    level thread namespace_431cac9::function_a516f0de("raven_decal_start_riots01", 5, 2);
    level util::clientnotify("sndLRstart");
    level namespace_431cac9::function_484bc3aa(1);
    level thread function_54e4839a();
    level thread function_e2d5189a();
    trigger::wait_till("riots_wave_two");
    level thread function_cf0c15cc();
    level thread namespace_431cac9::function_a516f0de("raven_decal_start_riots02");
    level scene::init("cin_lot_02_02_startriots_vign_overridelock");
    e_trig = trigger::wait_till("riots_wave_three");
    e_who = e_trig.who;
    b_sprinting = 0;
    if (isdefined(e_who) && isplayer(e_who) && e_who issprinting()) {
        b_sprinting = 1;
    }
    level thread function_8ded8093(b_sprinting);
    spawner::waittill_ai_group_cleared("ai_group_riot_phalanx");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level notify(#"hash_c087d549", 1);
    trigger::use("color_phalanx_cleared");
    function_69903fa7(1);
    level thread function_786aab8d();
    if (level flag::get("khalil_in_door_vignette")) {
        level flag::wait_till_clear_any_timeout(5, array("khalil_in_door_vignette"));
    }
    level thread scene::play("cin_lot_02_02_startriots_vign_overridelock");
    level thread util::function_d8eaed3d(2);
    level flag::wait_till("hakim_assassination_start");
    level util::clientnotify("sndLRstop");
    skipto::function_be8adfb8("start_the_riots");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_8ded8093
// Checksum 0xf7b35af2, Offset: 0x1d40
// Size: 0x124
function function_8ded8093(var_ab4c4a9e) {
    if (!isdefined(var_ab4c4a9e)) {
        var_ab4c4a9e = 0;
    }
    v_start = struct::get("s_riots_phalanx_start").origin;
    v_end = struct::get("s_riots_phalanx_end").origin;
    var_f835ddae = getent("sp_riots_phalanx", "targetname");
    if (var_ab4c4a9e) {
        var_f835ddae.ignorespawninglimit = 1;
    }
    phalanx = new phalanx();
    [[ phalanx ]]->initialize("phalanx_reverse_wedge", v_start, v_end, 2, 5, var_f835ddae, var_f835ddae);
    var_f835ddae delete();
}

// Namespace namespace_3b39ab74
// Params 4, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_a3cc6d62
// Checksum 0x19186433, Offset: 0x1e70
// Size: 0x5c
function function_a3cc6d62(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::wait_till("all_players_spawned");
    exploder::exploder("fx_interior_ambient_falling_debris_tower1");
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_92206070
// Checksum 0xe0855af6, Offset: 0x1ed8
// Size: 0x3ac
function function_92206070(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level flag::set("hakim_security_door_open");
        e_door = getent("keypad_door01", "targetname");
        if (isdefined(e_door)) {
            e_door movez(100, 0.5);
        }
        level thread function_8a2e81c3();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        function_47dcfae8();
        function_69903fa7(1);
        function_c5116fb2();
        skipto::teleport_ai(str_objective);
        level scene::add_scene_func("cin_lot_03_01_hakim_1st_kill_player", &function_9030e073);
        level scene::init("cin_lot_03_01_hakim_1st_kill_player");
        load::function_a2995f22();
        level namespace_431cac9::function_484bc3aa(1);
        trigger::use("override_lock_done");
        level flag::wait_till("hakim_assassination_start");
    }
    while (!isdefined(level.var_81ba7f9e)) {
        wait(0.05);
    }
    if (isdefined(level.var_f43e3f7)) {
        level thread [[ level.var_f43e3f7 ]]();
    }
    level thread namespace_431cac9::function_511cba45("atrium_to_security", 3, "cp_lotus_projection_ravengrafitti3");
    level scene::add_scene_func("cin_lot_03_01_hakim_1st_kill_player", &function_cb65e794, "play");
    level thread scene::play("cin_lot_03_01_hakim_1st_kill_player", level.var_81ba7f9e);
    level.var_81ba7f9e = undefined;
    level waittill(#"hash_cdac0264");
    level scene::add_scene_func("cin_lot_03_01_hakim_vign_toss", &function_caba12d2);
    level thread scene::play("cin_lot_03_01_hakim_vign_toss");
    if (!scene::function_b1f75ee9()) {
        wait(1);
    }
    if (!scene::function_b1f75ee9()) {
        level thread scene::play("cin_lot_04_01_security_vign_finishoff");
    }
    if (!scene::function_b1f75ee9()) {
        level thread scene::play("cin_lot_04_01_security_vign_finishoff_v02");
    }
    if (!scene::function_b1f75ee9()) {
        level thread function_92c0ed5c();
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_cb65e794
// Checksum 0xf8a62856, Offset: 0x2290
// Size: 0xc4
function function_cb65e794(a_ents) {
    level thread function_11c401c8();
    level thread function_fd777f22();
    level thread function_9fe3e84();
    namespace_8e4b89e2::function_de57d320();
    level thread scene::init("cin_lot_03_01_hakim_vign_toss");
    level thread scene::init("cin_lot_04_01_security_vign_finishoff");
    level thread scene::init("cin_lot_04_01_security_vign_weaponcivs");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_fd777f22
// Checksum 0xa5126c4e, Offset: 0x2360
// Size: 0xcc
function function_fd777f22() {
    level waittill(#"hash_1470068a");
    level thread scene::play("assassination_bodies", "targetname");
    level scene::stop("cin_lot_02_02_startriots_vign_bangwindow");
    level scene::stop("cin_gen_crowd_riot_activity");
    trigger::use("post_hakim_armed_civs");
    level thread scene::play("cin_lot_04_01_security_vign_weaponcivs");
    level thread scene::play("cin_lot_04_01_security_vign_weaponguards");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_9fe3e84
// Checksum 0xde82bc7d, Offset: 0x2438
// Size: 0x19a
function function_9fe3e84() {
    foreach (player in level.players) {
        player enableinvulnerability();
    }
    level waittill(#"hash_fa29b03d");
    level thread namespace_66fe78fb::function_36e942f6();
    level notify(#"hash_fb8a92fd");
    level clientfield::set("swap_crowd_to_riot", 1);
    level util::function_93831e79("apartments");
    skipto::function_be8adfb8("general_hakim");
    wait(1);
    foreach (player in level.players) {
        player disableinvulnerability();
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_9030e073
// Checksum 0xe620f53d, Offset: 0x25e0
// Size: 0x16a
function function_9030e073(a_ents) {
    a_ents["player 1"] waittill(#"hash_5790cd4a");
    if (!scene::function_b1f75ee9()) {
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("pickup_hakim_rumble_loop", 1);
        }
        a_ents["player 1"] waittill(#"hash_957e5940");
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("pickup_hakim_rumble_loop", 0);
        }
    }
}

// Namespace namespace_3b39ab74
// Params 4, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_14166bcb
// Checksum 0x9c6b7a17, Offset: 0x2758
// Size: 0xbc
function function_14166bcb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_hakim_assassinate");
    function_69903fa7(0);
    battlechatter::function_d9f49fba(1);
    level thread namespace_431cac9::function_fda257c3();
    level flag::wait_till("all_players_spawned");
    exploder::exploder("fx_interior_ambient_tracer_fire_atrium");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_6bf216f3
// Checksum 0xc0cef60d, Offset: 0x2820
// Size: 0x264
function function_6bf216f3() {
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_open_door", &function_cd0fea70, "init");
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_open_door", &function_90a05c64);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &function_198186d, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &namespace_431cac9::function_f2596cbe, "init");
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_scuffle_loop", &function_c1943fd, "init");
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_siege2nd", &function_adfe9569, "init");
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm", &function_9f2861ce);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm", &function_2e3bc362);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_siege2nd", &function_ace07855);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_alt", &function_e85196be);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_alt2", &function_a5b8cd1e);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_alt2", &function_2e3bc362);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_takeout", &function_50b42010);
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_subdued", &function_c0caa0cf, "init");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_54e4839a
// Checksum 0x595904b6, Offset: 0x2a90
// Size: 0x1fc
function function_54e4839a() {
    trigger::wait_till("riots_wave_one");
    level thread scene::play("cin_lot_02_01_startriots_vign_scuffle_loop");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm");
    trigger::wait_till("riots_wave_two");
    if (level scene::is_active("cin_lot_02_01_startriots_vign_overwhelm_siege1st")) {
        level notify(#"hash_7c5c433c");
        level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_siege1st");
    }
    level scene::remove_scene_func("cin_lot_04_05_security_vign_melee_variation2", &function_198186d);
    level scene::remove_scene_func("cin_lot_04_05_security_vign_melee_variation2", &namespace_431cac9::function_f2596cbe);
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_siege2nd");
    trigger::wait_till("riots_wave_three");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_end");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_alt");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_alt2");
    level thread scene::play("cin_lot_02_01_startriots_vign_takeout");
    trigger::wait_till("riots_wave_four");
    level thread scene::play("cin_lot_02_01_startriots_vign_subdued");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c1943fd
// Checksum 0xabe3a5a, Offset: 0x2c98
// Size: 0x204
function function_c1943fd(a_ents) {
    ai_enemy = a_ents["scuffle_guard"];
    var_14c918e8 = a_ents["scuffle_civ"];
    ai_enemy ai::set_ignoreall(1);
    ai_enemy ai::set_ignoreme(1);
    trigger::wait_till("riots_wave_one");
    while (isalive(ai_enemy)) {
        if (distance2d(level.var_9db406db.origin, ai_enemy.origin) < 400) {
            level.var_2fd26037 ai::set_ignoreall(1);
            ai_enemy ai::set_ignoreme(0);
            ai_enemy waittill(#"death");
            level.var_2fd26037 ai::set_ignoreall(0);
            break;
        }
        wait(0.25);
    }
    if (isalive(var_14c918e8)) {
        level thread scene::play("cin_lot_02_01_startriots_vign_scuffle_cuvrun");
        wait(1);
        if (isalive(var_14c918e8)) {
            var_14c918e8 setgoal(getnode("scuffle_retreat_goal", "targetname"), 1);
            var_14c918e8 thread namespace_431cac9::function_c8849158(500, 15);
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_50b42010
// Checksum 0x5e6881ca, Offset: 0x2ea8
// Size: 0x1f4
function function_50b42010(a_ents) {
    foreach (ent in a_ents) {
        ent ai::set_ignoreall(1);
        ent ai::set_ignoreme(1);
        ent thread namespace_431cac9::function_5b57004a();
    }
    level thread function_c06f06a5(a_ents, self);
    level waittill(#"hash_f68ac3a");
    if (isalive(a_ents["takeout_guard"])) {
        level scene::add_scene_func("cin_lot_02_01_startriots_vign_takeout_civkills", &function_da13419c);
        level scene::add_scene_func("cin_lot_02_01_startriots_vign_takeout_civkills", &function_693d9b17);
        level scene::add_scene_func("cin_lot_02_01_startriots_vign_takeout_civkills", &function_9ff47248);
        level thread scene::play("cin_lot_02_01_startriots_vign_takeout_civkills");
        return;
    }
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_takeout_playerkills", &function_da13419c);
    level thread scene::play("cin_lot_02_01_startriots_vign_takeout_playerkills");
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c06f06a5
// Checksum 0x114e2cf8, Offset: 0x30a8
// Size: 0x12a
function function_c06f06a5(a_ents, s_scene) {
    level endon(#"hash_f68ac3a");
    array::wait_any(a_ents, "death");
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team == "axis") {
            ent ai::set_ignoreall(0);
            ent ai::set_ignoreme(0);
            self thread scene::stop();
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_693d9b17
// Checksum 0xcf0515d4, Offset: 0x31e0
// Size: 0x13c
function function_693d9b17(a_ents) {
    array::wait_any(a_ents, "death");
    if (isalive(a_ents["takeout_guard"])) {
        if (a_ents["takeout_guard"].var_f8da79d2 === 1) {
            a_ents["takeout_guard"] notsolid();
            a_ents["takeout_guard"] startragdoll(1);
            a_ents["takeout_guard"] kill();
        } else {
            a_ents["takeout_guard"] ai::set_ignoreall(0);
            a_ents["takeout_guard"] ai::set_ignoreme(0);
        }
    }
    self thread scene::stop();
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_9ff47248
// Checksum 0xc371726e, Offset: 0x3328
// Size: 0x64
function function_9ff47248(a_ents) {
    a_ents["takeout_guard"] waittill(#"point_of_no_return");
    a_ents["takeout_guard"].var_f8da79d2 = 1;
    a_ents["takeout_guard"] thread namespace_431cac9::function_3e9f1592();
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_da13419c
// Checksum 0x88ed2abb, Offset: 0x3398
// Size: 0x138
function function_da13419c(a_ents) {
    var_ac318b32 = getnodearray("takeout_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait(1);
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team == "allies") {
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_b73b584a
// Checksum 0xb231493a, Offset: 0x34d8
// Size: 0x1b4
function function_b73b584a(a_ents) {
    var_ac318b32 = getnodearray("initial_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            level util::magic_bullet_shield(ent);
            if (ent.team == "allies") {
                ent thread namespace_431cac9::function_c8849158(500, 15);
                ent thread namespace_431cac9::function_5b57004a();
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    level thread function_f4561e7c(self, a_ents);
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_f4561e7c
// Checksum 0xc9855ff1, Offset: 0x3698
// Size: 0x1b2
function function_f4561e7c(s_scene, a_ents) {
    level endon(#"hash_7c5c433c");
    level flag::wait_till("intro_igc_done");
    array::thread_all_ents(a_ents, &util::stop_magic_bullet_shield);
    array::thread_all(a_ents, &function_51922beb);
    level waittill(#"hash_6fdc4680");
    level scene::stop(s_scene.scriptbundlename);
    level.var_a1e195e4 = 0;
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team == "axis") {
            ent ai::set_ignoreall(0);
            ent ai::set_ignoreme(0);
            level.var_a1e195e4++;
            level.var_3a013a47 = 0;
            ent thread function_b7323de8();
        }
    }
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_b7323de8
// Checksum 0x3769c21e, Offset: 0x3858
// Size: 0xae
function function_b7323de8() {
    level.var_9db406db ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreall(0);
    self waittill(#"death");
    level.var_3a013a47++;
    if (level.var_3a013a47 >= level.var_a1e195e4) {
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_9db406db ai::set_ignoreall(1);
        level.var_3a013a47 = undefined;
        level.var_a1e195e4 = undefined;
    }
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_51922beb
// Checksum 0x6b97ef43, Offset: 0x3910
// Size: 0x4a
function function_51922beb() {
    if (isdefined(self)) {
        self util::waittill_any("death", "damage", "bulletwhizby");
        level notify(#"hash_6fdc4680");
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_adfe9569
// Checksum 0x2d7b348f, Offset: 0x3968
// Size: 0x1ac
function function_adfe9569(a_ents) {
    trigger::wait_till("riots_wave_one");
    var_ac318b32 = getnodearray("second_siege_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent util::magic_bullet_shield();
            if (ent.team == "allies") {
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
                continue;
            }
            ent thread namespace_431cac9::function_5b57004a();
        }
    }
    level thread function_17d17b52(a_ents, self);
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_ace07855
// Checksum 0xb88a0aab, Offset: 0x3b20
// Size: 0xe2
function function_ace07855(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent util::stop_magic_bullet_shield();
            if (ent.team == "allies") {
                ent thread namespace_431cac9::function_c8849158(500, 5);
            }
        }
    }
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_17d17b52
// Checksum 0x3ad0ea6c, Offset: 0x3c10
// Size: 0x124
function function_17d17b52(a_ents, str_scene) {
    level endon(#"hash_2ff600cd");
    var_85e30c70 = array(a_ents["second_riots_civ_1"], a_ents["second_riots_civ_2"], a_ents["second_riots_guard_1"]);
    array::wait_any(var_85e30c70, "death");
    if (isalive(a_ents["second_riots_guard_1"])) {
        a_ents["second_riots_guard_1"] notsolid();
        a_ents["second_riots_guard_1"] startragdoll(1);
        a_ents["second_riots_guard_1"] kill();
    }
    level scene::stop(str_scene.scriptbundlename);
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_cd0fea70
// Checksum 0x56b4697b, Offset: 0x3d40
// Size: 0x694
function function_cd0fea70(a_ents) {
    a_ents["open_door_guard"] ai::set_ignoreall(1);
    a_ents["open_door_guard"] ai::set_ignoreme(1);
    foreach (ent in a_ents) {
        if (isai(ent) && isalive(ent)) {
            util::magic_bullet_shield(ent);
        }
    }
    trigger::wait_till("start_the_riots_breadcrumb");
    level flag::set("khalil_in_door_vignette");
    level.var_9db406db colors::disable();
    level.var_9db406db ai::set_ignoreme(1);
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_behavior_attribute("sprint", 1);
    level.var_9db406db ai::set_behavior_attribute("cqb", 0);
    if (isalive(a_ents["open_door_guard"])) {
        a_ents["open_door_guard"] thread namespace_431cac9::function_5b57004a();
        a_ents["open_door_guard"] thread function_ef4d5e6c();
        util::stop_magic_bullet_shield(a_ents["open_door_guard"]);
    }
    level thread scene::init("cin_lot_02_01_startriots_vign_open_door_khalil");
    level.var_9db406db.goalradius = 32;
    level.var_9db406db util::waittill_any_timeout(10, "goal", "door_guard_killed");
    if (!isalive(a_ents["open_door_guard"])) {
        foreach (ent in a_ents) {
            if (isai(ent)) {
                util::stop_magic_bullet_shield(ent);
            }
        }
        self thread scene::play();
    } else {
        level thread scene::play("cin_lot_02_01_startriots_vign_open_door_khalil");
        if (!level.var_9db406db flagsys::get("scriptedanim")) {
            level.var_9db406db flagsys::wait_till_any_timeout(3, array("scriptedanim"));
        }
        foreach (ent in a_ents) {
            if (isai(ent)) {
                util::stop_magic_bullet_shield(ent);
            }
        }
        if (!isalive(a_ents["open_door_guard"])) {
            level scene::stop("cin_lot_02_01_startriots_vign_open_door_khalil");
            self thread scene::play();
        } else {
            self thread scene::play();
            level.var_9db406db util::waittill_notify_or_timeout("khalil_melee_started", 5);
            if (isalive(a_ents["open_door_guard"])) {
                a_ents["open_door_guard"] thread namespace_431cac9::function_3e9f1592();
            } else {
                level scene::stop("cin_lot_02_01_startriots_vign_open_door_khalil");
            }
        }
    }
    level.var_9db406db ai::set_behavior_attribute("sprint", 0);
    var_a8015c01 = getnode("post_door_open_khalil", "targetname");
    level.var_9db406db setgoal(var_a8015c01, 1);
    level.var_9db406db waittill(#"goal");
    wait(0.5);
    level.var_9db406db ai::set_ignoreme(0);
    level.var_9db406db ai::set_ignoreall(0);
    level.var_9db406db colors::enable();
    level flag::clear("khalil_in_door_vignette");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_ef4d5e6c
// Checksum 0x40e6a23b, Offset: 0x43e0
// Size: 0x24
function function_ef4d5e6c() {
    self waittill(#"death");
    level.var_9db406db notify(#"hash_fd767fe1");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_90a05c64
// Checksum 0x2f753963, Offset: 0x4410
// Size: 0x168
function function_90a05c64(a_ents) {
    var_ac318b32 = getnodearray("open_door_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            if (ent.team == "allies") {
                ent thread namespace_431cac9::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_198186d
// Checksum 0x4bf3eb72, Offset: 0x4580
// Size: 0x1c4
function function_198186d(a_ents) {
    level endon(#"hash_2ff600cd");
    var_ac318b32 = getnodearray("hallway_1_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread namespace_431cac9::function_5b57004a();
            if (ent.team == "allies") {
                ent thread namespace_431cac9::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    a_ents["vign_melee_nrc_1"] waittill(#"point_of_no_return");
    a_ents["vign_melee_nrc_1"] thread namespace_431cac9::function_3e9f1592();
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_2e3bc362
// Checksum 0xa8396988, Offset: 0x4750
// Size: 0x102
function function_2e3bc362(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent thread namespace_431cac9::function_5b57004a();
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_9f2861ce
// Checksum 0xa0d4be45, Offset: 0x4860
// Size: 0x54
function function_9f2861ce(a_ents) {
    level endon(#"hash_2ff600cd");
    array::wait_any(a_ents, "death");
    trigger::use("riots_wave_three", "targetname");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_e85196be
// Checksum 0xe1ff7916, Offset: 0x48c0
// Size: 0x184
function function_e85196be(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent thread namespace_431cac9::function_5b57004a();
        }
    }
    if (isalive(a_ents["overwhelm_alt_guard"])) {
        a_ents["overwhelm_alt_guard"] thread namespace_431cac9::function_3e9f1592();
    }
    level thread function_2e629842(a_ents, a_ents["overwhelm_alt_shield"], self);
    level thread function_306be92b(a_ents, self);
}

// Namespace namespace_3b39ab74
// Params 3, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_2e629842
// Checksum 0x8008104c, Offset: 0x4a50
// Size: 0xcc
function function_2e629842(a_ents, var_2d756179, s_scene) {
    arrayremovevalue(a_ents, a_ents["overwhelm_alt_guard"]);
    array::wait_any(a_ents, "death");
    level thread scene::stop(s_scene.scriptbundlename);
    var_2d756179 stopanimscripted(0);
    var_2d756179 physicslaunch(var_2d756179.origin, (0, 0, -0.1));
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_306be92b
// Checksum 0x648087c2, Offset: 0x4b28
// Size: 0x190
function function_306be92b(a_ents, s_scene) {
    var_ac318b32 = getnodearray("overwhelm_alt_retreat_goals", "targetname");
    var_52177c84 = 0;
    do {
        wait(0.2);
    } while (level scene::is_active(s_scene.scriptbundlename));
    wait(0.05);
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team === "allies") {
            ent ai::set_ignoreme(0);
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_a5b8cd1e
// Checksum 0xbba87575, Offset: 0x4cc0
// Size: 0x64
function function_a5b8cd1e(a_ents) {
    level thread function_d6a7c0f4(a_ents, self);
    if (isalive(a_ents["overwhelm_alt2_guard"])) {
        a_ents["overwhelm_alt2_guard"] thread namespace_431cac9::function_3e9f1592();
    }
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_d6a7c0f4
// Checksum 0xece31871, Offset: 0x4d30
// Size: 0x1a0
function function_d6a7c0f4(a_ents, s_scene) {
    array::wait_any(a_ents, "death");
    level scene::stop(s_scene.scriptbundlename);
    var_ac318b32 = getnodearray("overwhelm_alt2_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait(0.05);
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team === "allies") {
            ent ai::set_ignoreme(0);
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c0caa0cf
// Checksum 0x9e15c789, Offset: 0x4ed8
// Size: 0x28c
function function_c0caa0cf(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread namespace_431cac9::function_c8849158(500, 15);
        }
    }
    trigger::wait_till("riots_wave_four");
    a_ents["subdued_guard"] util::waittill_any_timeout(6, "damage");
    wait(0.05);
    foreach (ent in a_ents) {
        if (isalive(ent)) {
            if (ent.team == "axis") {
                ent setgoal(ent.origin);
                ent stopanimscripted();
                ent ai::set_ignoreme(0);
                ent ai::set_ignoreall(0);
            }
        }
    }
    scene::add_scene_func("cin_lot_02_01_startriots_vign_subdued_kill", &function_80bcd913);
    level thread scene::play("cin_lot_02_01_startriots_vign_subdued_kill");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_80bcd913
// Checksum 0x450eb248, Offset: 0x5170
// Size: 0x138
function function_80bcd913(a_ents) {
    var_ac318b32 = getnodearray("subdued_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait(1.5);
    foreach (ent in a_ents) {
        if (isalive(ent)) {
            ent ai::set_ignoreme(0);
            ent thread namespace_431cac9::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_caba12d2
// Checksum 0xf4441140, Offset: 0x52b0
// Size: 0x204
function function_caba12d2(a_ents) {
    level endon(#"hash_402e6fa1");
    var_ac318b32 = getnodearray("toss_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread namespace_431cac9::function_5b57004a();
            if (ent.team == "allies") {
                ent thread namespace_431cac9::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    level thread function_461f82a0(a_ents, self);
    if (isdefined(a_ents["assassination_nrc"])) {
        a_ents["assassination_nrc"] waittill(#"point_of_no_return");
        if (isdefined(a_ents["assassination_nrc"])) {
            a_ents["assassination_nrc"] thread namespace_431cac9::function_3e9f1592();
        }
    }
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_461f82a0
// Checksum 0x1618d558, Offset: 0x54c0
// Size: 0xbc
function function_461f82a0(a_ents, s_scene) {
    level endon(#"hash_402e6fa1");
    array::wait_any(a_ents, "death");
    if (isalive(a_ents["assassination_nrc"])) {
        a_ents["assassination_nrc"] ai::set_ignoreme(0);
        a_ents["assassination_nrc"] ai::set_ignoreall(0);
    }
    s_scene scene::stop();
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_cf0c15cc
// Checksum 0xe673f227, Offset: 0x5588
// Size: 0x34
function function_cf0c15cc() {
    objectives::breadcrumb("start_the_riots_breadcrumb");
    level thread function_8a2e81c3();
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_e2d5189a
// Checksum 0x743dc46c, Offset: 0x55c8
// Size: 0xb4
function function_e2d5189a() {
    level dialog::remote("kane_okay_nearest_secur_0", 1);
    level.var_9db406db dialog::say("khal_be_on_your_guard_th_0", 0.5);
    level flag::wait_till("hakim_seen");
    level.var_9db406db dialog::say("khal_there_he_is_general_0");
    level.var_9db406db dialog::say("khal_cairo_waits_to_attac_0", 3);
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_f7410faa
// Checksum 0xe02f97f1, Offset: 0x5688
// Size: 0xd4
function function_f7410faa() {
    level.var_6bd6767c endon(#"hash_87b505ea");
    if (level.var_31aefea8 === "start_the_riots") {
        level flag::wait_till("start_hakim_speech");
        function_4410b0a7("haki_citizens_of_cairo_w_0", 1);
        wait(0.5);
        function_4410b0a7("haki_the_nile_river_coali_0", 2);
        wait(1);
    }
    function_4410b0a7("haki_ramses_was_meant_to_0", 3);
    wait(0.7);
    function_4410b0a7("haki_anyone_seen_assistin_0", 4);
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_11c401c8
// Checksum 0x65724c01, Offset: 0x5768
// Size: 0xb0
function function_11c401c8() {
    level waittill(#"hash_87b505ea");
    if (isdefined(level.var_6bd6767c)) {
        level.var_6bd6767c playsound("evt_mic_feedback");
        level clientfield::set("sndHakimPaVox", 5);
        level.var_6bd6767c stopsounds();
        level.var_6bd6767c notify(#"hash_87b505ea");
        level.var_6bd6767c notify(#"hash_3962ec94");
        level.var_6bd6767c notify(#"hash_ad4a3c97");
    }
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c5116fb2
// Checksum 0xa7e91338, Offset: 0x5820
// Size: 0x5c
function function_c5116fb2() {
    scene::add_scene_func("cin_lot_02_02_startriots_vign_speech", &function_8a3bdac, "init");
    level scene::init("hakim_speech", "targetname");
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_8a3bdac
// Checksum 0x53c765c5, Offset: 0x5888
// Size: 0x44
function function_8a3bdac(a_ents) {
    if (!isdefined(level.var_6bd6767c)) {
        level.var_6bd6767c = a_ents["general_hakim"];
    }
    level thread function_f7410faa();
}

// Namespace namespace_3b39ab74
// Params 2, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_4410b0a7
// Checksum 0x597cd8bd, Offset: 0x58d8
// Size: 0x54
function function_4410b0a7(scriptid, var_56d74922) {
    level clientfield::set("sndHakimPaVox", var_56d74922);
    level.var_6bd6767c dialog::say(scriptid);
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_69903fa7
// Checksum 0x3bc838cc, Offset: 0x5938
// Size: 0x5c
function function_69903fa7(b_ignore) {
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 ai::set_ignoreall(b_ignore);
    }
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db ai::set_ignoreall(b_ignore);
    }
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_47dcfae8
// Checksum 0x11b05f3f, Offset: 0x59a0
// Size: 0x10c
function function_47dcfae8() {
    battlechatter::function_d9f49fba(0);
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 1);
        level.var_2fd26037 ai::set_behavior_attribute("useGrenades", 0);
    }
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db ai::set_behavior_attribute("cqb", 1);
        level.var_9db406db ai::set_behavior_attribute("disablesprint", 1);
        level.var_9db406db ai::set_behavior_attribute("useGrenades", 0);
    }
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_786aab8d
// Checksum 0x79cdabe1, Offset: 0x5ab8
// Size: 0x144
function function_786aab8d() {
    level waittill(#"open_door");
    level thread scene::play("hakim_door_raven_fly_away", "targetname");
    e_door = getent("keypad_door01", "targetname");
    e_door movez(100, 0.5);
    e_door playsound("evt_security_door_open");
    e_door waittill(#"movedone");
    level flag::set("hakim_security_door_open");
    var_3f3fb113 = getent("override_lock_done", "targetname");
    if (isdefined(level.var_da26fef8)) {
        level thread [[ level.var_da26fef8 ]]();
    }
    level thread namespace_431cac9::function_e577c596("hakim_assassination_ravens", var_3f3fb113, "hakim_door", "cp_lotus_projection_ravengrafitti2");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x0
// namespace_3b39ab74<file_0>::function_2f52df3
// Checksum 0xf7335152, Offset: 0x5c08
// Size: 0x44
function function_2f52df3() {
    self endon(#"death");
    self.scenegoal = self.target;
    self waittill(#"goal");
    self kill();
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_92c0ed5c
// Checksum 0xac2bb44a, Offset: 0x5c58
// Size: 0x2a
function function_92c0ed5c() {
    exploder::exploder("fx_interior_ambient_tracer_fire_atrium");
    level notify(#"hash_72d53556");
}

// Namespace namespace_3b39ab74
// Params 0, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_8a2e81c3
// Checksum 0x49d38875, Offset: 0x5c90
// Size: 0xa0
function function_8a2e81c3() {
    objectives::complete("cp_level_lotus_hakim_locate");
    t_door = getent("start_the_riots_done", "targetname");
    level flag::wait_till("hakim_security_door_open");
    e_gameobject = util::function_14518e76(t_door, %cp_level_lotus_hakim_door, %CP_MI_CAIRO_LOTUS_OPEN, &function_c8f71637);
}

// Namespace namespace_3b39ab74
// Params 1, eflags: 0x1 linked
// namespace_3b39ab74<file_0>::function_c8f71637
// Checksum 0x28d9ff76, Offset: 0x5d38
// Size: 0xa4
function function_c8f71637(e_player) {
    self gameobjects::disable_object();
    level.var_81ba7f9e = e_player;
    mdl_clip = getent("mdl_general_door", "targetname");
    mdl_clip delete();
    objectives::complete("cp_level_lotus_hakim_door");
    self gameobjects::destroy_object(1);
}

