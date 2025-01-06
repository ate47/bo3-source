#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_sing_blackstation_station;

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xb36ea435, Offset: 0x17e8
// Size: 0x1ea
function function_9f5e1dcd() {
    level.var_e121f644 = 0;
    level.var_6999c9ec = 0;
    level.var_eaf20b66 = getnodearray("black_station_warlord_preferred_node", "targetname");
    level.var_c5719229 = 0;
    level.var_960b4a94 = 0;
    level thread function_da25c72f();
    level thread function_86861a95();
    level thread function_d316aef3();
    level thread function_df797544();
    level thread function_7c8de67c();
    level thread function_1f5941f8();
    level thread function_41ad2775();
    level thread lightning_strike();
    level thread function_c31f21d6();
    level thread function_60578067();
    level thread function_d9afa854();
    level thread function_46ae7f32();
    level thread function_9694617b();
    level thread spawn_warlord();
    level thread function_d83742ed();
    level thread function_5493cb1d();
    if (isdefined(level.var_513b9d17)) {
        level thread [[ level.var_513b9d17 ]]();
    }
    level thread namespace_23567e72::function_328b2c47();
    array::thread_all(level.activeplayers, &namespace_79e1cd97::function_d870e0, "trig_exterior_color01");
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 0);
    level flag::wait_till("exterior_ready_weapons");
}

// Namespace cp_mi_sing_blackstation_station
// Params 2, eflags: 0x0
// Checksum 0x4f2b8b71, Offset: 0x19e0
// Size: 0x1c2
function function_3450aa78(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_blackstation_exterior_hendricks");
        namespace_79e1cd97::function_da579a5d("objective_blackstation_exterior");
        level.var_3d556bcd ai::set_ignoreall(1);
        level thread scene::play("cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane_idle");
        load::function_a2995f22();
        var_23419962 = getent("trigger_talk_kane", "targetname");
        var_23419962 delete();
        level flag::set("hendricks_crossed");
        level flag::set("goto_zipline");
        level flag::set("talk_kane");
        level flag::set("hendricks_zipline");
        level function_5142ef8e();
        level function_b8052aae();
    }
    level thread namespace_79e1cd97::function_6778ea09("none");
    level thread scene::play("blackstation_exterior_shutters");
    level thread function_ac6ad822();
    streamerrequest("set", "cp_mi_sing_blackstation_objective_end_igc");
    function_9f5e1dcd();
}

