#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/cp_mi_cairo_lotus_sound;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_detention_center;
#using scripts/cp/lotus_util;
#using scripts/shared/ai/phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace lotus_security_station;

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0xd886223a, Offset: 0x1f60
// Size: 0x1f2
function function_cd269efc(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        skipto::teleport_ai(str_objective);
        function_de57d320();
        level scene::skipto_end_noai("cin_lot_04_01_security_vign_weaponcivs");
        level thread scene::play("assassination_bodies", "targetname");
        trigger::use("post_hakim_armed_civs");
        level flag::wait_till("first_player_spawned");
        clientfield::set("swap_crowd_to_riot", 1);
        load::function_a2995f22();
        level thread scene::play("cin_lot_04_01_security_vign_weaponguards");
        level lotus_util::function_484bc3aa(1);
        level thread namespace_66fe78fb::function_36e942f6();
        level notify(#"hash_72d53556");
    }
    objectives::set("cp_level_lotus_capture_security_station");
    objectives::set("cp_level_lotus_to_security_station");
    level thread apartment_main();
    level thread function_a2032fbb();
    level.var_9db406db thread function_e8ea29f3(var_74cd64bc);
    trigger::wait_till("apartments_complete");
    skipto::function_be8adfb8("apartments");
}

// Namespace lotus_security_station
// Params 4, eflags: 0x0
// Checksum 0x27a5d6b3, Offset: 0x2160
// Size: 0x22
function function_46593e07(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x15d39a19, Offset: 0x2190
// Size: 0x5a
function function_e8ea29f3(var_74cd64bc) {
    if (!var_74cd64bc) {
        self waittill(#"hash_aa1b20a2");
    }
    do {
        wait 0.25;
    } while (self.is_talking === 1);
    wait 5;
    level flag::wait_till("apartment_clear_magic_bullet");
    self dialog::say("khal_drive_the_nrc_out_of_0");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x16cdd116, Offset: 0x21f8
// Size: 0xda
function function_a2032fbb(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    level thread scene::init("cin_lot_04_03_security_vign_stairshot");
    s_align = struct::get("security_vign_breakout", "targetname");
    s_align scene::add_scene_func("cin_lot_04_01_security_vign_beaten_breakout_loop", &function_b5d037ab, "init", s_align);
    s_align scene::init("cin_lot_04_01_security_vign_beaten_breakout_loop");
    if (!var_74cd64bc) {
        trigger::wait_till("post_up_before_stairs");
        spawn_manager::enable("sm_atrium_battle");
        function_c687efb();
    }
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0x9b09974c, Offset: 0x22e0
// Size: 0x3fa
function atrium_battle(str_objective, var_74cd64bc) {
    var_725a58df = getent("mobile_shop_0_model", "script_noteworthy");
    var_f4595f48 = getent("mobile_shop_0_clip", "script_noteworthy");
    var_576c11ba = getent("mobile_shop_0_player_clip", "script_noteworthy");
    var_725a58df linkto(var_f4595f48);
    var_576c11ba linkto(var_f4595f48);
    var_47d90b65 = getent("mobile_shop_1_vehicle", "targetname");
    var_47d90b65 ghost();
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_a2032fbb(var_74cd64bc);
        level scene::init("mobile_shop_ravens", "targetname");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_9db406db ai::set_behavior_attribute("cqb", 1);
        skipto::teleport_ai(str_objective);
        objectives::set("cp_level_lotus_capture_security_station");
        objectives::set("cp_level_lotus_to_security_station");
        spawn_manager::enable("sm_atrium_battle");
        level thread function_c687efb();
        trigger::use("post_up_before_stairs");
        load::function_a2995f22();
        level notify(#"hash_72d53556");
        clientfield::set("swap_crowd_to_riot", 1);
        level lotus_util::function_484bc3aa(1);
        level thread namespace_66fe78fb::function_36e942f6();
    } else {
        level scene::init("mobile_shop_ravens", "targetname");
    }
    level thread function_c370e3e();
    level thread function_c2d878c1();
    level thread function_2bb3bfaa();
    level thread function_445b4b54();
    level thread function_a10660d2();
    level thread function_dfaa08e3();
    level thread function_80d145c5();
    level thread function_e0f59e66();
    flag::wait_till("start_atrium_battle");
    level thread lotus_util::function_a516f0de("raven_decal_atrium_battle", 5, 5);
    level thread function_6ee2c51b();
    level flag::wait_till("shop_1_elevator_up");
    function_769fdf5b();
    level flag::wait_till("atrium_done");
    skipto::function_be8adfb8("atrium_battle");
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    level.var_9db406db ai::set_behavior_attribute("cqb", 0);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xb0b82e36, Offset: 0x26e8
// Size: 0x4a
function function_6ee2c51b() {
    spawner::waittill_ai_group_ai_count("atrium_enemy", 2);
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level flag::set("hero_mobile_shop_board");
}

// Namespace lotus_security_station
// Params 4, eflags: 0x0
// Checksum 0xab71f97f, Offset: 0x2740
// Size: 0x6a
function function_57b2d9ef(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        function_769fdf5b();
    }
    getent("kill_after_mobileride", "targetname") triggerenable(1);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x40b17e8e, Offset: 0x27b8
// Size: 0x2aa
function function_769fdf5b() {
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation1", &lotus_util::function_5da90c71, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation1", &function_3807296);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &lotus_util::function_5da90c71, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &lotus_util::function_f2596cbe);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation2", &function_ad02ed86);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation3", &lotus_util::function_5da90c71, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation3", &function_3807296);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation4", &lotus_util::function_5da90c71, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation4", &function_3807296);
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation5", &lotus_util::function_5da90c71, "init");
    level scene::add_scene_func("cin_lot_04_05_security_vign_melee_variation5", &function_5bdeffa9);
    level scene::add_scene_func("cin_lot_04_07_security_vign_headshot_loop", &function_3d3111c6, "init");
    level thread scene::init("cin_lot_04_07_security_vign_headshot_loop");
    level thread scene::init("cin_lot_04_05_security_vign_melee_variation1");
    level thread scene::init("security_melee1", "targetname");
    level thread scene::init("cin_lot_04_05_security_vign_melee_variation3");
    level thread scene::init("cin_lot_04_05_security_vign_melee_variation4");
    level thread scene::init("cin_lot_04_05_security_vign_melee_variation5");
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0x181cb557, Offset: 0x2a70
// Size: 0x24a
function to_security_station(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level flag::set("mobile_shop_vo_done");
        level scene::skipto_end("p7_fxanim_cp_lotus_monitors_atrium_fall_bundle");
        level scene::init("security_mobile_shop_fall");
        trigger::use("start_security_station");
        trigger::use("security_spawner");
        trigger::use("atrium_done");
        skipto::teleport_ai(str_objective);
        objectives::set("cp_level_lotus_capture_security_station");
        objectives::set("cp_level_lotus_to_security_station");
        load::function_a2995f22();
        level lotus_util::function_484bc3aa(1);
        level thread namespace_66fe78fb::function_36e942f6();
    }
    objectives::show("cp_level_lotus_to_security_station");
    level thread lotus_util::function_a516f0de("raven_decal_security_hall", 5, 5);
    level scene::init("vent_hallway_ravens", "targetname");
    level thread scene::play("cin_lot_04_07_security_vign_headshot_loop");
    level notify(#"hash_ef61cb8");
    level thread function_b402dcb9();
    level thread function_7804d8d9();
    level thread function_e20f0a12();
    level thread function_8b94205a();
    level thread function_322aa3e0();
    level thread function_32477a75();
    trigger::wait_till("to_security_station_done");
    skipto::function_be8adfb8("to_security_station");
}

// Namespace lotus_security_station
// Params 4, eflags: 0x0
// Checksum 0xa59f393c, Offset: 0x2cc8
// Size: 0x57
function to_security_station_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db delete();
    }
    level notify(#"hash_1206d494");
    level notify(#"hash_c087d549", 1);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xac37a199, Offset: 0x2d28
// Size: 0x182
function function_3807296(a_ents) {
    level endon(#"hash_376f3a30");
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent util::stop_magic_bullet_shield();
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
                ent thread lotus_util::function_5b57004a();
            }
        }
    }
    if (self.scriptbundlename == "cin_lot_04_05_security_vign_melee_variation4") {
        level thread function_a80b1613(a_ents, self);
    } else {
        level thread function_f761fb9c(a_ents, self);
    }
    ai_civ = a_ents["vign_melee_civ_1"];
    if (isdefined(ai_civ)) {
        ai_civ waittill(#"point_of_no_return");
        if (isalive(ai_civ)) {
            ai_civ.var_f8da79d2 = 1;
            ai_civ thread lotus_util::function_3e9f1592();
        }
    }
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0x56f95ad1, Offset: 0x2eb8
// Size: 0x10a
function function_f761fb9c(a_ents, s_scene) {
    level endon(#"hash_376f3a30");
    array::wait_any(a_ents, "damage");
    if (isalive(a_ents["vign_melee_nrc_1"])) {
        a_ents["vign_melee_nrc_1"] ai::set_ignoreall(0);
        a_ents["vign_melee_nrc_1"] ai::set_ignoreme(0);
    }
    s_scene scene::stop();
    wait 0.05;
    ai_civ = a_ents["vign_melee_civ_1"];
    if (isalive(ai_civ)) {
        ai_civ util::stop_magic_bullet_shield();
        ai_civ notsolid();
        ai_civ startragdoll(1);
        ai_civ kill();
    }
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0xb50e26b2, Offset: 0x2fd0
// Size: 0x1a2
function function_a80b1613(a_ents, s_scene) {
    level endon(#"hash_376f3a30");
    level thread function_d14babf0(a_ents["vign_melee_nrc_1"]);
    level thread function_34bcf791(a_ents["vign_melee_nrc_2"]);
    level thread function_339f4fbb(a_ents["vign_melee_civ_1"]);
    level waittill(#"hash_eef00e2");
    if (level.var_9e4b7906 === 1) {
        a_ents["vign_melee_civ_1"] waittill(#"point_of_no_return");
    }
    level.var_9e4b7906 = undefined;
    if (isalive(a_ents["vign_melee_nrc_1"])) {
        a_ents["vign_melee_nrc_1"] ai::set_ignoreall(0);
        a_ents["vign_melee_nrc_1"] ai::set_ignoreme(0);
    }
    if (isalive(a_ents["vign_melee_nrc_2"])) {
        a_ents["vign_melee_nrc_1"] ai::set_ignoreall(0);
        a_ents["vign_melee_nrc_1"] ai::set_ignoreme(0);
    }
    s_scene scene::stop();
    wait 0.05;
    if (isalive(a_ents["vign_melee_civ_1"])) {
        a_ents["vign_melee_civ_1"] setgoal(getnode("vign_melee_4_goal", "targetname"), 1);
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xc4ba4799, Offset: 0x3180
// Size: 0x3b
function function_d14babf0(var_2ddfb28d) {
    level endon(#"hash_eef00e2");
    var_2ddfb28d util::waittill_any("death", "damage");
    level notify(#"hash_eef00e2");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x84768209, Offset: 0x31c8
// Size: 0x57
function function_34bcf791(var_53e22cf6) {
    level endon(#"hash_eef00e2");
    var_53e22cf6 util::waittill_any("death", "damage");
    if (!isalive(var_53e22cf6)) {
        level.var_9e4b7906 = 1;
    }
    level notify(#"hash_eef00e2");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xbcebb5b7, Offset: 0x3228
// Size: 0x63
function function_339f4fbb(var_9100eb74) {
    level endon(#"hash_eef00e2");
    var_9100eb74 util::waittill_any("death", "point_of_no_return");
    if (isalive(var_9100eb74)) {
        var_9100eb74 thread lotus_util::function_3e9f1592();
    }
    level notify(#"hash_eef00e2");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x8245f14c, Offset: 0x3298
// Size: 0x11a
function function_ad02ed86(a_ents) {
    level endon(#"hash_376f3a30");
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent util::stop_magic_bullet_shield();
            ent thread lotus_util::function_5b57004a();
            if (ent.team == "allies") {
                ent thread lotus_util::function_c8849158(500, 15);
            }
        }
    }
    a_ents["vign_melee_nrc_1"] waittill(#"point_of_no_return");
    a_ents["vign_melee_nrc_1"] thread lotus_util::function_3e9f1592();
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xdfa4d7a4, Offset: 0x33c0
// Size: 0x16b
function function_5bdeffa9(a_ents) {
    level endon(#"hash_376f3a30");
    foreach (ent in a_ents) {
        ent util::stop_magic_bullet_shield();
        if (ent.team === "axis") {
            ent ai::set_ignoreme(0);
            ent ai::set_ignoreall(0);
            continue;
        }
        ent thread lotus_util::function_3e9f1592();
    }
    a_ents["vign_melee_nrc_1"] waittill(#"death");
    foreach (ent in a_ents) {
        if (isalive(ent) && isactor(ent)) {
            ent notsolid();
            ent kill();
        }
    }
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0xb04c1cea, Offset: 0x3538
// Size: 0x482
function function_f5f5e18e(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        nd_start = getnode("hs_hendricks_start", "targetname");
        level.var_2fd26037 setgoal(nd_start, 1);
        level scene::init("vent_hallway_ravens", "targetname");
        scene::skipto_end_noai("cin_lot_04_09_security_vign_flee");
        level thread scene::skipto_end("p7_fxanim_cp_lotus_wall_hole_nrc_raps_bundle");
        level thread scene::skipto_end("p7_fxanim_cp_lotus_monitors_atrium_fall_bundle");
        var_941c4cee = getent("raps_breach_no_sight", "targetname");
        var_941c4cee delete();
        load::function_a2995f22();
        level lotus_util::function_484bc3aa(1);
        level thread function_32477a75();
        objectives::set("cp_level_lotus_capture_security_station");
        objectives::set("cp_level_lotus_to_security_station");
        level flag::set("hendricks_breach_line_done");
        trigger::use("trig_cqb_hendricks", "targetname", undefined, 0);
    }
    function_e1e0f9da();
    level notify(#"hash_376f3a30");
    level notify(#"hash_c087d549", 1);
    level clientfield::set("hs_fxinit_vent", 1);
    exploder::exploder("light_exploder_secstation");
    level thread lotus_util::function_e577c596("vent_hallway_ravens", getent("trig_vent_hallway_ravens", "targetname"), "vent_hallway_raven_decals", "cp_lotus_projection_ravengrafitti1");
    level thread function_db1878f3();
    level thread function_5098ba58();
    level thread function_14a5dbed();
    level thread function_3a2620ab();
    function_986134c7();
    savegame::function_fb150717();
    videostart("cp_lotus1_env_hacksystemcarnage", 1);
    var_f0e94a11 = getent("hack_the_system", "targetname");
    var_f0e94a11 triggerenable(0);
    trigger::wait_till("security_station_start");
    level thread util::function_d8eaed3d(3);
    var_a178d2fe = getent("security_door_damage", "targetname");
    var_a178d2fe delete();
    level scene::init("cin_lot_05_01_hack_system_1st_security_station");
    function_a2946402();
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    savegame::checkpoint_save();
    level flag::set("hack_the_system_ready");
    level flag::wait_till("hack_the_system_vo_done");
    var_f0e94a11 triggerenable(1);
    objectives::complete("cp_level_lotus_defend", struct::get("defend_objective_marker"));
    util::function_14518e76(var_f0e94a11, %cp_level_lotus_hack_console, %CP_MI_CAIRO_LOTUS_HACK_SYSTEM, &function_dc25fc43);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x7dd52780, Offset: 0x39c8
// Size: 0x222
function function_dc25fc43(e_player) {
    level thread namespace_66fe78fb::function_8836c025();
    objectives::complete("cp_level_lotus_hack_console");
    if (isdefined(level.var_bdb879ca)) {
        level thread [[ level.var_bdb879ca ]]();
    }
    level thread scene::add_scene_func("cin_lot_05_01_hack_system_1st_security_station", &function_203a65ec, "skip_started");
    level thread scene::play("cin_lot_05_01_hack_system_1st_security_station", e_player);
    foreach (player in level.players) {
        player cybercom::function_f8669cbf(1);
    }
    self gameobjects::disable_object();
    level thread hendricks_frost_breath();
    wait 3.33;
    level thread function_9f2e38f0();
    foreach (player in level.players) {
        player thread function_c7402e23();
    }
    exploder::exploder("lgt_raven");
    level thread lotus_util::function_78805698();
    level thread function_8309c8fd();
    level waittill(#"hash_481ec310");
    if (!scene::function_b1f75ee9()) {
        level clientfield::set("sndIGCsnapshot", 4);
        level lui::screen_fade_out(1.5, "white");
    }
    skipto::function_be8adfb8("hack_the_system");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xc06afbdf, Offset: 0x3bf8
// Size: 0x82
function function_203a65ec(a_ents) {
    foreach (player in level.activeplayers) {
        player setlowready(1);
    }
    util::screen_fade_out(0, "black");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x6194c6f0, Offset: 0x3c88
// Size: 0x42
function function_9f2e38f0() {
    level waittill(#"hash_302eb0c9");
    videostop("cp_lotus1_env_hacksystemcarnage");
    level waittill(#"hash_f78646c5");
    videostart("cp_lotus1_pip_meditateloop");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x1fa43013, Offset: 0x3cd8
// Size: 0x52
function hendricks_frost_breath() {
    level.var_2fd26037 waittill(#"hash_a5038e77");
    level.var_2fd26037 clientfield::set("hendricks_frost_breath", 0);
    wait 1;
    level.var_2fd26037 clientfield::set("hendricks_frost_breath", 1);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x9fb2db8b, Offset: 0x3d38
// Size: 0x93
function function_8309c8fd() {
    wait 0.15;
    var_222d6912 = getentarray("otus_snow_pile_security", "targetname");
    foreach (var_51fb1917 in var_222d6912) {
        var_51fb1917 show();
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x77c899fe, Offset: 0x3dd8
// Size: 0x75
function function_c7402e23() {
    self notify(#"hash_7507ad85");
    self endon(#"hash_7507ad85");
    self endon(#"death");
    self.var_5b9f1ca7 = 1;
    self.var_6e127f9d = 0;
    do {
        playfxoncamera(level._effect["fx_snow_lotus"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait 0.05;
    } while (!self flag::get("end_snow_fx"));
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x769407cd, Offset: 0x3e58
// Size: 0xea
function function_a2946402() {
    spawner::waittill_ai_group_ai_count("security_guard", 2);
    var_78e73676 = spawner::get_ai_group_ai("security_guard");
    foreach (ai in var_78e73676) {
        e_target = util::get_closest_player(ai.origin, "allies");
        ai setgoal(e_target.origin, 0, 256);
    }
    spawner::waittill_ai_group_ai_count("security_guard", 0);
    wait 1.5;
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x22d8f8b5, Offset: 0x3f50
// Size: 0x32
function function_db1878f3() {
    level flag::init("hack_the_system_ready");
    level flag::init("hack_the_system_vo_done");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x4ded59ff, Offset: 0x3f90
// Size: 0x23
function function_14a5dbed() {
    objectives::breadcrumb("trig_breadcrum_hack_the_system");
    level notify(#"hs_breadcrumb_complete");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xbe681597, Offset: 0x3fc0
// Size: 0x21a
function function_5098ba58() {
    battlechatter::function_d9f49fba(0);
    level thread namespace_66fe78fb::function_f2d3d939();
    level flag::wait_till("hendricks_breach_line_done");
    level dialog::remote("kane_that_air_duct_leads_0");
    level waittill(#"hash_4487ad99");
    wait 1;
    level dialog::function_13b3b16a("plyr_take_it_easy_hendri_0");
    level dialog::function_13b3b16a("plyr_this_isn_t_you_it_s_0");
    level flag::wait_till("hs_breadcrumb_complete");
    wait 1;
    foreach (player in level.players) {
        player thread function_beaa4aae();
    }
    if (!level flag::get("close_to_vent")) {
        level dialog::remote("kane_there_that_vent_d_0");
        wait 1;
    }
    if (!level flag::get("hendricks_duct_three")) {
        level dialog::function_13b3b16a("plyr_at_least_we_got_the_0");
    }
    level flag::wait_till("inside_security_station");
    level.var_2fd26037 dialog::say("hend_spread_out_and_grab_0");
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("hack_the_system_ready");
    battlechatter::function_d9f49fba(0);
    level thread namespace_66fe78fb::function_973b77f9();
    level thread dialog::remote("kane_interface_with_that_1");
    level flag::set("hack_the_system_vo_done");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xb20951c, Offset: 0x41e8
// Size: 0xaa
function function_beaa4aae(var_f1658cab) {
    self endon(#"death");
    self endon(#"inside_security_station");
    if (!isdefined(var_f1658cab)) {
        var_f1658cab = getent("trig_vent_area", "targetname");
    }
    var_f1658cab trigger::wait_till(undefined, undefined, self);
    self util::function_16c71b8(1);
    while (self istouching(var_f1658cab)) {
        wait 0.25;
    }
    self util::function_16c71b8(0);
    self thread function_beaa4aae(var_f1658cab);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x4335b230, Offset: 0x42a0
// Size: 0xaa
function function_32477a75() {
    level scene::init("cin_lot_04_09_security_vign_airduct01");
    trigger::wait_till("trig_cqb_hendricks", "targetname", undefined, 0);
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
    level.var_2fd26037 util::waittill_notify_or_timeout("goal", 3);
    level thread function_7d81252f();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xf8a203b0, Offset: 0x4358
// Size: 0xda
function function_986134c7() {
    util::waittill_either("play_fxanim_vent", "play_fxanim_vent_group");
    if (level.players.size == 1) {
        flag::wait_till("play_fxanim_vent");
    }
    if (isdefined(level.var_b2dc81a6)) {
        level thread [[ level.var_b2dc81a6 ]]();
    }
    var_38c5f0d6 = function_bdb77f87("trig_fxanim_vent");
    playsoundatposition("evt_vent_screen_shake", (0, 0, 0));
    wait 1;
    array::run_all(var_38c5f0d6, &playrumbleonentity, "cp_level_lotus_fxanim_vent");
    level clientfield::set("hs_fxanim_vent", 1);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xc61d6ebc, Offset: 0x4440
// Size: 0xdf
function function_bdb77f87(str_trigger) {
    var_8bfaaefe = getent(str_trigger, "targetname");
    var_38c5f0d6 = [];
    foreach (player in level.players) {
        if (player istouching(var_8bfaaefe)) {
            if (!isdefined(var_38c5f0d6)) {
                var_38c5f0d6 = [];
            } else if (!isarray(var_38c5f0d6)) {
                var_38c5f0d6 = array(var_38c5f0d6);
            }
            var_38c5f0d6[var_38c5f0d6.size] = player;
        }
    }
    return var_38c5f0d6;
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x306d2c0c, Offset: 0x4528
// Size: 0x16a
function function_3a2620ab() {
    var_222d6912 = getentarray("otus_snow_pile_security", "targetname");
    foreach (var_1dd40297 in var_222d6912) {
        var_1dd40297 hide();
    }
    scene::add_scene_func("cin_lot_04_09_security_1st_kickgrate", &function_14223de2, "init");
    level thread scene::init("cin_lot_04_09_security_1st_kickgrate");
    level waittill(#"hs_breadcrumb_complete");
    objectives::complete("cp_level_lotus_to_security_station");
    var_93a27bfd = getent("security_station_grate", "targetname");
    mdl_gameobject = util::function_14518e76(var_93a27bfd, %cp_level_lotus_interact_breach, %CP_MI_CAIRO_LOTUS_BREACH, &function_bad59a8e);
    level thread function_2a69536(mdl_gameobject);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x7125350e, Offset: 0x46a0
// Size: 0x7b
function function_14223de2(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent sethighdetail(0);
        }
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x63e1427f, Offset: 0x4728
// Size: 0x6a
function function_2a69536(mdl_gameobject) {
    level endon(#"hash_54f5cf77");
    t_damage = trigger::wait_till("vent_damage_trigger");
    if (isplayer(t_damage.who)) {
        mdl_gameobject thread function_bad59a8e(t_damage.who);
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x4e534267, Offset: 0x47a0
// Size: 0x1ea
function function_bad59a8e(e_player) {
    level notify(#"hash_54f5cf77");
    scene::add_scene_func("cin_lot_04_09_security_1st_kickgrate", &function_4af11e24, "players_done");
    level thread scene::play("cin_lot_04_09_security_1st_kickgrate", e_player);
    foreach (player in level.players) {
        player enableinvulnerability();
    }
    level notify(#"hash_fe7439eb");
    level thread namespace_66fe78fb::function_86781870();
    spawn_manager::enable("sm_security_station");
    objectives::complete("cp_level_lotus_interact_breach");
    objectives::set("cp_level_lotus_defend", struct::get("defend_objective_marker"));
    self gameobjects::disable_object();
    foreach (player in level.players) {
        player util::function_16c71b8(0);
    }
    level thread function_afe7a8b3();
    level scene::play("cin_lot_04_09_security_vign_airduct03");
    level clientfield::set("crowd_anims_off", 1);
    self gameobjects::destroy_object(1);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xe544afa0, Offset: 0x4998
// Size: 0x8b
function function_afe7a8b3() {
    wait 1;
    foreach (ai in getaiteamarray("axis")) {
        if (ai.script_aigroup !== "security_guard") {
            ai delete();
        }
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x70635452, Offset: 0x4a30
// Size: 0x83
function function_4af11e24(a_ents) {
    level util::function_93831e79("after_kick_grate");
    foreach (player in level.players) {
        player disableinvulnerability();
    }
}

// Namespace lotus_security_station
// Params 4, eflags: 0x0
// Checksum 0x222f86cd, Offset: 0x4ac0
// Size: 0x6a
function function_2f8e8d25(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_interact_breach");
    objectives::complete("cp_level_lotus_hack_console");
    objectives::complete("cp_level_lotus_capture_security_station");
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0x75061de7, Offset: 0x4b38
// Size: 0x312
function function_5d64afc3(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    level scene::init("vtol_hallway_ravens", "targetname");
    var_222d6912 = getentarray("otus_snow_pile_security", "targetname");
    foreach (var_1dd40297 in var_222d6912) {
        var_1dd40297 delete();
    }
    function_e1e0f9da();
    if (var_74cd64bc) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai("prometheus_otr");
        scene::skipto_end_noai("cin_lot_04_09_security_1st_kickgrate");
        level lotus_util::function_484bc3aa(1);
    }
    objectives::complete("cp_level_lotus_hakim_assassinate");
    objectives::complete("cp_level_lotus_capture_security_station");
    objectives::set("cp_menu_objective_awaiting_update");
    level thread namespace_a92ad484::function_8836c025();
    var_a178d2fe = getent("security_door_damage", "targetname");
    var_a178d2fe hide();
    var_a178d2fe notsolid();
    level scene::init("cin_lot_05_01_hack_system_1st_breach_hendricks");
    level scene::init("cin_lot_05_01_hack_system_1st_breach_player");
    load::function_a2995f22();
    level scene::play("cin_lot_05_01_hack_system_1st_breach_player");
    level util::function_93831e79("prometheus_otr");
    level thread function_966f4e31();
    var_a178d2fe playsound("evt_prebreach");
    wait 1;
    level thread scene::play("cin_lot_05_01_hack_system_1st_breach_hendricks");
    level waittill(#"hash_9589cacc");
    level thread namespace_a92ad484::function_fd00a4f2();
    var_a178d2fe stopsound("evt_prebreach");
    level thread function_8667d536(var_a178d2fe);
    level flag::wait_till("security_station_breach_ai_cleared");
    skipto::function_be8adfb8("prometheus_otr");
    objectives::hide("cp_menu_objective_awaiting_update");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x8ecb5380, Offset: 0x4e58
// Size: 0x5a
function function_966f4e31() {
    battlechatter::function_d9f49fba(0);
    level waittill(#"hash_ec01b627");
    level dialog::function_13b3b16a("plyr_kane_i_hope_you_r_0");
    level dialog::remote("kane_thirty_seconds_hold_0");
    battlechatter::function_d9f49fba(1);
}

// Namespace lotus_security_station
// Params 4, eflags: 0x0
// Checksum 0xbf8e48e2, Offset: 0x4ec0
// Size: 0x9a
function function_a1a139dc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_hakim_assassinate");
    objectives::complete("cp_level_lotus_capture_security_station");
    objectives::set("cp_level_lotus_capture_taylor");
    objectives::set("cp_level_lotus_go_to_taylor_prison_cell");
    if (var_74cd64bc) {
        function_e1e0f9da();
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xde09f615, Offset: 0x4f68
// Size: 0x19a
function init() {
    spawner::add_spawn_function_group("newly_armed_civ", "targetname", &marked_for_death);
    spawner::add_spawn_function_group("mobile0_interior_soldiers", "script_noteworthy", &function_df344ae6);
    spawner::add_spawn_function_group("atrium_runners", "targetname", &function_5554d5f8);
    spawner::add_spawn_function_group("fleeing_civ", "script_noteworthy", &function_da4d024c);
    spawner::add_spawn_function_group("security_station_first_wave", "targetname", &security_station_first_wave);
    spawner::add_spawn_function_group("headshot_robots", "script_noteworthy", &function_2a70544b);
    level flag::init("shop_1_elevator_up");
    level flag::init("entermobile_done");
    level flag::init("enemy_mobile_shop_done");
    level flag::init("hero_mobile_ride_over");
    level flag::init("khalil_boarded_mobile_shop");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x87dded1f, Offset: 0x5110
// Size: 0x1db
function function_e0f59e66() {
    var_8a0d5994 = lotus_util::function_b26ca094("mobile_security_1_group", 1, 1, 1, "veh_t7_turret_auto_sentry");
    level flag::wait_till("shop_1_elevator_up");
    trigger::use("mobile_security_1_trigger", "script_noteworthy");
    foreach (turret in var_8a0d5994.var_75cccf1) {
        turret thread function_6a4a23df();
    }
    level notify(#"hash_7bf693f");
    level thread namespace_66fe78fb::function_f3bdd599();
    level waittill(#"hash_1a64b222");
    var_34f79b2f = struct::get("security_molotov_origin");
    foreach (turret in var_8a0d5994.var_75cccf1) {
        v_velocity = vectornormalize(turret.origin - var_34f79b2f.origin) * 3000;
        level.players[0] magicgrenadetype(getweapon("molotov_grenade"), var_34f79b2f.origin + (0, 0, 25), v_velocity);
        wait 0.5;
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x6e654632, Offset: 0x52f8
// Size: 0x105
function function_6a4a23df() {
    level endon(#"hash_1a64b222");
    a_s_targets = struct::get_array("security_platform_target");
    while (true) {
        var_bab21612 = array::random(a_s_targets);
        n_timer = randomfloatrange(0.2, 0.7) * 20;
        for (i = 0; i < n_timer; i++) {
            magicbullet(getweapon("ar_standard"), self gettagorigin("tag_barrel") + (0, -40, 0), var_bab21612.origin);
            wait 0.05;
        }
        wait randomfloatrange(0.75, 2);
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xa286c4d0, Offset: 0x5408
// Size: 0x10a
function apartment_main() {
    level thread function_56ab9afe();
    level thread function_8c0c7a73();
    level thread function_7cc50c55();
    level thread function_f5ac9464();
    level thread function_7973e192();
    level thread function_82850b73();
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_9db406db ai::set_behavior_attribute("cqb", 1);
    spawner::waittill_ai_group_cleared("apartment_front");
    spawner::waittill_ai_group_cleared("ai_group_apt_phalanx");
    spawner::waittill_ai_group_cleared("apartment_rear");
    trigger::use("post_up_before_stairs", "targetname", undefined, 0);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x51818d4c, Offset: 0x5520
// Size: 0x8a
function function_de57d320() {
    level scene::add_scene_func("cin_lot_04_01_security_vign_holddown", &function_4f022f94, "init");
    level scene::init("civ_hold_guard_1", "targetname");
    level scene::init("civ_hold_guard_2", "targetname");
    level scene::init("cin_lot_04_01_security_vign_weaponguards");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x11d63fc6, Offset: 0x55b8
// Size: 0xea
function function_8c0c7a73() {
    level thread scene::play("cin_lot_04_01_security_aie_enter");
    scene::add_scene_func("cin_lot_04_02_security_vign_drag", &function_7097716c, "init");
    level scene::init("cin_lot_04_02_security_vign_drag");
    level thread scene::play("civ_hold_guard_1", "targetname");
    wait 1;
    level thread scene::play("civ_hold_guard_2", "targetname");
    flag::wait_till("start_apartment_battle");
    level thread lotus_util::function_a516f0de("raven_decal_apartments", 5, 5);
    level scene::play("cin_lot_04_02_security_vign_drag");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xdd9e18f7, Offset: 0x56b0
// Size: 0x72
function function_7097716c(a_ents) {
    a_ents["drag_civilian"] ai::set_ignoreme(1);
    level waittill(#"hash_870fc78d");
    if (isalive(a_ents["drag_civilian"])) {
        a_ents["drag_civilian"] ai::set_ignoreme(0);
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x7263d535, Offset: 0x5730
// Size: 0xf2
function function_7cc50c55() {
    level scene::add_scene_func("cin_lot_04_02_security_vign_run_a_civ01", &function_a0813430, "init");
    level scene::add_scene_func("cin_lot_04_02_security_vign_run_b_civ01", &function_a0813430, "init");
    level scene::init("cin_lot_04_02_security_vign_run_a_civ01");
    level scene::init("cin_lot_04_02_security_vign_run_b_civ01");
    trigger::wait_till("trigger_first_apartment_civs");
    level thread scene::play("cin_lot_04_02_security_vign_run_a_civ01");
    trigger::wait_till("trigger_second_apartment_civs");
    level thread scene::play("cin_lot_04_02_security_vign_run_b_civ01");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x13fbd731, Offset: 0x5830
// Size: 0x8b
function function_a0813430(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreme(1);
            ent ai::set_ignoreall(1);
        }
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xf52d3b96, Offset: 0x58c8
// Size: 0x1ca
function function_4f022f94(a_ents) {
    level endon(#"hero_mobile_ride_over");
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(1);
            ent ai::set_ignoreme(1);
            ent thread lotus_util::function_5b57004a();
        }
    }
    array::wait_any(a_ents, "death");
    if (isalive(a_ents["enemy"])) {
        a_ents["enemy"] notsolid();
        a_ents["enemy"] startragdoll(1);
        a_ents["enemy"] kill();
        return;
    }
    if (isalive(a_ents["newly_armed_civ"])) {
        a_ents["newly_armed_civ"] ai::set_ignoreall(0);
        a_ents["newly_armed_civ"] ai::set_ignoreme(0);
        a_ents["newly_armed_civ"] stopanimscripted();
        a_ents["newly_armed_civ"] ai::set_behavior_attribute("cqb", 1);
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xa2858e66, Offset: 0x5aa0
// Size: 0x1a
function function_56ab9afe() {
    objectives::breadcrumb("apartments_breadcrumb");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xf4f18838, Offset: 0x5ac8
// Size: 0xb2
function function_f5ac9464() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    spawner::add_spawn_function_ai_group("apartment_front", &util::magic_bullet_shield);
    flag::wait_till("apartment_clear_magic_bullet");
    spawner::remove_spawn_function_ai_group("apartment_front", &util::magic_bullet_shield);
    array::run_all(spawner::get_ai_group_ai("apartment_front"), &util::stop_magic_bullet_shield);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x84e70c8e, Offset: 0x5b88
// Size: 0x15a
function function_7973e192() {
    trigger::wait_till("trigger_apartment_riotshields");
    v_start = struct::get("s_apt_2_phalanx_start").origin;
    v_end = struct::get("s_apt_2_phalanx_end").origin;
    var_f835ddae = getent("sp_apartments_phalanx", "targetname");
    phalanx = new phalanx();
    [[ phalanx ]]->initialize("phanalx_wedge", v_start, v_end, 1, 1, var_f835ddae, var_f835ddae);
    v_start = struct::get("s_apt_1_phalanx_start").origin;
    v_end = struct::get("s_apt_1_phalanx_end").origin;
    phalanx = new phalanx();
    [[ phalanx ]]->initialize("phanalx_wedge", v_start, v_end, 1, 1, var_f835ddae, var_f835ddae);
    var_f835ddae delete();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xf0c8ee8f, Offset: 0x5cf0
// Size: 0x5a
function marked_for_death() {
    self endon(#"death");
    wait 1;
    if (self flagsys::get("scriptedanim")) {
        self flagsys::wait_till_clear("scriptedanim");
    }
    wait randomfloatrange(20, 30);
    self kill();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x286bc48c, Offset: 0x5d58
// Size: 0x8f
function function_82850b73() {
    level scene::add_scene_func("cin_lot_04_02_security_vign_wave", &function_26d2d4be, "init");
    level scene::init("cin_lot_04_02_security_vign_wave");
    flag::wait_till("apartment_clear_magic_bullet");
    level thread scene::skipto_end("cin_lot_04_02_security_vign_wave", undefined, undefined, 0.3);
    wait 1;
    level notify(#"hash_9fdb7d54");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xbadbe472, Offset: 0x5df0
// Size: 0x112
function function_26d2d4be(a_ents) {
    a_ents["wave_civilian"] ai::set_ignoreall(1);
    a_ents["wave_civilian"] ai::set_ignoreme(1);
    a_ents["wave_civilian"] util::magic_bullet_shield();
    level waittill(#"hash_9fdb7d54");
    if (isalive(a_ents["wave_civilian"])) {
        a_ents["wave_civilian"] ai::set_ignoreall(0);
        a_ents["wave_civilian"] ai::set_ignoreme(0);
        a_ents["wave_civilian"] util::stop_magic_bullet_shield();
        a_ents["wave_civilian"] setgoal(getnode("post_wave_cover", "targetname"), 1);
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x4893fa13, Offset: 0x5f10
// Size: 0xd2
function function_445b4b54() {
    objectives::breadcrumb("atrium_battle_breadcrumb");
    level flag::wait_till("mobile_shop_1_top");
    objectives::set("cp_level_lotus_defend_mobile_shop", struct::get("hero_shop_gather", "script_noteworthy"));
    objectives::hide("cp_level_lotus_to_security_station");
    level flag::wait_till("shop_1_elevator_up");
    objectives::complete("cp_level_lotus_defend_mobile_shop", struct::get("hero_shop_gather", "script_noteworthy"));
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x5d1123c9, Offset: 0x5ff0
// Size: 0x7a
function function_dfaa08e3() {
    level flag::wait_till("player_at_atrium_main");
    lotus_util::function_fe64b86b("rainman", struct::get("atrium_battle_corpse_drop"), 0);
    wait 5;
    lotus_util::function_fe64b86b("rainman", struct::get("atrium_battle_corpse_drop2"), 0);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x34eb6058, Offset: 0x6078
// Size: 0x42
function function_c370e3e() {
    s_align = struct::get("security_vign_breakout", "targetname");
    s_align thread scene::play("cin_lot_04_01_security_vign_beaten_breakout_loop");
}

// Namespace lotus_security_station
// Params 2, eflags: 0x0
// Checksum 0x5a84aa40, Offset: 0x60c8
// Size: 0x2ca
function function_b5d037ab(a_ents, s_align) {
    s_align endon(#"scene_done");
    foreach (ent in a_ents) {
        ent ai::set_ignoreme(1);
        ent ai::set_ignoreall(1);
        ent util::magic_bullet_shield();
    }
    level flag::wait_till("start_atrium_battle");
    foreach (ent in a_ents) {
        ent util::stop_magic_bullet_shield();
        ent thread lotus_util::function_5b57004a();
    }
    a_ents["beaten_breakout_civ_01"] thread function_794875cb(s_align, "cin_lot_04_01_security_vign_beaten_breakout_civ01_death", a_ents);
    a_ents["beaten_breakout_civ_02"] thread function_794875cb(s_align, "cin_lot_04_01_security_vign_beaten_breakout_civ02_death", a_ents);
    a_ents["beaten_breakout_nrc"] thread function_794875cb(s_align, "cin_lot_04_01_security_vign_beaten_breakout_nrc_death", a_ents);
    s_align endon(#"hash_5ba67727");
    level flag::wait_till("player_at_atrium_main");
    wait randomfloatrange(5, 10);
    if (isalive(a_ents["beaten_breakout_civ_01"]) && isalive(a_ents["beaten_breakout_civ_02"]) && isalive(a_ents["beaten_breakout_nrc"])) {
        var_845111f3 = struct::get("security_vign_magic_bullet", "targetname");
        var_7e64c6f8 = array::random(a_ents);
        magicbullet(getweapon("ar_standard"), var_845111f3.origin, var_7e64c6f8 gettagorigin("j_head"));
        var_7e64c6f8 dodamage(1, var_845111f3.origin);
    }
}

// Namespace lotus_security_station
// Params 3, eflags: 0x0
// Checksum 0x19e66342, Offset: 0x63a0
// Size: 0x142
function function_794875cb(s_align, str_scene, a_ents) {
    self endon(#"hash_c5781b2");
    self waittill(#"damage");
    s_align notify(#"hash_5ba67727");
    foreach (ent in a_ents) {
        if (ent != self) {
            ent notify(#"hash_c5781b2");
        }
        if (ent.team != "axis") {
            ent ai::set_ignoreme(0);
            ent ai::set_ignoreall(0);
            ent thread lotus_util::function_c8849158(1000);
            continue;
        }
        ent thread util::delay(1, undefined, &lotus_util::function_3e9f1592);
    }
    if (self.team != "axis") {
        self thread util::delay(1, undefined, &lotus_util::function_3e9f1592);
    }
    s_align thread scene::play(str_scene);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xc1a10460, Offset: 0x64f0
// Size: 0x17
function function_965ed288() {
    self endon(#"goal");
    wait 30;
    self notify(#"goal");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x91d2f5d7, Offset: 0x6510
// Size: 0x5b
function function_f92e06f2() {
    self endon(#"death");
    self endon(#"goal");
    wait 30;
    goal_node = getnode("hendricks_roof_goal", "targetname");
    self forceteleport(goal_node.origin);
    self notify(#"failsafe_teleport");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x570c8bea, Offset: 0x6578
// Size: 0x643
function function_80d145c5() {
    level scene::init("cin_lot_04_06_security_vign_entermobile");
    var_47d90b65 = getent("mobile_shop_1_vehicle", "targetname");
    var_47d90b65 setcandamage(0);
    var_c8256c12 = getnode("entermobile1_start", "targetname");
    linktraversal(var_c8256c12);
    level flag::wait_till("enemy_mobile_shop_done");
    level flag::wait_till("hero_mobile_shop_board");
    level scene::add_scene_func("cin_lot_04_06_security_vign_entermobile", &function_4f07d8eb, "done");
    level scene::add_scene_func("cin_lot_04_06_security_vign_entermobile", &function_eca1e72e, "play");
    level thread scene::play("cin_lot_04_06_security_vign_entermobile");
    level.var_9db406db thread function_965ed288();
    level flag::wait_till("khalil_boarded_mobile_shop");
    savegame::checkpoint_save();
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 0);
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 1);
    level.var_2fd26037 setgoal(getnode("hendricks_roof_goal", "targetname"), 1);
    level.var_2fd26037 thread function_f92e06f2();
    level.var_2fd26037 util::waittill_any("goal", "failsafe_teleport");
    level.var_2fd26037.allowbattlechatter["bc"] = 0;
    level.var_2fd26037 ai::set_ignoreall(1);
    level flag::wait_till("entermobile_done");
    if (isdefined(level.var_731f5de7)) {
        level thread [[ level.var_731f5de7 ]]();
    }
    e_trigger = getent("mobile_shop_1_start_trigger", "script_noteworthy");
    e_trigger lotus_util::function_36a6e271(0, level.heroes);
    wait 0.5;
    var_c8256c12 = getnode("entermobile1_start", "targetname");
    foreach (player in level.players) {
        player thread function_40c7669();
    }
    unlinktraversal(var_c8256c12);
    level.var_2fd26037 linkto(var_47d90b65);
    level flag::set("shop_1_elevator_up");
    level thread function_282a605e();
    spawn_manager::enable("sm_hero_shop_enemies");
    unlinktraversal(var_c8256c12);
    level.var_c4e28386 = new class_fa0d90fd();
    [[ level.var_c4e28386 ]]->init("mobile_shop_1", "mobile_shop_1_start_node");
    var_47d90b65 thread function_e99d2077();
    trigger::wait_till("atrium_done", undefined, undefined, 0);
    level flag::set("hero_mobile_ride_over");
    if (isdefined(level.var_22e2a260)) {
        level thread [[ level.var_22e2a260 ]]();
    }
    var_f89fb348 = getnode("start_mobile_1_roof_across_128", "targetname");
    linktraversal(var_f89fb348);
    wait 1.5;
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037.allowbattlechatter["bc"] = 1;
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
    level.var_2fd26037 unlink();
    level.var_2fd26037 setgoal(getnode("end_mobile_1_roof_across_128", "targetname"), 1);
    level.var_2fd26037 waittill(#"goal");
    level.var_2fd26037 colors::enable();
    trigger::use("start_security_station");
    a_enemies = spawner::get_ai_group_ai("hero_shop_ambient");
    foreach (enemy in a_enemies) {
        enemy kill();
        wait randomfloatrange(0.2, 0.5);
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xf2139739, Offset: 0x6bc8
// Size: 0x22
function function_eca1e72e(a_ents) {
    level flag::set("khalil_boarded_mobile_shop");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xcff73a11, Offset: 0x6bf8
// Size: 0x91
function function_40c7669() {
    level endon(#"hero_mobile_ride_over");
    self endon(#"death");
    while (true) {
        v_loc = getnode("hendricks_roof_goal", "targetname").origin;
        if (v_loc[2] - self.origin[2] > 500) {
            self enableinvulnerability();
            util::function_207f8667(%CP_MI_CAIRO_LOTUS_MOBILE_SHOP);
        }
        wait 1;
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xb92beaaf, Offset: 0x6c98
// Size: 0x63
function function_282a605e() {
    level notify(#"hash_c087d549", 1);
    level waittill(#"hash_2d770a81");
    wait 0.5;
    lotus_util::function_e577c596("mobile_shop_ravens", undefined, "mobile_shop_raven_decals", "cp_lotus_projection_ravengrafitti4");
    level scene::stop("p7_fxanim_cp_lotus_atrium_ravens_bundle");
    level notify(#"hash_c4a944f0");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x8c5ee558, Offset: 0x6d08
// Size: 0x1fa
function function_c687efb() {
    level thread function_d4538b37();
    a_spawns = getentarray("atrium_battle_main", "script_noteworthy");
    spawner::simple_spawn(a_spawns);
    a_spawns = getentarray("mobile0_interior_soldiers", "script_noteworthy");
    spawner::simple_spawn(a_spawns);
    flag::wait_till("start_atrium_battle");
    trigger::use("start_enemy_mobile_shop", "script_noteworthy");
    level flag::wait_till("security_shop_unload");
    var_85129eab = getnode("start_mobile_0_interior_across_128", "targetname");
    linktraversal(var_85129eab);
    wait 10;
    unlinktraversal(var_85129eab);
    level notify(#"hash_834140d7");
    level flag::wait_till_timeout(8, "security_shop_stopped");
    var_a7be1923 = getnode("start_mobile_0_top_across_128", "targetname");
    linktraversal(var_a7be1923);
    var_7d15b22d = getnode("start_mobile_0_across_128", "targetname");
    linktraversal(var_7d15b22d);
    var_ba891ade = getnode("start_mobile_0_up_160", "targetname");
    linktraversal(var_ba891ade);
    level flag::set("enemy_mobile_shop_done");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xba385de9, Offset: 0x6f10
// Size: 0x42
function function_d4538b37() {
    level waittill(#"hash_8a1b1b48");
    level flag::set("security_shop_unload");
    level waittill(#"hash_efce9878");
    level flag::set("security_shop_stopped");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xec5c86c4, Offset: 0x6f60
// Size: 0x1a2
function function_2bb3bfaa() {
    level scene::init("p7_fxanim_cp_lotus_monitors_atrium_fall_02_bundle");
    level scene::init("atrium_mobile_shop_fall_1");
    level scene::init("atrium_mobile_shop_fall_2");
    level scene::init("security_mobile_shop_fall");
    level flag::wait_till("player_at_atrium_main");
    level thread scene::play("p7_fxanim_cp_lotus_monitors_atrium_fall_02_bundle");
    trigger::wait_till("ambient_rocket_1");
    function_cc59fc62("s_fx_monitor_rocket_foreshadow");
    util::delay(3, undefined, &scene::play, "atrium_mobile_shop_fall_1");
    trigger::wait_till("ambient_rocket_2");
    function_cc59fc62("s_fx_monitor_rocket_foreshadow_2");
    trigger::wait_till("trigger_fx_monitors");
    function_cc59fc62("s_fx_monitor_rocket");
    level thread scene::play("p7_fxanim_cp_lotus_monitors_atrium_fall_bundle");
    level flag::wait_till("shop_1_elevator_up");
    util::delay(5, undefined, &scene::play, "atrium_mobile_shop_fall_2");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xdce7dac2, Offset: 0x7110
// Size: 0xa5
function function_cc59fc62(str_targetname) {
    var_a448a262 = struct::get(str_targetname, "targetname");
    var_38433989 = struct::get(var_a448a262.target, "targetname");
    var_5e92b8ab = getweapon("smaw");
    var_3c91fda1 = magicbullet(var_5e92b8ab, var_a448a262.origin, var_38433989.origin);
    var_3c91fda1 waittill(#"death");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xbb703ea8, Offset: 0x71c0
// Size: 0xba
function function_df344ae6() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    level waittill(#"hash_8a1b1b48");
    var_9de10fe3 = getnode(self.script_string, "targetname");
    if (isdefined(var_9de10fe3.radius)) {
        self setgoal(var_9de10fe3, 1);
    } else {
        self setgoal(var_9de10fe3);
    }
    self waittill(#"goal");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xc791f0a2, Offset: 0x7288
// Size: 0x92
function function_4f07d8eb(a_ents) {
    level flag::set("entermobile_done");
    level waittill(#"hash_9a441d9e");
    level scene::stop("cin_lot_04_06_security_vign_entermobile");
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreme(1);
    level waittill(#"hash_e0d4b687");
    level.var_9db406db delete();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xf7957979, Offset: 0x7328
// Size: 0x32
function function_c2d878c1() {
    level flag::wait_till("start_stair_shoot");
    level thread scene::play("cin_lot_04_03_security_vign_stairshot");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xa6c33329, Offset: 0x7368
// Size: 0x1ea
function function_a10660d2() {
    level flag::wait_till("start_stair_shoot");
    level.var_9db406db thread dialog::say("khal_watch_your_fire_th_0");
    level waittill(#"hash_8a1b1b48");
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_there_commandeer_th_0");
    level dialog::function_13b3b16a("plyr_copy_that_moving_0", 0.5);
    level.var_9db406db dialog::say("khal_here_they_come_cut_0", 0.7);
    battlechatter::function_d9f49fba(1);
    trigger::wait_till("mobile_shop_1_wait", undefined, undefined, 0);
    level.var_9db406db dialog::say("khal_hold_on_the_roof_i_0");
    level flag::wait_till("shop_1_elevator_up");
    level.var_9db406db dialog::say("khal_i_ll_take_us_up_giv_0");
    level.var_9db406db dialog::say("khal_nrc_reinforcements_a_0", 2);
    level dialog::function_13b3b16a("plyr_you_got_a_suggestion_2", 0.25);
    level waittill(#"hash_c4a944f0");
    level.var_9db406db dialog::say("khal_go_ahead_i_need_to_0", 0.5);
    level notify(#"hash_e0d4b687");
    level.var_2fd26037 dialog::say("hend_go_for_it_boy_scout_0", 0.25);
    level flag::set("mobile_shop_vo_done");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xbf3be548, Offset: 0x7560
// Size: 0x4a
function function_5554d5f8() {
    self endon(#"death");
    wait randomfloatrange(1, 5);
    self ai::set_ignoreme(0);
    self waittill(#"goal");
    self kill();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x7754e0bc, Offset: 0x75b8
// Size: 0x2a
function function_3153496d() {
    self setthreatbiasgroup("lvl_one_ambient");
    self thread function_2f52df3();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x31c90dbf, Offset: 0x75f0
// Size: 0x22
function function_2f52df3() {
    self endon(#"death");
    self waittill(#"goal");
    self kill();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x60410b65, Offset: 0x7620
// Size: 0x11d
function function_e99d2077() {
    wait 1.4;
    while (!level flag::get("hero_mobile_ride_over")) {
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("mobile_shop_rumble_loop", 1);
        }
        self util::waittill_either("reached_node", "reached_end_node");
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("mobile_shop_rumble_loop", 0);
        }
        wait 1.4;
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x207fb005, Offset: 0x7748
// Size: 0x1a
function function_8b94205a() {
    objectives::breadcrumb("to_security_station_breadcrumb");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x9123425e, Offset: 0x7770
// Size: 0x33
function function_2a70544b() {
    level endon(#"hash_e4c92343");
    self waittill(#"death");
    spawn_manager::enable("sm_after_mobile_shop1");
    level notify(#"hash_e4c92343");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xb3e45d36, Offset: 0x77b0
// Size: 0x9a
function function_7804d8d9() {
    trigger::wait_till("trigger_raps_wall");
    spawn_manager::enable("sm_wall_breech");
    spawn_manager::enable("sm_wall_breech_raps");
    wait 1;
    level thread scene::play("p7_fxanim_cp_lotus_wall_hole_nrc_raps_bundle");
    var_941c4cee = getent("raps_breach_no_sight", "targetname");
    var_941c4cee delete();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xaade643f, Offset: 0x7858
// Size: 0x32
function function_e20f0a12() {
    trigger::wait_till("security_mobile_shop_fall");
    level thread scene::play("security_mobile_shop_fall");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x7a92ccba, Offset: 0x7898
// Size: 0x72
function function_b402dcb9() {
    level scene::init("cin_lot_04_09_security_vign_flee");
    level flag::wait_till("security_station_first_raps");
    level scene::add_scene_func("cin_lot_04_09_security_vign_flee", &function_e4ea8ea0);
    level scene::play("cin_lot_04_09_security_vign_flee");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xc5002c74, Offset: 0x7918
// Size: 0xab
function function_e4ea8ea0(a_ents) {
    var_ab891f49 = getent("gv_security_station_slaughter", "targetname");
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent setgoal(var_ab891f49, 1);
        }
    }
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x666d55cf, Offset: 0x79d0
// Size: 0x222
function function_3d3111c6(a_ents) {
    level flag::init("robot_vs_civ_finish");
    ai_civ = a_ents["vign_headshot_civ"];
    var_f6c5842 = a_ents["vign_headshot_robot"];
    ai_civ ai::set_ignoreme(1);
    ai_civ thread function_75e170d1();
    var_f6c5842 ai::set_ignoreme(1);
    var_f6c5842 thread function_75e170d1();
    level waittill(#"hash_ef61cb8");
    level flag::wait_till_any_timeout(4, array("robot_vs_civ_finish"));
    if (isalive(ai_civ)) {
        if (isalive(var_f6c5842)) {
            ai_civ thread function_4be7964c(var_f6c5842);
            ai_civ util::magic_bullet_shield();
            level thread scene::play("cin_lot_04_07_security_vign_headshot");
            var_f6c5842 ai::set_ignoreme(0);
            level waittill(#"hash_8a548864");
            if (isalive(ai_civ)) {
                ai_civ util::stop_magic_bullet_shield();
                ai_civ startragdoll(1);
                ai_civ kill();
            }
        } else {
            level scene::stop("cin_lot_04_07_security_vign_headshot_loop");
            wait 0.25;
            ai_civ setgoal(getnode("vign_headshot_goal", "targetname"), 1);
        }
        return;
    }
    if (isalive(var_f6c5842)) {
        var_f6c5842 ai::set_ignoreme(0);
        self scene::stop();
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x9b150ce2, Offset: 0x7c00
// Size: 0x2a
function function_75e170d1() {
    self endon(#"robot_vs_civ_finish");
    self waittill(#"death");
    level flag::set("robot_vs_civ_finish");
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0x420cc354, Offset: 0x7c38
// Size: 0x42
function function_4be7964c(var_f6c5842) {
    self waittill(#"death");
    if (level scene::is_active("cin_lot_04_07_security_vign_headshot")) {
        var_f6c5842 stopanimscripted(0.5);
    }
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xca77200a, Offset: 0x7c88
// Size: 0x122
function function_322aa3e0() {
    level flag::wait_till("mobile_shop_vo_done");
    battlechatter::function_d9f49fba(0);
    wait 2;
    level thread namespace_66fe78fb::function_d116b1d8();
    level dialog::remote("kane_i_got_a_dozen_of_civ_0", 2);
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("security_station_nrc_reinforce");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_more_nrc_moving_in_0", 2);
    level dialog::remote("kane_they_re_locking_down_0", 1);
    level flag::wait_till("security_station_player_in_wall");
    level thread namespace_66fe78fb::function_973b77f9();
    level.var_2fd26037 dialog::say("hend_moving_through_breac_0");
    level flag::set("hendricks_breach_line_done");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xb05dd8de, Offset: 0x7db8
// Size: 0x12
function function_da4d024c() {
    self ai::set_ignoreall(1);
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xcb811a85, Offset: 0x7dd8
// Size: 0x92
function function_7d81252f() {
    level endon(#"hendricks_duct_three");
    level thread function_e633ccb6();
    if (isdefined(level.var_235c126d)) {
        level thread [[ level.var_235c126d ]]();
    }
    level scene::play("cin_lot_04_09_security_vign_airduct01");
    flag::wait_till("rflag_hendircks_vent_anim_2");
    level scene::play("cin_lot_04_09_security_vign_airduct02");
    level scene::init("cin_lot_04_09_security_vign_airduct03");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0xdc5609ca, Offset: 0x7e78
// Size: 0x8a
function function_e633ccb6() {
    var_a39fe0e2 = getent("vent_down_clip", "targetname");
    var_a39fe0e2 notsolid();
    level waittill(#"hash_dc460b51");
    mdl_clip = getent("vent_clip", "targetname");
    mdl_clip delete();
    var_a39fe0e2 solid();
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x6bc196ac, Offset: 0x7f10
// Size: 0x32
function security_station_first_wave() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    wait 5;
    self ai::set_ignoreall(0);
}

// Namespace lotus_security_station
// Params 1, eflags: 0x0
// Checksum 0xd3722ffd, Offset: 0x7f50
// Size: 0x49a
function function_8667d536(var_a178d2fe) {
    var_4f05370f = getent("breach_leader", "script_noteworthy");
    var_c28cf7b4 = struct::get_array("breach_origin");
    foreach (struct in var_c28cf7b4) {
        var_4f05370f magicgrenadetype(getweapon("willy_pete_nd"), struct.origin, (0, 0, 1), 0.05);
    }
    level thread scene::play("p7_fxanim_cp_lotus_security_station_door_bundle");
    level notify(#"hash_ec01b627");
    var_a178d2fe show();
    var_a178d2fe solid();
    var_2820f5e9 = getentarray("security_door_intact", "targetname");
    array::run_all(var_2820f5e9, &delete);
    var_f63341eb = struct::get("breach_grenade_origin");
    a_s_targets = struct::get_array("breach_target");
    foreach (struct in a_s_targets) {
        v_velocity = vectornormalize(struct.origin - var_f63341eb.origin) * 500;
        var_4f05370f magicgrenadetype(getweapon("flash_grenade"), var_f63341eb.origin, v_velocity, 0.5);
    }
    foreach (struct in a_s_targets) {
        v_velocity = vectornormalize(struct.origin - var_f63341eb.origin) * 500;
        var_4f05370f magicgrenadetype(getweapon("willy_pete_nd"), var_f63341eb.origin, v_velocity, 0.5);
    }
    var_c42a71ee = struct::get("reverse_breach_epicenter", "targetname");
    foreach (e_player in level.players) {
        e_player playrumbleonentity("damage_heavy");
        earthquake(0.2, 0.05, e_player.origin, 120);
        e_player shellshock("default", 0.6);
    }
    level thread lotus_detention_center::function_80318e87(1);
    lotus_util::function_e58f5689();
    level thread scene::play("to_detention_center1_initial_bodies", "targetname");
    spawn_manager::enable("sm_security_station_breach");
    spawn_manager::enable("sm_security_station_breach_raps");
    level thread function_603b0189();
    spawn_manager::wait_till_cleared("sm_security_station_breach_raps");
    spawn_manager::wait_till_cleared("sm_security_station_breach");
    level flag::set("security_station_breach_ai_cleared");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x484a3847, Offset: 0x83f8
// Size: 0x3a
function function_603b0189() {
    level endon(#"security_station_breach_ai_cleared");
    trigger::wait_till("vtol_fly_by");
    level flag::set("security_station_breach_ai_cleared");
}

// Namespace lotus_security_station
// Params 0, eflags: 0x0
// Checksum 0x4c8409a0, Offset: 0x8440
// Size: 0x8b
function function_e1e0f9da() {
    a_doors = getentarray("locker_door_right", "script_noteworthy");
    foreach (e_door in a_doors) {
        e_door rotateyaw(120, 1);
    }
}

