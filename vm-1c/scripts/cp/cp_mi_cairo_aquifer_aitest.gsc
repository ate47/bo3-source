#using scripts/shared/callbacks_shared;
#using scripts/shared/lui_shared;
#using scripts/cp/gametypes/_save;
#using scripts/shared/scene_shared;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/shared/exploder_shared;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/codescripts/struct;
#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/_spawn_manager;
#using scripts/shared/vehicle_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;

#namespace namespace_4a128b5f;

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_c35e6aab
// Checksum 0x873f5300, Offset: 0x12f8
// Size: 0x464
function init() {
    if (!level flag::exists("inside_aquifer")) {
        level flag::init("inside_aquifer");
    }
    level flag::init("aquifer_zone02_combat_start");
    level flag::init("aquifer_zone03_combat_start");
    level flag::init("flag_force_off_dust");
    level flag::init("flag_post_vtol_intro");
    level flag::init("exterior_hack_trig_left_1_finished");
    level flag::init("exterior_hack_trig_right_1_finished");
    level flag::init("hack_zone02_1_finished");
    level flag::init("hack_zone02_2_finished");
    level flag::init("hack_zone03_1_finished");
    level flag::init("hack_zone03_2_finished");
    level flag::init("flag_aqu_save_state");
    level flag::init("exterior_hack_trig_left_1_started");
    level flag::init("exterior_hack_trig_right_1_started");
    level flag::init("hack_zone02_1_started");
    level flag::init("hack_zone02_2_started");
    level flag::init("hack_zone03_1_started");
    level flag::init("hack_zone03_2_started");
    level flag::init("hack_zone02_3_started");
    level flag::init("hack_zone02_3_finished");
    level flag::init("hack_zone02_4_started");
    level flag::init("hack_zone02_4_finished");
    level flag::init("hack_zone02_5_started");
    level flag::init("hack_zone02_5_finished");
    level flag::init("hack_zone02_6_started");
    level flag::init("hack_zone02_6_finished");
    level flag::init("flag_kayne_vulnerable");
    level flag::init("kayne_starts_overload");
    level flag::init("flag_wave2_port");
    level flag::init("flag_wave2_residential");
    level flag::init("flag_player_left_tower_done");
    level flag::init("flag_player_right_tower_done");
    level flag::init("flag_player_started_left_tower");
    level flag::init("flag_player_started_right_tower");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_82230f12
// Checksum 0x49fcaaf8, Offset: 0x1768
// Size: 0x24
function function_82230f12() {
    thread function_b63b8588();
    thread function_5f0c85a2();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_25dcb860
// Checksum 0x4d8b2d9b, Offset: 0x1798
// Size: 0x44
function function_25dcb860() {
    thread function_92eaa107("start_spawning_zone01_enemies", "spawn_manager_zone01", "spawn_manager_zone01b", "destroy_defenses_completed", "hack_terminal_right_completed", "aquifer_zone03_combat_start");
}

// Namespace namespace_4a128b5f
// Params 6, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_92eaa107
// Checksum 0x42f3deee, Offset: 0x17e8
// Size: 0x294
function function_92eaa107(trig, sm, var_470f86b1, var_f0b6f220, var_a6b912d3, var_5b64aa9b) {
    tr = getent(trig, "targetname");
    tr waittill(#"trigger");
    spawner::add_global_spawn_function("axis", &function_18de558f);
    spawn_manager::enable(sm);
    spawn_manager::enable(var_470f86b1);
    vehicle::add_spawn_function("zone01_hunter", &function_8273bb26);
    var_17644d42 = getent("zone01_hunter", "targetname");
    veh = vehicle::_vehicle_spawn(var_17644d42);
    spawners = getentarray("dummy_runners_01", "targetname");
    foreach (s in spawners) {
        s thread function_59a7e387();
    }
    level flag::wait_till(var_f0b6f220);
    spawn_manager::disable(sm);
    spawn_manager::disable(var_470f86b1);
    spawner::remove_global_spawn_function("axis", &function_18de558f);
    level flag::wait_till(var_a6b912d3);
    if (isdefined(var_5b64aa9b)) {
        level flag::set(var_5b64aa9b);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_18de558f
// Checksum 0x7f39eae8, Offset: 0x1a88
// Size: 0x10
function function_18de558f() {
    self.dontdropweapon = 1;
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_8273bb26
// Checksum 0x37ab5216, Offset: 0x1aa0
// Size: 0x10a
function function_8273bb26() {
    self endon(#"death");
    self endon(#"deleted");
    level flag::wait_till("destroy_defenses_completed");
    self ai::set_ignoreall(1);
    self.goalradius = 32;
    var_25e662d3 = getent("zone01_hunter_goal", "targetname");
    var_25e662d3.radius = 32;
    self setneargoalnotifydist(32);
    self setvehgoalpos(var_25e662d3.origin, 1);
    self waittill(#"goal");
    self delete();
    self notify(#"deleted");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_59a7e387
// Checksum 0x96ac68e8, Offset: 0x1bb8
// Size: 0x76
function function_59a7e387() {
    level endon(#"hash_4af9ae51");
    while (true) {
        soldier = self spawner::spawn();
        if (isdefined(soldier)) {
            soldier waittill(#"death");
        } else {
            wait(0.05);
        }
        self.count = 1;
        wait(3);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_b63b8588
// Checksum 0xef398114, Offset: 0x1c38
// Size: 0x34
function function_b63b8588() {
    thread function_f0eb736e();
    thread function_16f0ef2b();
    thread function_44f51c2d();
}

// Namespace namespace_4a128b5f
// Params 1, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_44e145d1
// Checksum 0xe4e4241b, Offset: 0x1c78
// Size: 0x2d4
function function_44e145d1(var_e413e785) {
    sm = "spawn_manager_egyptian_defend1";
    var_ad81c50c = "spawn_manager_hack_zone03_1";
    array::thread_all(getentarray("egyptian_spawner_01", "targetname"), &spawner::add_spawn_function, &function_2f71981c);
    callback::on_ai_damage(&function_40cfc8f4);
    thread function_5433cddd();
    spawner::add_global_spawn_function("axis", &function_18de558f);
    wait(3);
    thread function_caae752c();
    util::function_d8eaed3d(5);
    spawn_manager::enable(sm);
    spawn_manager::enable(var_ad81c50c);
    level flag::wait_till(var_e413e785);
    spawn_manager::disable(sm);
    spawn_manager::disable(var_ad81c50c);
    callback::remove_on_ai_damage(&function_40cfc8f4);
    level flag::set("hack_zone03_1_finished");
    wait(5);
    var_7ead86e5 = spawn_manager::function_423eae50(sm);
    var_7c0a3add = spawn_manager::function_423eae50(var_ad81c50c);
    var_7ead86e5 = arraycombine(var_7ead86e5, var_7c0a3add, 0, 0);
    var_7ead86e5 = arraycombine(var_7ead86e5, level.var_79168bae, 0, 0);
    spawner::remove_global_spawn_function("axis", &function_18de558f);
    level waittill(#"hash_476bcf62");
    level flag::set("flag_force_off_dust");
    wait(3);
    array::thread_all(var_7ead86e5, &delete_me);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ce276271
// Checksum 0x2709e907, Offset: 0x1f58
// Size: 0x24
function delete_me() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_5433cddd
// Checksum 0xa23439d4, Offset: 0x1f88
// Size: 0xb4
function function_5433cddd() {
    t = getent("egyptian_defend_reached_trig", "targetname");
    if (isdefined(t)) {
        t triggerenable(1);
    }
    wait(20);
    if (!level flag::get("egyptian_defend_reached")) {
        level flag::set("egyptian_defend_reached");
    }
    if (isdefined(t)) {
        t triggerenable(0);
    }
}

// Namespace namespace_4a128b5f
// Params 1, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_40cfc8f4
// Checksum 0xa112cb9, Offset: 0x2048
// Size: 0x244
function function_40cfc8f4(params) {
    if (!level flag::get("egyptian_defend_reached") && isplayer(params.eattacker)) {
        level flag::set("egyptian_defend_reached");
    } else if (!level flag::get("egyptian_defend_reached") && !isplayer(params.eattacker)) {
        return;
    }
    if (!isdefined(level.var_27aeb908)) {
        level.var_27aeb908 = 0;
        level.var_ff73cf2d = 0;
        level.var_103b592a = 0;
    }
    if (isplayer(params.eattacker) && isdefined(self.targetname) && self.targetname == "egyptian_spawner_01_ai") {
        level.var_27aeb908 += params.idamage;
        function_ccf5af95();
    }
    if (isplayer(params.eattacker) && isdefined(self.team) && self.team == "axis") {
        level.var_103b592a = 0;
    }
    if (isdefined(params.eattacker) && params.eattacker.team == "axis" && isdefined(self.targetname) && self.targetname == "egyptian_spawner_01_ai") {
        level.var_103b592a += 1;
        if (level.var_103b592a >= 7) {
            util::function_207f8667(%CP_MI_CAIRO_AQUIFER_KHALILKILLED, %CP_MI_CAIRO_AQUIFER_EGYPT_FAIL);
        }
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ccf5af95
// Checksum 0x943cf121, Offset: 0x2298
// Size: 0xb4
function function_ccf5af95() {
    if (!isdefined(level.var_26ee895f)) {
        level.var_26ee895f = 1;
        level.var_70c85b56 = [];
        array::add(level.var_70c85b56, "khal_friendly_fire_frien_0");
        array::add(level.var_70c85b56, "khal_watch_your_fire_you_0");
    }
    if (level.var_27aeb908 > level.var_26ee895f * 850) {
        level thread dialog::remote(level.var_70c85b56[level.var_26ee895f % 2]);
        level.var_26ee895f++;
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_caae752c
// Checksum 0x99ec1590, Offset: 0x2358
// Size: 0x4
function function_caae752c() {
    
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_2f71981c
// Checksum 0xc06c50ed, Offset: 0x2368
// Size: 0x28
function function_2f71981c() {
    self util::magic_bullet_shield();
    self.dontdropweapon = 1;
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f0eb736e
// Checksum 0x1c08d61a, Offset: 0x2398
// Size: 0x1fc
function function_f0eb736e() {
    thread function_bd9f11ed();
    thread function_254b71e5();
    vehicle::add_spawn_function("port_vtol1", &function_6c135aa8);
    vehicle::add_spawn_function("port_vtol2", &function_6c135aa8);
    vehicle::add_spawn_function("defend_1_2_hunter_1", &function_1c36248b);
    vehicle::add_spawn_function("defend_1_2_hunter_2", &function_1c36248b);
    var_4208e495 = getent("defend_1_2_hunter_1", "targetname");
    var_680b5efe = getent("defend_1_2_hunter_2", "targetname");
    var_f3ed94cd = "spawn_manager_hack_zone01_2_wave1";
    var_19f00f36 = "spawn_manager_hack_zone01_2_wave2";
    var_3ff2899f = "spawn_manager_hack_zone01_2_wave3";
    var_5d8f4916 = "trig_veh_hack1_2a";
    var_378ccead = "trig_veh_hack1_2b";
    thread function_e8e3d4b4("port", "destroy_defenses_completed", "exterior_hack_trig_left_1", "exterior_hack_trig_left_1_started", "exterior_hack_trig_left_1_finished", var_5d8f4916, var_378ccead, var_4208e495, var_680b5efe, var_f3ed94cd, var_19f00f36, var_3ff2899f, "exterior_hack_trig_left_1_finished", "pre_hack_01_2_volume", "aquifer_zone_1_left", "left_pad_volume");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_16f0ef2b
// Checksum 0x5ae86273, Offset: 0x25a0
// Size: 0x1ec
function function_16f0ef2b() {
    thread function_e3a18c56();
    vehicle::add_spawn_function("res_vtol1", &function_6c135aa8);
    vehicle::add_spawn_function("res_vtol2", &function_6c135aa8);
    vehicle::add_spawn_function("defend_1_1_hunter_1", &function_1c36248b);
    vehicle::add_spawn_function("defend_1_1_hunter_1", &function_1c36248b);
    var_6a43b028 = getent("defend_1_1_hunter_1", "targetname");
    var_dc4b1f63 = getent("defend_1_1_hunter_2", "targetname");
    var_9a9ac320 = "spawn_manager_hack_zone01_1_wave1";
    var_ca2325b = "spawn_manager_hack_zone01_1_wave2";
    var_e69fb7f2 = "spawn_manager_hack_zone01_1_wave3";
    var_5d8f4916 = "trig_veh_hack1_1a";
    var_378ccead = "trig_veh_hack1_1b";
    thread function_e8e3d4b4("residential", "destroy_defenses_completed", "exterior_hack_trig_right_1", "exterior_hack_trig_right_1_started", "exterior_hack_trig_right_1_finished", var_5d8f4916, var_378ccead, var_6a43b028, var_dc4b1f63, var_9a9ac320, var_ca2325b, var_e69fb7f2, "exterior_hack_trig_right_1_finished", "hack_01_1_volume", "aquifer_zone_1_right", "right_pad_volume");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_254b71e5
// Checksum 0xe07bd2fe, Offset: 0x2798
// Size: 0x24
function function_254b71e5() {
    level flag::wait_till("flag_port_land_enemy_shift1");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_6c135aa8
// Checksum 0xfd4ed0aa, Offset: 0x27c8
// Size: 0x1c
function function_6c135aa8() {
    target_set(self);
}

// Namespace namespace_4a128b5f
// Params 16, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_e8e3d4b4
// Checksum 0xbbf6f8fd, Offset: 0x27f0
// Size: 0x2ec
function function_e8e3d4b4(zone, flag, var_3ab33977, var_b96ae653, var_57b589ae, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6, var_e413e785, var_2b2ece93, var_735cecc8, var_7b82a236) {
    level flag::wait_till(flag);
    var_9ff423eb = getent(var_3ab33977, "targetname");
    var_9ff423eb triggerenable(1);
    var_ee69678 = getent(var_2b2ece93, "targetname");
    var_2d7c1aa2 = getent(var_735cecc8, "targetname");
    guys = getaiteamarray("axis");
    foreach (guy in guys) {
        if (isdefined(guy)) {
            if (guy istouching(var_2d7c1aa2)) {
                thread function_3b8a6405(guy, var_ee69678);
            }
        }
    }
    level flag::wait_till(var_b96ae653);
    thread function_1a2672d9(zone);
    thread function_346a6ba8(zone, var_9ff423eb, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6);
    level flag::wait_till(var_57b589ae);
    if (zone == "port") {
        level notify(#"hash_c8354b43");
    }
    if (zone == "residential") {
        level notify(#"hash_952639a0");
    }
    thread function_ecb1c055(var_735cecc8, var_7b82a236);
}

// Namespace namespace_4a128b5f
// Params 1, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_1a2672d9
// Checksum 0xf150b1d3, Offset: 0x2ae8
// Size: 0x7a4
function function_1a2672d9(zone) {
    if (zone == "port") {
        org = getent("kayne_hacking_left", "targetname");
        wait(30);
        exploder::exploder("hack01_stage01");
        org playloopsound("evt_tower_sparks_lyr_01");
        wait(10);
        exploder::exploder("hack01_stage02");
        org playloopsound("evt_tower_sparks_lyr_02");
        wait(10);
        exploder::exploder("hack01_stage03");
        org playloopsound("evt_tower_sparks_lyr_03");
        wait(10);
        exploder::exploder("hack01_stage04");
        org playloopsound("evt_tower_sparks_lyr_04");
        playsoundatposition("evt_tower_overload", org.origin);
        wait(10);
        exploder::exploder("hack01_stage05");
        foreach (player in level.players) {
            playsoundatposition("evt_exp_electrical", org.origin);
            player playrumbleonentity("tank_damage_heavy_mp");
            earthquake(0.35, 0.5, player.origin, 325);
        }
        wait(5);
        foreach (player in level.players) {
            playsoundatposition("evt_exp_electrical", org.origin);
            player playrumbleonentity("tank_damage_heavy_mp");
            earthquake(0.75, 0.7, player.origin, 325);
        }
        org stoploopsound(0.1);
        exploder::exploder_stop("hack01_stage01");
        exploder::exploder_stop("hack01_stage02");
        exploder::exploder_stop("hack01_stage03");
        exploder::exploder_stop("hack01_stage04");
    }
    if (zone == "residential") {
        org = getent("kayne_hacking_right", "targetname");
        wait(30);
        exploder::exploder("hack02_stage01");
        org playloopsound("evt_tower_sparks_lyr_01");
        wait(10);
        exploder::exploder("hack02_stage02");
        org playloopsound("evt_tower_sparks_lyr_02");
        wait(10);
        exploder::exploder("hack02_stage03");
        org playloopsound("evt_tower_sparks_lyr_03");
        wait(10);
        exploder::exploder("hack02_stage04");
        org playloopsound("evt_tower_sparks_lyr_04");
        playsoundatposition("evt_tower_overload", org.origin);
        wait(10);
        exploder::exploder("hack02_stage05");
        foreach (player in level.players) {
            playsoundatposition("evt_exp_electrical", org.origin);
            player playrumbleonentity("tank_damage_heavy_mp");
            earthquake(0.45, 0.5, player.origin, 325);
        }
        wait(5);
        foreach (player in level.players) {
            playsoundatposition("evt_exp_electrical", org.origin);
            player playrumbleonentity("tank_damage_heavy_mp");
            earthquake(0.8, 1, player.origin, 400);
        }
        org stoploopsound(0.1);
        exploder::exploder_stop("hack02_stage01");
        exploder::exploder_stop("hack02_stage02");
        exploder::exploder_stop("hack02_stage03");
        exploder::exploder_stop("hack02_stage04");
    }
}

// Namespace namespace_4a128b5f
// Params 9, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_346a6ba8
// Checksum 0x22656ada, Offset: 0x3298
// Size: 0x7c4
function function_346a6ba8(zone, var_9ff423eb, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6) {
    level endon(#"hash_2ba72bcb");
    if (zone == "residential") {
        level notify(#"hash_ac35b0bd");
        thread function_c8bb3155("vol_res_defend_kayne", "exterior_hack_trig_right_1_finished");
    }
    if (zone == "port") {
        level notify(#"hash_794b04e");
        thread function_c8bb3155("vol_port_defend_kayne", "exterior_hack_trig_left_1_finished");
    }
    if (isdefined(level.var_89ea8991)) {
        level.var_89ea8991 ai::set_ignoreall(1);
    }
    while (true) {
        wait(1);
        if (isdefined(var_9ff423eb) && isdefined(var_9ff423eb.var_a220f04a) && var_9ff423eb.var_a220f04a > 1) {
            if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991) && level.var_260a842b == 1) {
                savegame::checkpoint_save();
                thread function_810caddd();
            }
            spawn_manager::enable(var_35a5f3d4);
            wait(4);
            if (zone == "residential") {
                level.var_89ea8991 thread dialog::say("kane_multiple_contacts_r_0");
            }
            if (zone == "port") {
                level.var_89ea8991 thread dialog::say("kane_more_enemies_coming_0");
            }
            trigger::use(var_1543d260, "targetname");
            if (isdefined(var_82491bec) && level.players.size > 1 && function_a6748659()) {
                veh = vehicle::_vehicle_spawn(var_82491bec);
                veh thread vehicle::get_on_and_go_path(veh.target);
            }
            break;
        }
        wait(0.25);
    }
    while (true) {
        wait(1);
        if (isdefined(var_9ff423eb) && isdefined(var_9ff423eb.var_a220f04a) && var_9ff423eb.var_a220f04a > 30) {
            if (zone == "port") {
                level.var_89ea8991 dialog::say("kane_more_ground_troops_1");
                level.var_89ea8991 dialog::say("kane_watch_my_six_0");
            }
            wait(3);
            if (zone == "port") {
                thread function_ced14faf();
            }
            if (zone == "residential") {
                thread function_78d6fd02();
            }
            break;
        }
        wait(0.25);
    }
    while (true) {
        if (isdefined(var_9ff423eb) && isdefined(var_9ff423eb.var_a220f04a) && var_9ff423eb.var_a220f04a > 50) {
            level notify(#"hash_213353eb");
            if (zone == "residential") {
                level.var_89ea8991 dialog::say("kane_good_job_keep_watch_1");
            }
            if (zone == "port") {
                level.var_89ea8991 dialog::say("kane_i_m_halfway_there_k_1");
            }
            spawn_manager::enable(var_a7ad630f);
            if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991) && level.var_260a842b == 1) {
                savegame::checkpoint_save();
                thread function_810caddd();
            }
            trigger::use(var_874b419b, "targetname");
            if (isdefined(var_f4508b27) && level.players.size > 2 && function_a6748659() && !isdefined(var_82491bec)) {
                veh = vehicle::_vehicle_spawn(var_f4508b27);
                veh thread vehicle::get_on_and_go_path(veh.target);
                level.var_89ea8991 dialog::say("kane_watch_out_for_drones_1");
            }
            wait(3);
            if (zone == "residential") {
                level.var_89ea8991 dialog::say("kane_tangos_above_us_dea_0");
            }
            if (zone == "port") {
                level dialog::remote("hend_look_out_they_re_dr_0");
            }
            break;
        }
        wait(0.25);
    }
    while (true) {
        if (isdefined(var_9ff423eb) && isdefined(var_9ff423eb.var_a220f04a) && var_9ff423eb.var_a220f04a > 65) {
            if (zone == "residential") {
                level.var_89ea8991 dialog::say("kane_getting_close_1");
            }
            if (zone == "port") {
                level.var_89ea8991 dialog::say("kane_almost_there_1");
            }
            spawn_manager::enable(var_81aae8a6);
            wait(2);
            if (zone == "residential") {
                level.var_89ea8991 dialog::say("kane_watch_out_for_drones_1");
            }
            break;
        }
        wait(0.25);
    }
    while (true) {
        if (isdefined(var_9ff423eb) && isdefined(var_9ff423eb.var_a220f04a) && var_9ff423eb.var_a220f04a > 85) {
            if (zone == "residential") {
                level.var_89ea8991 dialog::say("kane_nearly_done_1");
            }
            if (zone == "port") {
                level.var_89ea8991 dialog::say("kane_just_a_little_more_1");
            }
            break;
        }
        wait(0.25);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_810caddd
// Checksum 0x8157e5cf, Offset: 0x3a68
// Size: 0x44
function function_810caddd() {
    level flag::set("flag_aqu_save_state");
    wait(5);
    level flag::clear("flag_aqu_save_state");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_1c36248b
// Checksum 0x8465d8ec, Offset: 0x3ab8
// Size: 0x124
function function_1c36248b() {
    self endon(#"death");
    self setthreatbiasgroup("defend_hunters");
    self.var_d3f57f67 = 1;
    setignoremegroup("players_ground", "defend_hunters");
    while (function_a6748659()) {
        wait(0.5);
    }
    self ai::set_ignoreall(1);
    goalent = getent("zone01_hunter_goal", "targetname");
    self setneargoalnotifydist(32);
    self setvehgoalpos(goalent.origin, 1);
    self waittill(#"goal");
    self delete();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_a6748659
// Checksum 0x2554a924, Offset: 0x3be8
// Size: 0x94
function function_a6748659() {
    foreach (player in level.activeplayers) {
        if (player namespace_84eb777e::function_2ccd041c()) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_4a128b5f
// Params 2, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_c8bb3155
// Checksum 0xb650a79f, Offset: 0x3c88
// Size: 0x210
function function_c8bb3155(vol, flag) {
    level endon(#"hash_221e0b70");
    var_368eea5 = getent(vol, "targetname");
    thread function_5d498f22();
    var_e015a244 = 0;
    var_ac95a522 = 0;
    level.var_260a842b = 0;
    while (!flag::get(flag)) {
        if (!isalive(level.var_89ea8991)) {
            return;
        }
        if (util::any_player_is_touching(var_368eea5, "allies")) {
            var_ac95a522 = 0;
            level flag::clear("flag_kayne_vulnerable");
            if (!var_e015a244) {
                level.var_89ea8991 util::magic_bullet_shield();
                level notify(#"hash_78a213c8");
                var_e015a244 = 1;
                level.var_260a842b = 1;
            }
        } else if (!util::any_player_is_touching(var_368eea5, "allies")) {
            while (flag::get("flag_aqu_save_state")) {
                wait(0.25);
            }
            var_e015a244 = 0;
            if (!var_ac95a522) {
                level.var_89ea8991 thread function_f5a137d2();
                level.var_89ea8991 setthreatbiasgroup("players_vtol");
                var_ac95a522 = 1;
                level.var_260a842b = 0;
            }
            level flag::set("flag_kayne_vulnerable");
        }
        wait(0.5);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f5a137d2
// Checksum 0x8469f1c9, Offset: 0x3ea0
// Size: 0xdc
function function_f5a137d2() {
    level endon(#"hash_78a213c8");
    level endon(#"hash_221e0b70");
    level.var_89ea8991 util::stop_magic_bullet_shield();
    level.var_89ea8991.health = 999999;
    level thread function_2a977ecd();
    for (hit_count = 0; hit_count < 5; hit_count++) {
        self waittill(#"damage");
    }
    level notify(#"hash_2ba72bcb");
    level.var_89ea8991 ai::bloody_death();
    util::function_207f8667(%CP_MI_CAIRO_AQUIFER_KANEKILLED, %CP_MI_CAIRO_AQUIFER_PROTECT_FAIL);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_2a977ecd
// Checksum 0x326a86e1, Offset: 0x3f88
// Size: 0x44
function function_2a977ecd() {
    level notify(#"hash_b084268c");
    level endon(#"hash_b084268c");
    level waittill(#"hash_221e0b70");
    level.var_89ea8991 util::magic_bullet_shield();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_5d498f22
// Checksum 0xa1c73746, Offset: 0x3fd8
// Size: 0x11c
function function_5d498f22() {
    level endon(#"hash_221e0b70");
    level endon(#"hash_2ba72bcb");
    var_687c3dc4 = 0;
    var_a7254166 = [];
    var_a7254166[var_a7254166.size] = "kane_what_the_hell_are_yo_1";
    var_a7254166[var_a7254166.size] = "kane_where_are_you_going_1";
    var_a7254166[var_a7254166.size] = "kane_hey_watch_my_six_0";
    while (true) {
        while (level flag::get("flag_kayne_vulnerable")) {
            wait(1);
            var_69e9781d = array::random(var_a7254166);
            level.var_89ea8991 dialog::say(var_69e9781d);
            if (!var_687c3dc4) {
                level notify(#"hash_67e6e842");
            }
            var_687c3dc4 = 1;
            wait(3);
        }
        wait(0.75);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ced14faf
// Checksum 0xf908ea86, Offset: 0x4100
// Size: 0x132
function function_ced14faf() {
    var_2d7c1aa2 = getent("hack_01_2_volume", "targetname");
    var_5bb53a30 = getent("pre_hack_01_2_volume", "targetname");
    guys = getaiteamarray("axis");
    foreach (guy in guys) {
        if (guy istouching(var_2d7c1aa2)) {
            thread function_3b8a6405(guy, var_5bb53a30);
        }
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_78d6fd02
// Checksum 0xc91672a1, Offset: 0x4240
// Size: 0x132
function function_78d6fd02() {
    var_2d7c1aa2 = getent("hack_01_1_volume", "targetname");
    var_5bb53a30 = getent("hack_01_1_volume2", "targetname");
    guys = getaiteamarray("axis");
    foreach (guy in guys) {
        if (guy istouching(var_2d7c1aa2)) {
            thread function_3b8a6405(guy, var_5bb53a30);
        }
    }
}

// Namespace namespace_4a128b5f
// Params 3, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ecb1c055
// Checksum 0xef749045, Offset: 0x4380
// Size: 0x18a
function function_ecb1c055(var_4897ec9f, var_5bb53a30, var_64f17a00) {
    var_2d7c1aa2 = getent(var_4897ec9f, "targetname");
    a_vol = getent(var_5bb53a30, "targetname");
    guys = getaiteamarray("axis");
    foreach (guy in guys) {
        if (guy istouching(var_2d7c1aa2)) {
            if (isalive(guy)) {
                thread function_3b8a6405(guy, a_vol);
                if (isdefined(var_64f17a00) && var_64f17a00 == 1) {
                    thread function_10e80b01(guy, 2);
                }
            }
        }
    }
}

// Namespace namespace_4a128b5f
// Params 2, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_10e80b01
// Checksum 0x441adae3, Offset: 0x4518
// Size: 0x4c
function function_10e80b01(guy, delay) {
    wait(delay);
    if (isalive(guy)) {
        guy delete();
    }
}

// Namespace namespace_4a128b5f
// Params 7, eflags: 0x0
// namespace_4a128b5f<file_0>::function_1ce3cac0
// Checksum 0xdf6b7a77, Offset: 0x4570
// Size: 0x48a
function function_1ce3cac0(flag, var_b96ae653, var_3ab33977, var_82122952, var_e413e785, var_b96b1ea0, var_1acd98f5) {
    level flag::wait_till(flag);
    var_9ff423eb = getent(var_3ab33977, "targetname");
    var_9ff423eb triggerenable(1);
    spawn_manager::enable(var_82122952);
    level flag::wait_till(var_e413e785);
    spawn_manager::disable(var_82122952);
    vol = undefined;
    if (isdefined(var_b96b1ea0)) {
        vol = getent(var_b96b1ea0, "targetname");
    }
    if (isdefined(vol)) {
        var_bc67f3a7 = spawn_manager::function_423eae50(var_82122952);
        foreach (dude in var_bc67f3a7) {
            dude clearentitytarget();
            dude cleargoalvolume();
            dude clearforcedgoal();
            thread function_3b8a6405(dude, vol);
        }
    }
    if (isdefined(level.var_6657ee03) && isdefined(var_1acd98f5)) {
        if (var_1acd98f5 == "volume_egyptian_zone02_4") {
            ts = struct::get_array("egyptian_defenders_tele", "targetname");
            var_71dd83fd = 0;
            foreach (guy in level.var_6657ee03) {
                tries = 0;
                while (tries < 20) {
                    if (isalive(guy)) {
                        if (guy teleport(ts[var_71dd83fd].origin, ts[var_71dd83fd].angles)) {
                            break;
                        }
                    }
                    tries++;
                    wait(0.05);
                }
                var_71dd83fd++;
            }
        }
        vol = getent(var_1acd98f5, "targetname");
        if (isdefined(vol)) {
            foreach (dude in level.var_6657ee03) {
                if (isalive(dude)) {
                    dude clearentitytarget();
                    dude cleargoalvolume();
                    dude clearforcedgoal();
                    thread function_3b8a6405(dude, vol);
                }
            }
        }
    }
}

// Namespace namespace_4a128b5f
// Params 1, eflags: 0x0
// namespace_4a128b5f<file_0>::function_34ad69d9
// Checksum 0xf6d7ec0a, Offset: 0x4a08
// Size: 0x7c
function function_34ad69d9(trig) {
    t = getent(trig, "targetname");
    t waittill(#"trigger");
    if (isdefined(t.script_flag_set)) {
        level flag::set(t.script_flag_set);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ada56725
// Checksum 0x4ecf8a1d, Offset: 0x4a90
// Size: 0x16c
function function_ada56725() {
    struct = getent("kayne_hacking_right", "targetname");
    trig = getent("right_hack_use_trig", "targetname");
    activator = trig waittill(#"hash_ece70538");
    if (isdefined(level.var_11177797)) {
        level thread [[ level.var_11177797 ]]();
    }
    s_scenedef = struct::get_script_bundle("scene", "cin_aqu_01_20_towerright_1st_panelrip");
    if (isdefined(s_scenedef) && isdefined(s_scenedef.objects) && s_scenedef.objects.size > 0) {
        s_scenedef.objects[0].removeweapon = 1;
    }
    struct scene::play("cin_aqu_01_20_towerright_1st_panelrip", activator);
    level flag::set("flag_player_right_tower_done");
    thread function_ad2882a8();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_ad2882a8
// Checksum 0xef2686e3, Offset: 0x4c08
// Size: 0x202
function function_ad2882a8() {
    level endon(#"hash_2ba72bcb");
    struct = getent("kayne_hacking_right", "targetname");
    struct scene::play("cin_aqu_01_20_towerright_vign_overload_enter", level.var_89ea8991);
    level notify(#"hash_571aa0aa");
    struct thread scene::play("cin_aqu_01_20_towerright_vign_overload_main", level.var_89ea8991);
    level flag::wait_till("exterior_hack_trig_right_1_finished");
    level flag::clear("kayne_starts_overload");
    struct thread scene::play("cin_aqu_01_20_towerright_vign_overload_exit", level.var_89ea8991);
    if (!level flag::get("exterior_hack_trig_left_1_finished")) {
        level.var_89ea8991 dialog::say("kane_comms_down_let_s_ge_0");
        level thread function_36a1fd93();
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991) && !flag::get("flag_kayne_vulnerable")) {
        wait(0.05);
        level.var_89ea8991 util::magic_bullet_shield();
        savegame::checkpoint_save();
    }
    wait(0.25);
    if (isdefined(level.var_89ea8991)) {
        level.var_89ea8991 ai::set_ignoreall(0);
    }
    level notify(#"hash_221e0b70");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_36a1fd93
// Checksum 0x6449fb38, Offset: 0x4e18
// Size: 0x4c
function function_36a1fd93() {
    level dialog::remote("hend_we_ve_got_more_quad_0", 1);
    level dialog::remote("kane_on_our_way_0", 0.25);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f9e22dfc
// Checksum 0x6323038d, Offset: 0x4e70
// Size: 0xcc
function function_f9e22dfc() {
    struct = getent("kayne_hacking_left", "targetname");
    trig = getent("left_hack_use_trig", "targetname");
    activator = trig waittill(#"hash_ece70538");
    struct scene::play("cin_aqu_01_20_towerleft_1st_panelrip", activator);
    level flag::set("flag_player_left_tower_done");
    thread function_9b151b9b();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_9b151b9b
// Checksum 0xa68842de, Offset: 0x4f48
// Size: 0x202
function function_9b151b9b() {
    level endon(#"hash_2ba72bcb");
    struct = getent("kayne_hacking_left", "targetname");
    struct scene::play("cin_aqu_01_20_towerleft_vign_overload_enter", level.var_89ea8991);
    level notify(#"hash_571aa0aa");
    struct thread scene::play("cin_aqu_01_20_towerleft_vign_overload_main", level.var_89ea8991);
    level flag::wait_till("exterior_hack_trig_left_1_finished");
    level flag::clear("kayne_starts_overload");
    struct thread scene::play("cin_aqu_01_20_towerleft_vign_overload_exit", level.var_89ea8991);
    if (!level flag::get("exterior_hack_trig_right_1_finished")) {
        level.var_89ea8991 dialog::say("kane_enemy_comms_cut_we_0");
        level thread function_36a1fd93();
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991) && !flag::get("flag_kayne_vulnerable")) {
        wait(0.05);
        level.var_89ea8991 util::magic_bullet_shield();
        savegame::checkpoint_save();
    }
    wait(0.25);
    if (isdefined(level.var_89ea8991)) {
        level.var_89ea8991 ai::set_ignoreall(0);
    }
    level notify(#"hash_221e0b70");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_bd9f11ed
// Checksum 0x28e754a9, Offset: 0x5158
// Size: 0xd4
function function_bd9f11ed() {
    thread function_66aabab2("notify_defend_hack1_started", "flag_kayne_at_hack1");
    thread function_f9e22dfc();
    thread function_f250176e();
    landing_zone = -1;
    while (landing_zone != 1) {
        player, landing_zone = level waittill(#"hash_2e0c12cd");
    }
    level.var_89ea8991 = namespace_84eb777e::function_30343b22("kayne_hack1");
    wait(1);
    level flag::wait_till("finished_first_landing_vo");
    thread function_f83cec9b();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f250176e
// Checksum 0x9a744b52, Offset: 0x5238
// Size: 0x154
function function_f250176e() {
    level flag::wait_till("exterior_hack_trig_left_1_started");
    level notify(#"hash_79051ffd");
    level.var_89ea8991 dialog::say("kane_this_will_take_some_0", 1);
    level.var_89ea8991 dialog::say("kane_spread_out_don_t_ge_0", 4);
    wait(1);
    level flag::wait_till("exterior_hack_trig_left_1_finished");
    wait(1);
    spawn_manager::enable("spawn_manager_takeoff_port");
    trigger::use("kayne_colors_left_takeoff", "targetname");
    wait(1);
    landing_zone = -1;
    while (landing_zone != 1) {
        player, landing_zone = level waittill(#"hash_8d91bdcf");
    }
    if (isdefined(level.var_89ea8991) && level.var_1226dab0 == 0) {
        level.var_89ea8991 delete();
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f83cec9b
// Checksum 0x6cf46987, Offset: 0x5398
// Size: 0x5c
function function_f83cec9b() {
    level endon(#"hash_79051ffd");
    wait(5);
    level.var_89ea8991 dialog::say("kane_cover_to_cover_up_t_0");
    wait(3);
    level.var_89ea8991 dialog::say("kane_clean_up_remaining_t_0");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_e3a18c56
// Checksum 0x9ca85130, Offset: 0x5400
// Size: 0xd4
function function_e3a18c56() {
    thread function_66aabab2("notify_defend_hack2_started", "flag_kayne_at_hack2");
    thread function_ada56725();
    thread function_932a5979();
    landing_zone = -1;
    while (landing_zone != 2) {
        player, landing_zone = level waittill(#"hash_2e0c12cd");
    }
    level.var_89ea8991 = namespace_84eb777e::function_30343b22("kayne_hack2");
    wait(1);
    level flag::wait_till("finished_first_landing_vo");
    thread function_db00cade();
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_db00cade
// Checksum 0xa80e6cb3, Offset: 0x54e0
// Size: 0x84
function function_db00cade() {
    level endon(#"hash_bd6f4584");
    wait(3);
    level.var_89ea8991 dialog::say("kane_push_forward_0");
    wait(5);
    level.var_89ea8991 dialog::say("kane_get_moving_i_ll_cov_0");
    wait(8);
    level.var_89ea8991 dialog::say("kane_the_array_is_just_up_0");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_932a5979
// Checksum 0xc0542043, Offset: 0x5570
// Size: 0x124
function function_932a5979() {
    level flag::wait_till("exterior_hack_trig_right_1_started");
    level notify(#"hash_bd6f4584");
    level.var_89ea8991 dialog::say("kane_i_can_take_it_from_h_0", 1);
    level flag::wait_till("exterior_hack_trig_right_1_finished");
    wait(1);
    spawn_manager::enable("spawn_manager_takeoff_residential");
    trigger::use("kayne_colors_right_takeoff", "targetname");
    landing_zone = -1;
    while (landing_zone != 2) {
        player, landing_zone = level waittill(#"hash_8d91bdcf");
    }
    if (isdefined(level.var_89ea8991) && level.var_1226dab0 == 0) {
        level.var_89ea8991 delete();
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_44f51c2d
// Checksum 0x73db9126, Offset: 0x56a0
// Size: 0x5c
function function_44f51c2d() {
    level flag::wait_till_all(array("exterior_hack_trig_right_1_finished", "exterior_hack_trig_left_1_finished"));
    level.var_89ea8991 dialog::say("kane_mission_complete_le_0", 2);
}

// Namespace namespace_4a128b5f
// Params 2, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_66aabab2
// Checksum 0x12f88741, Offset: 0x5708
// Size: 0x266
function function_66aabab2(var_b031addf, flag) {
    level endon(var_b031addf);
    level flag::wait_till(flag);
    if (!isdefined(level.var_518d7942)) {
        level.var_518d7942 = [];
        if (!isdefined(level.var_518d7942)) {
            level.var_518d7942 = [];
        } else if (!isarray(level.var_518d7942)) {
            level.var_518d7942 = array(level.var_518d7942);
        }
        level.var_518d7942[level.var_518d7942.size] = "kane_boot_up_the_array_0";
        if (!isdefined(level.var_518d7942)) {
            level.var_518d7942 = [];
        } else if (!isarray(level.var_518d7942)) {
            level.var_518d7942 = array(level.var_518d7942);
        }
        level.var_518d7942[level.var_518d7942.size] = "kane_start_the_process_0";
        if (!isdefined(level.var_518d7942)) {
            level.var_518d7942 = [];
        } else if (!isarray(level.var_518d7942)) {
            level.var_518d7942 = array(level.var_518d7942);
        }
        level.var_518d7942[level.var_518d7942.size] = "kane_start_the_overload_p_0";
    }
    var_364c5984 = array(1, 8, 15);
    var_d44c15f4 = arraycopy(level.var_518d7942);
    for (x = 0; x < var_d44c15f4.size; x++) {
        wait(var_364c5984[x]);
        array::remove_index(level.var_518d7942, x);
        level.var_89ea8991 dialog::say(var_d44c15f4[x]);
    }
}

// Namespace namespace_4a128b5f
// Params 2, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_3b8a6405
// Checksum 0xcb32c3b6, Offset: 0x5978
// Size: 0xb4
function function_3b8a6405(dude, vol) {
    dude endon(#"death");
    dude clearentitytarget();
    dude cleargoalvolume();
    dude clearforcedgoal();
    dude ai::set_ignoreall(1);
    wait(0.05);
    dude setgoalvolume(vol);
    dude ai::set_ignoreall(0);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_5f0c85a2
// Checksum 0x8b41e4a2, Offset: 0x5a38
// Size: 0x84
function function_5f0c85a2() {
    thread function_f065e00e();
    thread function_790839b7();
    thread function_d123f7f2();
    thread function_36f5a1f4();
    thread function_4e5e42a9();
    thread function_5bda03b6();
    level flag::wait_till("flag_egyptian_hacking_completed");
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_f065e00e
// Checksum 0x9132a007, Offset: 0x5ac8
// Size: 0x6c
function function_f065e00e() {
    level flag::wait_till("destroy_defenses_completed");
    guys = spawner::get_ai_group_ai("dummy_runners_01");
    if (isdefined(guys)) {
        thread function_dd1c4e18(guys);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_2d0258ff
// Checksum 0x7121eaa5, Offset: 0x5b40
// Size: 0x4c
function function_2d0258ff() {
    var_b56f2b95 = spawner::get_ai_group_ai("zone01_rpgs");
    if (isdefined(var_b56f2b95)) {
        thread function_dd1c4e18(var_b56f2b95);
    }
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_790839b7
// Checksum 0xd6f76fde, Offset: 0x5b98
// Size: 0x7c
function function_790839b7() {
    landing_zone = -1;
    while (landing_zone != 1) {
        player, landing_zone = level waittill(#"hash_2e0c12cd");
    }
    var_e27965fa = spawn_manager::function_423eae50("spawn_manager_zone01b");
    thread function_dd1c4e18(var_e27965fa);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_d123f7f2
// Checksum 0xcacf66fe, Offset: 0x5c20
// Size: 0x7c
function function_d123f7f2() {
    landing_zone = -1;
    while (landing_zone != 2) {
        player, landing_zone = level waittill(#"hash_2e0c12cd");
    }
    var_e27965fa = spawn_manager::function_423eae50("spawn_manager_zone01");
    thread function_dd1c4e18(var_e27965fa);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_4e5e42a9
// Checksum 0x608a0a13, Offset: 0x5ca8
// Size: 0x184
function function_4e5e42a9() {
    level flag::wait_till("hack_terminal_left_completed");
    level waittill(#"hash_8d91bdcf");
    var_e27965fa = spawn_manager::function_423eae50("spawn_manager_zone01");
    thread function_dd1c4e18(var_e27965fa);
    var_bc76eb91 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave1");
    thread function_dd1c4e18(var_bc76eb91);
    var_96747128 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave2");
    thread function_dd1c4e18(var_96747128);
    var_a085ca07 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave3");
    thread function_dd1c4e18(var_a085ca07);
    var_7a834f9e = spawn_manager::function_423eae50("spawn_manager_land_port");
    thread function_dd1c4e18(var_7a834f9e);
    var_5480d535 = spawn_manager::function_423eae50("spawn_manager_takeoff_port");
    thread function_dd1c4e18(var_5480d535);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_36f5a1f4
// Checksum 0x2bd65750, Offset: 0x5e38
// Size: 0x184
function function_36f5a1f4() {
    level flag::wait_till("hack_terminal_right_completed");
    level waittill(#"hash_8d91bdcf");
    var_e27965fa = spawn_manager::function_423eae50("spawn_manager_zone01b");
    thread function_dd1c4e18(var_e27965fa);
    var_bc76eb91 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave1");
    thread function_dd1c4e18(var_bc76eb91);
    var_96747128 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave2");
    thread function_dd1c4e18(var_96747128);
    var_a085ca07 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave3");
    thread function_dd1c4e18(var_a085ca07);
    var_7a834f9e = spawn_manager::function_423eae50("spawn_manager_land_residential");
    thread function_dd1c4e18(var_7a834f9e);
    var_5480d535 = spawn_manager::function_423eae50("spawn_manager_takeoff_residential");
    thread function_dd1c4e18(var_5480d535);
}

// Namespace namespace_4a128b5f
// Params 0, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_5bda03b6
// Checksum 0x6edb2def, Offset: 0x5fc8
// Size: 0x27e
function function_5bda03b6() {
    level flag::wait_till_all(array("hack_terminal_right_completed", "hack_terminal_left_completed"));
    level waittill(#"hash_8d91bdcf");
    var_e27965fa = spawn_manager::function_423eae50("spawn_manager_zone01");
    thread function_dd1c4e18(var_e27965fa);
    var_bc76eb91 = spawn_manager::function_423eae50("spawn_manager_zone01");
    thread function_dd1c4e18(var_bc76eb91);
    var_96747128 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave1");
    thread function_dd1c4e18(var_96747128);
    var_a085ca07 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave2");
    thread function_dd1c4e18(var_a085ca07);
    var_7a834f9e = spawn_manager::function_423eae50("spawn_manager_hack_zone01_1_wave3");
    thread function_dd1c4e18(var_7a834f9e);
    var_5480d535 = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave1");
    thread function_dd1c4e18(var_5480d535);
    var_2e7e5acc = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave2");
    thread function_dd1c4e18(var_2e7e5acc);
    var_d8680d1b = spawn_manager::function_423eae50("spawn_manager_hack_zone01_2_wave3");
    thread function_dd1c4e18(var_d8680d1b);
    var_62fd3a = 4;
    for (i = 1; i <= var_62fd3a; i++) {
        var_1560b77d = spawner::get_ai_group_ai("enemy_vtol_riders_" + i);
        thread function_dd1c4e18(var_1560b77d);
    }
}

// Namespace namespace_4a128b5f
// Params 1, eflags: 0x1 linked
// namespace_4a128b5f<file_0>::function_dd1c4e18
// Checksum 0x499ed8a8, Offset: 0x6250
// Size: 0xaa
function function_dd1c4e18(guys) {
    wait(10);
    if (isdefined(guys)) {
        foreach (guy in guys) {
            if (isdefined(guy)) {
                guy kill();
            }
        }
    }
}

// Namespace namespace_4a128b5f
// Params 3, eflags: 0x0
// namespace_4a128b5f<file_0>::function_c836830
// Checksum 0xef469558, Offset: 0x6308
// Size: 0x1f2
function function_c836830(var_1b052e61, wait_flag, waves) {
    level flag::wait_till(wait_flag);
    var_11d8734e = 2;
    z = 1;
    if (var_1b052e61 == 2) {
        var_11d8734e = 6;
        z = 4;
    }
    guys = [];
    guys = spawn_manager::function_423eae50("spawn_manager_zone0" + var_1b052e61);
    while (z <= var_11d8734e) {
        sm = "spawn_manager_hack_zone0" + var_1b052e61 + "_" + z;
        guys = arraycombine(guys, spawn_manager::function_423eae50(sm), 0, 0);
        spawn_manager::kill(sm);
        z++;
    }
    spawn_manager::kill("spawn_manager_zone0" + var_1b052e61, 1);
    wait(10);
    foreach (guy in guys) {
        if (isdefined(guy)) {
            guy delete();
        }
    }
}