// Namespace cp_mi_sing_blackstation_station
// Params 4, eflags: 0x0
// Checksum 0x75d2dba0, Offset: 0x1bb0
// Size: 0x22
function function_b5e9c2fe(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8d675196, Offset: 0x1be0
// Size: 0xd5
function function_ac6ad822() {
    level endon(#"zipline_player_landed");
    while (true) {
        if (math::cointoss()) {
            exploder::exploder("exp_lightning_blackstation_exterior_f_01");
        } else {
            exploder::exploder("exp_lightning_blackstation_exterior_f_02");
        }
        wait randomfloatrange(5, 8);
        if (math::cointoss()) {
            exploder::exploder("exp_lightning_blackstation_exterior_f_01");
        } else {
            exploder::exploder("exp_lightning_blackstation_exterior_f_02");
        }
        wait randomfloatrange(5, 8);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x7700fd12, Offset: 0x1cc0
// Size: 0x212
function function_5142ef8e() {
    spawner::add_spawn_function_group("upper_group1", "targetname", &function_1492467b);
    spawner::add_spawn_function_group("exterior_robots", "targetname", &function_1492467b);
    spawner::add_spawn_function_group("lower_exterior_group01", "targetname", &function_1492467b);
    spawner::add_spawn_function_group("exterior_robots_guards", "script_aigroup", &function_337b5b09);
    spawner::add_spawn_function_group("exterior_robots_pathers", "script_aigroup", &function_6933f59e);
    spawner::add_spawn_function_group("lightning_struck_gib", "script_noteworthy", &function_dca80d71);
    spawner::add_spawn_function_group("lightning_struck_shock", "script_noteworthy", &function_dca80d71);
    spawner::add_spawn_function_group("lightning_launch_ai", "script_noteworthy", &lightning_launch_ai);
    spawner::add_spawn_function_group("exterior_gunner_front", "script_noteworthy", &lightning_launch_ai);
    spawner::add_spawn_function_group("blackstation_warlord_spawner", "script_noteworthy", &function_7ed3137d);
    spawner::add_spawn_function_group("exterior_patroller", "script_noteworthy", &function_6d08f715);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x2b99f4b8, Offset: 0x1ee0
// Size: 0x92
function function_86861a95() {
    var_b61d7410 = getent("trig_zipline01", "targetname");
    level thread function_b099c73d(var_b61d7410);
    var_2824e34b = getent("trig_zipline02", "targetname");
    level thread function_b099c73d(var_2824e34b);
    level thread function_b78bbba4();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xb701bd27, Offset: 0x1f80
// Size: 0x5a
function function_b8052aae() {
    spawner::simple_spawn("perimeter_patrol", &function_50eaaa70);
    wait 0.5;
    spawner::simple_spawn("exterior_working_robots", &function_1492467b);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8ad86694, Offset: 0x1fe8
// Size: 0xf2
function function_d9afa854() {
    level flag::wait_till("talk_kane");
    spawn_manager::enable("sm_upper_group1");
    level flag::wait_till("ziplines_ready");
    spawner::simple_spawn("lower_exterior_group01", &function_1492467b);
    wait 0.5;
    spawn_manager::enable("sm_exterior_robots");
    level.var_4666226e = getaiteamarray("axis");
    level flag::wait_till("blackstation_exterior_engaged");
    spawner::simple_spawn("sniper_exterior_group01", &function_bfa694b0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xf5d95bed, Offset: 0x20e8
// Size: 0xc2
function function_b0c674cf() {
    if (level.activeplayers.size < 3) {
        if (level.var_d4bb1798 == "left") {
            spawner::simple_spawn_single("sniper_right", &function_2dafb2d1);
        } else {
            spawner::simple_spawn_single("sniper_left", &function_2dafb2d1);
        }
        return;
    }
    spawner::simple_spawn_single("sniper_right", &function_2dafb2d1);
    spawner::simple_spawn_single("sniper_left", &function_2dafb2d1);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x95bf7303, Offset: 0x21b8
// Size: 0x62
function function_41ad2775() {
    level flag::wait_till("zipline_player_landed");
    level thread objectives::breadcrumb("blackstation_exterior_breadcrumb");
    trigger::wait_till("trig_waypoint_station01");
    skipto::function_be8adfb8("objective_blackstation_exterior");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x1fa4b1a3, Offset: 0x2228
// Size: 0x1a
function function_3d53956f() {
    level thread objectives::breadcrumb("blackstation_interior_breadcrumb");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x6cb3782, Offset: 0x2250
// Size: 0xb2
function function_1e6e44af() {
    self endon(#"death");
    self endon(#"hash_b2d41628");
    trigger::wait_till("trig_waypoint_station00", "targetname", self);
    self util::function_16c71b8(1);
    do {
        wait 1;
    } while (self istouching(getent("trig_waypoint_station00", "targetname")));
    self util::function_16c71b8(0);
    if (!level flag::get("exterior_ready_weapons")) {
        self function_1e6e44af();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xc62a5717, Offset: 0x2310
// Size: 0x9a
function function_d83742ed() {
    level flag::wait_till("approach_intersection");
    level flag::wait_till("warlord_dead");
    trigger::use("triggercolor_station_advance");
    level flag::wait_till("goto_entrance");
    level thread function_a05c3d53();
    trigger::use("triggercolor_station_entrance");
    wait 2;
    level thread function_4b241521();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x78dda22f, Offset: 0x23b8
// Size: 0x1aa
function function_4b241521() {
    level flag::wait_till("exterior_clear");
    level scene::init("cin_bla_14_02_blackstation_vign_takepoint");
    level thread scene::play("p7_fxanim_gp_lantern_chinese_red_04_bs_bundle");
    level.var_2fd26037 thread function_8632f992();
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "slow");
    level.var_2fd26037 setgoal(getnode("nd_door_kick", "targetname"), 1);
    level.var_2fd26037 util::waittill_any("goal", "kick_door");
    wait 1;
    level thread scene::play("cin_gen_aie_door_kick");
    wait 1;
    level.var_2fd26037 colors::enable();
    trigger::use("triggercolor_station_interior");
    level notify(#"hash_b5d76c65");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "off");
    getent("clip_station_door", "targetname") delete();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x69ccc2fd, Offset: 0x2570
// Size: 0x17
function function_8632f992() {
    level endon(#"hash_b5d76c65");
    wait 15;
    self notify(#"kick_door");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xad5a8284, Offset: 0x2590
// Size: 0x4e6
function function_da25c72f() {
    if (!isdefined(level.var_3d556bcd)) {
        namespace_79e1cd97::function_da579a5d("objective_blackstation_exterior");
    }
    level.var_2fd26037 notify(#"hash_a2ba32d");
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_3d556bcd ai::set_ignoreall(1);
    level.var_3d556bcd ai::set_ignoreme(1);
    foreach (player in level.players) {
        player thread function_1e6e44af();
    }
    level flag::wait_till("hendricks_crossed");
    level flag::wait_till("hendricks_zipline");
    level.var_2fd26037 setgoal(getnode("node_zipline", "targetname"), 1);
    level.var_2fd26037 waittill(#"goal");
    level flag::wait_till("talk_kane");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "slow");
    level thread namespace_4297372::function_973b77f9();
    level thread scene::add_scene_func("cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_hendricks", &function_20aa53b9);
    level thread scene::add_scene_func("cin_bla_13_02_looting_vign_looting_zipline", &function_29ec302d, "play");
    level thread scene::add_scene_func("cin_bla_13_02_looting_vign_looting_zipline", &function_b8aa66aa, "done");
    level scene::play("cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_hendricks");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "off");
    wait 4;
    savegame::checkpoint_save();
    level flag::set("ziplines_ready");
    objectives::set("cp_level_blackstation_goto_station");
    level.var_2fd26037 thread function_2d102c76();
    level flag::wait_till("zipline_player_landed");
    array::thread_all(level.activeplayers, &function_5fc18bba);
    level thread function_7f259445();
    level flag::wait_till("blackstation_exterior_engaged");
    level.var_2fd26037 thread namespace_79e1cd97::function_dccf6ccc();
    level.var_2fd26037 thread function_dfb9eb36();
    level.var_2fd26037 ai::set_behavior_attribute("move_mode", "rambo");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_3d556bcd ai::set_ignoreall(0);
    trigger::use("trig_exterior_color01");
    level.var_3d556bcd thread function_97b95534();
    level flag::wait_till("kane_move_up");
    level function_9d556a71(level.var_3d556bcd, "trig_zipline01");
    level.var_3d556bcd ai::set_ignoreme(0);
    level.var_3d556bcd thread function_2d102c76();
    level flag::wait_till("kane_landed");
    level.var_3d556bcd ai::set_ignoreall(0);
    level.var_3d556bcd ai::set_ignoreme(0);
    level.var_3d556bcd colors::set_force_color("y");
    trigger::use("trig_exterior_color01", "targetname");
    wait 2;
    level.var_3d556bcd.holdfire = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x4ffc542f, Offset: 0x2a80
// Size: 0xa6
function function_29ec302d(a_ents) {
    var_3169a073 = getent("trig_zipline01", "targetname");
    var_3169a073.b_in_use = 1;
    level waittill(#"hash_808b60ca");
    level.var_2fd26037 playsound("evt_zipline_attach");
    level.var_2fd26037 playloopsound("evt_zipline_npc_move", 0.3);
    wait 0.5;
    var_3169a073.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x33597397, Offset: 0x2b30
// Size: 0x72
function function_b8aa66aa(a_ents) {
    level.var_2fd26037 stoploopsound(0.1);
    level.var_2fd26037 setgoal(level.var_2fd26037.origin);
    wait 0.5;
    trigger::use("triggercolor_zipline");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0xecfab042, Offset: 0x2bb0
// Size: 0x3a
function function_20aa53b9(a_ents) {
    objectives::complete("cp_level_blackstation_rendezvous");
    level scene::play("cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8ac1e70c, Offset: 0x2bf8
// Size: 0xca
function function_a561f620() {
    level endon(#"hendricks_crossed");
    trigger::wait_till("trigger_at_zipline");
    if (level scene::is_playing("cin_bla_12_01_cross_debris_vign_point")) {
        level notify(#"hash_62f8dc0c");
        level scene::stop("cin_bla_12_01_cross_debris_vign_point");
        s_pos = struct::get("hendricks_post_frogger");
        self skipto::function_d9b1ee00(s_pos);
        self colors::enable();
        level flag::set("hendricks_crossed");
        self ai::set_ignoreall(1);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x6cae12e3, Offset: 0x2cd0
// Size: 0x62
function function_7f259445() {
    level util::waittill_notify_or_timeout("exterior_moved_forward", 30);
    level flag::set("exterior_ready_weapons");
    level flag::wait_till("lightning_strike_done");
    level flag::set("blackstation_exterior_engaged");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8d55d98e, Offset: 0x2d40
// Size: 0x2c5
function function_97b95534() {
    level endon(#"kane_landed");
    self ai::set_ignoreme(1);
    self thread laser_on();
    self thread laser_off();
    wait 5;
    var_45900c37 = getent("exterior_technical01_vh", "targetname");
    if (isalive(var_45900c37)) {
        var_dfb53de7 = var_45900c37 vehicle::function_ad4ec07a("gunner1");
        if (isalive(var_dfb53de7)) {
            self thread ai::shoot_at_target("normal", var_dfb53de7, "j_head", undefined, undefined, 1);
            level fx::play("blood_headpop", var_dfb53de7 gettagorigin("j_head"));
            var_dfb53de7 kill();
        }
    }
    wait 2;
    while (true) {
        a_ai_enemies = getaiteamarray("axis");
        for (i = a_ai_enemies.size - 1; i >= 0; i--) {
            if (a_ai_enemies[i].archetype === "warlord") {
                arrayremoveindex(a_ai_enemies, i);
            }
        }
        if (level.activeplayers.size) {
            e_player = level.activeplayers[randomint(level.activeplayers.size)];
            if (isalive(e_player)) {
                a_ai_targets = arraysortclosest(a_ai_enemies, e_player.origin);
                for (i = 0; i < a_ai_targets.size; i++) {
                    if (isalive(a_ai_targets[i])) {
                        if (isalive(e_player)) {
                            if (e_player util::is_player_looking_at(a_ai_targets[i] gettagorigin("j_head"), 0.85, 1) && a_ai_targets[i].allowdeath === "true") {
                                self function_3f00de07(a_ai_targets[i]);
                                break;
                            }
                        }
                    }
                }
                wait randomfloatrange(4, 5);
            }
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0xdc3abaae, Offset: 0x3010
// Size: 0x9a
function function_3f00de07(ai_enemy) {
    ai_enemy endon(#"death");
    self thread ai::shoot_at_target("normal", ai_enemy, "j_head");
    wait 1;
    self.holdfire = 0;
    if (ai_enemy.archetype == "human") {
        level fx::play("blood_headpop", ai_enemy gettagorigin("j_head"));
    }
    self.holdfire = 1;
    ai_enemy kill();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xd4725156, Offset: 0x30b8
// Size: 0x2d
function laser_on() {
    self endon(#"laser_off");
    while (true) {
        self laseron();
        wait 0.05;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x37da0397, Offset: 0x30f0
// Size: 0x42
function laser_off() {
    trigger::wait_till("trigger_station_approach");
    self notify(#"laser_off");
    util::wait_network_frame();
    self laseroff();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x9b5ccfa6, Offset: 0x3140
// Size: 0xda
function lightning_strike() {
    level flag::wait_till("lightning_hit");
    level flag::set("lightning_strike");
    s_strike = struct::get("station_strike01");
    level fx::play("lightning_strike", s_strike.origin, (-90, 0, 0));
    exploder::exploder("fx_expl_lightning_strike_blkstn_ext");
    playsoundatposition("amb_2d_thunder_hits", s_strike.origin);
    wait 0.5;
    level flag::set("lightning_strike_done");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x43ae18a3, Offset: 0x3228
// Size: 0xbb
function function_c31f21d6() {
    level endon(#"lightning_hit");
    level flag::wait_till("blackstation_exterior_engaged");
    wait 2;
    var_64e85e6d = getentarray("exterior_working_robots_ai", "targetname");
    foreach (var_f6c5842 in var_64e85e6d) {
        array::thread_all(level.activeplayers, &function_5eb38a05, var_f6c5842);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x18b4b915, Offset: 0x32f0
// Size: 0x5a
function function_5eb38a05(var_f6c5842) {
    self endon(#"death");
    level endon(#"lightning_hit");
    self util::waittill_player_looking_at(var_f6c5842 getcentroid(), 30, 1);
    level flag::set("lightning_hit");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x3aa7bdc6, Offset: 0x3358
// Size: 0xd5
function function_7c8de67c() {
    level endon(#"zipline_player_landed");
    level flag::wait_till("talk_kane");
    var_3de152e1 = struct::get_array("ambient_strike");
    while (true) {
        s_strike = array::random(var_3de152e1);
        level fx::play("lightning_strike", s_strike.origin, (-90, 0, 0));
        playsoundatposition("amb_2d_thunder_hits", s_strike.origin);
        wait randomfloatrange(3.5, 5.5);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xc059548b, Offset: 0x3438
// Size: 0x132
function lightning_launch_ai() {
    self endon(#"death");
    level flag::wait_till("lightning_strike");
    wait 0.2;
    if (self.script_noteworthy === "exterior_gunner_front") {
        self thread animation::play(self.var_1b425382.ridedeathanim);
        self startragdoll();
        self launchragdoll((50, 0, 90));
        self flagsys::clear("in_vehicle");
        vehicle::function_d3fa882a(self.vehicle, self.var_1b425382.position);
        self.vehicle = undefined;
        self.var_1b425382 = undefined;
        self animation::set_death_anim(undefined);
    } else {
        self startragdoll();
        self launchragdoll((-50, -20, 50));
    }
    level flag::wait_till("blackstation_exterior_engaged");
    self kill();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x76a74a6c, Offset: 0x3578
// Size: 0x62
function function_60578067() {
    level flag::wait_till("lightning_strike");
    wait 0.5;
    e_sfx = getent("lightning_strike_sound", "targetname");
    e_sfx playsound("fly_bot_head_sparks_disable");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xeaaeb3f5, Offset: 0x35e8
// Size: 0x52
function function_bfa694b0() {
    var_92f29fd5 = getweapon("launcher_guided_blackstation_ai");
    self ai::gun_switchto(var_92f29fd5, "right");
    self thread function_4472fea7();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8cad5e32, Offset: 0x3648
// Size: 0xd5
function function_4472fea7() {
    self endon(#"death");
    while (true) {
        self waittill(#"missile_fire", var_e40110b0);
        if (isdefined(var_e40110b0) && isdefined(self.enemy)) {
            n_dist = int(distance(self.origin, self.enemy.origin) * 0.05);
            n_range = randomintrange(n_dist * -1, n_dist);
            v_offset = (n_range, n_range, n_range);
            var_e40110b0 missile_settarget(self.enemy, v_offset);
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x18572f96, Offset: 0x3728
// Size: 0x3a
function function_2d102c76() {
    trigger::wait_till("trigger_station_cqb", "targetname", self);
    self ai::set_behavior_attribute("cqb", 1);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xd52dc48c, Offset: 0x3770
// Size: 0x182
function function_1f5941f8() {
    level flag::wait_till("blackstation_exterior_engaged");
    spawner::add_spawn_function_group("lower_exterior_group02", "targetname", &function_1492467b);
    spawner::add_spawn_function_group("exterior_group03", "targetname", &function_b690ea0e);
    foreach (ai in level.var_4666226e) {
        if (isdefined(ai)) {
            ai notify(#"under_attack");
        }
    }
    level.var_4666226e = [];
    wait 3;
    level flag::set("exterior_truck_event");
    level flag::wait_till("warlord_go");
    spawn_manager::enable("sm_lower_group");
    level thread function_31b6dec0();
    spawn_manager::enable("exterior_group03_sm");
    level flag::wait_till("warlord_dead");
    spawn_manager::kill("exterior_group03_sm");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xac0c40ee, Offset: 0x3900
// Size: 0x32
function spawn_warlord() {
    level flag::wait_till("warlord_go");
    spawn_manager::enable("sm_warlord_station");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xb0605656, Offset: 0x3940
// Size: 0x4a
function function_31b6dec0() {
    level endon(#"warlord_go");
    while (getaicount() > 12 + 2) {
        wait 1;
    }
    level flag::set("warlord_go");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xf905301, Offset: 0x3998
// Size: 0x15a
function function_7ed3137d() {
    self endon(#"death");
    level.var_e121f644++;
    self setthreatbiasgroup("warlords");
    setthreatbias("heroes", "warlords", -1000);
    self thread function_5d3711fa();
    foreach (node in level.var_eaf20b66) {
        self namespace_69ee7109::function_da308a83(node.origin, 3000, 5000);
    }
    self setgoal(getnode(self.script_string, "targetname"), 1);
    self waittill(#"goal");
    self clearforcedgoal();
    level flag::wait_till("goto_entrance");
    self setgoal(getent("vol_warlord_retreat", "targetname"));
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x8a2dfa30, Offset: 0x3b00
// Size: 0x3a
function function_5d3711fa() {
    self waittill(#"death");
    level.var_6999c9ec++;
    if (level.var_e121f644 == level.var_6999c9ec) {
        level flag::set("warlord_dead");
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x97fd8bfd, Offset: 0x3b48
// Size: 0x59
function function_a05c3d53() {
    level endon(#"exterior_clear");
    while (true) {
        a_ai_enemies = getaiteamarray("axis");
        if (!a_ai_enemies.size) {
            level flag::set("exterior_clear");
        }
        wait 1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x185f8a5f, Offset: 0x3bb0
// Size: 0x1d2
function function_46ae7f32() {
    level flag::wait_till("ziplines_ready");
    var_35a302af = vehicle::simple_spawn_single("exterior_technical01");
    var_35a302af endon(#"death");
    var_35a302af vehicle::lights_off();
    var_35a302af util::magic_bullet_shield();
    var_35a302af thread function_d1825549();
    var_35a302af thread function_1ff678ce();
    var_35a302af thread vehicle::get_on_and_go_path(getvehiclenode(var_35a302af.target, "targetname"));
    var_35a302af thread namespace_79e1cd97::function_c262adca();
    level waittill(#"pause");
    var_35a302af setspeed(0, 15, 5);
    var_dfb53de7 = var_35a302af vehicle::function_ad4ec07a("gunner1");
    while (isalive(var_dfb53de7)) {
        wait 0.5;
    }
    wait 1;
    var_35a302af resumespeed(15);
    var_35a302af playsound("evt_tech_driveup_3");
    level flag::wait_till("lightning_strike");
    var_35a302af turret::enable_auto_use(0);
    var_35a302af waittill(#"reached_end_node");
    var_35a302af util::stop_magic_bullet_shield();
    var_35a302af thread namespace_79e1cd97::function_fae23684("driver");
    var_35a302af setseatoccupied(0);
    var_35a302af makevehicleusable();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xfd65e70a, Offset: 0x3d90
// Size: 0x3a
function function_d1825549() {
    self endon(#"death");
    level flag::wait_till("blackstation_exterior_engaged");
    self turret::enable(1, 1);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xd2d71748, Offset: 0x3dd8
// Size: 0x22
function function_1ff678ce() {
    level waittill(#"truck_in_position");
    level flag::set("truck_in_position");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x5f87e17, Offset: 0x3e08
// Size: 0x172
function function_d316aef3() {
    var_35a302af = vehicle::simple_spawn_single("exterior_technical02");
    var_35a302af endon(#"death");
    var_35a302af vehicle::lights_off();
    var_35a302af util::magic_bullet_shield();
    level flag::wait_till("blackstation_exterior_engaged");
    wait 2;
    var_35a302af turret::enable(1, 1);
    var_35a302af thread vehicle::get_on_and_go_path(getvehiclenode(var_35a302af.target, "targetname"));
    var_35a302af playsound("evt_tech_driveup_4");
    var_35a302af waittill(#"reached_end_node");
    var_35a302af util::stop_magic_bullet_shield();
    wait 1;
    var_44762fa4 = var_35a302af vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4 colors::set_force_color("r");
        var_44762fa4 vehicle::get_out();
    }
    var_35a302af setseatoccupied(0);
    var_35a302af makevehicleusable();
    var_35a302af thread namespace_79e1cd97::function_d01267bd(2, 2, "cross_street");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x75c7eae6, Offset: 0x3f88
// Size: 0x182
function function_df797544() {
    var_35a302af = vehicle::simple_spawn_single("exterior_technical03");
    var_35a302af endon(#"death");
    var_35a302af vehicle::lights_off();
    var_35a302af util::magic_bullet_shield();
    level flag::wait_till("blackstation_exterior_engaged");
    var_35a302af thread vehicle::get_on_and_go_path(getvehiclenode(var_35a302af.target, "targetname"));
    var_35a302af playsound("evt_tech_driveup_5");
    var_35a302af resumespeed(35);
    var_35a302af turret::enable(1, 1);
    var_35a302af waittill(#"reached_end_node");
    var_35a302af util::stop_magic_bullet_shield();
    wait 1;
    var_44762fa4 = var_35a302af vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4 colors::set_force_color("r");
        var_44762fa4 vehicle::get_out();
    }
    var_35a302af setseatoccupied(0);
    var_35a302af makevehicleusable();
    var_35a302af thread namespace_79e1cd97::function_d01267bd(2, 2, "cross_street");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x4d2cb2ec, Offset: 0x4118
// Size: 0x89
function function_3d8fcbfe(var_35a302af) {
    self endon(#"death");
    self vehicle::get_in(var_35a302af, "gunner1");
    while (!self flagsys::get("in_vehicle")) {
        if (!var_35a302af flagsys::get("driveroccupied")) {
            self vehicle::get_in(var_35a302af, "driver");
            continue;
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x30ca3851, Offset: 0x41b0
// Size: 0x62
function function_78b9affb() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    level flag::wait_till("blackstation_exterior_engaged");
    self notify(#"stop_patrolling");
    self ai::set_behavior_attribute("patrol", 0);
    self ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x43db5170, Offset: 0x4220
// Size: 0xda
function function_8401b524() {
    self endon(#"death");
    level flag::wait_till("lightning_strike");
    self notify(#"stop_patrolling");
    self ai::set_behavior_attribute("patrol", 0);
    wait randomfloatrange(0.5, 1);
    var_bea85066 = getnode(self.script_noteworthy, "script_noteworthy");
    if (isdefined(var_bea85066)) {
        self setgoal(getnode(self.script_noteworthy, "script_noteworthy"), 1);
        self waittill(#"goal");
        self clearforcedgoal();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x293cfce9, Offset: 0x4308
// Size: 0x11a
function function_50eaaa70() {
    self endon(#"death");
    self colors::set_force_color("r");
    self thread function_862c1664();
    self thread function_78b9affb();
    self thread function_8401b524();
    self thread function_1492467b();
    self ai::set_behavior_attribute("patrol", 1);
    self thread ai::patrol(getnode(self.script_noteworthy, "targetname"));
    self util::waittill_any("damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "under_attack");
    level flag::set("exterior_ready_weapons");
    level flag::set("blackstation_exterior_engaged");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x9680d653, Offset: 0x4430
// Size: 0x14a
function function_1492467b() {
    self endon(#"death");
    if (self.archetype == "human") {
        self colors::set_force_color("r");
    }
    self thread function_862c1664();
    self ai::set_ignoreall(1);
    self util::waittill_any("damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "under_attack");
    level flag::set("exterior_ready_weapons");
    level flag::set("blackstation_exterior_engaged");
    self ai::set_ignoreall(0);
    self.maxsightdistsqrd = self.var_98207841;
    foreach (ai in level.var_4666226e) {
        if (isdefined(ai)) {
            ai notify(#"under_attack");
        }
    }
    level.var_4666226e = [];
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x188e74f4, Offset: 0x4588
// Size: 0x42
function function_2dafb2d1() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    level flag::wait_till("blackstation_exterior_engaged");
    self ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x54ada7bd, Offset: 0x45d8
// Size: 0xbd
function function_862c1664() {
    self endon(#"death");
    level endon(#"blackstation_exterior_engaged");
    self.var_98207841 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 360000;
    while (true) {
        foreach (player in level.activeplayers) {
            if (self cansee(player)) {
                level flag::set("blackstation_exterior_engaged");
            }
        }
        wait 0.3;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x81871526, Offset: 0x46a0
// Size: 0x14a
function function_dca80d71() {
    self endon(#"death");
    if (!level flag::get("lightning_strike")) {
        if (self.script_noteworthy == "lightning_struck_gib") {
            self setgoal(self.origin, 1);
        }
        level flag::wait_till("lightning_strike");
        self ai::set_ignoreme(1);
        self disableaimassist();
        wait randomfloat(1);
        self fx::play("disabled_robot", self.origin, undefined, 15, 1, "j_neck");
        switch (randomint(4)) {
        case 0:
            str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot01";
            break;
        case 1:
            str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot02";
            break;
        case 2:
            str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot03";
            break;
        case 3:
            str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot04";
            break;
        }
        self thread function_84aabd4b(str_scene);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x140ef501, Offset: 0x47f8
// Size: 0x11a
function function_84aabd4b(str_scene) {
    self endon(#"death");
    var_ec24660 = 6;
    var_39dd968a = 10;
    self scene::play(str_scene + "_zapped", self);
    self thread scene::play(str_scene + "_loop", self);
    wait randomfloatrange(var_ec24660, var_39dd968a);
    if (self.script_noteworthy === "lightning_struck_gib") {
        self ai::set_behavior_attribute("force_crawler", "gib_legs");
        self kill();
        return;
    }
    self scene::play(str_scene, self);
    self enableaimassist();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xd7e83feb, Offset: 0x4920
// Size: 0xba
function function_337b5b09() {
    self endon(#"death");
    if (self.script_noteworthy === "robot_patrol") {
        self ai::set_behavior_attribute("move_mode", "normal");
    } else {
        self setgoal(self.origin, 0, -128);
        self ai::set_behavior_attribute("move_mode", "guard");
    }
    level flag::wait_till("blackstation_exterior_engaged");
    self.goalradius = 1000;
    self ai::set_behavior_attribute("move_mode", "normal");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xc7120cb4, Offset: 0x49e8
// Size: 0x5a
function function_6933f59e() {
    self endon(#"death");
    level flag::wait_till("zipline_player_landed");
    nd_start = getnearestnode(self.origin);
    self setgoal(nd_start);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xff40e80, Offset: 0x4a50
// Size: 0x32
function function_6d08f715() {
    self endon(#"death");
    self thread ai::patrol(getnearestnode(self.origin));
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x4213a627, Offset: 0x4a90
// Size: 0x22
function function_b690ea0e() {
    self endon(#"death");
    self colors::set_force_color("r");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xc1f0b031, Offset: 0x4ac0
// Size: 0xba
function function_dfb9eb36() {
    level flag::wait_till("warlord_dead");
    self notify(#"hash_d60979de");
    wait 1;
    while (getaiteamarray("axis").size > 2) {
        wait 0.5;
    }
    a_ai_enemies = getaiteamarray("axis");
    if (a_ai_enemies.size) {
        self namespace_79e1cd97::function_4f96504c(a_ai_enemies[0]);
        if (isalive(a_ai_enemies[0])) {
            self cybercom::function_d240e350("cybercom_fireflyswarm", a_ai_enemies[0], 0, 1);
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x9646aae3, Offset: 0x4b88
// Size: 0x32
function function_5fc18bba() {
    self endon(#"death");
    level endon(#"blackstation_exterior_engaged");
    self waittill(#"weapon_fired");
    level flag::set("blackstation_exterior_engaged");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x10ceddf0, Offset: 0x4bc8
// Size: 0x65
function function_2a47a71c(player_num) {
    if (player_num == 0) {
        return (-4768, 10399, 329);
    }
    if (player_num == 1) {
        return (-4768, 10355, 329);
    }
    if (player_num == 2) {
        return (-5618, 9366, 329);
    }
    return (-5618, 9294, 329);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x5b6df45e, Offset: 0x4c38
// Size: 0x9a
function function_34a9c09e() {
    self endon(#"death");
    self clientfield::increment_to_player("postfx_igc", 1);
    self freezecontrols(1);
    wait 0.5;
    var_be173713 = function_2a47a71c(self getentitynumber());
    self setorigin(var_be173713);
    self setplayerangles((0, 0, 0));
    self freezecontrols(0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 3, eflags: 0x0
// Checksum 0xa6681c38, Offset: 0x4ce0
// Size: 0x3f2
function zipline_player(var_62e11f41, s_start, s_end) {
    self endon(#"death");
    self thread namespace_79e1cd97::function_ed7faf05();
    var_ad470f8c = util::spawn_model("tag_origin", self.origin, self.angles);
    n_dist = distance(s_start.origin, s_end.origin);
    n_time = n_dist / 750;
    self disableweaponcycling();
    self disableoffhandweapons();
    self allowcrouch(0);
    self allowprone(0);
    var_ad470f8c playsoundtoplayer("evt_zipline_attach", self);
    self.var_23304c9e = 1;
    var_ad470f8c.origin = self.origin;
    var_ad470f8c.angles = self.angles;
    self util::function_16c71b8(0);
    self playrumbleonentity("cp_blackstation_zipline_attach_rumble");
    var_ad470f8c moveto(s_start.origin, 0.05);
    var_ad470f8c rotateto(s_start.angles, 0.05);
    var_f32c41e7 = gettime();
    var_ad470f8c scene::play("cin_gen_traversal_zipline_player_attach", self);
    if (gettime() - var_f32c41e7 < 0.5) {
        var_6ec94357 = 1;
    }
    if (!(isdefined(var_6ec94357) && var_6ec94357)) {
        self clientfield::set_to_player("wind_blur", 1);
        var_ad470f8c thread scene::play("cin_gen_traversal_zipline_player_idle", self);
        self clientfield::set_to_player("zipline_rumble_loop", 1);
        self clientfield::set("zipline_sound_loop", 1);
        self playloopsound("evt_zipline_move", 0.3);
        var_ad470f8c moveto(s_end.origin, n_time, 0, 0);
        var_ad470f8c waittill(#"movedone");
        var_ad470f8c playsoundtoplayer("evt_zipline_attach", self);
        self clientfield::set_to_player("wind_blur", 0);
        self playrumbleonentity("cp_blackstation_zipline_dismount_rumble");
        self clientfield::set_to_player("zipline_rumble_loop", 0);
        self clientfield::set("zipline_sound_loop", 0);
        self stoploopsound(0.5);
        var_ad470f8c scene::play("cin_gen_traversal_zipline_player_dismount", self);
    }
    self playrumbleonentity("cp_blackstation_zipline_land_rumble");
    self.var_23304c9e = 0;
    self notify(#"hash_4d91a838");
    self enableweaponcycling();
    self enableoffhandweapons();
    self allowcrouch(1);
    self allowprone(1);
    self thread namespace_79e1cd97::player_anchor();
    level flag::set("zipline_player_landed");
    wait 0.3;
    var_ad470f8c delete();
    self disableinvulnerability();
    if (isdefined(var_6ec94357) && var_6ec94357) {
        function_34a9c09e();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x58ae0ddb, Offset: 0x50e0
// Size: 0x19d
function function_b099c73d(var_62e11f41) {
    var_62e11f41 triggerenable(0);
    var_62e11f41.b_in_use = 0;
    level flag::wait_till("ziplines_ready");
    var_744d4302 = util::function_14518e76(var_62e11f41, %cp_level_blackstation_zipline, %CP_MI_SING_BLACKSTATION_ZIPLINE_TEXT, &function_a7b2f59e);
    var_744d4302.dontlinkplayertotrigger = 1;
    var_744d4302.trigger = var_62e11f41;
    var_744d4302 thread function_76529a7a();
    while (var_62e11f41.b_in_use) {
        wait 0.1;
    }
    var_62e11f41 triggerenable(1);
    objectives::set("cp_level_blackstation_zipline", var_62e11f41.origin);
    s_start = struct::get(var_62e11f41.target, "targetname");
    s_end = struct::get(s_start.target, "targetname");
    while (!level flag::get("zipline_done")) {
        while (var_62e11f41.b_in_use == 1) {
            wait 0.25;
        }
        var_744d4302 gameobjects::enable_object();
        util::wait_network_frame();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0xa9db1a39, Offset: 0x5288
// Size: 0x1d2
function function_a7b2f59e(e_player) {
    e_player enableinvulnerability();
    trigger::use("trig_zipline_player_spawns", "targetname", e_player);
    level thread namespace_4297372::function_f152b1dc();
    level flag::set(self.trigger.targetname);
    self.trigger.b_in_use = 1;
    self gameobjects::disable_object();
    objectives::function_66c6f97b("cp_level_blackstation_zipline", self.trigger.origin);
    if (!level.var_c5719229) {
        level.var_c5719229 = 1;
        if (self.trigger.targetname == "trig_zipline01") {
            level.var_d4bb1798 = "left";
        } else {
            level.var_d4bb1798 = "right";
        }
        level thread function_b0c674cf();
    }
    s_start = struct::get(self.trigger.target, "targetname");
    s_end = struct::get(s_start.target, "targetname");
    e_player namespace_79e1cd97::function_ed7faf05();
    e_player notify(#"hash_b2d41628");
    e_player util::function_16c71b8(1);
    e_player thread zipline_player(self.trigger, s_start, s_end);
    wait 1.5;
    self.trigger.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x7899e995, Offset: 0x5468
// Size: 0xc5
function function_b78bbba4() {
    var_21c0cedf = [];
    while (!level flag::get("zipline_done")) {
        var_d0f085 = trigger::wait_till("trig_zipline_player_spawns", "targetname");
        if (!array::contains(var_21c0cedf, var_d0f085.who)) {
            level.var_960b4a94++;
            if (level.activeplayers.size && level.var_960b4a94 >= level.activeplayers.size) {
                level flag::set("zipline_done");
                continue;
            }
            array::add(var_21c0cedf, var_d0f085.who);
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x90b241f2, Offset: 0x5538
// Size: 0x72
function function_76529a7a() {
    level flag::wait_till("zipline_done");
    self gameobjects::destroy_object();
    hidemiscmodels("collapse_frogger_water");
    hidemiscmodels("lt_wharf_water");
    hidemiscmodels("vista_water");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x82a49173, Offset: 0x55b8
// Size: 0x13a
function function_1357e282(var_eda6085e) {
    self waittill(#"movedone");
    if (isplayer(var_eda6085e)) {
        var_eda6085e stoploopsound(0.5);
    }
    v_on_navmesh = getclosestpointonnavmesh(self.origin, 100, 48);
    if (isdefined(v_on_navmesh)) {
        self moveto(v_on_navmesh, 0.25);
    }
    if (!isplayer(var_eda6085e)) {
        self scene::play("cin_gen_traversal_zipline_enemy02_dismount", var_eda6085e);
    }
    self unlink();
    self delete();
    if (var_eda6085e == level.var_3d556bcd) {
        level flag::set("kane_landed");
        return;
    }
    if (isplayer(var_eda6085e)) {
        var_eda6085e thread namespace_79e1cd97::player_anchor();
        level flag::set("zipline_player_landed");
        var_eda6085e util::function_16c71b8(0);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 2, eflags: 0x0
// Checksum 0x5a24bafb, Offset: 0x5700
// Size: 0x1ce
function function_9d556a71(var_3b8db917, var_4faa1e49) {
    var_3169a073 = getent(var_4faa1e49, "targetname");
    var_3169a073.b_in_use = 1;
    s_start = struct::get(var_3169a073.target, "targetname");
    s_end = struct::get(s_start.target, "targetname");
    var_3b8db917 playsound("evt_zipline_attach");
    var_eeed805e = util::spawn_model("tag_origin", s_start.origin, s_start.angles);
    if (var_3b8db917 == level.var_3d556bcd) {
        var_eeed805e scene::play("cin_gen_traversal_zipline_enemy02_attach", var_3b8db917);
    }
    var_3b8db917 playloopsound("evt_zipline_npc_move", 0.3);
    var_eeed805e thread scene::play("cin_gen_traversal_zipline_enemy02_idle", var_3b8db917);
    n_dist = distance(s_start.origin, s_end.origin);
    n_time = n_dist / 750;
    var_eeed805e moveto(s_end.origin, n_time, n_time / 2, 0.1);
    var_eeed805e thread function_1357e282(var_3b8db917);
    var_3b8db917 stoploopsound(0.5);
    var_3169a073.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xf839b83a, Offset: 0x58d8
// Size: 0xf2
function function_9694617b() {
    level flag::wait_till("blackstation_exterior_engaged");
    level dialog::remote("kane_you_got_hostiles_inb_0", 1);
    level flag::wait_till("lightning_strike");
    level.var_2fd26037 dialog::say("hend_their_grunts_will_ha_0", 1);
    level flag::wait_till("warlord_go");
    level dialog::remote("kane_enemy_warlord_0", 2);
    level.var_2fd26037 dialog::say("hend_reinforcements_comin_1", 2);
    level flag::wait_till("goto_entrance");
    level.var_2fd26037 dialog::say("hend_kane_we_got_eyes_o_0", 5);
}

// Namespace cp_mi_sing_blackstation_station
// Params 2, eflags: 0x0
// Checksum 0x2110d6cb, Offset: 0x59d8
// Size: 0x2ea
function function_a870c9be(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_blackstation_interior");
        namespace_79e1cd97::function_da579a5d("objective_blackstation_interior");
        level.var_3d556bcd colors::set_force_color("y");
        trigger::use("trig_blackstation_interior");
        level thread function_5493cb1d();
        level flag::set("blackstation_entry");
        objectives::complete("cp_level_blackstation_rendezvous");
        objectives::set("cp_level_blackstation_goto_station");
        level scene::init("cin_bla_14_02_blackstation_vign_takepoint");
        while (!scene::is_ready("cin_bla_14_02_blackstation_vign_takepoint")) {
            wait 0.05;
        }
        load::function_a2995f22();
    }
    objectives::complete("cp_level_blackstation_goto_station");
    level scene::init("cin_bla_14_06_blackstation_1st_approachdoor");
    level thread function_3d53956f();
    level thread namespace_79e1cd97::function_6778ea09("none");
    spawner::add_spawn_function_group("group_driller", "script_aigroup", &function_872c1dfe);
    spawner::add_spawn_function_group("interior_looter1", "targetname", &function_fa27d153);
    level thread function_fb2359a2();
    level thread function_c51fef21();
    level thread function_fc21e39b();
    level thread function_7bba9576();
    level thread function_bd050a2d();
    level.var_2fd26037 notify(#"hash_a2ba32d");
    level.var_3d556bcd notify(#"hash_a2ba32d");
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_3d556bcd ai::set_behavior_attribute("cqb", 1);
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_3d556bcd ai::set_ignoreall(1);
    level clientfield::set("sndBlackStationSounds", 1);
}

// Namespace cp_mi_sing_blackstation_station
// Params 4, eflags: 0x0
// Checksum 0x507bae99, Offset: 0x5cd0
// Size: 0x3a
function function_2846e098(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_blackstation_blackstation");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xf7dc4a0d, Offset: 0x5d18
// Size: 0x92
function function_fb2359a2() {
    trigger::wait_till("trig_waypoint_station03");
    level thread scene::play("cin_bla_14_05_blackstation_vign_drilling_idle");
    level thread scene::play("cin_bla_14_04_blackstation_aie_looting_a_idle");
    level flag::wait_till("drill_engaged");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_3d556bcd ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0xf1d5af84, Offset: 0x5db8
// Size: 0x62
function function_bd050a2d() {
    level flag::wait_till("driller_patrol");
    level flag::wait_till_timeout(8, "drill_engaged");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_3d556bcd ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x47e1504f, Offset: 0x5e28
// Size: 0x5a
function function_872c1dfe() {
    self endon(#"death");
    self thread function_99610c91();
    self thread function_2a08d4df();
    level flag::wait_till("drill_engaged");
    level thread scene::play(self.script_noteworthy);
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x5b74a671, Offset: 0x5e90
// Size: 0xb5
function function_2a08d4df() {
    self endon(#"death");
    level endon(#"drill_engaged");
    while (true) {
        foreach (player in level.activeplayers) {
            if (self cansee(player) && self.targetname != "interior_looter1_ai") {
                level flag::set("drill_engaged");
            }
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x800366f6, Offset: 0x5f50
// Size: 0x62
function function_99610c91() {
    self endon(#"death");
    self util::waittill_any("damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "driller_go");
    level flag::set("drill_engaged");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x7be27a6c, Offset: 0x5fc0
// Size: 0x4a
function function_fa27d153() {
    self endon(#"death");
    self thread function_99610c91();
    level flag::wait_till("drill_engaged");
    level thread scene::play("cin_bla_14_04_blackstation_aie_looting_a_react");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x894cab8c, Offset: 0x6018
// Size: 0x10a
function function_7bba9576() {
    level flag::wait_till("drill_engaged");
    level thread scene::play("cin_bla_14_05_blackstation_vign_drilling_react4");
    level clientfield::set("sndDrillWalla", 0);
    var_88fd08c3 = getaiteamarray("axis");
    foreach (var_973053c8 in var_88fd08c3) {
        var_973053c8 notify(#"driller_go");
    }
    level.var_54dc3c4c = spawn("script_origin", (-712, 9546, 368));
    level.var_54dc3c4c playloopsound("vox_black_15_02_004_salm");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x1dd13fe5, Offset: 0x6130
// Size: 0x4a
function function_893b7d1f() {
    self endon(#"death");
    level endon(#"drill_engaged");
    self waittill(#"weapon_fired");
    level flag::set("driller_patrol");
    level flag::set("drill_engaged");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x6f5fb22b, Offset: 0x6188
// Size: 0x2b2
function function_c51fef21() {
    t_door = getent("trig_end_igc_door", "targetname");
    t_door triggerenable(0);
    spawner::waittill_ai_group_cleared("group_driller");
    trigger::use("triggercolor_station_door");
    level thread namespace_4297372::function_973b77f9();
    wait 1;
    objectives::set("cp_level_blackstation_door", struct::get("outro_igc"));
    t_door triggerenable(1);
    t_door trigger::wait_till();
    t_door delete();
    level.var_54dc3c4c stoploopsound();
    foreach (player in level.activeplayers) {
        player thread namespace_79e1cd97::function_ed7faf05();
    }
    level.var_2fd26037 colors::disable();
    level.var_3d556bcd colors::disable();
    level.var_2fd26037 setgoal(level.var_2fd26037.origin);
    level.var_3d556bcd setgoal(level.var_3d556bcd.origin);
    level thread namespace_4297372::function_6048af60();
    level scene::play("cin_bla_14_06_blackstation_1st_approachdoor", t_door.who);
    mdl_clip = getent("bs_station_clip", "targetname");
    mdl_clip notsolid();
    mdl_clip connectpaths();
    objectives::complete("cp_level_blackstation_door", struct::get("outro_igc"));
    skipto::function_be8adfb8("objective_blackstation_interior");
    wait 1;
    level.var_54dc3c4c delete();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x94891a9c, Offset: 0x6448
// Size: 0xfa
function function_5493cb1d() {
    level flag::wait_till("blackstation_entry");
    level thread namespace_4297372::function_674f7650();
    level.var_2fd26037 dialog::say("hend_okay_let_s_see_wh_0");
    level flag::wait_till("driller_sound");
    level clientfield::set("sndDrillWalla", 1);
    foreach (player in level.activeplayers) {
        player thread function_893b7d1f();
    }
    level.var_2fd26037 dialog::say("hend_something_up_ahead_0");
}

// Namespace cp_mi_sing_blackstation_station
// Params 0, eflags: 0x0
// Checksum 0x471ac1a4, Offset: 0x6550
// Size: 0x162
function function_fc21e39b() {
    trigger::wait_till("trig_blackstation_interior");
    level.var_2fd26037 thread function_7c4f357d("nd_hendricks_boiler", "hendricks_ready");
    level.var_3d556bcd thread function_7c4f357d("nd_kane_boiler", "kane_ready");
    util::waittill_multiple("hendricks_ready", "kane_ready");
    namespace_79e1cd97::cleanup_ai();
    level scene::add_scene_func("cin_bla_14_02_blackstation_vign_takepoint", &function_362c6fe1);
    level scene::play("cin_bla_14_02_blackstation_vign_takepoint");
    objectives::set("cp_level_blackstation_goto_center");
    mdl_clip = getent("clip_boiler_room", "targetname");
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
    savegame::checkpoint_save();
    streamerrequest("set", "cp_mi_sing_blackstation_objective_end_igc");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0xcf544b87, Offset: 0x66c0
// Size: 0x52
function function_362c6fe1(a_ents) {
    level.var_2fd26037 colors::enable();
    level.var_3d556bcd colors::enable();
    trigger::use("triggercolor_past_boiler");
}

// Namespace cp_mi_sing_blackstation_station
// Params 2, eflags: 0x0
// Checksum 0x7c3f3d42, Offset: 0x6720
// Size: 0x5c
function function_7c4f357d(var_9e2ba1f1, str_notify) {
    self colors::disable();
    self setgoal(getnode(var_9e2ba1f1, "targetname"), 1);
    self waittill(#"goal");
    wait 1;
    level notify(str_notify);
}

// Namespace cp_mi_sing_blackstation_station
// Params 2, eflags: 0x0
// Checksum 0x1b57e3b, Offset: 0x6788
// Size: 0x1d2
function function_2783ca83(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_end_igc");
        namespace_79e1cd97::function_da579a5d("objective_end_igc");
        level scene::init("cin_bla_15_outro_3rd_sh010");
        load::function_a2995f22();
    }
    level notify(#"end_igc");
    level thread namespace_4297372::function_6048af60();
    level thread audio::unlockfrontendmusic("mus_blackstation_theme_intro");
    level scene::add_scene_func("cin_bla_15_outro_3rd_sh010", &function_bffd5cf, "play");
    level scene::add_scene_func("cin_bla_15_outro_3rd_sh070", &function_f94ebed5, "play");
    level scene::add_scene_func("cin_bla_15_outro_3rd_sh210", &function_c10be1, "play");
    level scene::add_scene_func("cin_bla_15_outro_3rd_sh210", &function_92a23169, "done");
    if (isdefined(level.var_8b2530b4)) {
        level thread [[ level.var_8b2530b4 ]]();
    }
    array::run_all(getcorpsearray(), &delete);
    level scene::play("cin_bla_15_outro_3rd_sh010");
}

// Namespace cp_mi_sing_blackstation_station
// Params 4, eflags: 0x0
// Checksum 0xa4512922, Offset: 0x6968
// Size: 0x22
function function_392085c9(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x605d1837, Offset: 0x6998
// Size: 0x22
function function_f94ebed5(a_ents) {
    level thread scene::play("cin_bla_15_outro_3rd_sh070_bodies");
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x6d55ce91, Offset: 0x69c8
// Size: 0x42
function function_bffd5cf(a_ents) {
    level clientfield::set("outro_exposure", 1);
    level waittill(#"hash_8823b64");
    level lui::screen_fade(0.5);
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0xd85e7a42, Offset: 0x6a18
// Size: 0x6b
function function_c10be1(a_ents) {
    foreach (player in level.activeplayers) {
        player util::function_16c71b8(1);
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1, eflags: 0x0
// Checksum 0x1a3ecb76, Offset: 0x6a90
// Size: 0x22
function function_92a23169(a_ents) {
    skipto::function_be8adfb8("objective_end_igc");
}

