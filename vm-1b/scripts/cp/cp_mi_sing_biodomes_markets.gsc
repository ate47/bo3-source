#using scripts/shared/ai/robot_phalanx;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/warlord;
#using scripts/shared/ai/archetype_warlord_interface;
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
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_dialog;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/_squad_control;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/gametypes/_save;

#namespace cp_mi_sing_biodomes_markets;

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xeda5d5e9, Offset: 0x1a30
// Size: 0x242
function main() {
    var_83b0c601 = getentarray("hendricks_markets1_scene_triggers", "script_noteworthy");
    level thread array::thread_all(var_83b0c601, &function_ddde0fc3);
    spawner::add_spawn_function_group("sp_markets1_warlord", "targetname", &function_7ff66080);
    spawner::add_spawn_function_group("sp_markets2_warlord", "targetname", &function_ff2bafac);
    spawner::add_spawn_function_group("headpop_guys", "script_noteworthy", &function_2a1badc);
    spawner::add_spawn_function_group("markets2_rpg_tower", "script_noteworthy", &markets2_rpg_tower);
    spawner::add_spawn_function_group("markets2_ambush_guys", "script_noteworthy", &markets2_ambush_guys);
    spawner::add_spawn_function_group("sp_markets2_bridge_retreat", "targetname", &function_f4ed98ea);
    spawner::add_spawn_function_group("markets2_robot_rushers", "script_noteworthy", &markets2_robot_rushers);
    level.var_9198e8fa = [];
    spawner::add_spawn_function_group("sp_markets1_start_anim", "script_noteworthy", &ai::force_goal, undefined, 64);
    spawner::add_spawn_function_group("sp_markets1_weapongrab_leader", "targetname", &function_4a0994ae);
    spawner::add_spawn_function_group("markets1_magic_rpg", "script_noteworthy", &markets1_magic_rpg);
    function_7b244c18();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xc6627074, Offset: 0x1c80
// Size: 0x92
function function_7b244c18() {
    level scene::add_scene_func("cin_bio_03_01_market_vign_hendricksmoment_throw", &function_a5040920, "play");
    level scene::add_scene_func("cin_bio_03_01_market_vign_hendricksmoment_rush", &function_f4e90efd, "play");
    level scene::add_scene_func("cin_bio_04_01_market2_vign_explode", &function_b27f1679, "play");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x1b6eb9a5, Offset: 0x1d20
// Size: 0x1c2
function function_afd92016(str_side) {
    level endon(#"hash_efa973e9");
    var_1d92694f = getent("dumpster_markets1_push_sideways_" + str_side, "targetname");
    var_1d92694f disconnectpaths();
    s_align = struct::get("markets1_push_sideways_" + str_side);
    s_align scene::init(s_align.scriptbundlename, var_1d92694f);
    var_974cc07 = getnode("nd_markets1_push_sideways_" + str_side, "targetname");
    setenablenode(var_974cc07, 0);
    trigger::wait_till("trig_markets1_push_sideways_" + str_side);
    var_a715f176 = spawner::simple_spawn_single("sp_markets1_push_sideways_" + str_side);
    var_a715f176 ai::set_behavior_attribute("sprint", 1);
    var_a715f176 endon(#"death");
    var_a715f176 function_d87e0a34(1024);
    var_1d92694f connectpaths();
    a_ents = array(var_a715f176, var_1d92694f);
    s_align thread function_73bcc8bf(var_a715f176, var_1d92694f);
    s_align scene::play("cin_gen_aie_push_cover_sideways_no_dynpath", a_ents);
    s_align notify(#"hash_5c016b54");
    setenablenode(var_974cc07, 1);
    var_1d92694f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0xfced729f, Offset: 0x1ef0
// Size: 0x4a
function function_73bcc8bf(var_a715f176, var_1d92694f) {
    self endon(#"hash_5c016b54");
    var_a715f176 waittill(#"death");
    self scene::stop("cin_gen_aie_push_cover_sideways_no_dynpath");
    var_1d92694f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x8723ffc, Offset: 0x1f48
// Size: 0x1ca
function function_d3cdcc7a(str_side) {
    level endon(#"hash_efa973e9");
    var_db712e4f = getent("table_markets1_flip_" + str_side, "targetname");
    var_db712e4f disconnectpaths();
    s_align = struct::get("markets1_flip_" + str_side);
    s_align scene::init("cin_gen_aie_table_flip_no_dynpath", var_db712e4f);
    var_f377c056 = getnode("nd_markets1_flip_" + str_side, "targetname");
    setenablenode(var_f377c056, 0);
    trigger::wait_till("trig_markets1_flip_" + str_side);
    var_7f7b2bb8 = spawner::simple_spawn_single("sp_markets1_flip_" + str_side);
    var_7f7b2bb8 ai::set_behavior_attribute("sprint", 1);
    var_7f7b2bb8 endon(#"death");
    var_7f7b2bb8 function_d87e0a34(1024);
    a_ents = array(var_7f7b2bb8, var_db712e4f);
    s_align thread function_2188c8d1(var_7f7b2bb8, var_db712e4f);
    s_align thread scene::play("cin_gen_aie_table_flip_no_dynpath", a_ents);
    var_db712e4f waittill(#"connect_paths");
    var_db712e4f connectpaths();
    var_7f7b2bb8 waittill(#"hash_3bcf8b97");
    setenablenode(var_f377c056, 1);
    var_db712e4f thread function_1d148f52();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0xfb03fc2, Offset: 0x2120
// Size: 0x4a
function function_2188c8d1(var_7f7b2bb8, var_db712e4f) {
    var_7f7b2bb8 endon(#"hash_3bcf8b97");
    var_7f7b2bb8 waittill(#"death");
    self scene::stop("cin_gen_aie_table_flip_no_dynpath");
    var_db712e4f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x6759ea3d, Offset: 0x2178
// Size: 0x1a
function function_1d148f52() {
    self waittill(#"disconnect_paths");
    self disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x68383ce2, Offset: 0x21a0
// Size: 0x3b1
function function_174b2742() {
    level endon(#"hash_9bb53038");
    trigger::wait_till("trig_markets1_warlord");
    spawn_manager::wait_till_complete("sm_markets1_warlord");
    while (true) {
        var_11657e7b = spawn_manager::function_423eae50("sm_markets1_warlord");
        foreach (var_c7a78bed in var_11657e7b) {
            var_c7a78bed.var_8e7be685 = [];
            foreach (player in level.activeplayers) {
                n_dist_sq = distancesquared(var_c7a78bed.origin, player.origin);
                if (!isdefined(var_c7a78bed.var_8e7be685)) {
                    var_c7a78bed.var_8e7be685 = [];
                } else if (!isarray(var_c7a78bed.var_8e7be685)) {
                    var_c7a78bed.var_8e7be685 = array(var_c7a78bed.var_8e7be685);
                }
                var_c7a78bed.var_8e7be685[var_c7a78bed.var_8e7be685.size] = n_dist_sq;
            }
            var_c7a78bed.e_target = undefined;
        }
        for (i = 0; i < level.activeplayers.size; i++) {
            var_43b73530 = undefined;
            n_dist_sq_closest = undefined;
            var_ab1697de = undefined;
            foreach (var_c7a78bed in var_11657e7b) {
                if (isdefined(var_c7a78bed.var_8e7be685)) {
                    for (i = 0; i < var_c7a78bed.var_8e7be685.size; i++) {
                        if (isdefined(var_c7a78bed.var_8e7be685[i]) && (!isdefined(n_dist_sq_closest) || var_c7a78bed.var_8e7be685[i] < n_dist_sq_closest)) {
                            n_dist_sq_closest = var_c7a78bed.var_8e7be685[i];
                            var_ab1697de = i;
                            var_43b73530 = var_c7a78bed;
                        }
                    }
                }
            }
            var_43b73530.e_target = level.activeplayers[var_ab1697de];
            var_43b73530.var_8e7be685 = undefined;
            foreach (var_c7a78bed in var_11657e7b) {
                if (isdefined(var_c7a78bed.var_8e7be685)) {
                    var_c7a78bed.var_8e7be685[var_ab1697de] = undefined;
                }
            }
        }
        if (var_11657e7b.size > level.activeplayers.size) {
            foreach (var_c7a78bed in var_11657e7b) {
                if (!isdefined(var_c7a78bed.e_target)) {
                    var_c7a78bed.e_target = arraysortclosest(level.activeplayers, var_c7a78bed.origin, 1)[0];
                }
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xe0c73380, Offset: 0x2560
// Size: 0x13d
function function_7ff66080() {
    self endon(#"death");
    self thread function_5a24feff();
    self.e_target = undefined;
    self.var_8fa11c4a = undefined;
    self cp_mi_sing_biodomes_util::function_f61c0df8("nd_market1_warlord", 2, 3);
    var_e812ecff = getent("vol_markets1_warlord_last", "targetname");
    a_volumes = getentarray("vol_markets1_warlord", "script_noteworthy");
    while (true) {
        if (isdefined(self.e_target)) {
            if (self.e_target istouching(var_e812ecff)) {
                var_bf84b114 = var_e812ecff;
            } else {
                var_bf84b114 = arraysortclosest(a_volumes, self.e_target.origin, 1)[0];
            }
            if (!isdefined(self.var_8fa11c4a) || self.var_8fa11c4a !== var_bf84b114) {
                self.var_8fa11c4a = var_bf84b114;
                self setgoal(self.var_8fa11c4a, 1);
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x7d2bac78, Offset: 0x26a8
// Size: 0xf3
function function_5a24feff() {
    self endon(#"death");
    level endon(#"warlord_vo_done");
    var_9f460d03 = 0;
    while (!var_9f460d03) {
        foreach (player in level.activeplayers) {
            if (player islookingat(self)) {
                var_9f460d03 = 1;
                break;
            }
        }
        wait 0.25;
    }
    level util::delay_notify(5, "warlord_vo_done");
    level flag::wait_till("markets1_intro_dialogue_done");
    level thread dialog::remote("kane_warlord_get_to_cove_0");
    level notify(#"warlord_vo_done");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0x2c9322fa, Offset: 0x27a8
// Size: 0x3d2
function objective_markets_start_init(str_objective, var_74cd64bc) {
    objectives::set("cp_level_biodomes_cloud_mountain");
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets_start_init");
    if (var_74cd64bc) {
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level thread cp_mi_sing_biodomes::function_69468f09(1);
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        level waittill(#"end_igc");
        streamerrequest("clear", "cin_bio_02_04_gunplay_vign_stab");
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    if (isdefined(level.var_f22c67b)) {
        level thread [[ level.var_f22c67b ]]();
    }
    level thread cp_mi_sing_biodomes_util::function_cc20e187("markets1", 1);
    level.var_996e05eb = "friendly_spawns_markets_start";
    trigger::use("trig_hendricks_color_marketst1");
    level flag::set("markets1_enemies_alert");
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets1"));
    objectives::hide("cp_waypoint_breadcrumb");
    savegame::checkpoint_save();
    level thread namespace_f1b4cbbc::function_fa2e45b8();
    level thread function_174b2742();
    level thread function_afd92016("left");
    level thread function_d3cdcc7a("left");
    level thread function_afd92016("right");
    level thread function_d3cdcc7a("right");
    trigger::wait_till("trig_markets1_combat2");
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters_left", "info_volume_markets1_left", 2, 4);
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters_right", "info_volume_markets1_right", 2, 4);
    trigger::wait_till("trig_markets1_pushback");
    spawn_manager::kill("sm_markets1_combat0");
    spawn_manager::kill("sm_markets1_combat1");
    spawn_manager::kill("sm_markets1_combat2");
    spawn_manager::kill("sm_markets1_combat3");
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_snipers", "info_volume_markets1_rear", 1, 4);
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters", "info_volume_markets1_rear", 1, 4);
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters_left", "info_volume_markets1_rear", 2, 4);
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters_right", "info_volume_markets1_rear", 1, 3);
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets1_retreaters_last", "info_volume_markets1_rear", 3, 6);
    level scene::init("p7_fxanim_cp_biodomes_cafe_window_break_right_bundle");
    level scene::init("p7_fxanim_cp_biodomes_cafe_window_break_left_bundle");
    trigger::wait_till("trig_markets_rpg");
    level notify(#"hash_efa973e9");
    level skipto::function_be8adfb8("objective_markets_start");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x71ef2df9, Offset: 0x2b88
// Size: 0x3a
function function_4a0994ae() {
    self waittill(#"death");
    if (level scene::is_playing("cin_bio_03_01_market_aie_weapons")) {
        level scene::stop("cin_bio_03_01_market_aie_weapons");
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xc0b120f1, Offset: 0x2bd0
// Size: 0x16a
function function_8387168c() {
    level thread scene::add_scene_func("cin_gen_aie_table_react", &function_c7cb9a93, "done");
    level waittill(#"hash_ec11d3eb");
    spawner::simple_spawn("sp_markets1_friendly_robot_start");
    spawn_manager::enable("sm_markets1_combat0");
    spawn_manager::enable("sm_markets1_combat1");
    level.turret_markets1 = spawner::simple_spawn_single("turret_markets1");
    level.turret_markets1 thread function_70da4f9b();
    level thread function_5d4c2323();
    level thread function_b1e84c2();
    trigger::use("trig_markets1_combat1");
    level thread scene::play("cin_bio_03_01_market_vign_engage");
    level thread scene::play("cin_bio_03_01_market_aie_weapons");
    level thread scene::play("cin_gen_aie_table_react");
    wait 2;
    level flag::set("markets1_enemies_alert");
    level clientfield::set("sndIGCsnapshot", 0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x4cb7e292, Offset: 0x2d48
// Size: 0xf5
function function_d87e0a34(var_78850f88) {
    n_distance_sq = var_78850f88 * var_78850f88;
    var_9f460d03 = 0;
    while (!var_9f460d03) {
        foreach (player in level.activeplayers) {
            n_distance = distance2dsquared(player.origin, self.origin);
            if (player util::is_looking_at(self, 0.6, 1) && n_distance < 1000000 || n_distance < n_distance_sq) {
                var_9f460d03 = 1;
                break;
            }
        }
        wait 0.25;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x47e72f67, Offset: 0x2e48
// Size: 0x19a
function function_5d4c2323() {
    while (!isdefined(level.var_2fd26037)) {
        wait 0.05;
    }
    battlechatter::function_d9f49fba(0);
    level dialog::function_13b3b16a("plyr_plan_b_0");
    level.var_2fd26037 dialog::say("hend_plan_b_into_comms_0");
    level dialog::function_13b3b16a("plyr_i_thought_you_and_da_0");
    level.var_2fd26037 dialog::say("hend_yeah_so_did_i_0");
    level dialog::remote("kane_robot_squad_activati_0", 1);
    level.var_2fd26037 dialog::say("hend_you_finished_triangu_0", 3);
    level dialog::remote("kane_got_em_data_drives_0");
    level.var_2fd26037 dialog::say("hend_are_you_fucking_kidd_0");
    level dialog::function_13b3b16a("plyr_how_much_do_you_wann_0");
    level dialog::remote("kane_overwatch_shows_cdp_0");
    objectives::show("cp_waypoint_breadcrumb");
    level.var_2fd26037 dialog::say("hend_you_kidding_me_wha_0");
    battlechatter::function_d9f49fba(1);
    level flag::set("markets1_intro_dialogue_done");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x665f2ff5, Offset: 0x2ff0
// Size: 0x15a
function function_b1e84c2() {
    trigger::wait_till("trig_markets1_combat3");
    var_bd9defd6 = spawner::get_ai_group_sentient_count("markets1_snipers");
    if (var_bd9defd6 > 0) {
        var_2d3d7b7 = [];
        var_2d3d7b7[0] = "hend_i_got_eyes_on_a_snip_0";
        var_2d3d7b7[1] = "hend_hostile_sniper_ahead_0";
        var_2d3d7b7[2] = "hend_eyes_up_sniper_in_p_0";
        level.var_2fd26037 dialog::say(cp_mi_sing_biodomes_util::function_7ff50323(var_2d3d7b7), 3);
    }
    var_207c708e = spawner::get_ai_group_sentient_count("markets1_riotshields");
    if (var_207c708e > 0) {
        var_2d3d7b7 = [];
        var_2d3d7b7[0] = "hend_riot_gear_incoming_0";
        var_2d3d7b7[1] = "hend_eyes_on_riot_gear_0";
        var_2d3d7b7[2] = "hend_riot_shields_comin_0";
        level.var_2fd26037 dialog::say(cp_mi_sing_biodomes_util::function_7ff50323(var_2d3d7b7), 3);
    }
    level flag::wait_till("markets1_enemies_retreating");
    level.var_2fd26037 thread dialog::say("hend_they_re_falling_back_0", 5);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x26cd65e3, Offset: 0x3158
// Size: 0x85
function function_ddde0fc3() {
    self endon(#"death");
    while (self istriggerenabled()) {
        self trigger::wait_till();
        if (self.who == level.players[0]) {
            if (isstring(self.target)) {
                level.var_2fd26037 thread function_563bb5b3(self.target);
            }
            self triggerenable(0);
        }
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0xdd08b8e3, Offset: 0x31e8
// Size: 0xa2
function function_563bb5b3(var_87b2bbe5) {
    switch (var_87b2bbe5) {
    case "nd_hendricks_wok1":
        level.var_2fd26037 thread function_1485f7dc();
        break;
    case "nd_hendricks_shelves":
        level.var_2fd26037 thread function_a67aaa62();
        break;
    default:
        break;
    }
    var_dfcbd82b = getnode(var_87b2bbe5, "targetname");
    if (isdefined(var_dfcbd82b)) {
        self setgoal(var_dfcbd82b);
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xe843c381, Offset: 0x3298
// Size: 0x32
function function_a67aaa62() {
    level scene::init("cin_bio_03_01_market_vign_hendricksmoment_rush");
    self waittill(#"goal");
    function_2e1ac4d4();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x2dc5e542, Offset: 0x32d8
// Size: 0xda
function function_2e1ac4d4() {
    var_d36f9bf = "trig_hendricks_moment_colors_right";
    var_68833421 = spawner::simple_spawn_single("sp_markets1_shelfguy");
    if (isalive(var_68833421)) {
        var_68833421 ai::set_ignoreme(1);
        level scene::add_scene_func("cin_bio_03_01_market_vign_hendricksmoment_rush_enemy", &function_3a8d91fc, "play");
        level thread function_a3bac88("cin_bio_03_01_market_vign_hendricksmoment_rush", var_68833421, var_d36f9bf);
        level scene::play("cin_bio_03_01_market_vign_hendricksmoment_rush_enemy", var_68833421);
        return;
    }
    level thread function_a3bac88("cin_bio_03_01_market_vign_hendricksmoment_rush", undefined, var_d36f9bf);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x6e3f5df1, Offset: 0x33c0
// Size: 0x22
function function_3a8d91fc(a_ents) {
    level scene::play("cin_bio_03_01_market_vign_hendricksmoment_rush");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xfde44f78, Offset: 0x33f0
// Size: 0x6a
function function_1485f7dc() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level scene::add_scene_func("cin_bio_03_01_market_vign_hendricksmoment_throw", &function_b347511d, "init");
    level scene::init("cin_bio_03_01_market_vign_hendricksmoment_throw");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0xc73b1b5a, Offset: 0x3468
// Size: 0xca
function function_b347511d(a_ents) {
    var_d36f9bf = "trig_hendricks_color_markets1_left1";
    var_eb8ef003 = spawner::simple_spawn_single("sp_hendricks_enemy_throw_1");
    if (isalive(var_eb8ef003)) {
        level scene::add_scene_func("cin_bio_03_01_market_vign_hendricksmoment_throw_enemy", &function_af620536, "play");
        level thread function_a3bac88("cin_bio_03_01_market_vign_hendricksmoment_throw", var_eb8ef003, var_d36f9bf);
        level scene::play("cin_bio_03_01_market_vign_hendricksmoment_throw_enemy", var_eb8ef003);
        return;
    }
    level thread function_a3bac88("cin_bio_03_01_market_vign_hendricksmoment_throw", undefined, var_d36f9bf);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0xe78bcde0, Offset: 0x3540
// Size: 0x52
function function_af620536(a_ents) {
    level scene::play("cin_bio_03_01_market_vign_hendricksmoment_throw");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 3, eflags: 0x0
// Checksum 0xd83d60b0, Offset: 0x35a0
// Size: 0x9a
function function_a3bac88(str_scene, ai_enemy, var_d36f9bf) {
    if (isalive(ai_enemy)) {
        ai_enemy waittill(#"death");
    }
    level scene::stop(str_scene);
    wait 0.15;
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    trigger::use(var_d36f9bf, "targetname", undefined, 0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0xd02cac0e, Offset: 0x3648
// Size: 0x14
function function_a5040920(a_ents) {
    level waittill(#"hash_d1c9c0a9");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x79a42d7a, Offset: 0x3668
// Size: 0x62
function function_f4e90efd(a_ents) {
    level waittill(#"hash_a04c5e57");
    var_8fbeee65 = getent("plaster_walls_01", "targetname");
    var_8fbeee65 notsolid();
    level scene::play("p7_fxanim_cp_newworld_plaster_walls_01_bundle");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0xef69d7ae, Offset: 0x36d8
// Size: 0x42
function function_1589a392(str_scene) {
    self.goalradius = 8;
    self ai::set_ignoreme(1);
    self waittill(#"death");
    level scene::stop(str_scene);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x44b0d01e, Offset: 0x3728
// Size: 0x7a
function function_c7cb9a93(a_ents) {
    var_524f5f14 = getent("sp_markets_table_react_chair", "targetname");
    var_27fbdccf = getent("sp_markets_table_react_table", "targetname");
    var_524f5f14 disconnectpaths();
    var_27fbdccf disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4, eflags: 0x0
// Checksum 0x2fa1c0a6, Offset: 0x37b0
// Size: 0x3a
function objective_markets_start_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets_start_done");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0xcbb792fb, Offset: 0x37f8
// Size: 0x2fa
function objective_markets_rpg_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets_rpg_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        cp_mi_sing_biodomes::function_cef897cf(str_objective);
        level scene::init("p7_fxanim_cp_biodomes_cafe_window_break_right_bundle");
        level scene::init("p7_fxanim_cp_biodomes_cafe_window_break_left_bundle");
        level.turret_markets1 = spawner::simple_spawn_single("turret_markets1");
        level.turret_markets1 thread function_70da4f9b();
        level thread clientfield::set("party_house_shutter", 1);
        level thread clientfield::set("party_house_destruction", 1);
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        objectives::set("cp_level_biodomes_cloud_mountain");
        objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets1"));
        level thread cp_mi_sing_biodomes_util::function_cc20e187("markets1");
        load::function_a2995f22();
        trigger::use("t_pre_turret1");
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    level.var_996e05eb = "friendly_spawns_markets_rpg";
    showmiscmodels("fxanim_nursery");
    showmiscmodels("fxanim_markets2");
    spawner::add_spawn_function_group("markets1_rpgguy", "script_noteworthy", &function_c008e227);
    trigger::wait_till("trig_markets_rpg");
    spawner::simple_spawn_single("sp_markets_rpg_dome_break", &markets1_magic_rpg);
    spawn_manager::enable("sm_markets_rpg_nest");
    level thread function_1711aacb();
    level thread function_e7229eec();
    wait 0.5;
    if (isalive(level.turret_markets1)) {
        level.turret_markets1 thread function_ac861f96();
    }
    trigger::wait_till("trig_markets2_start");
    level notify(#"hash_4893df48");
    level skipto::function_be8adfb8("objective_markets_rpg");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x12893091, Offset: 0x3b00
// Size: 0xfa
function function_ac861f96() {
    self endon(#"death");
    var_44dee395 = getent("turret_shutter_target", "targetname");
    self.ignoreall = 0;
    self.ignoreme = 0;
    var_6f458912 = getent("market_turret_clip", "targetname");
    var_6f458912 delete();
    self thread turret::shoot_at_target(var_44dee395, 3, (0, 0, 0), 0);
    self waittill(#"turret_on_target");
    self cybercom::function_a1f70a02("cybercom_hijack");
    var_44dee395 movez(64, 3);
    level flag::set("turret1");
    level scene::play("p7_fxanim_cp_biodomes_cafe_window_break_right_bundle");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xea84fe6d, Offset: 0x3c08
// Size: 0x5a
function function_c008e227() {
    self waittill(#"goal");
    var_fedce7e9 = getent("market_rpg_clip", "targetname");
    var_fedce7e9 delete();
    level scene::play("p7_fxanim_cp_biodomes_cafe_window_break_left_bundle");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xbb9a9cf2, Offset: 0x3c70
// Size: 0xc2
function function_1711aacb() {
    level endon(#"turret1_dead");
    level endon(#"hash_4893df48");
    level flag::wait_till("turret1");
    level.var_2fd26037 dialog::say("hend_take_out_that_turret_1", 1);
    level thread namespace_36171bd3::function_9c52a47e("floor_collapse");
    wait 6;
    level.var_2fd26037 dialog::say("hend_we_gotta_take_out_th_1");
    wait 8;
    level.var_2fd26037 dialog::say("hend_we_ain_t_movin_with_0");
    wait 10;
    level.var_2fd26037 dialog::say("hend_bring_down_that_turr_0");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xf6fe4633, Offset: 0x3d40
// Size: 0x5a
function function_e7229eec() {
    level endon(#"hash_4893df48");
    spawn_manager::wait_till_cleared("sm_markets_rpg_nest");
    level flag::wait_till("turret1_dead");
    level.var_2fd26037 dialog::say("hend_area_clear_0");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x563110d4, Offset: 0x3da8
// Size: 0xa2
function function_20e9cee4() {
    level scene::skipto_end("p7_fxanim_cp_biodomes_cafe_window_break_left_bundle");
    level scene::skipto_end("p7_fxanim_cp_biodomes_cafe_window_break_right_bundle");
    var_a8a0e766 = getent("market_turret_clip", "targetname");
    var_a8a0e766 delete();
    var_d8861eed = getent("market_rpg_clip", "targetname");
    var_d8861eed delete();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x1a31ad20, Offset: 0x3e58
// Size: 0x122
function function_254ce088(str_model) {
    var_197ca77b = getent(str_model, "targetname");
    assert(isdefined(var_197ca77b), str_model + "<dev string:x28>");
    var_d4cf8d4e = struct::get(var_197ca77b.target, "targetname");
    assert(isdefined(var_d4cf8d4e), str_model + "<dev string:x46>");
    if (isdefined(var_197ca77b) && isdefined(var_d4cf8d4e)) {
        var_d246e703 = var_197ca77b.angles - (0, 90, 0);
        var_197ca77b fx::play("dirt_impact", var_197ca77b.origin, var_d246e703, 4);
        var_197ca77b moveto(var_d4cf8d4e.origin, 0.5);
        var_197ca77b rotateto(var_d4cf8d4e.angles, 0.5);
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x8e8fef2c, Offset: 0x3f88
// Size: 0x122
function markets1_magic_rpg() {
    self waittill(#"death");
    var_9faa0c88 = getweapon("smaw");
    var_1987d48e = self gettagorigin("tag_aim");
    var_6893fc99 = struct::get("markets1_magic_rpg_dest", "targetname");
    var_3c91fda1 = magicbullet(var_9faa0c88, var_1987d48e + (5, 5, 5), var_6893fc99.origin);
    var_3c91fda1 waittill(#"death");
    playrumbleonposition("cp_biodomes_rpg_dome_rumble", var_6893fc99.origin);
    level clientfield::set("dome_glass_break", 1);
    var_1842712c = getent("rpg_dome_glass_clip", "targetname");
    var_1842712c delete();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4, eflags: 0x0
// Checksum 0x3597bb9e, Offset: 0x40b8
// Size: 0x6a
function objective_markets_rpg_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets_rpg_done");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets1"));
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0xb5c3c906, Offset: 0x4130
// Size: 0x3b2
function objective_markets2_start_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets2_start_init");
    level thread function_11549ce5();
    level thread function_f5120a68();
    level thread function_4ef9f5db();
    level thread function_1c8db87();
    if (var_74cd64bc) {
        load::function_73adcefc();
        array::delete_all(getentarray("triggers_markets1", "script_noteworthy"));
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        cp_mi_sing_biodomes::function_cef897cf(str_objective);
        level thread clientfield::set("party_house_shutter", 1);
        level thread clientfield::set("party_house_destruction", 1);
        level.turret_markets1 = spawner::simple_spawn_single("turret_markets1");
        level.turret_markets1 kill();
        thread function_20e9cee4();
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        level thread cp_mi_sing_biodomes_util::function_cc20e187("markets1");
        objectives::set("cp_level_biodomes_cloud_mountain");
        load::function_a2995f22();
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    if (isdefined(level.var_8b9b1711)) {
        level thread [[ level.var_8b9b1711 ]]();
    }
    level thread cp_mi_sing_biodomes_util::function_cc20e187("markets2", 1);
    level thread cp_mi_sing_biodomes_util::function_cc20e187("warehouse", 1);
    level.var_996e05eb = "friendly_spawns_markets2_tunnel";
    level scene::init("p7_fxanim_cp_biodomes_market_bridge_bundle");
    function_a7548a8f();
    cp_mi_sing_biodomes_util::function_a22e7052(0, "markets2_bridge_traversals", "script_noteworthy");
    hidemiscmodels("fxanim_party_house");
    showmiscmodels("fxanim_warehouse");
    trigger::wait_till("trig_warehouse_entrance");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_markets1_combat0");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_markets1_combat1");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_markets1_combat2");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_markets1_combat3");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_markets_rpg_nest");
    if (isalive(level.turret_markets1)) {
        level.turret_markets1 util::stop_magic_bullet_shield();
        level.turret_markets1 kill();
    }
    if (isalive(level.turret_markets2)) {
        level.turret_markets2 util::stop_magic_bullet_shield();
        level.turret_markets2 kill();
    }
    level skipto::function_be8adfb8("objective_markets2_start");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xcea46fff, Offset: 0x44f0
// Size: 0x1e2
function function_11549ce5() {
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_pit"));
    trigger::wait_till("trig_markets2_combat2b");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_pit"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_arch"));
    trigger::wait_till("trig_markets2_turret_intro");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_arch"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_bridge"));
    trigger::wait_till("trig_markets2_combat3");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_bridge"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_end"));
    trigger::wait_till("trig_warehouse_entrance");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets2_end"));
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x98cff34e, Offset: 0x46e0
// Size: 0x1ba
function function_a7548a8f() {
    level thread function_eb44b3e8();
    trigger::wait_till("trig_markets2_hendricks_pit");
    trigger::use("trig_hendricks_color_markets2_pit");
    spawn_manager::enable("sm_markets2_combat0");
    level.turret_markets2 = spawner::simple_spawn_single("turret_markets2");
    level.turret_markets2 thread function_9e873c98();
    level.turret_markets2 thread function_45ec4c38();
    level flag::set("turret2");
    trigger::wait_till("trig_markets2_combat2");
    level.var_2fd26037 notify(#"player_in_pit");
    level.var_2fd26037 notify(#"hash_ce815b72");
    level notify(#"hash_79fccdae");
    level.var_2fd26037 thread function_802808a0();
    trigger::wait_till("trig_markets2_turret_intro");
    level.var_996e05eb = "friendly_spawns_markets2_waterfall";
    spawn_manager::enable("sm_markets2_combat2c");
    spawn_manager::enable("sm_markets2_warlord");
    level thread function_306c7d29();
    level.var_2fd26037 notify(#"hash_e0a6f6d8");
    level thread cp_mi_sing_biodomes_util::function_a1669688("markets2_retreaters", "info_volume_markets2_rear", 0, 0.1);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xf833d380, Offset: 0x48a8
// Size: 0xaa
function markets2_ambush_guys() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self ai::set_behavior_attribute("coverIdleOnly", 1);
    level util::waittill_notify_or_timeout("player_in_pit", 5);
    wait randomfloatrange(0, 0.5);
    self ai::set_behavior_attribute("coverIdleOnly", 0);
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x90d58588, Offset: 0x4960
// Size: 0x1ca
function function_802808a0() {
    self notify(#"hash_ce815b72");
    level flag::wait_till("hendricks_markets2_arch_throw");
    var_e2b94783 = spawner::simple_spawn_single("sp_arch_thrown_off", &function_8fcead5c, "markets2_hendricks_throw_arch", 1);
    level scene::play("markets2_hendricks_throw_arch", "targetname", array(self, var_e2b94783));
    var_dfcbd82b = getnode("cover_hendricks_arch", "targetname");
    self setgoal(var_dfcbd82b);
    level flag::wait_till("hendricks_markets2_wallrun");
    var_87b6fa5f = spawner::simple_spawn_single("sp_hendricks_wallrun_fodder", &function_8fcead5c, "cin_bio_04_03_market2_vign_wallrun", 0);
    level scene::play("cin_bio_04_03_market2_vign_wallrun", array(self, var_87b6fa5f));
    var_dfcbd82b = getnode("nd_hendricks_window_after_wallrun", "targetname");
    self thread ai::force_goal(var_dfcbd82b, 12, 1, "goal", 1);
    self waittill(#"goal");
    self clearforcedgoal();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2, eflags: 0x0
// Checksum 0xd4dedd88, Offset: 0x4b38
// Size: 0x72
function function_8fcead5c(str_scene, var_5d5638aa) {
    self.goalradius = 8;
    self.goalheight = 8;
    self ai::set_ignoreme(1);
    self waittill(#"death");
    if (var_5d5638aa) {
        level scene::stop(str_scene, "targetname");
        return;
    }
    level scene::stop(str_scene);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x9ae22a67, Offset: 0x4bb8
// Size: 0x3a
function function_4eb79d4f(var_a92ac318) {
    level endon(#"hash_54ba776e");
    self waittill(#"death");
    wait 0.5;
    level scene::stop(var_a92ac318, "targetname");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x1cac7f, Offset: 0x4c00
// Size: 0xfa
function function_eb44b3e8() {
    level dialog::remote("kane_heads_up_got_54i_r_0");
    var_d65ac7cc = trigger::wait_till("trig_markets2_turret_intro");
    level.var_2fd26037 dialog::say("hend_moving_up_gimme_som_0");
    if (var_d65ac7cc.script_label == "path_arch") {
        level dialog::function_13b3b16a("plyr_covering_go_0");
    }
    trigger::wait_till("trig_rpg_tower_vo");
    if (!level flag::get("markets2_tower_destroyed")) {
        level thread dialog::function_13b3b16a("plyr_got_an_rpg_in_that_t_0");
    }
    level endon(#"turret2_dead");
    wait 8;
    level.var_2fd26037 dialog::say("hend_we_gotta_take_out_th_1");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1, eflags: 0x0
// Checksum 0x203a4729, Offset: 0x4d08
// Size: 0x59
function function_b27f1679(a_ents) {
    level notify(#"hash_ad26056f");
    for (i = 1; i <= 3; i++) {
        a_ents["sp_civilian_headpop" + i].var_70a4ef5f = a_ents["bomb_collar_" + i];
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x87ec233a, Offset: 0x4d70
// Size: 0x15a
function function_2a1badc() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self ai::gun_remove();
    level waittill(#"hash_ad26056f");
    self waittill(#"hash_49055167");
    self.var_70a4ef5f hide();
    playrumbleonposition("cp_biodomes_headpop_rumble", self.origin);
    foreach (player in level.players) {
        distance = distance2dsquared(player.origin, self.origin);
        if (distance < 160000 && self cansee(player)) {
            player dodamage(player.health * 0.1, self.origin);
        }
    }
    self util::stop_magic_bullet_shield();
    gibserverutils::gibhead(self);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x544739dd, Offset: 0x4ed8
// Size: 0x182
function function_1c8db87() {
    var_6f261beb = 6;
    var_80110940 = 4;
    var_72e94765 = [];
    for (m = 1; m <= var_6f261beb; m++) {
        var_83491dca = spawner::simple_spawn_single("bound_civ_male");
        var_83491dca.animname = "prisoner_male_0" + m;
        var_83491dca.overrideactordamage = &function_c1c247f6;
        if (!isdefined(var_72e94765)) {
            var_72e94765 = [];
        } else if (!isarray(var_72e94765)) {
            var_72e94765 = array(var_72e94765);
        }
        var_72e94765[var_72e94765.size] = var_83491dca;
    }
    for (f = 1; f <= var_80110940; f++) {
        var_83491dca = spawner::simple_spawn_single("bound_civ_female");
        var_83491dca.animname = "prisoner_female_0" + f;
        var_83491dca.overrideactordamage = &function_c1c247f6;
        if (!isdefined(var_72e94765)) {
            var_72e94765 = [];
        } else if (!isarray(var_72e94765)) {
            var_72e94765 = array(var_72e94765);
        }
        var_72e94765[var_72e94765.size] = var_83491dca;
    }
    level scene::play("cin_bio_04_01_market2_vign_caged", var_72e94765);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xa170b8c9, Offset: 0x5068
// Size: 0x183
function function_4ef9f5db() {
    var_64bc5989 = struct::get_array("prisoner_aligns", "script_noteworthy");
    var_d71a37a5 = spawn("script_origin", (9944, 12957, -163));
    var_d71a37a5 playloopsound("amb_slaves_a");
    var_fd1cb20e = spawn("script_origin", (9895, 13170, -163));
    var_fd1cb20e playloopsound("amb_slaves_b");
    foreach (s_align in var_64bc5989) {
        var_83491dca = spawner::simple_spawn_single(s_align.script_string);
        if (s_align.script_label == "male") {
            str_scene_name = "cin_bio_04_01_market2_vign_bound_civ01";
        } else {
            str_scene_name = "cin_bio_04_01_market2_vign_bound_civ02";
        }
        s_align thread scene::play(str_scene_name, var_83491dca);
        wait 1;
        var_83491dca kill();
        wait randomfloatrange(0, 2);
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x5b2f8c81, Offset: 0x51f8
// Size: 0x8b
function function_dbb91fcf() {
    var_64bc5989 = struct::get_array("prisoner_aligns", "script_noteworthy");
    foreach (s_align in var_64bc5989) {
        s_align scene::stop();
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 15, eflags: 0x0
// Checksum 0xfd7a9735, Offset: 0x5290
// Size: 0xeb
function function_c1c247f6(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, var_46043680, psoffsettime, var_3bc96147, var_269779a, var_829b9480, var_eca96ec1) {
    var_f6896234 = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), str_means_of_death);
    if (var_f6896234 && e_attacker isbadguy()) {
        n_damage = 0;
    }
    return n_damage;
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xddb897b5, Offset: 0x5388
// Size: 0xea
function function_45ec4c38() {
    self endon(#"death");
    trigger::wait_till("trig_markets2_turret_intro");
    s_markets2_turret_target = struct::get("s_markets2_turret_target", "targetname");
    var_975c918d = util::spawn_model("tag_origin", s_markets2_turret_target.origin, s_markets2_turret_target.angles);
    level.turret_markets2 turret::set_target(var_975c918d, (0, 0, 0), 0);
    var_975c918d movex(40, 3);
    var_975c918d movey(-200, 3);
    var_975c918d waittill(#"movedone");
    level.turret_markets2 turret::clear_target(0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x649fbfe9, Offset: 0x5480
// Size: 0x152
function markets2_rpg_tower() {
    level thread function_226ac1e4();
    self waittill(#"death");
    var_9faa0c88 = getweapon("smaw");
    if (sessionmodeiscampaignzombiesgame()) {
        tag = "tag_eye";
    } else {
        tag = "tag_aim";
    }
    var_1987d48e = self gettagorigin("tag_aim");
    v_origin = self.origin;
    var_2f7fd5db = self.damageweapon;
    if (var_2f7fd5db == getweapon("gadget_mrpukey")) {
        wait 2;
    } else {
        wait 0.5;
    }
    magicbullet(var_9faa0c88, var_1987d48e, v_origin);
    playrumbleonposition("cp_biodomes_rpg_tower_rumble", v_origin);
    level notify(#"hash_f311a0e2");
    level flag::set("markets2_tower_destroyed");
    level scene::play("p7_fxanim_cp_biodomes_guard_tower_warehouse_bundle");
    namespace_769dc23f::function_b5cf7b68();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x2414e253, Offset: 0x55e0
// Size: 0xb4
function function_226ac1e4() {
    trigger::wait_till("trig_markets2_rpg_tower_warning");
    var_9faa0c88 = getweapon("smaw");
    var_11fd5f3f = struct::get("markets2_rpg_tower_warning_launch", "targetname");
    var_6beedec9 = struct::get("markets2_rpg_tower_warning_target", "targetname");
    var_3c91fda1 = magicbullet(var_9faa0c88, var_11fd5f3f.origin, var_6beedec9.origin);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xf37f7525, Offset: 0x56a0
// Size: 0x9a
function function_f4ed98ea() {
    self endon(#"death");
    level endon(#"hash_f7452abe");
    self thread function_e143a359();
    self ai::set_ignoreall(1);
    var_9de10fe3 = getnode(self.target, "targetname");
    if (isdefined(var_9de10fe3)) {
        self ai::force_goal(var_9de10fe3, 12, 0, "goal", 0, 1);
        self waittill(#"goal");
    }
    self ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xa2d36531, Offset: 0x5748
// Size: 0x3a
function function_e143a359() {
    self endon(#"goal");
    self endon(#"death");
    level waittill(#"hash_f7452abe");
    self ai::set_ignoreall(0);
    self clearforcedgoal();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xfc276d10, Offset: 0x5790
// Size: 0x2a
function markets2_robot_rushers() {
    self endon(#"death");
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x4f1f220, Offset: 0x57c8
// Size: 0x272
function function_f5120a68() {
    level endon(#"hash_3fe031c0");
    trigger::wait_till("trig_markets2_turret_intro");
    var_b31ff87c = spawner::simple_spawn_single("sp_bridge_controller");
    if (isalive(var_b31ff87c)) {
        level thread scene::play("cin_bio_04_01_market2_vign_bridge_destroy", var_b31ff87c);
        level thread util::delay_notify(15, "retract_bridge");
        level util::waittill_any_ents_two(level, "retract_bridge", var_b31ff87c, "death");
        if (level scene::is_playing("cin_bio_04_01_market2_vign_bridge_destroy")) {
            level scene::stop("cin_bio_04_01_market2_vign_bridge_destroy");
        }
    }
    level thread scene::play("p7_fxanim_cp_biodomes_market_bridge_bundle");
    var_97268a8e = struct::get("breadcrumb_markets2_bridge", "targetname");
    if (isdefined(var_97268a8e)) {
        playrumbleonposition("cp_biodomes_markets2_bridge_rumble", var_97268a8e.origin);
        foreach (player in level.activeplayers) {
            distance = distance2dsquared(player.origin, var_97268a8e.origin);
            if (distance < 160000) {
                player dodamage(player.health * 0.1, var_97268a8e.origin);
            }
        }
    }
    var_29c45e93 = getent("markets2_bridge_collision", "targetname");
    if (isdefined(var_29c45e93)) {
        var_29c45e93 notsolid();
        var_29c45e93 disconnectpaths();
    }
    level notify(#"hash_f7452abe");
    cp_mi_sing_biodomes_util::function_a22e7052(1, "markets2_bridge_traversals", "script_noteworthy");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xf5932511, Offset: 0x5a48
// Size: 0xd2
function function_306c7d29() {
    trigger::wait_till("trig_markets2_robot_colors_end");
    level.var_996e05eb = "friendly_spawns_markets2_warlord";
    v_start = struct::get("phalanx_markets2_start").origin;
    v_end = struct::get("phalanx_markets2_end").origin;
    var_1b6ee6b2 = 4;
    if (level.players.size >= 2) {
        var_1b6ee6b2 = 6;
    }
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize("phanalx_wedge", v_start, v_end, 2, var_1b6ee6b2);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xffa0ec9, Offset: 0x5b28
// Size: 0x5a
function function_ff2bafac() {
    self endon(#"death");
    self setthreatbiasgroup("warlords");
    setthreatbias("heroes", "warlords", -9999);
    self cp_mi_sing_biodomes_util::function_f61c0df8("node_warlord_markets2_preferred", 1, 2);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4, eflags: 0x0
// Checksum 0x187de42d, Offset: 0x5b90
// Size: 0x43
function objective_markets2_start_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_markets2_start_done");
    level notify(#"hash_3fe031c0");
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0x4d6be7fe, Offset: 0x5be0
// Size: 0xda
function function_70da4f9b() {
    self.var_2ddc2ef9 = 0;
    self.var_38c1e4c8 = 0;
    level.turret_markets1.ignoreall = 1;
    level.turret_markets1.ignoreme = 1;
    self cybercom::function_59965309("cybercom_hijack");
    self.script_noteworthy = "floor_collapse";
    level.turret_markets1 turret::set_on_target_angle(1, 0);
    self waittill(#"death");
    level flag::set("turret1_dead");
    var_dfcbd82b = getnode("cover_hendricks_headpopper", "targetname");
    level.var_2fd26037 setgoal(var_dfcbd82b, 1);
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0, eflags: 0x0
// Checksum 0xa5fda9f3, Offset: 0x5cc8
// Size: 0x32
function function_9e873c98() {
    self waittill(#"death");
    level flag::set("turret2_dead");
    savegame::checkpoint_save();
}

