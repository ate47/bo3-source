#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/cp_mi_sing_vengeance_dogleg_1;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_dev;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_62b73aed;

// Namespace namespace_62b73aed
// Params 2, eflags: 0x1 linked
// Checksum 0x7d1e695d, Offset: 0x17e8
// Size: 0x1a4
function function_5b3d7d44(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level thread namespace_63b4601c::function_e3420328("killing_streets_ambient_anims", "dogleg_1_begin");
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        level thread function_9736d8c9();
        level thread function_8704e5f();
        load::function_a2995f22();
        videostop("cp_vengeance_env_sign_dancer01");
        wait(0.05);
        level thread namespace_63b4601c::function_ab876b5a("cp_vengeance_env_sign_dancer01", "strip_video_start", "strip_video_end");
        wait(0.05);
        level notify(#"hash_96cd3d20");
    }
    namespace_63b4601c::function_4e8207e9("killing_streets");
    thread namespace_7c587e3e::function_749aad88();
    function_fedc3ede(str_objective);
}

// Namespace namespace_62b73aed
// Params 1, eflags: 0x1 linked
// Checksum 0xbfa0905f, Offset: 0x1998
// Size: 0x29c
function function_fedc3ede(str_objective) {
    level flag::set("killing_streets_begin");
    exploder::exploder("killing_streets_butcher_fx");
    spawner::add_spawn_function_group("killing_streets_civilian_spawners", "script_noteworthy", &function_580091b4);
    level.var_2fd26037 thread function_acf87132();
    level.var_2fd26037 thread function_c5a187ba();
    level thread function_4b7aea65();
    level thread function_ef12791();
    level.var_b40baa9d = struct::get("lineup_kill_doors_scripted_node", "targetname");
    level.var_ecc18bcf = struct::get("lineup_kill_scripted_node", "targetname");
    level.var_b40baa9d thread scene::init("cin_ven_03_20_storelineup_vign_start_doors_only");
    level.var_b40baa9d thread scene::init("cin_ven_03_20_storelineup_vign_exit");
    level.var_5abaf57 = struct::get("dogleg_1_intro_org");
    s_scene = level.var_3f831f3b["scene"]["cin_ven_04_10_cafedoor_1st_sh010"];
    s_scene.objects[0].entitylerptime = 0.5;
    s_scene.objects[1].cameratween = 0.2;
    s_scene.objects[1].lerptime = 0.2;
    level.var_5abaf57 scene::init("cin_ven_04_10_cafedoor_1st_sh010");
    level thread function_71a7056();
    level thread function_999f0273();
    level thread function_9f0122b9();
    level thread function_28fa297f();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xd30b3bff, Offset: 0x1c40
// Size: 0x274
function function_acf87132() {
    level endon(#"stealth_combat");
    level endon(#"hash_5411235");
    level endon(#"hash_a3f6cd68");
    self endon(#"death");
    self.holdfire = 1;
    self.ignoreall = 0;
    self.ignoreme = 1;
    self colors::disable();
    self ai::set_behavior_attribute("cqb", 1);
    self.goalradius = 32;
    self battlechatter::function_d9f49fba(0);
    node = getnode("killing_streets_hendricks_node_03", "targetname");
    self setgoal(node, 1, 16);
    if (!level flag::get("move_killing_streets_hendricks_node_05")) {
        level flag::wait_till("move_killing_streets_hendricks_node_05");
    }
    node = getnode("killing_streets_hendricks_node_05", "targetname");
    self setgoal(node, 1, 16);
    if (!level flag::get("move_killing_streets_hendricks_node_10") || !level flag::get("killing_streets_civilian_sniped")) {
        level flag::wait_till_all(array("move_killing_streets_hendricks_node_10", "killing_streets_civilian_sniped"));
    }
    node = getnode("killing_streets_hendricks_node_10", "targetname");
    self setgoal(node, 1, 16);
    self waittill(#"goal");
    wait(7);
    level flag::set("hendricks_break_ally_stealth");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x66bcfff1, Offset: 0x1ec0
// Size: 0x1cc
function function_c5a187ba() {
    level flag::wait_till_any(array("stealth_alert", "stealth_combat", "killing_streets_intro_patroller_spawners_cleared", "cin_ven_03_15_killingstreets_vign_done", "hendricks_break_ally_stealth"));
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.1;
    self.ignoreme = 0;
    self.holdfire = 0;
    self ai::set_behavior_attribute("cqb", 0);
    self colors::enable();
    level flag::wait_till("killing_streets_intro_patroller_spawners_cleared");
    level flag::clear("stealth_discovered");
    self colors::disable();
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.holdfire = 1;
    self battlechatter::function_d9f49fba(0);
    self.script_accuracy = self.var_df53bc6;
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("sprint", 0);
    stealth::reset();
    wait(0.05);
    self thread function_9680df4e();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xcf63661f, Offset: 0x2098
// Size: 0x21c
function function_9736d8c9() {
    var_315c2d41 = spawner::simple_spawn("killing_streets_intro_sniper_spawner", &namespace_63b4601c::function_b62b56ba);
    level.var_abd93cb3 = var_315c2d41[0];
    level.var_abd93cb3 thread function_68661375();
    scene::add_scene_func("cin_ven_03_15_killingstreets_vign_snipershot", &function_286754f2, "done");
    var_bba8f947 = struct::get("lineup_kill_doors_scripted_node");
    var_bba8f947 thread scene::init("cin_ven_03_15_killingstreets_vign_snipershot");
    level flag::wait_till("start_killing_streets_sniper_shoots_civilian");
    playsoundatposition("mus_alley_stinger", (0, 0, 0));
    util::clientnotify("sndLRstart");
    var_bba8f947 thread scene::play("cin_ven_03_15_killingstreets_vign_snipershot");
    thread namespace_7c587e3e::function_68da61d9();
    wait(0.1);
    while (true) {
        guy = getent("killing_streets_alley_civ_a_ai", "targetname");
        if (isdefined(guy)) {
            break;
        }
        wait(0.05);
    }
    guy.perfectaim = 1;
    guy laseron();
    guy endon(#"death");
    guy waittill(#"sniper_fire");
    level.var_abd93cb3 notify(#"hash_55f87e20");
    guy animation::fire_weapon();
}

// Namespace namespace_62b73aed
// Params 1, eflags: 0x1 linked
// Checksum 0x75edbb98, Offset: 0x22c0
// Size: 0x2c
function function_286754f2(a_ents) {
    level flag::set("killing_streets_civilian_sniped");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xd3c3dcf2, Offset: 0x22f8
// Size: 0x75c
function function_9680df4e() {
    level endon(#"hash_f4ce1009");
    self endon(#"death");
    self thread function_a66391e6();
    level flag::set("move_hendricks_to_meat_market");
    var_6e87e729 = struct::get("hendricks_open_alley_door_01_gather_org");
    objectives::set("cp_waypoint_breadcrumb", var_6e87e729);
    var_a392d7f9 = getnode("hendricks_pre_butcher_node", "targetname");
    self setgoal(var_a392d7f9, 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("cqb", 0);
    self ai::set_behavior_attribute("forceTacticalWalk", 1);
    var_a392d7f9 = getnode("hendricks_pre_butcher_node_2", "targetname");
    self setgoal(var_a392d7f9, 1);
    self waittill(#"goal");
    level.var_ecc18bcf scene::init("cin_ven_03_20_storelineup_vign_start_hendricks_only");
    level flag::set("enable_hendricks_open_alley_door_01");
    self waittill(#"reach_done");
    level thread function_96d0d9ff();
    level flag::wait_till("start_hendricks_open_alley_door_01");
    if (isdefined(level.var_a923dc3b)) {
        level thread [[ level.var_a923dc3b ]]();
    }
    savegame::checkpoint_save();
    objectives::complete("cp_waypoint_breadcrumb", var_6e87e729);
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    self ai::set_behavior_attribute("forceTacticalWalk", 0);
    self ai::set_behavior_attribute("cqb", 1);
    level thread function_e84a45c2();
    spawner::add_spawn_function_group("killing_streets_lineup_patroller_spawners", "script_noteworthy", &function_ae4ad020);
    spawner::add_spawn_function_group("killing_streets_lineup_civilian_spawners", "script_noteworthy", &function_b9d0c862);
    var_6177e956 = getent("storelineup_door1_clip", "targetname");
    var_6177e956 thread function_6177e956();
    level thread function_18420eba();
    level thread function_ae1a0f7a();
    level waittill(#"hash_ef7d820");
    if (!level flag::get("move_killing_streets_hendricks_node_30")) {
        level flag::wait_till("move_killing_streets_hendricks_node_30");
    }
    level flag::set("hendricks_says_stay_down");
    level.var_ecc18bcf scene::play("cin_ven_03_20_storelineup_vign_move1");
    if (!level flag::get("move_killing_streets_hendricks_node_35")) {
        level flag::wait_till("move_killing_streets_hendricks_node_35");
    }
    level.var_ecc18bcf scene::play("cin_ven_03_20_storelineup_vign_move2");
    if (!level flag::get("move_killing_streets_hendricks_node_40") && !level flag::get("cin_ven_03_20_storelineup_vign_fire_done")) {
        level flag::wait_till_all(array("move_killing_streets_hendricks_node_40", "cin_ven_03_20_storelineup_vign_fire_done"));
    }
    level.var_ecc18bcf scene::play("cin_ven_03_20_storelineup_vign_move3");
    level flag::set("enable_hendricks_open_alley_door_02");
    if (!level flag::get("start_hendricks_open_alley_door_02")) {
        level flag::wait_till("start_hendricks_open_alley_door_02");
    }
    savegame::checkpoint_save();
    var_600ff27c = getent("storelineup_door3_clip", "targetname");
    if (isdefined(var_600ff27c)) {
        var_600ff27c thread function_600ff27c();
    }
    level.var_b40baa9d thread scene::play("cin_ven_03_20_storelineup_vign_exit");
    wait(0.5);
    self clearforcedgoal();
    node = getnode("killing_streets_hendricks_node_55", "targetname");
    self setgoal(node, 1, 16);
    level waittill(#"hash_2b5b2f5d");
    level flag::set("hendricks_cleared_meat_market_door");
    level flag::wait_till("move_killing_streets_hendricks_node_57");
    node = getnode("killing_streets_hendricks_node_57", "targetname");
    self setgoal(node, 1, 16);
    level flag::wait_till("clear_killing_streets_breadcrumb_07");
    level.var_2fd26037 thread function_2adde689();
    node = getnode("killing_streets_hendricks_node_60", "targetname");
    self setgoal(node, 1, 16);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x723d61ef, Offset: 0x2a60
// Size: 0x394
function function_a66391e6() {
    level flag::wait_till("killing_streets_lineup_patrollers_alerted");
    wait(0.05);
    self stopanimscripted();
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.holdfire = 0;
    self battlechatter::function_d9f49fba(1);
    self ai::set_behavior_attribute("forceTacticalWalk", 0);
    self colors::enable();
    level flag::wait_till_all(array("killing_streets_lineup_patroller_spawners_cleared", "killing_streets_robots_cleared"));
    level flag::clear("stealth_discovered");
    self.ignoreme = 1;
    self.holdfire = 1;
    self battlechatter::function_d9f49fba(0);
    self ai::set_behavior_attribute("cqb", 1);
    self colors::disable();
    var_600ff27c = getent("storelineup_door3_clip", "targetname");
    if (isdefined(var_600ff27c)) {
        var_600ff27c thread function_600ff27c();
    }
    if (!level flag::get("hendricks_cleared_meat_market_door")) {
        level.var_b40baa9d thread scene::play("cin_ven_03_20_storelineup_vign_exit_reach");
        self waittill(#"reach_done");
        wait(0.5);
    }
    self clearforcedgoal();
    node = getnode("killing_streets_hendricks_node_55", "targetname");
    self setgoal(node, 1, 16);
    if (!level flag::get("hendricks_cleared_meat_market_door")) {
        level waittill(#"hash_2b5b2f5d");
    }
    level flag::wait_till("move_killing_streets_hendricks_node_57");
    node = getnode("killing_streets_hendricks_node_57", "targetname");
    self setgoal(node, 1, 16);
    level flag::wait_till("clear_killing_streets_breadcrumb_07");
    level.var_2fd26037 thread function_2adde689();
    node = getnode("killing_streets_hendricks_node_60", "targetname");
    self setgoal(node, 1, 16);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x337f0d0b, Offset: 0x2e00
// Size: 0xa4
function function_2adde689() {
    self endon(#"death");
    self ai::set_behavior_attribute("vignette_mode", "fast");
    self ai::set_behavior_attribute("coverIdleOnly", 1);
    level waittill(#"hash_f1a04aa0");
    self ai::set_behavior_attribute("vignette_mode", "off");
    self ai::set_behavior_attribute("coverIdleOnly", 0);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x407150fd, Offset: 0x2eb0
// Size: 0x8a
function function_96d0d9ff() {
    foreach (e_player in level.activeplayers) {
        e_player thread function_a39cd1bb();
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x78e6d71e, Offset: 0x2f48
// Size: 0x110
function function_a39cd1bb() {
    level endon(#"hash_f4ce1009");
    level endon(#"hash_f1a04aa0");
    self endon(#"disconnect");
    a_vol = getentarray("killing_streets_outside", "targetname");
    while (true) {
        foreach (e_vol in a_vol) {
            if (self istouching(e_vol)) {
                self.ignoreme = 1;
                continue;
            }
            self.ignoreme = 0;
        }
        wait(0.05);
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x9bcc7645, Offset: 0x3060
// Size: 0x392
function function_18420eba() {
    level endon(#"hash_f4ce1009");
    level thread function_fd81381e("execution_blood_spray_lt", "lineup_civ_1_killed", "lineup_kill_decal_lt_window_broken");
    level thread function_fd81381e("execution_blood_spray_rt", "lineup_civ_2_killed", "lineup_kill_decal_rt_window_broken");
    level thread function_d864c642();
    level.var_ecc18bcf thread scene::init("cin_ven_03_20_storelineup_vign_fire");
    level.var_b40baa9d thread scene::play("cin_ven_03_20_storelineup_vign_start_doors_only");
    level.var_ecc18bcf scene::play("cin_ven_03_20_storelineup_vign_start_hendricks_only");
    level notify(#"hash_ef7d820");
    level flag::wait_till("start_lineup_kill_execution");
    level.var_ecc18bcf scene::play("cin_ven_03_20_storelineup_vign_fire");
    level flag::set("cin_ven_03_20_storelineup_vign_fire_done");
    node = getnode("killing_streets_lineup_patroller_spawners_exit_node", "targetname");
    guys = getentarray("killing_streets_robots", "script_noteworthy", 1);
    foreach (guy in guys) {
        if (isdefined(guy) && isalive(guy)) {
            if (isdefined(guy.script_delay)) {
                guy thread util::_delay(guy.script_delay, undefined, &namespace_63b4601c::function_3d5f97bd, node, undefined, 1, 1024);
                continue;
            }
            guy thread namespace_63b4601c::function_3d5f97bd(node, undefined, 1, 1024);
        }
    }
    wait(15);
    guys = getentarray("killing_streets_lineup_patroller_spawners", "script_noteworthy", 1);
    foreach (guy in guys) {
        if (isdefined(guy) && isalive(guy)) {
            guy thread namespace_63b4601c::function_3d5f97bd(node, undefined, 1, 1024);
        }
    }
}

// Namespace namespace_62b73aed
// Params 3, eflags: 0x1 linked
// Checksum 0x59360835, Offset: 0x3400
// Size: 0xf4
function function_fd81381e(var_210e7715, var_a9d6b8b7, var_734ef62a) {
    var_f644fb29 = getent(var_210e7715, "targetname");
    var_f644fb29 clientfield::set("normal_hide", 1);
    var_f644fb29 notsolid();
    level waittill(var_a9d6b8b7);
    if (!level flag::get(var_734ef62a)) {
        var_f644fb29 clientfield::set("mature_hide", 1);
    }
    level flag::wait_till(var_734ef62a);
    var_f644fb29 delete();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x345b31dd, Offset: 0x3500
// Size: 0x84
function function_d864c642() {
    level flag::wait_till_any(array("killing_streets_lineup_patrollers_alerted", "lineup_kill_window_broken"));
    var_f4835685 = getent("storelineup_window_clip", "targetname");
    if (isdefined(var_f4835685)) {
        var_f4835685 delete();
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x17e2c61d, Offset: 0x3590
// Size: 0x3c
function function_ae1a0f7a() {
    level flag::wait_till("killing_streets_lineup_patrollers_alerted");
    level.var_ecc18bcf scene::stop();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xcbc0f675, Offset: 0x35d8
// Size: 0x5c
function function_6177e956() {
    wait(2);
    self notsolid();
    self connectpaths();
    wait(1);
    self delete();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xed1683fd, Offset: 0x3640
// Size: 0x3c
function function_600ff27c() {
    wait(0.75);
    self notsolid();
    self connectpaths();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xf76c7f99, Offset: 0x3688
// Size: 0x174
function function_8704e5f() {
    spawner::add_spawn_function_group("killing_streets_intro_patroller_spawners", "script_noteworthy", &function_a45594e6);
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "killing_streets_alley_civ_b";
    var_6a07eb6c[1] = "killing_streets_alley_rope";
    scene::add_scene_func("cin_ven_03_15_killingstreets_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    scene::add_scene_func("cin_ven_03_15_killingstreets_vign_loop", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    var_a9e0b15b = struct::get("lineup_kill_doors_scripted_node");
    var_a9e0b15b scene::init("cin_ven_03_15_killingstreets_vign");
    if (!level flag::get("move_killing_streets_hendricks_node_15")) {
        level flag::wait_till("move_killing_streets_hendricks_node_15");
    }
    var_a9e0b15b scene::play("cin_ven_03_15_killingstreets_vign");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x8c5556b4, Offset: 0x3808
// Size: 0x1fa
function function_a45594e6() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    setdvar("ai_awarenessEnabled", 0);
    self thread function_53a6540a();
    if (!level flag::get("move_killing_streets_hendricks_node_15")) {
        level flag::wait_till("move_killing_streets_hendricks_node_15");
    }
    self ai::set_ignoreall(0);
    setdvar("ai_awarenessEnabled", 1);
    while (true) {
        eventname = self util::waittill_any_return("killing_streets_intro_alerted", "scene_done", "done_shooting_civilian");
        if (eventname == "done_shooting_civilian") {
            self ai::set_ignoreme(0);
            continue;
        }
        level flag::set("cin_ven_03_15_killingstreets_vign_done");
        var_c3b293c9 = getent("killing_streets_enemy_gv", "targetname");
        if (isdefined(var_c3b293c9)) {
            if (isdefined(self.var_30dac0b5) && self.var_30dac0b5) {
                self waittill(#"hash_45b11ba2");
                self.var_30dac0b5 = undefined;
            }
            wait(0.05);
            self setgoal(var_c3b293c9);
        }
        return;
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x5eeaa6b6, Offset: 0x3a10
// Size: 0x74
function function_68661375() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self waittill(#"hash_55f87e20");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x25e7c3b8, Offset: 0x3a90
// Size: 0xb6
function function_53a6540a() {
    self endon(#"death");
    self waittill(#"alert");
    self notify(#"hash_30dac0b5");
    level.var_abd93cb3 notify(#"hash_55f87e20");
    level.var_abd93cb3 stealth::stop();
    if (isdefined(self.script_parameters)) {
        self stealth::stop();
        self.var_30dac0b5 = 1;
        self scene::play(self.script_parameters);
        self waittill(#"scene_done");
        self notify(#"hash_45b11ba2");
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x4692d38, Offset: 0x3b50
// Size: 0x124
function function_580091b4() {
    self endon(#"death");
    self.team = "allies";
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self.health = 1;
    if (self.targetname == "killing_streets_alley_civ_a_ai") {
        self.civilian = 1;
        self ai::set_behavior_attribute("panic", 0);
    }
    if (isdefined(self.target)) {
        node = getnode(self.target, "targetname");
        self thread ai::force_goal(node, node.radius);
    }
    level waittill(#"hash_f4c7c788");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xf1539999, Offset: 0x3c80
// Size: 0xec
function function_b9d0c862() {
    self endon(#"death");
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme(1);
    self ai::set_behavior_attribute("panic", 0);
    self thread function_cfede1cf();
    level flag::wait_till("killing_streets_lineup_patrollers_alerted");
    self stopanimscripted();
    self ai::set_ignoreme(0);
    self ai::set_behavior_attribute("panic", 1);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xc47756b, Offset: 0x3d78
// Size: 0x54
function function_cfede1cf() {
    self endon(#"death");
    self waittill(#"hash_bc04f3c2");
    self.takedamage = 1;
    self.skipdeath = 1;
    self.allowdeath = 1;
    self kill();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xa8a96cf8, Offset: 0x3dd8
// Size: 0xcc
function function_ae4ad020() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self util::waittill_any("damage", "alert");
    self ai::set_ignoreme(0);
    level flag::set("killing_streets_lineup_patrollers_alerted");
    util::clientnotify("sndLRstop");
    level thread namespace_9fd035::function_6c2fa1d0();
    self stopanimscripted();
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x8bee243c, Offset: 0x3eb0
// Size: 0x38
function function_e84a45c2() {
    var_e84a45c2 = spawner::simple_spawn("killing_streets_robots", undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

// Namespace namespace_62b73aed
// Params 4, eflags: 0x1 linked
// Checksum 0x9e240d64, Offset: 0x3ef0
// Size: 0x694
function function_e416ac3a(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("killing_streets_end");
    level function_9e5f73db();
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("play_client_igc", 2);
    }
    namespace_63b4601c::function_e00864bd("dogleg_1_umbra_gate", 1, "dogleg_1_gate");
    level struct::function_368120a1("scene", "cin_ven_02_20_synckill_vign");
    level struct::function_368120a1("scene", "cin_ven_02_30_masterbedroom_vign");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ03");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ06");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ08");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_intro_1st");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_intro_1st_props");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_1st");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_1st_props");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_intro_1st_test");
    level struct::function_368120a1("scene", "cin_ven_01_02_rooftop_1st_overlook");
    level struct::function_368120a1("scene", "cin_ven_03_10_takedown_1st_hendricks");
    level struct::function_368120a1("scene", "cin_ven_03_11_gate_convo_vign");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_snipershot");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_loop");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_react_enemy_a");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_react_enemy_b");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_react_enemy_c");
    level struct::function_368120a1("scene", "cin_ven_03_15_killingstreets_vign_react_enemy_d");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_start_hendricks_only");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_move1");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_move2");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_move3");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_fire");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_loop");
    level struct::function_368120a1("scene", "cin_gen_f_floor_onfront_armdown_legstraight_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_m_floor_armup_legaskew_onfront_faceright_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_f_floor_onfront_armup_legstraight_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_f_floor_onleftside_armcurled_legcurled_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_m_wall_headonly_leanleft_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_m_floor_armstomach_onback_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_f_floor_onback_armup_legcurled_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_m_floor_armstretched_onrightside_deathpose_civ_sing");
    level struct::function_368120a1("scene", "cin_gen_m_armover_onrightside_deathpose_civ_sing");
    namespace_63b4601c::function_4e8207e9("killing_streets", 0);
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x34d26997, Offset: 0x4590
// Size: 0xc2
function function_9e5f73db() {
    array::thread_all(getentarray("killing_streets_lineup_patroller_spawners", "script_noteworthy"), &util::self_delete);
    array::thread_all(getentarray("killing_streets_robots", "targetname"), &util::self_delete);
    exploder::exploder_stop("killing_streets_butcher_fx");
    level notify(#"hash_85ae1ef3");
    wait(0.05);
    level notify(#"hash_92bd0e81");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xc7544b2b, Offset: 0x4660
// Size: 0x2e4
function function_ef12791() {
    level waittill(#"hash_2b5b2f5d");
    var_655205bf = struct::get("dogleg_1_intro_goto_obj_org", "targetname");
    objectives::show("cp_level_vengeance_go_to_safehouse");
    objectives::set("cp_waypoint_breadcrumb", var_655205bf);
    var_131d0575 = getent("dogleg_1_intro_trigger", "script_noteworthy");
    var_131d0575 triggerenable(0);
    level thread util::function_d8eaed3d(3);
    msg = level util::waittill_any_return("dogleg_1_intro_goto_trigger_touched", "stealth_discovered");
    if (msg == "stealth_discovered") {
        objectives::hide("cp_waypoint_breadcrumb");
        if (level flag::get("stealth_discovered")) {
            level flag::wait_till_clear("stealth_discovered");
        }
        objectives::show("cp_waypoint_breadcrumb");
        level flag::wait_till("dogleg_1_intro_goto_trigger_touched");
    }
    objectives::complete("cp_waypoint_breadcrumb", var_655205bf);
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    var_131d0575 triggerenable(1);
    var_ca0e9b65 = util::function_14518e76(var_131d0575, %cp_prompt_enter_ven_door, %CP_MI_SING_VENGEANCE_HINT_OPEN, &function_88762207);
    objectives::set("cp_level_vengeance_open_dogleg_1_menu");
    level thread namespace_63b4601c::function_8a63fd6b(var_131d0575, undefined, "cp_level_vengeance_open_dogleg_1_menu", "start_dogleg_1_intro", undefined, var_ca0e9b65);
    level waittill(#"hash_f1a04aa0");
    var_ca0e9b65 gameobjects::disable_object();
    objectives::hide("cp_level_vengeance_open_dogleg_1_menu");
    wait(0.1);
    skipto::function_be8adfb8("killing_streets");
}

// Namespace namespace_62b73aed
// Params 1, eflags: 0x1 linked
// Checksum 0x1f36a5db, Offset: 0x4950
// Size: 0x28
function function_88762207(e_player) {
    level notify(#"hash_f1a04aa0");
    level.var_4c62d05f = e_player;
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x2ab140de, Offset: 0x4980
// Size: 0x17c
function function_4b7aea65() {
    wait(0.05);
    level.var_29304913 = struct::get("killing_streets_breadcrumb_01");
    objectives::set("cp_waypoint_breadcrumb", level.var_29304913);
    level flag::wait_till("move_killing_streets_hendricks_node_05");
    objectives::complete("cp_waypoint_breadcrumb", level.var_29304913);
    level flag::wait_till("start_hendricks_open_alley_door_01");
    level thread function_ff499dd5();
    level flag::wait_till("hendricks_cleared_meat_market_door");
    if (!flag::get("clear_killing_streets_breadcrumb_06")) {
        level.var_29304913 = struct::get("killing_streets_breadcrumb_06");
        objectives::set("cp_waypoint_breadcrumb", level.var_29304913);
        level flag::wait_till("clear_killing_streets_breadcrumb_06");
        objectives::complete("cp_waypoint_breadcrumb", level.var_29304913);
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x7300e20b, Offset: 0x4b08
// Size: 0xac
function function_ff499dd5() {
    level endon(#"hash_b29d42d8");
    wait(20);
    if (!flag::get("clear_killing_streets_breadcrumb_04")) {
        level.var_29304913 = struct::get("killing_streets_breadcrumb_04");
        objectives::set("cp_waypoint_breadcrumb", level.var_29304913);
        level flag::wait_till("clear_killing_streets_breadcrumb_04");
        objectives::complete("cp_waypoint_breadcrumb", level.var_29304913);
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xf0bb287b, Offset: 0x4bc0
// Size: 0x1ac
function function_71a7056() {
    level flag::wait_till("start_killing_streets_sniper_shoots_civilian");
    wait(1.5);
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_shit_weapons_ready_0");
    if (!level flag::get("move_killing_streets_hendricks_node_15")) {
        level flag::wait_till("move_killing_streets_hendricks_node_15");
        level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_contact_1");
    }
    level flag::wait_till_any(array("stealth_alert", "stealth_combat", "killing_streets_intro_patroller_spawners_cleared", "cin_ven_03_15_killingstreets_vign_done", "hendricks_break_ally_stealth"));
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_weapons_free_0");
    wait(0.5);
    level.var_2fd26037 battlechatter::function_d9f49fba(1);
    level flag::wait_till("move_hendricks_to_meat_market");
    wait(1.75);
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_what_the_fuck_is_wro_0");
    wait(0.5);
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_no_mission_is_worth_0");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0xce0761e, Offset: 0x4d78
// Size: 0x44
function function_999f0273() {
    level flag::wait_till("hendricks_says_stay_down");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_stay_down_1");
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x6818bc25, Offset: 0x4dc8
// Size: 0x92
function function_9f0122b9() {
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("play_client_igc", 1);
    }
}

// Namespace namespace_62b73aed
// Params 0, eflags: 0x1 linked
// Checksum 0x13706c24, Offset: 0x4e68
// Size: 0x134
function function_28fa297f() {
    var_8c8bdeb5 = getent("lineup_kill_exit_door", "targetname");
    if (isdefined(var_8c8bdeb5)) {
        var_8c8bdeb5 hide();
        var_8c8bdeb5 notsolid();
    }
    var_1e51cc5a = getent("lineup_kill_exit_door_clip", "targetname");
    if (isdefined(var_1e51cc5a)) {
        var_1e51cc5a notsolid();
        wait(0.1);
        var_1e51cc5a connectpaths();
        level flag::wait_till("killing_streets_end");
        var_1e51cc5a solid();
        wait(0.1);
        var_1e51cc5a disconnectpaths();
    }
}

