#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/lotus_util;
#using scripts/cp/lotus_accolades;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_elevator;
#using scripts/cp/_dialog;
#using scripts/shared/ai/phalanx;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_20a6d5c1;

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ddf518df
// Checksum 0x7174a4d7, Offset: 0x1f20
// Size: 0x6a2
function function_ddf518df(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level scene::init("vtol_hallway_ravens", "targetname");
        scene::skipto_end("p7_fxanim_cp_lotus_security_station_door_bundle");
        scene::skipto_end("p7_fxanim_cp_lotus_monitor_security_bundle");
        scene::skipto_end_noai("cin_lot_04_09_security_1st_kickgrate");
        var_2820f5e9 = getentarray("security_door_intact", "targetname");
        array::run_all(var_2820f5e9, &delete);
        level flag::wait_till("all_players_spawned");
        skipto::teleport_ai(str_objective);
        level thread function_80318e87();
        namespace_431cac9::function_e58f5689();
        level thread scene::play("to_detention_center1_initial_bodies", "targetname");
        load::function_a2995f22();
    }
    level.var_2fd26037 ai::set_behavior_attribute("useGrenades", 0);
    level thread namespace_431cac9::function_e577c596("vtol_hallway_ravens", getent("trig_vtol_hallway_ravens", "targetname"), "vtol_hallway_raven_decals", "cp_lotus_projection_ravengrafitti3");
    if (sessionmodeiscampaignzombiesgame()) {
        thread function_383b165b();
    }
    level namespace_431cac9::function_484bc3aa(0);
    battlechatter::function_d9f49fba(0);
    spawner::add_spawn_function_group("zipline_guy", "script_noteworthy", &util::magic_bullet_shield);
    spawner::add_spawn_function_group("zipline_guy", "script_noteworthy", &ai::set_behavior_attribute, "useGrenades", 0);
    spawner::add_spawn_function_group("zipline_victims", "targetname", &function_cba3d0d4);
    spawner::add_spawn_function_group("vtol_hallway_enemy", "script_noteworthy", &function_f2e34115);
    spawner::add_spawn_function_group("vtol_shooting_victim", "targetname", &function_f2e34115);
    spawner::add_spawn_function_group("vtol_shooting_victim_robot", "targetname", &function_f2e34115);
    spawner::add_spawn_function_group("landing_area_ally_victim", "targetname", &function_959c5937);
    vehicle::add_spawn_function("detention_center_vtol", &function_e907511f);
    vehicle::add_spawn_function("lotus_vtol_hallway_destruction_vtol", &function_d3a1377e);
    var_1083f981 = getent("vtol_hallway_open_door", "targetname");
    var_1083f981 triggerenable(0);
    level flag::set("prometheus_otr_cleared");
    level thread function_6ed44248(var_74cd64bc);
    level.var_2fd26037 ai::set_goal("hendricks_door_node", "targetname", 1);
    level.var_2fd26037 thread function_ec8c4d64();
    spawn_manager::enable("sm_vtol_shooting_victims");
    spawn_manager::enable("sm_vtol_hallway_robot_spawns");
    level flag::wait_till("hendricks_reached_vtol_hallway_door");
    level thread function_bad9594a();
    var_1083f981 = getent("vtol_hallway_open_door", "targetname");
    var_1083f981 triggerenable(1);
    var_1083f981 waittill(#"trigger");
    level thread function_df5da340();
    level.var_2fd26037 thread dialog::say("hend_friendlys_repelling_0", 2.4);
    level waittill(#"hash_8c18560c");
    level flag::set("zipline_done");
    if (!sessionmodeiscampaignzombiesgame()) {
        function_383b165b();
    }
    trigger::use("hendricks_shooting_starts_color_trigger");
    level.var_2fd26037 ai::set_behavior_attribute("coverIdleOnly", 0);
    level waittill(#"hash_facd74a1");
    level thread scene::play("p7_fxanim_cp_lotus_vtol_hallway_destruction_01_bundle");
    vehicle::simple_spawn_single("lotus_vtol_hallway_destruction_vtol", 1);
    level thread function_613df5d9(13.3);
    var_4c24b478 = getentarray("ammo_cache", "script_noteworthy");
    foreach (var_dee1c358 in var_4c24b478) {
        var_dee1c358.gameobject gameobjects::hide_waypoint();
    }
    function_2143f8c4();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_bad9594a
// Checksum 0x570cf431, Offset: 0x25d0
// Size: 0x52
function function_bad9594a() {
    playsoundatposition("evt_vtolhallway_walla", (-5564, 2906, 4158));
    level waittill(#"hash_e54c697");
    playsoundatposition("evt_vtolhallway_walla_death", (-5564, 2906, 4158));
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ec8c4d64
// Checksum 0x88e6b0cf, Offset: 0x2630
// Size: 0x42
function function_ec8c4d64() {
    level endon(#"hash_1e0c171f");
    level.var_2fd26037 ai::set_ignoreall(1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("coverIdleOnly", 1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_383b165b
// Checksum 0xe8658af2, Offset: 0x2680
// Size: 0xab
function function_383b165b() {
    mdl_door_left = getent("vtol_hallway_door_left", "targetname");
    mdl_door_right = getent("vtol_hallway_door_right", "targetname");
    mdl_door_left movey(100, 1);
    mdl_door_right movey(-100, 1);
    mdl_door_right waittill(#"movedone");
    level.var_2fd26037 ai::set_ignoreall(0);
    level notify(#"hash_1e0c171f");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_80318e87
// Checksum 0x27781d67, Offset: 0x2738
// Size: 0xd2
function function_80318e87(var_6dc777dc) {
    if (!isdefined(var_6dc777dc)) {
        var_6dc777dc = 0;
    }
    level thread scene::init("p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle");
    if (var_6dc777dc) {
        flag::wait_till("security_station_breach_ai_cleared");
    }
    level thread function_9e1bef17();
    trigger::wait_till("vtol_fly_by");
    playsoundatposition("evt_vtolhallway_flyby", (-7235, 3447, 4079));
    level scene::add_scene_func("p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle", &function_bb4e63f9, "play");
    level thread scene::play("p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_bb4e63f9
// Checksum 0x87ad8d5e, Offset: 0x2818
// Size: 0x73
function function_bb4e63f9(a_ents) {
    foreach (player in level.players) {
        player playrumbleonentity("cp_lotus_rumble_vtol_hallway_flyby");
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_9e1bef17
// Checksum 0x36a87aa5, Offset: 0x2898
// Size: 0x3a
function function_9e1bef17() {
    level dialog::remote("kane_lieutenant_khalil_d_0");
    level dialog::remote("khal_confirmed_air_suppo_0", 0.5);
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_6ed44248
// Checksum 0xee74f9b9, Offset: 0x28e0
// Size: 0x3a
function function_6ed44248(var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::set("cp_level_lotus_go_to_taylor_prison_cell");
    }
    objectives::breadcrumb("vtol_hallway_obj_breadcrumb");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_df5da340
// Checksum 0x3fc715fc, Offset: 0x2928
// Size: 0x17a
function function_df5da340() {
    level thread function_199e4429();
    level scene::init("cin_lot_07_02_detcenter_vign_zipline");
    level waittill(#"hash_99ffe550");
    spawn_manager::enable("sm_vtol_hallway_innocent_runners");
    spawn_manager::enable("sm_zipline_victims");
    level thread function_6047a747();
    trigger::use("zipline_guys_start_color_trigger");
    level thread scene::play("cin_lot_07_02_detcenter_vign_zipline");
    level waittill(#"hash_facd74a1");
    var_2caa2879 = getent("zipline_vtol", "targetname");
    v_angles = var_2caa2879.angles;
    var_2caa2879 stopanimscripted();
    wait(0.05);
    var_2caa2879 animation::play("v_lot_07_02_detcenter_vign_zipline_vtol_depart", struct::get("align_event_7_2_zipline"), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0);
    var_2caa2879.angles = v_angles;
    var_2caa2879 movez(4500, 4);
    var_2caa2879 waittill(#"movedone");
    var_2caa2879 delete();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_cba3d0d4
// Checksum 0x5ae87db3, Offset: 0x2ab0
// Size: 0x6a
function function_cba3d0d4() {
    self.grenadeammo = 0;
    a_targets = getaiarray("vtol_hallway_innocent_runners", "targetname");
    e_target = array::random(a_targets);
    if (isdefined(e_target)) {
        self ai::shoot_at_target("shoot_until_target_dead", e_target);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_199e4429
// Checksum 0xdef0ea1b, Offset: 0x2b28
// Size: 0x52
function function_199e4429() {
    var_b28eb61c = struct::get("vtol_zipline_break_glass_struct");
    level waittill(#"hash_ea9c6f10");
    glassradiusdamage(var_b28eb61c.origin, -56, 1000, 1000);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_6047a747
// Checksum 0x18ecd5ff, Offset: 0x2b88
// Size: 0xc3
function function_6047a747() {
    level waittill(#"hash_8c18560c");
    var_c4b22a77 = getaiarray("zipline_victims", "targetname");
    var_c033ff4 = getaiarray("zipline_guy", "targetname");
    foreach (n_index, var_5eade0e9 in var_c033ff4) {
        var_5eade0e9 thread ai::shoot_at_target("shoot_until_target_dead", var_c4b22a77[n_index]);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_e907511f
// Checksum 0x55faef90, Offset: 0x2c58
// Size: 0x1a
function function_e907511f() {
    self turret::set_ignore_line_of_sight(1, 0);
    level.var_338f6013 = self;
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_d3a1377e
// Checksum 0x513690c, Offset: 0x2c80
// Size: 0x3a
function function_d3a1377e() {
    level.var_c35e5e91 = self;
    level.var_c35e5e91 turret::function_3cf7ce0e(0.1, 0);
    level.var_c35e5e91.allowdeath = 0;
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_613df5d9
// Checksum 0xe8e312c9, Offset: 0x2cc8
// Size: 0x4fa
function function_613df5d9(var_9597a744) {
    wait(2.66);
    var_db25489f = 0;
    var_9cb86044 = 0;
    s_turret = level.var_c35e5e91.a_turrets[0];
    s_turret flag::set("turret manual");
    level.var_c35e5e91 thread turret::fire_for_time(var_9597a744, 0);
    level util::clientnotify("sndDSTR");
    level thread battlechatter::function_d9f49fba(0);
    level thread function_f37f019c();
    level thread function_facc6349(4);
    level thread function_1e3790ff(2);
    level thread function_5d7e677d(4);
    level thread function_7126ab6f("allies_move_up");
    wait(2.4);
    var_db25489f = 2.4;
    var_6356aeef = (var_9597a744 - 2.4) / 13;
    while (var_db25489f < var_9597a744) {
        n_index = int((var_db25489f - 2.4) / var_6356aeef) + 1;
        n_index = math::clamp(n_index, 1, 13);
        var_e4b1b0d6 = n_index < 10 ? "vtol_shooting_area0" : "vtol_shooting_area";
        var_5003a2bd = getent(var_e4b1b0d6 + n_index, "targetname");
        a_ai = [];
        a_ai = getaiteamarray("axis");
        var_3dd4b11c = array::filter(a_ai, 0, &function_67fe0ba5, var_5003a2bd);
        foreach (ai_victim in var_3dd4b11c) {
            if (isalive(ai_victim)) {
                if (isdefined(ai_victim.magic_bullet_shield) && ai_victim.magic_bullet_shield) {
                    ai_victim util::stop_magic_bullet_shield();
                }
                if (!isdefined(ai_victim.var_968edb1e)) {
                    ai_victim.var_968edb1e = 1;
                    ai_victim thread function_8f8d0072();
                }
            }
        }
        var_93abd77c = array::filter(level.players, 0, &function_67fe0ba5, var_5003a2bd);
        foreach (player in var_93abd77c) {
            player dodamage(player.health, player.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
        }
        var_446ac0ad = n_index - 1;
        var_446ac0ad = math::clamp(var_446ac0ad, 1, 13 - 1);
        var_ade4e252 = function_dbfa70cf(var_446ac0ad);
        var_a8364a58 = array::filter(level.players, 0, &function_67fe0ba5, var_ade4e252);
        foreach (player in var_a8364a58) {
            earthquake(1, 0.1, player.origin, 32, player);
            player playrumbleonentity("slide_loop");
        }
        wait(0.1);
        var_db25489f += 0.1;
    }
    level thread battlechatter::function_d9f49fba(1);
    level util::clientnotify("sndDSTRe");
    level thread namespace_a92ad484::function_51e72857();
    level.var_c35e5e91 util::stop_magic_bullet_shield();
    level.var_c35e5e91 thread turret::stop(0);
    function_76bada8a(1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_8f8d0072
// Checksum 0xf62ba92a, Offset: 0x31d0
// Size: 0xa2
function function_8f8d0072() {
    wait(randomfloatrange(0, 0.4));
    var_3cce4ae7 = randomint(100) < 25 ? "MOD_GRENADE_SPLASH" : "MOD_UNKNOWN";
    self playsound("evt_vtolhallway_dstr_bullet_imp_enemy");
    self dodamage(self.health, self.origin, undefined, undefined, undefined, var_3cce4ae7);
    physicsexplosionsphere(self.origin, 32, 16, 100);
}

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_67fe0ba5
// Checksum 0x547aeed9, Offset: 0x3280
// Size: 0xa2
function function_67fe0ba5(e_entity, var_8c2d8a7f) {
    if (!isarray(var_8c2d8a7f)) {
        var_8c2d8a7f = array(var_8c2d8a7f);
    }
    foreach (e_volume in var_8c2d8a7f) {
        if (e_entity istouching(e_volume)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_dbfa70cf
// Checksum 0x41e43b5f, Offset: 0x3330
// Size: 0xd1
function function_dbfa70cf(var_65346df) {
    var_46fcd4c = [];
    for (var_f852a368 = 2; var_65346df > 0 && var_f852a368 > 0; var_f852a368--) {
        var_84f20f7 = var_65346df < 10 ? "vtol_shooting_area0" : "vtol_shooting_area";
        var_e318ffa6 = getent(var_84f20f7 + var_65346df, "targetname");
        if (!isdefined(var_46fcd4c)) {
            var_46fcd4c = [];
        } else if (!isarray(var_46fcd4c)) {
            var_46fcd4c = array(var_46fcd4c);
        }
        var_46fcd4c[var_46fcd4c.size] = var_e318ffa6;
        var_65346df--;
    }
    return var_46fcd4c;
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f37f019c
// Checksum 0xa135219d, Offset: 0x3410
// Size: 0x81
function function_f37f019c() {
    for (var_3b86078d = 1; var_3b86078d <= 4; var_3b86078d++) {
        var_b28eb61c = struct::get("vtol_hallway_break_glass_struct0" + var_3b86078d, "targetname");
        glassradiusdamage(var_b28eb61c.origin, -56, 1000, 1000);
        wait(3.3);
    }
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_7126ab6f
// Checksum 0xe605c683, Offset: 0x34a0
// Size: 0x3a
function function_7126ab6f(str_notify) {
    level waittill(str_notify);
    function_76bada8a(0);
    trigger::use("hendricks_exit_vtol_hallway_color_trigger");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_1e3790ff
// Checksum 0x8adb9364, Offset: 0x34e8
// Size: 0x3a
function function_1e3790ff(n_delay) {
    wait(n_delay);
    spawn_manager::kill("sm_vtol_shooting_victims", 1);
    spawn_manager::kill("sm_vtol_hallway_robot_spawns", 1);
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_76bada8a
// Checksum 0x13bedd89, Offset: 0x3530
// Size: 0x72
function function_76bada8a(b_value) {
    level.var_2fd26037 ai::set_behavior_attribute("sprint", b_value);
    array::thread_all(getentarray("zipline_guy", "script_noteworthy", 1), &ai::set_behavior_attribute, "sprint", b_value);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f2e34115
// Checksum 0xf9f921de, Offset: 0x35b0
// Size: 0x4a
function function_f2e34115() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self.grenadeammo = 0;
    level flag::wait_till("zipline_done");
    self ai::set_ignoreall(0);
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_facc6349
// Checksum 0x81efb3e0, Offset: 0x3608
// Size: 0x6a
function function_facc6349(n_max_delay) {
    trigger::wait_or_timeout(n_max_delay, "supplemental_vtol_hallway_victims");
    var_a08b9452 = getentarray("supplemental_vtol_hallway_victim", "script_noteworthy");
    spawner::simple_spawn(var_a08b9452, &function_f2e34115);
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_5d7e677d
// Checksum 0xea5e9c23, Offset: 0x3680
// Size: 0x22
function function_5d7e677d(n_delay) {
    wait(n_delay);
    spawn_manager::enable("sm_vtol_hallway_final_spawns");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_959c5937
// Checksum 0x33f29672, Offset: 0x36b0
// Size: 0x213
function function_959c5937() {
    var_98a5836 = getentarray("landing_area_ally_victim_ai", "targetname");
    var_94607bce = var_98a5836.size - 1;
    var_7a9b47b6 = var_94607bce > 1 ? randomfloatrange(-0.5, 0.5) * var_94607bce + var_94607bce : 2.5;
    self util::magic_bullet_shield();
    self.grenadeammo = 0;
    level waittill(#"hash_bb05f4d0");
    trigger::wait_or_timeout(var_7a9b47b6, "kill_landing_area_allies", "targetname");
    self util::stop_magic_bullet_shield();
    self.health = 1;
    var_d320e401 = struct::get_array("landing_area_magic_bullet_source", "targetname");
    a_ai_enemies = getaiteamarray("axis");
    weapon = getweapon("lmg_light");
    v_target_origin = self.origin + (0, 0, 32);
    foreach (var_6757c7e1 in var_d320e401) {
        var_4b9c2228 = randomintrange(1, 5);
        do {
            magicbullet(weapon, var_6757c7e1.origin, v_target_origin);
            wait(randomfloatrange(0, 0.1));
            var_4b9c2228--;
        } while (var_4b9c2228 > 0);
        wait(randomfloatrange(0, 0.2));
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_2143f8c4
// Checksum 0x4beed465, Offset: 0x38d0
// Size: 0x9a
function function_2143f8c4() {
    level scene::init("cin_merch_interior_lower", "targetname");
    level flag::wait_till_all(array("sm_sm_vtol_hallway_final_spawns01_cleared", "sm_sm_vtol_hallway_final_spawns02_cleared"));
    level notify(#"hash_c243f1de");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level thread function_29458b95();
    skipto::function_be8adfb8("vtol_hallway");
}

// Namespace namespace_20a6d5c1
// Params 4, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_eef4fda8
// Checksum 0xf190b073, Offset: 0x3978
// Size: 0x72
function function_eef4fda8(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread util::delay(1, undefined, &namespace_431cac9::function_6fc3995f);
    getent("pursuit_oob", "targetname") triggerenable(0);
}

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_9c0f8169
// Checksum 0x79c6403f, Offset: 0x39f8
// Size: 0x36a
function function_9c0f8169(str_objective, var_74cd64bc) {
    level.var_f2bcf341 = struct::get("cin_merch_interior_lower", "targetname");
    level.var_38d7d98e = struct::get("cin_merch_interior_upper", "targetname");
    level thread function_97787d8d("open");
    battlechatter::function_d9f49fba(0);
    if (sessionmodeiscampaignzombiesgame()) {
        level thread function_3257371f();
    }
    if (var_74cd64bc) {
        load::function_73adcefc();
        level scene::init("cin_merch_interior_lower", "targetname");
        level scene::init("mobile_shop2_ravens", "targetname");
        level scene::skipto_end("p7_fxanim_cp_lotus_vtol_hallway_destruction_01_bundle");
        level flag::wait_till("all_players_spawned");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
        load::function_a2995f22();
        level thread function_29458b95(var_74cd64bc);
    } else {
        level scene::init("mobile_shop2_ravens", "targetname");
    }
    level namespace_431cac9::function_484bc3aa(1);
    var_4c24b478 = getentarray("ammo_cache", "script_noteworthy");
    foreach (var_dee1c358 in var_4c24b478) {
        var_dee1c358.gameobject gameobjects::show_waypoint();
    }
    level thread objectives::breadcrumb("breadcrumb_mobile_ride_2");
    flag::wait_till("long_mobile_shop_start");
    level scene::init("p7_fxanim_cp_lotus_mobile_shops_merch_rpg_hit_bundle");
    objectives::complete("cp_level_lotus_go_to_taylor_prison_cell");
    objectives::set("cp_level_lotus_go_to_taylor_holding_room");
    level waittill(#"hash_a6da966f");
    level.var_f2bcf341 scene::stop();
    level.var_38d7d98e thread scene::play();
    function_c92f487e();
    level thread function_9a0b8bc1();
    trigger::wait_till("mobile_shop_ride2_done");
    skipto::function_be8adfb8("mobile_shop_ride2");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_29458b95
// Checksum 0x4b93cf24, Offset: 0x3d70
// Size: 0x44a
function function_29458b95(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    battlechatter::function_d9f49fba(0);
    if (!var_74cd64bc) {
        level.var_2fd26037 thread function_edd237d9();
    }
    level thread namespace_a92ad484::function_614dc783();
    level.var_2fd26037 dialog::say("hend_okay_kane_enough_0");
    level dialog::remote("kane_take_that_shop_up_to_0");
    level thread function_aa17eb00();
    level flag::set("mobile_shop_ride_ready");
    level thread function_c24a19de();
    level flag::wait_till("long_mobile_shop_start");
    if (isdefined(level.var_c027307f)) {
        level thread [[ level.var_c027307f ]]();
    }
    var_d8cfd4dc = getent("mobile_ride_2_playerclip", "targetname");
    var_d8cfd4dc moveto(var_d8cfd4dc.origin + (0, 0, 100), 0.05);
    level clientfield::set("vtol_hallway_destruction_cleanup", 1);
    var_d26fd6e5 = getent("lotus_vtol_hallway_destruction01", "targetname");
    var_d26fd6e5 delete();
    level.var_2fd26037 ai::set_ignoreall(1);
    level thread scene::play("cin_lot_07_05_detcenter_vign_observation", level.var_2fd26037);
    trigger::wait_till("hendricks_in_mobile_shop_2", "targetname", level.var_2fd26037);
    level thread function_97787d8d("close");
    wait(1.5);
    level thread namespace_431cac9::function_e577c596("mobile_shop2_ravens", undefined, "raven_decal_mobile_shop2", "cp_lotus_projection_ravengrafitti1");
    level.var_2fd26037 ai::set_ignoreall(0);
    sndent = spawn("script_origin", (0, 0, 0));
    sndent playsound("veh_mobile_shop_ride_start");
    sndent playloopsound("veh_mobile_shop_ride_loop");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_lotus_rumble_mobile_shop_ride_2");
    }
    level thread scene::play("cin_merch_interior_lower", "targetname");
    level waittill(#"hash_4e6f08ff");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("explosion_generic_no_broadcast");
    }
    level notify(#"hash_a6da966f");
    sndent stoploopsound(0.3);
    sndent delete();
    wait(0.3);
    foreach (player in level.players) {
        player playrumbleonentity("explosion_generic_no_broadcast");
    }
    trigger::use("bridge_battle_more_enemies_here", "script_flag_set");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_c24a19de
// Checksum 0x6e762f21, Offset: 0x41c8
// Size: 0xeb
function function_c24a19de() {
    foreach (player in level.activeplayers) {
        if (isdefined(player.cybercom.var_46a37937)) {
            foreach (var_f6c5842 in player.cybercom.var_46a37937) {
                if (isalive(var_f6c5842)) {
                    var_f6c5842 kill();
                }
            }
        }
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_edd237d9
// Checksum 0xc8a33ff7, Offset: 0x42c0
// Size: 0x42
function function_edd237d9() {
    var_350c27ef = getnode("hendricks_preshop_node", "targetname");
    self setgoal(var_350c27ef, 1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_c92f487e
// Checksum 0x7ffc4e3f, Offset: 0x4310
// Size: 0x18a
function function_c92f487e() {
    var_bd1043f3 = struct::get("mobile_shop_ride_lower").origin;
    var_fd7210d4 = struct::get("mobile_shop_ride_upper").origin;
    var_44f2aa45 = var_fd7210d4 - var_bd1043f3;
    level.var_2fd26037 forceteleport(level.var_2fd26037.origin + var_44f2aa45, level.var_2fd26037.angles);
    level thread scene::play("cin_lot_07_05_detcenter_vign_mantle");
    foreach (player in level.activeplayers) {
        player setorigin(player.origin + var_44f2aa45);
    }
    if (isdefined(level.var_b55b2c5f)) {
        level.var_b55b2c5f scene::stop();
    }
    level.var_bd992b54 = struct::get("cin_merch_exterior_upper", "targetname");
    if (isdefined(level.var_bd992b54)) {
        level.var_bd992b54 scene::play();
    }
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_97787d8d
// Checksum 0x192f2967, Offset: 0x44a8
// Size: 0x1ba
function function_97787d8d(var_7f0b037) {
    if (!isdefined(var_7f0b037)) {
        var_7f0b037 = "open";
    }
    var_5b3fe023 = getent("mobile_door_left", "targetname");
    var_d758a83d = getent("mobile_door_right", "targetname");
    var_50de9d38 = 100;
    if (isdefined(var_5b3fe023) && isdefined(var_d758a83d)) {
        if (var_7f0b037 === "open") {
            var_5b3fe023 moveto(var_5b3fe023.origin + (var_50de9d38 * -1, 0, 0), 2, 0.1, 0.1);
            var_d758a83d moveto(var_d758a83d.origin + (var_50de9d38, 0, 0), 2, 0.1, 0.1);
            var_5b3fe023 playsound("evt_mobile_shop_doors_open");
        } else {
            var_5b3fe023 moveto(var_5b3fe023.origin + (var_50de9d38, 0, 0), 1, 0.1, 0.1);
            var_d758a83d moveto(var_d758a83d.origin + (var_50de9d38 * -1, 0, 0), 1, 0.1, 0.1);
            var_5b3fe023 playsound("evt_mobile_shop_doors_close");
        }
        return;
    }
    /#
        iprintlnbold("vtol_fly_by");
    #/
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_9a0b8bc1
// Checksum 0x9ad47431, Offset: 0x4670
// Size: 0x332
function function_9a0b8bc1() {
    foreach (player in level.players) {
        player clientfield::set_to_player("frost_post_fx", 0);
    }
    e_hatch = getent("mobile_shop_hatchdoor", "targetname");
    e_hatch playsound("wpn_rocket_explode_mobile_shop");
    self thread fx::play("mobile_shop_fall_explosion", e_hatch.origin, (0, 0, 0));
    wait(0.3);
    self thread fx::play("mobile_shop_fall_explosion", e_hatch.origin - (0, 200, 0), (0, 0, 0));
    level thread scene::play("p7_fxanim_cp_lotus_mobile_shops_merch_rpg_hit_bundle");
    earthquake(0.85, 1.75, e_hatch.origin, 1200);
    array::run_all(level.players, &playrumbleonentity, "damage_heavy");
    objectives::set("cp_waypoint_breadcrumb", struct::get("mobile_shop_ride2_last_objective"));
    level notify(#"hash_e0df7237");
    level thread scene::play("cin_lot_07_05_detcenter_vign_mantle_hatch");
    var_72a1d37e = spawner::simple_spawn_single("mobile_ride_2_end_rocketrobot");
    var_72a1d37e ai::set_ignoreall(1);
    var_72a1d37e setgoal(var_72a1d37e.origin, 1);
    var_72a1d37e.goalradius = 64;
    wait(3);
    s_target = struct::get("rocketshooter_target");
    mdl_target = util::spawn_model("tag_origin", s_target.origin + (0, 0, 80), s_target.angles);
    mdl_target.health = 9999;
    mdl_target.allowdeath = 0;
    var_72a1d37e thread ai::shoot_at_target("normal", mdl_target, "tag_origin", 16);
    var_72a1d37e util::waittill_any_timeout(16, "damage", "death");
    if (isalive(var_72a1d37e)) {
        var_72a1d37e.attackeraccuracy = 1;
        var_72a1d37e ai::set_ignoreall(0);
    }
    mdl_target delete();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_aa17eb00
// Checksum 0x4896d56a, Offset: 0x49b0
// Size: 0x10a
function function_aa17eb00() {
    level dialog::remote("kane_it_s_routed_to_the_d_0");
    level flag::wait_till("long_mobile_shop_start");
    level dialog::remote("kane_watch_hendricks_he_0", 0.5);
    level thread dialog::function_13b3b16a("plyr_copy_that_0");
    level waittill(#"hash_e0df7237");
    level thread namespace_a92ad484::function_8ca46216();
    level.var_2fd26037 dialog::say("hend_rpg_0", 0.5);
    wait(2);
    level dialog::function_13b3b16a("plyr_looks_like_this_is_o_0");
    if (!level flag::get("trig_player_out_of_mobile_shop_ride_2")) {
        level dialog::remote("kane_you_re_just_shy_of_t_0");
    }
    level flag::set("mobile_shop_2_vo_done");
}

// Namespace namespace_20a6d5c1
// Params 4, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_dffbb166
// Checksum 0xdf11aa68, Offset: 0x4ac8
// Size: 0x72
function function_dffbb166(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        objectives::complete("cp_level_lotus_go_to_taylor_prison_cell");
        objectives::set("cp_level_lotus_go_to_taylor_holding_room");
    }
    level thread scene::init("to_security_station_mobile_shop_fall", "targetname");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_296e8ec0
// Checksum 0x13a2647f, Offset: 0x4b48
// Size: 0x4a
function function_296e8ec0() {
    mdl_gate = getent("hallway_gate_06", "targetname");
    mdl_gate connectpaths();
    mdl_gate delete();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f6e4f19a
// Checksum 0xa8fb34e3, Offset: 0x4ba0
// Size: 0x1e5
function auto_delete() {
    self endon(#"death");
    self notify(#"__auto_delete__");
    self endon(#"__auto_delete__");
    level flag::wait_till("all_players_spawned");
    n_test_count = 0;
    wait(5);
    while (true) {
        wait(randomfloatrange(0.666667, 1.33333));
        n_tests_passed = 0;
        foreach (player in level.players) {
            var_d7e98a7d = 0;
            b_can_see = 0;
            v_eye = player geteye();
            v_facing = anglestoforward(player getplayerangles());
            v_to_ent = vectornormalize(self.origin - v_eye);
            n_dot = vectordot(v_facing, v_to_ent);
            if (n_dot > 0.67) {
                var_d7e98a7d = 1;
            } else {
                b_can_see = self sightconetrace(v_eye, player);
            }
            if (!b_can_see && !var_d7e98a7d) {
                n_tests_passed++;
            }
        }
        if (n_tests_passed == level.players.size) {
            n_test_count++;
            if (n_test_count < 5) {
                continue;
            }
            self notify(#"_disable_reinforcement");
            self delete();
            continue;
        }
        n_test_count = 0;
    }
}

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_57e7a8c9
// Checksum 0x40374977, Offset: 0x4d90
// Size: 0x20a
function function_57e7a8c9(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        trigger::use("trig_bridge_battle_initial_spawns");
        skipto::teleport_ai(str_objective);
        load::function_a2995f22();
    }
    level namespace_431cac9::function_484bc3aa(1);
    level thread namespace_431cac9::function_fda257c3();
    level thread function_e1c21e07();
    level thread function_1143b3b4();
    level thread function_2c257bff();
    level thread function_77e481f6();
    level thread function_10a2b6f2();
    level thread function_bebbfc6f();
    level thread function_3257371f(1);
    level thread function_8b9937fd();
    level thread function_f43bc1f8();
    level thread namespace_431cac9::function_14be4cad(1);
    level thread function_32049a32(var_74cd64bc);
    level thread function_44dd1b45();
    level thread function_94f75664();
    var_1e913765 = getent("dc4_enemy_sponge", "script_noteworthy");
    var_1e913765 spawner::add_spawn_function(&function_904f994);
    level thread scene::play("bridge_battle_falling_shop1", "targetname");
    level flag::wait_till("bridge_battle_done");
    skipto::function_be8adfb8("bridge_battle");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_94f75664
// Checksum 0x5d11bf60, Offset: 0x4fa8
// Size: 0xc3
function function_94f75664() {
    level flag::wait_till("player_crossed_bridge");
    var_9008f0c7 = getent("bridge_battle_across_gv", "targetname");
    a_enemies = spawner::get_ai_group_ai("bridge_end_enemies");
    foreach (enemy in a_enemies) {
        enemy setgoal(var_9008f0c7);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_e1c21e07
// Checksum 0xd4682e5e, Offset: 0x5078
// Size: 0x3a
function function_e1c21e07() {
    level endon(#"hash_800cbac6");
    level thread function_c928a4b5("bridge_end_enemies");
    level thread function_c928a4b5("police_station_enemies");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_c928a4b5
// Checksum 0x549c44f9, Offset: 0x50c0
// Size: 0x32
function function_c928a4b5(var_69e64c43) {
    level endon(#"hash_800cbac6");
    spawner::waittill_ai_group_cleared(var_69e64c43);
    savegame::checkpoint_save();
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_32049a32
// Checksum 0xe4a387d8, Offset: 0x5100
// Size: 0xda
function function_32049a32(var_74cd64bc) {
    battlechatter::function_d9f49fba(0);
    if (!var_74cd64bc) {
        level flag::wait_till("mobile_shop_2_vo_done");
    }
    dialog::remote("kane_follow_the_marker_0", 1);
    dialog::function_13b3b16a("plyr_copy_that_kane_0", 0.25);
    battlechatter::function_d9f49fba(1);
    flag::wait_till("bridge_battle_police_station_opened");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_raps_comin_in_hot_0", 0.5);
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_44dd1b45
// Checksum 0xd74c8a23, Offset: 0x51e8
// Size: 0x1d2
function function_44dd1b45() {
    spawner::waittill_ai_group_amount_killed("bb_start_enemies", 2);
    var_67ac5172 = getent("cult_center_door_left", "targetname");
    var_43ecc01c = getent("cult_center_door_right", "targetname");
    var_46f41a3b = 100;
    var_7d6af5ea = 1;
    var_67ac5172 moveto(var_67ac5172.origin + (0, var_46f41a3b, 0), var_7d6af5ea, 0.1, 0.1);
    var_43ecc01c moveto(var_43ecc01c.origin + (0, var_46f41a3b * -1, 0), var_7d6af5ea, 0.1, 0.1);
    wait(var_7d6af5ea);
    spawn_manager::enable("bb_nolull_spawn_manager");
    /#
        iprintlnbold("mobile_shop_ride_ready");
    #/
    level flag::wait_till("player_crossed_bridge");
    spawn_manager::disable("bb_nolull_spawn_manager");
    var_67ac5172 moveto(var_67ac5172.origin + (0, var_46f41a3b * -1, 0), var_7d6af5ea, 0.1, 0.1);
    var_43ecc01c moveto(var_43ecc01c.origin + (0, var_46f41a3b, 0), var_7d6af5ea, 0.1, 0.1);
    /#
        iprintlnbold("mobile_ride_2_end_rocketrobot");
    #/
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_1143b3b4
// Checksum 0xd7f9e0f3, Offset: 0x53c8
// Size: 0x1a
function function_1143b3b4() {
    objectives::breadcrumb("bridge_battle_breadcrumb01");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_2c257bff
// Checksum 0xddc0f47d, Offset: 0x53f0
// Size: 0xd2
function function_2c257bff() {
    var_8cc44767 = getnode("cover_endbridge_trashbin", "targetname");
    setenablenode(var_8cc44767, 0);
    flag::wait_till("flag_coverpush_endbridge");
    function_f423b892("coverpush_endbridge_pos", "coverpush_endbridge_enemy", "coverpush_endbridge_bin");
    setenablenode(var_8cc44767, 1);
    flag::wait_till("bridge_battle_police_station_opened");
    function_f423b892("coverpush_pos2", "coverpush_enemy2", "coverpush_trash_bin2");
}

// Namespace namespace_20a6d5c1
// Params 3, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f423b892
// Checksum 0x294582ef, Offset: 0x54d0
// Size: 0x11a
function function_f423b892(str_position, var_7fadc70c, var_e7daaecc) {
    var_a6ebc7b = getent(var_e7daaecc, "targetname");
    var_f43c5188 = getent(var_e7daaecc + "_col", "targetname");
    var_f43c5188 linkto(var_a6ebc7b);
    struct_pos = struct::get(str_position, "targetname");
    var_b429251f = spawner::simple_spawn_single(var_7fadc70c);
    struct_pos scene::init("cin_gen_aie_push_cover_sideways_no_dynpath", array(var_b429251f, var_a6ebc7b));
    struct_pos scene::play("cin_gen_aie_push_cover_sideways_no_dynpath");
    var_f43c5188 unlink();
    var_f43c5188 disconnectpaths(0, 0);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_10a2b6f2
// Checksum 0x3a76043c, Offset: 0x55f8
// Size: 0x1a2
function function_10a2b6f2() {
    level thread function_e90c24f8();
    flag::wait_till("flag_grand_entrances");
    /#
        iprintlnbold("police_door_02");
    #/
    spawner::add_spawn_function_group("robo_entrant01", "targetname", &function_87c91b1b);
    spawner::add_spawn_function_group("robo_entrant02", "targetname", &function_87c91b1b);
    spawner::add_spawn_function_group("robo_entrant03", "targetname", &function_87c91b1b);
    spawner::add_spawn_function_group("robo_entrant04", "targetname", &function_87c91b1b);
    level thread namespace_431cac9::function_99514074("robo_entrance01", "robo_entrant01");
    wait(0.75);
    level thread namespace_431cac9::function_99514074("robo_entrance02", "robo_entrant02");
    wait(1.5);
    level thread namespace_431cac9::function_99514074("robo_entrance04", "robo_entrant04");
    wait(1.5);
    level thread namespace_431cac9::function_99514074("robo_entrance03", "robo_entrant03");
    wait(1.5);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_e90c24f8
// Checksum 0x3130450b, Offset: 0x57a8
// Size: 0x52
function function_e90c24f8() {
    level endon(#"hash_92e00f70");
    level flag::wait_till("player_crossed_bridge");
    spawner::waittill_ai_group_count("bridge_end_enemies", 3);
    level flag::set("flag_grand_entrances");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_87c91b1b
// Checksum 0x39db6dc1, Offset: 0x5808
// Size: 0x42
function function_87c91b1b() {
    volume = getent("bridge_battle_ge_gv", "targetname");
    self setgoal(volume);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f43bc1f8
// Checksum 0x75dced8b, Offset: 0x5858
// Size: 0x52
function function_f43bc1f8() {
    a_flags = array("wall_run_enemies_cleared", "bridge_battle_done");
    level flag::wait_till_any(a_flags);
    level thread function_e7a8c6b();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_77e481f6
// Checksum 0x2ca9f29e, Offset: 0x58b8
// Size: 0x122
function function_77e481f6() {
    var_412a98c7 = spawner::simple_spawn_single("dc3_friendly_scarifice");
    util::magic_bullet_shield(var_412a98c7);
    level flag::wait_till("friendly_sacrifice");
    var_a3f0d6d = getnode("scarifice_goal", "targetname");
    var_412a98c7 thread ai::force_goal(var_a3f0d6d, 64, undefined, undefined, undefined, undefined);
    var_412a98c7 ai::set_ignoreall(1);
    trigger::wait_till("trig_sacrifice_death");
    var_412a98c7 ai::set_ignoreall(0);
    util::stop_magic_bullet_shield(var_412a98c7);
    a_enemies = getaiteamarray("axis");
    array::thread_all(a_enemies, &ai::shoot_at_target, "kill_within_time", var_412a98c7, undefined, 0.05);
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_3257371f
// Checksum 0x40e95829, Offset: 0x59e8
// Size: 0x183
function function_3257371f(var_729354f4) {
    if (!(isdefined(level.var_38c1711f) && level.var_38c1711f)) {
        level.var_38c1711f = 1;
        var_a7b48bf5 = getent("police_door_01", "targetname");
        var_a7b48bf5 moveto(var_a7b48bf5.origin + (0, 0, -144), 3);
        var_cdb7065e = getent("police_door_02", "targetname");
        var_cdb7065e moveto(var_cdb7065e.origin + (0, 0, -144), 3);
    }
    if (isdefined(var_729354f4) && var_729354f4) {
        trigger::wait_till("trig_kill_sniper");
        var_34c1b22f = getaiarray("dc3_police_sniper", "script_noteworthy");
        foreach (ai_sniper in var_34c1b22f) {
            level.var_2fd26037 ai::shoot_at_target("kill_within_time", ai_sniper, undefined, 0.05);
        }
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_8b9937fd
// Checksum 0x50b59eec, Offset: 0x5b78
// Size: 0xaa
function function_8b9937fd() {
    trigger::wait_till("trig_rollunder");
    level thread function_61700635();
    var_3170fbf = spawner::simple_spawn_single("rollunder_smg");
    level scene::play("detention_center3_rollunder", "targetname", var_3170fbf);
    volume = getent("bridge_battle_ge_gv", "targetname");
    var_3170fbf setgoal(volume);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_bebbfc6f
// Checksum 0x831e59cf, Offset: 0x5c30
// Size: 0x9a
function function_bebbfc6f() {
    trigger::wait_till("trig_slide");
    var_7cfde525 = spawner::simple_spawn_single("slide_smg");
    level scene::play("detention_center3_slide", "targetname", var_7cfde525);
    volume = getent("bridge_battle_ge_gv", "targetname");
    var_7cfde525 setgoal(volume);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_61700635
// Checksum 0xba4ce462, Offset: 0x5cd8
// Size: 0x72
function function_61700635() {
    mdl_door = getent("spawn_door7_5_1", "targetname");
    mdl_door moveto(mdl_door.origin + (0, 0, -136), 6);
    mdl_door waittill(#"movedone");
    mdl_door disconnectpaths();
}

// Namespace namespace_20a6d5c1
// Params 4, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_800cbac6
// Checksum 0x83f603e, Offset: 0x5d58
// Size: 0x8a
function function_800cbac6(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    var_15aaf918 = struct::get("s_glass_squib", "targetname");
    if (isdefined(var_15aaf918)) {
        /#
            iprintlnbold("start_up_to_detention_center");
        #/
        glassradiusdamage(var_15aaf918.origin, -106, 50, 50);
    }
}

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_5b4279a3
// Checksum 0x292890e3, Offset: 0x5df0
// Size: 0x30a
function function_5b4279a3(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        var_1e913765 = getent("dc4_enemy_sponge", "script_noteworthy");
        var_1e913765 spawner::add_spawn_function(&function_904f994);
        level thread function_3257371f();
        level thread function_61700635();
        level thread function_e7a8c6b();
        level thread namespace_431cac9::function_fda257c3();
        level thread namespace_431cac9::function_14be4cad();
        load::function_a2995f22();
        level namespace_431cac9::function_484bc3aa(1);
    }
    level function_17ceabc9();
    namespace_431cac9::function_fe64b86b("falling_nrc", struct::get("wallrun_corpse1"), 0);
    level thread function_3dcaa53a();
    level thread function_f31848ce();
    level thread function_8267fad4();
    level thread function_dcd3f360();
    level thread function_974bbb6b();
    level thread function_3604a049();
    level thread function_2ff2c34();
    level thread function_4753f046();
    level thread function_cb2b9cbf();
    spawner::add_spawn_function_group("siegebot_hospital", "script_noteworthy", &function_fd8c0654);
    spawner::add_spawn_function_group("siegebot_hospital", "script_noteworthy", &function_dce6e561);
    level flag::init("hospital_door_up");
    level flag::init("dc4_dead_siegebots");
    foreach (player in level.players) {
        player clientfield::set_to_player("siegebot_fans", 1);
    }
    level flag::wait_till("up_to_detention_center_done");
    skipto::function_be8adfb8("up_to_detention_center");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_17ceabc9
// Checksum 0x95f9b657, Offset: 0x6108
// Size: 0x8b
function function_17ceabc9() {
    var_b6a97ee5 = getentarray("infirmary_glass_triggers", "script_noteworthy");
    foreach (var_799e4c3a in var_b6a97ee5) {
        var_799e4c3a thread function_aa11d0bb();
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_aa11d0bb
// Checksum 0x65639136, Offset: 0x61a0
// Size: 0x52
function function_aa11d0bb() {
    self trigger::wait_till();
    var_25cdefbd = struct::get(self.target);
    glassradiusdamage(var_25cdefbd.origin, 20, -56, -56);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_2ff2c34
// Checksum 0xc677df8f, Offset: 0x6200
// Size: 0xab
function function_2ff2c34() {
    level endon(#"hash_cbbe14bc");
    trigger::wait_till("use_up_to_detention_center_triggers");
    a_triggers = getentarray("up_to_detention_center_triggers", "script_noteworthy");
    foreach (trigger in a_triggers) {
        trigger trigger::use(undefined, undefined, undefined, 0);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_3604a049
// Checksum 0xf3e165f9, Offset: 0x62b8
// Size: 0xea
function function_3604a049() {
    v_start = struct::get("s_dc_phalanx_start").origin;
    v_end = struct::get("s_dc_phalanx_end").origin;
    var_f835ddae = getent("sp_dc_phalanx", "targetname");
    var_de3c864 = new phalanx();
    [[ var_de3c864 ]]->initialize("phalanx_reverse_wedge", v_start, v_end, 2, 5, var_f835ddae, var_f835ddae);
    level flag::wait_till("dc4_dead_siegebots");
    var_de3c864 phalanx::scatterphalanx();
    var_f835ddae delete();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_dce6e561
// Checksum 0xaa52ad7f, Offset: 0x63b0
// Size: 0x5a
function function_dce6e561() {
    if (!isdefined(level.var_922b7c07)) {
        level.var_922b7c07 = 0;
    }
    level.var_922b7c07++;
    level endon(#"hash_a8d150b1");
    self waittill(#"death");
    level.var_922b7c07--;
    if (level.var_922b7c07 <= 0) {
        level flag::set("dc4_dead_siegebots");
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_fd8c0654
// Checksum 0x7dd20fa9, Offset: 0x6418
// Size: 0x3a
function function_fd8c0654() {
    self vehicle_ai::start_scripted();
    level flag::wait_till("hospital_door_up");
    self vehicle_ai::stop_scripted();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_cb2b9cbf
// Checksum 0x3f7e5d17, Offset: 0x6460
// Size: 0x6a
function function_cb2b9cbf() {
    level endon(#"hash_cbbe14bc");
    battlechatter::function_d9f49fba(0);
    flag::wait_till("start_up_to_detention_center");
    battlechatter::function_d9f49fba(1);
    flag::wait_till("trig_spawn_detention_center_kicked_guy");
    battlechatter::function_d9f49fba(0);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_4753f046
// Checksum 0x32a0c651, Offset: 0x64d8
// Size: 0x1a
function function_4753f046() {
    objectives::breadcrumb("up_to_detention_center_breadcrumb01");
}

// Namespace namespace_20a6d5c1
// Params 4, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_cbbe14bc
// Checksum 0x3ecbe0c5, Offset: 0x6500
// Size: 0x3a
function function_cbbe14bc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_go_to_taylor_prison_cell");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_39a310be
// Checksum 0xa128e047, Offset: 0x6548
// Size: 0x92
function function_39a310be() {
    flag::wait_till("spawn_doomed_rapper");
    var_d031ee03 = spawner::simple_spawn_single("doomed_rapper");
    var_d031ee03.overrideactordamage = &function_f0ce2a2f;
    flag::wait_till("rapper_is_doomed");
    if (isalive(var_d031ee03)) {
        var_d031ee03 function_5c93563b();
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_5c93563b
// Checksum 0x9faf9366, Offset: 0x65e8
// Size: 0x132
function function_5c93563b() {
    self endon(#"death");
    var_29839a5c = getnode("doomed_rapper_pos", "targetname");
    self ai::force_goal(var_29839a5c.origin, 5, 1, undefined, undefined, 1);
    while (distance2d(self.origin, var_29839a5c.origin) > 100) {
        wait(1);
    }
    var_3e32f05a = spawner::simple_spawn_single("raps_doomer");
    var_3e32f05a setspeed(19);
    foreach (var_5c4b8c35 in level.players) {
        self setignoreent(var_5c4b8c35, 1);
    }
    var_3e32f05a setentitytarget(self);
    self thread function_b80c1b50(var_3e32f05a);
}

// Namespace namespace_20a6d5c1
// Params 12, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f0ce2a2f
// Checksum 0x3060b8f2, Offset: 0x6728
// Size: 0x8d
function function_f0ce2a2f(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, var_269779a, psoffsettime, var_fe8d5ebb) {
    if (e_inflictor.archetype === "raps") {
        n_damage = self.health;
    } else {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_b80c1b50
// Checksum 0x43ccbf51, Offset: 0x67c0
// Size: 0x112
function function_b80c1b50(var_3e32f05a) {
    if (isdefined(var_3e32f05a) && var_3e32f05a.archetype === "raps") {
        idamage, smeansofdeath, weapon, shitloc, vdir = self waittill(#"death");
        if (isdefined(var_3e32f05a)) {
            v_dir = anglestoforward(var_3e32f05a.angles) + anglestoup(var_3e32f05a.angles) * 0.5;
            v_dir *= 64;
            self startragdoll();
            self launchragdoll((v_dir[0], v_dir[1], v_dir[2] + 32));
            if (isalive(var_3e32f05a)) {
                var_3e32f05a kill();
            }
        }
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_8267fad4
// Checksum 0xeedc09c7, Offset: 0x68e0
// Size: 0xaa
function function_8267fad4() {
    ai_enemy = spawner::simple_spawn_single("dc4_jump_out");
    ai_enemy ai::set_ignoreall(1);
    trigger::wait_till("trig_fleeing_enemy");
    if (isdefined(ai_enemy)) {
        ai_enemy ai::set_ignoreall(0);
        var_8b91eab7 = getnode("jump_out_dest", "targetname");
        ai_enemy setgoal(var_8b91eab7, 0, 64);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_e7a8c6b
// Checksum 0xddabc214, Offset: 0x6998
// Size: 0x282
function function_e7a8c6b() {
    if (flag::get("wall_run_enemies_cleared")) {
        var_ad0cc537 = struct::get("hendricks_uptodc_wallrun_waitpos", "targetname");
        level.var_2fd26037 setgoal(var_ad0cc537.origin, 1);
        if (level flag::get("all_players_spawned")) {
            var_72bda784 = distance2d(level.players[0].origin, level.var_2fd26037.origin);
            var_cf29ba8c = 300;
            while (var_72bda784 > var_cf29ba8c) {
                /#
                #/
                wait(0.5);
                var_72bda784 = distance2d(level.players[0].origin, level.var_2fd26037.origin);
            }
        } else {
            level flag::wait_till("all_players_spawned");
        }
    }
    util::delay(randomfloatrange(2, 4), undefined, &namespace_431cac9::function_fe64b86b, "falling_nrc", struct::get("wallrun_corpse2"), 0);
    level thread scene::play("to_security_station_mobile_shop_fall", "targetname");
    level thread scene::play("cin_lot_07_05_detcenter_vign_wallrun_hendricks");
    level.var_2fd26037 waittill(#"goal");
    util::delay(randomfloat(2), undefined, &namespace_431cac9::function_fe64b86b, "falling_nrc", struct::get("wallrun_corpse3"), 0);
    var_64dbd70a = getent("trig_dc4_hendricks", "targetname");
    if (isdefined(var_64dbd70a)) {
        var_64dbd70a trigger::use();
    }
    namespace_431cac9::function_fe64b86b("falling_nrc", struct::get("wallrun_corpse3"), 0);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_904f994
// Checksum 0x52de59f5, Offset: 0x6c28
// Size: 0x1a
function function_904f994() {
    self.overrideactordamage = &function_5f1eb24b;
}

// Namespace namespace_20a6d5c1
// Params 12, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_5f1eb24b
// Checksum 0xd0a7f4f6, Offset: 0x6c50
// Size: 0x7b
function function_5f1eb24b(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, psoffsettime, boneindex, var_269779a) {
    if (!isplayer(e_attacker)) {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_3dcaa53a
// Checksum 0x44c5775d, Offset: 0x6cd8
// Size: 0x152
function function_3dcaa53a() {
    var_412a98c7 = spawner::simple_spawn_single("dc4_friendly_sacrifice");
    var_412a98c7.overrideactordamage = &function_98c4a0b7;
    var_412a98c7 ai::set_ignoreme(1);
    var_9999ca8a = spawner::simple_spawn_single("dc4_deadly_rap", &function_ca258604);
    level scene::init("cin_lot_07_05_detcenter_vign_rapsdeath", array(var_9999ca8a, var_412a98c7));
    flag::wait_till("dc4_friendly_sacrifice");
    level thread scene::skipto_end("cin_lot_07_05_detcenter_vign_rapsdeath", undefined, undefined, 0.4);
    var_190535de = spawner::simple_spawn_single("rapsdeath_shooter");
    if (isalive(var_412a98c7)) {
        var_190535de thread ai::shoot_at_target("normal", var_412a98c7, undefined, 2);
    }
    trigger::use("trig_hendricks_r01utd", "targetname");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ca258604
// Checksum 0xad7248bd, Offset: 0x6e38
// Size: 0x62
function function_ca258604() {
    var_9999ca8a = self;
    var_9999ca8a ai::set_ignoreall(1);
    util::magic_bullet_shield(var_9999ca8a);
    level waittill(#"hash_c1151572");
    var_9999ca8a ai::set_ignoreall(0);
    util::stop_magic_bullet_shield(var_9999ca8a);
}

// Namespace namespace_20a6d5c1
// Params 12, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_98c4a0b7
// Checksum 0xa533c7d9, Offset: 0x6ea8
// Size: 0x93
function function_98c4a0b7(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, psoffsettime, boneindex, var_269779a) {
    if (isdefined(e_attacker.archetype) && e_attacker.archetype == "raps") {
        n_damage = 100;
    } else {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_4acf6164
// Checksum 0xb62cc923, Offset: 0x6f48
// Size: 0x7d
function function_4acf6164(var_412a98c7) {
    self endon(#"death");
    while (true) {
        if (isdefined(var_412a98c7)) {
            n_dist_2d_sq = distance2dsquared(var_412a98c7.origin, self.origin);
            if (n_dist_2d_sq < 4096) {
                self dodamage(self.health, self.origin);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_20a6d5c1
// Params 15, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_d086631d
// Checksum 0x7579060c, Offset: 0x6fd0
// Size: 0xc3
function function_d086631d(e_inflictor, e_attacker, n_damage, var_36537420, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, var_46043680, n_psoffsettime, var_3bc96147, var_269779a, var_829b9480, var_eca96ec1) {
    if (isdefined(str_means_of_death) && str_means_of_death == "MOD_UNKNOWN") {
        n_damage = n_damage;
    } else if (isplayer(e_attacker)) {
        n_damage *= 0.09;
    } else {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f31848ce
// Checksum 0x563e1904, Offset: 0x70a0
// Size: 0xd2
function function_f31848ce() {
    trigger::wait_till("trig_fleeing_enemy");
    ai_enemy = spawner::simple_spawn_single("dc4_fleeing_enemy");
    ai_enemy endon(#"death");
    var_5249b1c2 = getnode("fleeing_enemy_path", "targetname");
    ai_enemy ai::force_goal(var_5249b1c2, 64, 0, undefined, undefined, 1);
    ai_enemy waittill(#"goal");
    var_5249b1c2 = getnode("fleeing_enemy_node", "targetname");
    ai_enemy ai::force_goal(var_5249b1c2, 64, 0, undefined, undefined, 1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_dcd3f360
// Checksum 0xabef1972, Offset: 0x7180
// Size: 0x17a
function function_dcd3f360() {
    mdl_door = getent("spawn_door7_5_2", "targetname");
    mdl_door moveto(mdl_door.origin - (0, 0, -112), 0.1);
    trigger::wait_till("trig_dc4_door");
    level exploder::exploder("fx_interior_sentry_reveal");
    mdl_door = getent("spawn_door7_5_2", "targetname");
    mdl_door moveto(mdl_door.origin + (0, 0, 12), 1);
    mdl_door waittill(#"movedone");
    mdl_door playsound("evt_siegebot_door_buzz");
    wait(1.25);
    mdl_door playsound("evt_siegebot_door");
    mdl_door moveto(mdl_door.origin + (0, 0, -112 - 12), 3);
    mdl_door waittill(#"movedone");
    level flag::set("hospital_door_up");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_974bbb6b
// Checksum 0xb830812b, Offset: 0x7308
// Size: 0x102
function function_974bbb6b() {
    mdl_door = getent("hosp_hall_gate_10", "targetname");
    if (isdefined(mdl_door)) {
        mdl_door moveto(mdl_door.origin + (0, 0, 145), 1);
    }
    var_50de9d38 = 100;
    mdl_door_left = getent("hosp_hall_gate_10_L", "targetname");
    mdl_door_left moveto(mdl_door_left.origin + (0, var_50de9d38 * -1, 0), 1);
    mdl_door_right = getent("hosp_hall_gate_10_R", "targetname");
    mdl_door_right moveto(mdl_door_right.origin + (0, var_50de9d38, 0), 1);
}

// Namespace namespace_20a6d5c1
// Params 2, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_acdf71f3
// Checksum 0xa8588b53, Offset: 0x7418
// Size: 0x46a
function function_acdf71f3(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective);
        load::function_a2995f22();
        level namespace_431cac9::function_484bc3aa(1);
    }
    namespace_431cac9::function_3b6587d6(0, "lotus2_standdown_igc_umbra_gate");
    namespace_f4ff722a::function_a2c4c634();
    var_d6cea0d7 = getent("trig_kick_door", "targetname");
    if (isdefined(var_d6cea0d7)) {
        var_d6cea0d7 triggerenable(0);
    }
    level thread function_3699620f();
    level thread function_896c40b9();
    level thread function_ab3d9328();
    mdl_door_left = getent("det_door_prometheus_01_L", "targetname");
    mdl_door_right = getent("det_door_prometheus_01_R", "targetname");
    mdl_door_left moveto(mdl_door_left.origin + (0, 54, 0), 1, 0.25, 0.25);
    mdl_door_right moveto(mdl_door_right.origin + (0, -54, 0), 1, 0.25, 0.25);
    battlechatter::function_d9f49fba(0);
    level thread function_14273be5();
    level thread function_d371cec6("dc_fallback_0");
    level thread function_d371cec6("dc_fallback_1");
    level thread function_d371cec6("dc_fallback_2");
    level thread function_7d9b9de2();
    level thread function_795646b8();
    level thread function_f7887a52();
    level thread function_fefb4f44();
    wait(1);
    level thread function_19cafdb6();
    level notify(#"hash_1206d494");
    var_c77d7d8e = getent("trig_go_hendricks_after_kick", "targetname");
    if (isdefined(var_c77d7d8e)) {
        var_c77d7d8e trigger::use();
    }
    e_door_clip = getent("detention_center_door_clip", "targetname");
    e_door_clip notsolid();
    trigger::wait_till("trig_all_players_at_stand_down", "targetname", level.var_2fd26037);
    foreach (player in level.players) {
        player clientfield::set_to_player("siegebot_fans", 0);
    }
    e_door_clip solid();
    mdl_door_left moveto(mdl_door_left.origin + (0, -54, 0), 1, 0.25, 0.25);
    mdl_door_right moveto(mdl_door_right.origin + (0, 54, 0), 1, 0.25, 0.25);
    level scene::init("cin_lot_08_01_standdown_sh010");
    skipto::function_be8adfb8("detention_center");
    level notify(#"hash_5730accc");
    level.var_2fd26037 colors::enable();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_14273be5
// Checksum 0xc9a60be3, Offset: 0x7890
// Size: 0xca
function function_14273be5() {
    level endon(#"hash_5730accc");
    level flag::wait_till("players_made_it_to_stand_down");
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 1);
    level.var_2fd26037 setgoal(getnode("hendricks_stand_down_door_node", "targetname"), 0, 32);
    level.var_2fd26037.allowbattlechatter["bc"] = 0;
    level.var_2fd26037 ai::set_behavior_attribute("coverIdleOnly", 1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_3699620f
// Checksum 0x77740028, Offset: 0x7968
// Size: 0x3a
function function_3699620f() {
    battlechatter::function_d9f49fba(0);
    flag::wait_till("start_detention_center_action");
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_896c40b9
// Checksum 0x8278f44e, Offset: 0x79b0
// Size: 0x52
function function_896c40b9() {
    level endon(#"hash_5730accc");
    level thread function_ca30eede("aigroup_detention_center");
    level thread function_c928a4b5("dc_wave_1");
    level thread function_c928a4b5("dc_wave_2");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ca30eede
// Checksum 0xe509d008, Offset: 0x7a10
// Size: 0x32
function function_ca30eede(var_69e64c43) {
    level endon(#"hash_5730accc");
    spawner::waittill_ai_group_cleared(var_69e64c43);
    savegame::checkpoint_save();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ab3d9328
// Checksum 0x980adfa, Offset: 0x7a50
// Size: 0x13a
function function_ab3d9328() {
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_entrance_is_ahead_on_0", 0.75);
    flag::wait_till("entering_detention_center");
    level thread util::function_d8eaed3d(2, 1);
    level dialog::remote("kane_reinforcements_have_0");
    level.var_2fd26037 dialog::say("hend_tell_us_something_we_0", 0.25);
    battlechatter::function_d9f49fba(1);
    flag::wait_till("flag_nrc_hounds_moving_in");
    level dialog::remote("kane_taylor_s_secured_the_0", 0.25);
    level dialog::remote("kane_hang_tight_few_more_0", 3);
    level dialog::remote("kane_access_restored_0", 3);
    level dialog::function_13b3b16a("plyr_copy_that_kane_we_0", 0.5);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_fefb4f44
// Checksum 0x563b7d5c, Offset: 0x7b98
// Size: 0x62
function function_fefb4f44() {
    var_87248a54 = getent("trig_end_enemies", "targetname");
    var_87248a54 endon(#"trigger");
    spawner::waittill_ai_group_cleared("dc_wave_1");
    trigger::use("trig_end_enemies");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_19cafdb6
// Checksum 0x3535bba, Offset: 0x7c08
// Size: 0x1a
function function_19cafdb6() {
    objectives::breadcrumb("detention_center_breadcrumb01");
}

// Namespace namespace_20a6d5c1
// Params 1, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_d371cec6
// Checksum 0xd9d5fe0, Offset: 0x7c30
// Size: 0xe3
function function_d371cec6(str_trigger) {
    var_82fc0698 = getent(str_trigger, "targetname");
    var_82fc0698 waittill(#"trigger");
    var_ab891f49 = getent(var_82fc0698.target, "targetname");
    a_enemies = getaiarray("dc_bottom", "script_noteworthy");
    foreach (ai_enemy in a_enemies) {
        ai_enemy setgoal(var_ab891f49, 1);
    }
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_7d9b9de2
// Checksum 0x8e42fe87, Offset: 0x7d20
// Size: 0x62
function function_7d9b9de2() {
    trigger::wait_till("trig_dc_pamws_enemies");
    wait(2);
    mdl_clip = getent("dc_stair_2_monster_clip", "targetname");
    mdl_clip connectpaths();
    mdl_clip delete();
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_795646b8
// Checksum 0x23be5b5a, Offset: 0x7d90
// Size: 0xba
function function_795646b8() {
    trigger::wait_till("trig_dc_pamws");
    mdl_door_left = getent("detention_security_door_01_L", "targetname");
    mdl_door_right = getent("detention_security_door_01_R", "targetname");
    mdl_door_left moveto(mdl_door_left.origin + (-100, 0, 0), 3);
    mdl_door_right moveto(mdl_door_right.origin + (100, 0, 0), 3);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_f7887a52
// Checksum 0xbfa94ff4, Offset: 0x7e58
// Size: 0x112
function function_f7887a52() {
    trigger::wait_till("trig_dc_phalanx");
    v_start = struct::get("dc_phalanx_wedge_start").origin;
    v_end = struct::get("dc_phalanx_wedge_end").origin;
    var_1b6ee6b2 = 3;
    if (level.players.size > 2) {
        var_1b6ee6b2 = 5;
    }
    var_7947347f = getent("phalanx_spawner_01", "targetname", 0);
    var_73fc544 = getent("phalanx_spawner_02", "targetname", 0);
    var_52fcc5ab = new robotphalanx();
    [[ var_52fcc5ab ]]->initialize("phanalx_wedge", v_start, v_end, 1, var_1b6ee6b2, var_7947347f, var_73fc544);
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_ab3ac518
// Checksum 0x57e3f1e8, Offset: 0x7f78
// Size: 0xaa
function function_ab3ac518() {
    self endon(#"death");
    self.goalradius = 16;
    self waittill(#"goal");
    wait(1);
    var_ae8309eb = getent("detention_security_door_01", "targetname");
    var_ae8309eb moveto(var_ae8309eb getorigin() - (0, 0, 128), 1);
    var_ae8309eb connectpaths();
    spawn_manager::enable("sm_detention_center_control_panel_cobra");
}

// Namespace namespace_20a6d5c1
// Params 4, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_5730accc
// Checksum 0x7f31a515, Offset: 0x8030
// Size: 0x6a
function function_5730accc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_lotus_go_to_taylor_holding_room");
    level util::clientnotify("riot_on");
    level scene::init("p7_fxanim_cp_lotus_interrogation_room_glass_bundle");
}

// Namespace namespace_20a6d5c1
// Params 0, eflags: 0x0
// namespace_20a6d5c1<file_0>::function_c35e6aab
// Checksum 0x3374b15f, Offset: 0x80a8
// Size: 0x32
function init() {
    spawner::add_spawn_function_group("auto_delete", "script_string", &auto_delete);
}

