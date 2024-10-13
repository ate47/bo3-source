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

#namespace lotus_start_riot;

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xfe5048f6, Offset: 0x1140
// Size: 0xca
function init() {
    level flag::init("intro_igc_done");
    level flag::init("start_hakim_speech");
    level flag::init("hakim_seen");
    level flag::init("hakim_assassination_start");
    level flag::init("khalil_in_door_vignette");
    level flag::init("hakim_security_door_open");
    clientfield::register("world", "sndHakimPaVox", 1, 3, "int");
    lotus_util::function_77bfc3b2();
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0x16679df5, Offset: 0x1218
// Size: 0x26a
function function_e86a5395(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    level scene::add_scene_func("cin_lot_01_planb_3rd_sh160", &function_1320bd25, "done");
    level scene::init("cin_lot_01_planb_3rd_sh020");
    function_35dc675a();
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_9db406db = util::function_740f8516("khalil");
    battlechatter::function_d9f49fba(0);
    function_47dcfae8();
    level thread lotus_util::function_484bc3aa(1);
    objectives::set("cp_level_lotus_hakim_assassinate");
    objectives::set("cp_level_lotus_hakim_locate");
    level clientfield::set("sndIGCsnapshot", 1);
    load::function_a2995f22();
    level util::function_46d3a558(%CP_MI_CAIRO_LOTUS_INTRO_LINE_1_FULL, "", %CP_MI_CAIRO_LOTUS_INTRO_LINE_2_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_2_SHORT, %CP_MI_CAIRO_LOTUS_INTRO_LINE_3_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_3_SHORT, %CP_MI_CAIRO_LOTUS_INTRO_LINE_4_FULL, %CP_MI_CAIRO_LOTUS_INTRO_LINE_4_SHORT);
    level util::screen_fade_out(0, "black", "lotus_fade_in");
    level thread namespace_66fe78fb::play_intro();
    level thread scene::play("cin_lot_01_planb_3rd_sh020");
    level waittill(#"hash_9a9d029a");
    level util::screen_fade_in(1, "black", "lotus_fade_in");
    if (isdefined(level.var_19d8bbf0)) {
        level thread [[ level.var_19d8bbf0 ]]();
    }
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_overwhelm_siege1st", &function_b73b584a, "init");
    level scene::init("cin_lot_02_01_startriots_vign_overwhelm_siege1st");
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x21109b6a, Offset: 0x1490
// Size: 0x7a
function function_1320bd25(a_ents) {
    skipto::function_be8adfb8("plan_b");
    level thread util::clear_streamer_hint();
    level util::function_93831e79("start_the_riots");
    level clientfield::set("sndIGCsnapshot", 0);
    level flag::set("intro_igc_done");
}

// Namespace lotus_start_riot
// Params 4, eflags: 0x0
// Checksum 0xe51988d1, Offset: 0x1518
// Size: 0x8a
function function_88b5ab32(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread util::delay(1, undefined, &lotus_util::function_6fc3995f);
    getent("kill_after_mobileride", "targetname") triggerenable(0);
    level thread scene::play("p7_fxanim_cp_lotus_atrium_ravens_bundle");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xfb3789dd, Offset: 0x15b0
// Size: 0x12a
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

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0x24d15e68, Offset: 0x16e8
// Size: 0x392
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
    level scene::init("hakim_assassination_ravens", "targetname");
    function_c5116fb2();
    level thread lotus_util::function_a516f0de("raven_decal_start_riots01", 5, 2);
    level util::clientnotify("sndLRstart");
    level lotus_util::function_484bc3aa(1);
    level thread function_54e4839a();
    level thread function_e2d5189a();
    trigger::wait_till("riots_wave_two");
    level thread function_cf0c15cc();
    level thread lotus_util::function_a516f0de("raven_decal_start_riots02");
    level scene::init("cin_lot_02_02_startriots_vign_overridelock");
    trigger::wait_till("riots_wave_three");
    level thread function_8ded8093();
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xa930bc52, Offset: 0x1a88
// Size: 0xc2
function function_8ded8093() {
    v_start = struct::get("s_riots_phalanx_start").origin;
    v_end = struct::get("s_riots_phalanx_end").origin;
    var_f835ddae = getent("sp_riots_phalanx", "targetname");
    phalanx = new phalanx();
    [[ phalanx ]]->initialize("phalanx_reverse_wedge", v_start, v_end, 2, 5, var_f835ddae, var_f835ddae);
    var_f835ddae delete();
}

// Namespace lotus_start_riot
// Params 4, eflags: 0x0
// Checksum 0x5642f291, Offset: 0x1b58
// Size: 0x52
function start_the_riots_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::wait_till("all_players_spawned");
    exploder::exploder("fx_interior_ambient_falling_debris_tower1");
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0x59d276c1, Offset: 0x1bb8
// Size: 0x322
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
        level lotus_util::function_484bc3aa(1);
        trigger::use("override_lock_done");
        level flag::wait_till("hakim_assassination_start");
    }
    while (!isdefined(level.var_81ba7f9e)) {
        wait 0.05;
    }
    if (isdefined(level.var_f43e3f7)) {
        level thread [[ level.var_f43e3f7 ]]();
    }
    level thread lotus_util::function_511cba45("atrium_to_security", 3, "cp_lotus_projection_ravengrafitti3");
    level scene::add_scene_func("cin_lot_03_01_hakim_1st_kill_player", &function_cb65e794, "play");
    level thread scene::play("cin_lot_03_01_hakim_1st_kill_player", level.var_81ba7f9e);
    level.var_81ba7f9e = undefined;
    level waittill(#"hash_cdac0264");
    level scene::add_scene_func("cin_lot_03_01_hakim_vign_toss", &function_caba12d2);
    level thread scene::play("cin_lot_03_01_hakim_vign_toss");
    if (!scene::function_b1f75ee9()) {
        wait 1;
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

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x93521ee9, Offset: 0x1ee8
// Size: 0x92
function function_cb65e794(a_ents) {
    level thread function_11c401c8();
    level thread function_fd777f22();
    level thread function_9fe3e84();
    lotus_security_station::function_de57d320();
    level thread scene::init("cin_lot_03_01_hakim_vign_toss");
    level thread scene::init("cin_lot_04_01_security_vign_finishoff");
    level thread scene::init("cin_lot_04_01_security_vign_weaponcivs");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xc651cbc8, Offset: 0x1f88
// Size: 0xa2
function function_fd777f22() {
    level waittill(#"hash_1470068a");
    level thread scene::play("assassination_bodies", "targetname");
    level scene::stop("cin_lot_02_02_startriots_vign_bangwindow");
    level scene::stop("cin_gen_crowd_riot_activity");
    trigger::use("post_hakim_armed_civs");
    level thread scene::play("cin_lot_04_01_security_vign_weaponcivs");
    level thread scene::play("cin_lot_04_01_security_vign_weaponguards");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xdea6ff47, Offset: 0x2038
// Size: 0x12b
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
    wait 1;
    foreach (player in level.players) {
        player disableinvulnerability();
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x9701f84c, Offset: 0x2170
// Size: 0x103
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

// Namespace lotus_start_riot
// Params 4, eflags: 0x0
// Checksum 0xa06d0a2a, Offset: 0x2280
// Size: 0x9a
function function_14166bcb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_hakim_assassinate");
    function_69903fa7(0);
    battlechatter::function_d9f49fba(1);
    level thread lotus_util::function_fda257c3();
    level flag::wait_till("all_players_spawned");
    exploder::exploder("fx_interior_ambient_tracer_fire_atrium");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x2945c005, Offset: 0x2328
// Size: 0x262
function function_6bf216f3() {
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_open_door", &function_cd0fea70, "init");
    level scene::add_scene_func("cin_lot_02_01_startriots_vign_open_door", &function_90a05c64);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &function_198186d, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &lotus_util::function_f2596cbe, "init");
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xc022336c, Offset: 0x2598
// Size: 0x1aa
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
    level scene::remove_scene_func("cin_lot_04_05_security_vign_melee_variation2", &lotus_util::function_f2596cbe);
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_siege2nd");
    trigger::wait_till("riots_wave_three");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_end");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_alt");
    level thread scene::play("cin_lot_02_01_startriots_vign_overwhelm_alt2");
    level thread scene::play("cin_lot_02_01_startriots_vign_takeout");
    trigger::wait_till("riots_wave_four");
    level thread scene::play("cin_lot_02_01_startriots_vign_subdued");
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x3969c628, Offset: 0x2750
// Size: 0x1aa
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
        wait 0.25;
    }
    if (isalive(var_14c918e8)) {
        level thread scene::play("cin_lot_02_01_startriots_vign_scuffle_cuvrun");
        wait 1;
        if (isalive(var_14c918e8)) {
            var_14c918e8 setgoal(getnode("scuffle_retreat_goal", "targetname"), 1);
            var_14c918e8 thread lotus_util::function_c8849158(500, 15);
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x1f340819, Offset: 0x2908
// Size: 0x19a
function function_50b42010(a_ents) {
    foreach (ent in a_ents) {
        ent ai::set_ignoreall(1);
        ent ai::set_ignoreme(1);
        ent thread lotus_util::function_5b57004a();
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

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0x4d1f1568, Offset: 0x2ab0
// Size: 0xd3
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

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x31533e21, Offset: 0x2b90
// Size: 0xf2
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

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xf5f1e98a, Offset: 0x2c90
// Size: 0x4a
function function_9ff47248(a_ents) {
    a_ents["takeout_guard"] waittill(#"point_of_no_return");
    a_ents["takeout_guard"].var_f8da79d2 = 1;
    a_ents["takeout_guard"] thread lotus_util::function_3e9f1592();
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x9793aef9, Offset: 0x2ce8
// Size: 0xed
function function_da13419c(a_ents) {
    var_ac318b32 = getnodearray("takeout_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait 1;
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team == "allies") {
            ent thread lotus_util::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xcc36b267, Offset: 0x2de0
// Size: 0x142
function function_b73b584a(a_ents) {
    var_ac318b32 = getnodearray("initial_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            level util::magic_bullet_shield(ent);
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
                ent thread lotus_util::function_5b57004a();
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    level thread function_f4561e7c(self, a_ents);
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0xf68be834, Offset: 0x2f30
// Size: 0x14b
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x2b0287ff, Offset: 0x3088
// Size: 0x91
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xc4c62679, Offset: 0x3128
// Size: 0x33
function function_51922beb() {
    if (isdefined(self)) {
        self util::waittill_any("death", "damage", "bulletwhizby");
        level notify(#"hash_6fdc4680");
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xebc8662, Offset: 0x3168
// Size: 0x14a
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
            ent thread lotus_util::function_5b57004a();
        }
    }
    level thread function_17d17b52(a_ents, self);
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x49bb0a6c, Offset: 0x32c0
// Size: 0xab
function function_ace07855(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent util::stop_magic_bullet_shield();
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 5);
            }
        }
    }
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0xbcac1145, Offset: 0x3378
// Size: 0xea
function function_17d17b52(a_ents, str_scene) {
    level endon(#"start_hakim_speech");
    var_85e30c70 = array(a_ents["second_riots_civ_1"], a_ents["second_riots_civ_2"], a_ents["second_riots_guard_1"]);
    array::wait_any(var_85e30c70, "death");
    if (isalive(a_ents["second_riots_guard_1"])) {
        a_ents["second_riots_guard_1"] notsolid();
        a_ents["second_riots_guard_1"] startragdoll(1);
        a_ents["second_riots_guard_1"] kill();
    }
    level scene::stop(str_scene.scriptbundlename);
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x709150a2, Offset: 0x3470
// Size: 0x54a
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
        a_ents["open_door_guard"] thread lotus_util::function_5b57004a();
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
                a_ents["open_door_guard"] thread lotus_util::function_3e9f1592();
            } else {
                level scene::stop("cin_lot_02_01_startriots_vign_open_door_khalil");
            }
        }
    }
    level.var_9db406db ai::set_behavior_attribute("sprint", 0);
    var_a8015c01 = getnode("post_door_open_khalil", "targetname");
    level.var_9db406db setgoal(var_a8015c01, 1);
    level.var_9db406db waittill(#"goal");
    wait 0.5;
    level.var_9db406db ai::set_ignoreme(0);
    level.var_9db406db ai::set_ignoreall(0);
    level.var_9db406db colors::enable();
    level flag::clear("khalil_in_door_vignette");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xc8a87bc4, Offset: 0x39c8
// Size: 0x1e
function function_ef4d5e6c() {
    self waittill(#"death");
    level.var_9db406db notify(#"door_guard_killed");
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x398afe5a, Offset: 0x39f0
// Size: 0x10d
function function_90a05c64(a_ents) {
    var_ac318b32 = getnodearray("open_door_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xb155f2a5, Offset: 0x3b08
// Size: 0x152
function function_198186d(a_ents) {
    level endon(#"start_hakim_speech");
    var_ac318b32 = getnodearray("hallway_1_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_5b57004a();
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    a_ents["vign_melee_nrc_1"] waittill(#"point_of_no_return");
    a_ents["vign_melee_nrc_1"] thread lotus_util::function_3e9f1592();
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x33323f94, Offset: 0x3c68
// Size: 0xb3
function function_2e3bc362(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_c8849158(500, 15);
            ent thread lotus_util::function_5b57004a();
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x70e16b2d, Offset: 0x3d28
// Size: 0x4a
function function_9f2861ce(a_ents) {
    level endon(#"start_hakim_speech");
    array::wait_any(a_ents, "death");
    trigger::use("riots_wave_three", "targetname");
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xbff2b6a1, Offset: 0x3d80
// Size: 0x112
function function_e85196be(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_c8849158(500, 15);
            ent thread lotus_util::function_5b57004a();
        }
    }
    if (isalive(a_ents["overwhelm_alt_guard"])) {
        a_ents["overwhelm_alt_guard"] thread lotus_util::function_3e9f1592();
    }
    level thread function_2e629842(a_ents, a_ents["overwhelm_alt_shield"], self);
    level thread function_306be92b(a_ents, self);
}

// Namespace lotus_start_riot
// Params 3, eflags: 0x0
// Checksum 0xed867708, Offset: 0x3ea0
// Size: 0x92
function function_2e629842(a_ents, var_2d756179, s_scene) {
    arrayremovevalue(a_ents, a_ents["overwhelm_alt_guard"]);
    array::wait_any(a_ents, "death");
    level thread scene::stop(s_scene.scriptbundlename);
    var_2d756179 stopanimscripted(0);
    var_2d756179 physicslaunch(var_2d756179.origin, (0, 0, -0.1));
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0xe29270f6, Offset: 0x3f40
// Size: 0x12d
function function_306be92b(a_ents, s_scene) {
    var_ac318b32 = getnodearray("overwhelm_alt_retreat_goals", "targetname");
    var_52177c84 = 0;
    do {
        wait 0.2;
    } while (level scene::is_active(s_scene.scriptbundlename));
    wait 0.05;
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team === "allies") {
            ent ai::set_ignoreme(0);
            ent thread lotus_util::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x1c620d3f, Offset: 0x4078
// Size: 0x52
function function_a5b8cd1e(a_ents) {
    level thread function_d6a7c0f4(a_ents, self);
    if (isalive(a_ents["overwhelm_alt2_guard"])) {
        a_ents["overwhelm_alt2_guard"] thread lotus_util::function_3e9f1592();
    }
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0xff6a3f40, Offset: 0x40d8
// Size: 0x135
function function_d6a7c0f4(a_ents, s_scene) {
    array::wait_any(a_ents, "death");
    level scene::stop(s_scene.scriptbundlename);
    var_ac318b32 = getnodearray("overwhelm_alt2_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait 0.05;
    foreach (ent in a_ents) {
        if (isalive(ent) && ent.team === "allies") {
            ent ai::set_ignoreme(0);
            ent thread lotus_util::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xe03379f3, Offset: 0x4218
// Size: 0x1d2
function function_c0caa0cf(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_c8849158(500, 15);
        }
    }
    trigger::wait_till("riots_wave_four");
    a_ents["subdued_guard"] util::waittill_any_timeout(6, "damage");
    wait 0.05;
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

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x55cfaf71, Offset: 0x43f8
// Size: 0xed
function function_80bcd913(a_ents) {
    var_ac318b32 = getnodearray("subdued_retreat_goals", "targetname");
    var_52177c84 = 0;
    wait 1.5;
    foreach (ent in a_ents) {
        if (isalive(ent)) {
            ent ai::set_ignoreme(0);
            ent thread lotus_util::function_c8849158(500, 15);
            ent setgoal(var_ac318b32[var_52177c84], 1);
            var_52177c84++;
        }
    }
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xa5b5af6d, Offset: 0x44f0
// Size: 0x18a
function function_caba12d2(a_ents) {
    level endon(#"hash_402e6fa1");
    var_ac318b32 = getnodearray("toss_retreat_goals", "targetname");
    var_52177c84 = 0;
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_5b57004a();
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
                ent setgoal(var_ac318b32[var_52177c84], 1);
                var_52177c84++;
            }
        }
    }
    level thread function_461f82a0(a_ents, self);
    if (isdefined(a_ents["assassination_nrc"])) {
        a_ents["assassination_nrc"] waittill(#"point_of_no_return");
        if (isdefined(a_ents["assassination_nrc"])) {
            a_ents["assassination_nrc"] thread lotus_util::function_3e9f1592();
        }
    }
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0x6c49e92e, Offset: 0x4688
// Size: 0x92
function function_461f82a0(a_ents, s_scene) {
    level endon(#"hash_402e6fa1");
    array::wait_any(a_ents, "death");
    if (isalive(a_ents["assassination_nrc"])) {
        a_ents["assassination_nrc"] ai::set_ignoreme(0);
        a_ents["assassination_nrc"] ai::set_ignoreall(0);
    }
    s_scene scene::stop();
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x254234aa, Offset: 0x4728
// Size: 0x2a
function function_cf0c15cc() {
    objectives::breadcrumb("start_the_riots_breadcrumb");
    level thread function_8a2e81c3();
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x5bc14f5a, Offset: 0x4760
// Size: 0x9a
function function_e2d5189a() {
    level dialog::remote("kane_okay_nearest_secur_0", 1);
    level.var_9db406db dialog::say("khal_be_on_your_guard_th_0", 0.5);
    level flag::wait_till("hakim_seen");
    level.var_9db406db dialog::say("khal_there_he_is_general_0");
    level.var_9db406db dialog::say("khal_cairo_waits_to_attac_0", 3);
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x72ab615c, Offset: 0x4808
// Size: 0xaa
function function_f7410faa() {
    level.var_6bd6767c endon(#"hash_87b505ea");
    if (level.var_31aefea8 === "start_the_riots") {
        level flag::wait_till("start_hakim_speech");
        function_4410b0a7("haki_citizens_of_cairo_w_0", 1);
        wait 0.5;
        function_4410b0a7("haki_the_nile_river_coali_0", 2);
        wait 1;
    }
    function_4410b0a7("haki_ramses_was_meant_to_0", 3);
    wait 0.7;
    function_4410b0a7("haki_anyone_seen_assistin_0", 4);
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xf423de1c, Offset: 0x48c0
// Size: 0x92
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x5641450, Offset: 0x4960
// Size: 0x52
function function_c5116fb2() {
    scene::add_scene_func("cin_lot_02_02_startriots_vign_speech", &function_8a3bdac, "init");
    level scene::init("hakim_speech", "targetname");
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0xd5c04eb8, Offset: 0x49c0
// Size: 0x3a
function function_8a3bdac(a_ents) {
    if (!isdefined(level.var_6bd6767c)) {
        level.var_6bd6767c = a_ents["general_hakim"];
    }
    level thread function_f7410faa();
}

// Namespace lotus_start_riot
// Params 2, eflags: 0x0
// Checksum 0xa282216f, Offset: 0x4a08
// Size: 0x42
function function_4410b0a7(scriptid, var_56d74922) {
    level clientfield::set("sndHakimPaVox", var_56d74922);
    level.var_6bd6767c dialog::say(scriptid);
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x6c0ac25, Offset: 0x4a58
// Size: 0x4a
function function_69903fa7(b_ignore) {
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 ai::set_ignoreall(b_ignore);
    }
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db ai::set_ignoreall(b_ignore);
    }
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x3faedda1, Offset: 0x4ab0
// Size: 0xe2
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

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x4b1936f6, Offset: 0x4ba0
// Size: 0x112
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
    level thread lotus_util::function_e577c596("hakim_assassination_ravens", var_3f3fb113, "hakim_door", "cp_lotus_projection_ravengrafitti2");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0x2d2362c1, Offset: 0x4cc0
// Size: 0x32
function function_2f52df3() {
    self endon(#"death");
    self.scenegoal = self.target;
    self waittill(#"goal");
    self kill();
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xa2a7093a, Offset: 0x4d00
// Size: 0x23
function function_92c0ed5c() {
    exploder::exploder("fx_interior_ambient_tracer_fire_atrium");
    level notify(#"hash_72d53556");
}

// Namespace lotus_start_riot
// Params 0, eflags: 0x0
// Checksum 0xdd8d6518, Offset: 0x4d30
// Size: 0x94
function function_8a2e81c3() {
    objectives::complete("cp_level_lotus_hakim_locate");
    t_door = getent("start_the_riots_done", "targetname");
    level flag::wait_till("hakim_security_door_open");
    e_gameobject = util::function_14518e76(t_door, %cp_level_lotus_hakim_door, %CP_MI_CAIRO_LOTUS_OPEN, &function_c8f71637);
}

// Namespace lotus_start_riot
// Params 1, eflags: 0x0
// Checksum 0x306d9530, Offset: 0x4dd0
// Size: 0x82
function function_c8f71637(e_player) {
    self gameobjects::disable_object();
    level.var_81ba7f9e = e_player;
    mdl_clip = getent("mdl_general_door", "targetname");
    mdl_clip delete();
    objectives::complete("cp_level_lotus_hakim_door");
    self gameobjects::destroy_object(1);
}

