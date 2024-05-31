#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/_util;
#using scripts/cp/_squad_control;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_laststand;
#using scripts/cp/_hacking;
#using scripts/cp/_dialog;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_f5edec75;

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x2720
// Size: 0x4
function precache() {
    
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x9af21219, Offset: 0x2730
// Size: 0x19c
function main() {
    spawner::add_spawn_function_group("rambo", "script_noteworthy", &function_c81145c2);
    spawner::add_spawn_function_group("rusher", "script_noteworthy", &function_6a4cb712);
    spawner::add_spawn_function_group("hunter_flybys", "script_noteworthy", &function_45d0a02a);
    spawner::add_spawn_function_group("cloud_mountain_reinforcements", "script_noteworthy", &function_715d6f43);
    spawner::add_spawn_function_group("cloud_mountain_retreaters", "script_noteworthy", &function_ec47b2e6);
    spawner::add_spawn_function_group("level_3_surprised_enemies", "script_noteworthy", &function_2c36cacd);
    spawner::add_spawn_function_group("pod_spawners", "script_noteworthy", &function_e99db423);
    spawner::add_spawn_function_group("sp_cloudmountain_level_2_warlord", "targetname", &function_a288e474);
    level thread function_7c81648();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x584e77ce, Offset: 0x28d8
// Size: 0x2a4
function function_710c7f6a() {
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_warehouse"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
    objectives::hide("cp_waypoint_breadcrumb");
    trigger::wait_till("trig_level_2_enemy_spawns_1");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_03");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_04");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_04"));
    trigger::wait_till("trig_level_3_catwalk_reinforcements");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain04"));
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
    trigger::wait_till("trig_breadcrumb_cloudmountain_end");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0x7ddae0ac, Offset: 0x2b88
// Size: 0x1cc
function function_34f37fe(str_objective, var_74cd64bc) {
    namespace_27a45d31::function_ddb0eeea("objective_cloudmountain_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_27a45d31::function_bff1a867(str_objective);
        namespace_55d2f1be::function_cef897cf(str_objective);
        level flag::set("back_door_opened");
        var_b06d4473 = getent("back_door_player_clip", "targetname");
        var_b06d4473 delete();
        spawn_manager::enable("cloud_mountain_siegebot_manager");
        level thread namespace_27a45d31::function_753a859(str_objective);
        level thread namespace_23646cee::function_cb52a73();
        level thread namespace_23646cee::function_1b03da0e();
        level thread namespace_27a45d31::function_cc20e187("warehouse");
        level thread namespace_27a45d31::function_cc20e187("cloudmountain", 1);
        load::function_a2995f22();
    }
    hidemiscmodels("fxanim_markets2");
    level thread namespace_f1b4cbbc::function_2e34977e();
    level thread function_6da34baf();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xbb177087, Offset: 0x2d60
// Size: 0x1dc
function function_6da34baf() {
    level thread function_710c7f6a();
    level thread function_a52ff7c1();
    level thread function_11f04863();
    level thread function_d532cc21();
    spawner::add_spawn_function_ai_group("cloud_mountain_entrance_bridge", &function_4df7264d);
    spawn_manager::enable("manager_phalanx_humans_bridge");
    level thread function_a234f527();
    level thread function_efae47c8();
    level thread function_9a10cb7d();
    level thread function_85070883();
    level thread function_333f5b5b();
    level thread namespace_23646cee::glass_break("trig_cloudmountain_glass1");
    level thread namespace_23646cee::glass_break("trig_cloudmountain_glass2");
    level thread namespace_23646cee::glass_break("trig_cloudmountain_glass3");
    trigger::wait_till("trig_cloud_mountain_level_2_start");
    level.var_2fd26037 colors::enable();
    level.var_2fd26037 clearforcedgoal();
    skipto::function_be8adfb8("objective_cloudmountain");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x7ab71133, Offset: 0x2f48
// Size: 0x34
function function_9a10cb7d() {
    level endon(#"hash_19af2c9a");
    level waittill(#"hash_ce48e0c4");
    spawn_manager::enable("manager_phalanx_humans_overhead");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xcef0fad2, Offset: 0x2f88
// Size: 0x16c
function function_efae47c8() {
    spawn_manager::wait_till_complete("cloud_mountain_siegebot_manager");
    var_c81e3075 = spawn_manager::function_423eae50("cloud_mountain_siegebot_manager");
    objectives::set("cp_level_biodomes_siegebot", var_c81e3075);
    foreach (var_51a7831a in var_c81e3075) {
        var_51a7831a thread function_7ec07da9();
    }
    var_60104d0b = level util::waittill_any_return("cloudmountain_siegebots_dead", "cloudmountain_siegebots_skipped");
    if (var_60104d0b == "cloudmountain_siegebots_skipped") {
        level thread function_f6a70610(var_c81e3075);
    }
    objectives::set("cp_level_biodomes_servers");
    objectives::complete("cp_level_biodomes_siegebot");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x2b2c401e, Offset: 0x3100
// Size: 0x174
function function_7ec07da9() {
    level endon(#"hash_1530fdbd");
    level endon(#"hash_b6c3b80a");
    e_attacker = self waittill(#"death");
    objectives::function_66c6f97b("cp_level_biodomes_siegebot", self);
    wait(1);
    battlechatter::function_d9f49fba(0);
    if (isplayer(e_attacker)) {
        level dialog::function_13b3b16a("plyr_siege_bot_is_s_o_l_0");
        var_7a45cb6d = "hendricks";
    } else {
        level.var_2fd26037 dialog::say("hend_that_fucker_s_done_0");
        var_7a45cb6d = "player";
    }
    battlechatter::function_d9f49fba(1);
    var_dcd92b65 = spawner::get_ai_group_ai("cloudmountain_siegebots");
    if (var_dcd92b65.size) {
        var_dcd92b65[0] thread function_1932917(var_7a45cb6d);
        level notify(#"hash_1530fdbd");
        return;
    }
    level function_a1fa89a2();
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xada5be6b, Offset: 0x3280
// Size: 0xf4
function function_1932917(var_f7824075) {
    self waittill(#"death");
    level endon(#"hash_b6c3b80a");
    objectives::function_66c6f97b("cp_level_biodomes_siegebot", self);
    wait(1);
    battlechatter::function_d9f49fba(0);
    if (var_f7824075 == "player") {
        level dialog::function_13b3b16a("plyr_siege_bot_is_s_o_l_0");
    } else if (var_f7824075 == "hendricks") {
        level.var_2fd26037 dialog::say("hend_that_fucker_s_done_0");
    }
    battlechatter::function_d9f49fba(1);
    level function_a1fa89a2();
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x337dfd69, Offset: 0x3380
// Size: 0xb2
function function_f6a70610(var_c81e3075) {
    level waittill(#"hash_69d6458d");
    foreach (var_51a7831a in var_c81e3075) {
        if (isalive(var_51a7831a)) {
            var_51a7831a kill();
        }
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x9b22402f, Offset: 0x3440
// Size: 0xa4
function function_a1fa89a2() {
    level flag::set("cloudmountain_siegebots_dead");
    level thread namespace_f1b4cbbc::function_973b77f9();
    level thread namespace_27a45d31::function_a1669688("cloud_mountain_entrance_bridge", "cloudmountain_lobby_retreat_volume", 2, 4);
    trigger::use("trig_hendricks_lobby_entrance_colors", "targetname", undefined, 0);
    savegame::checkpoint_save();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x60334b1b, Offset: 0x34f0
// Size: 0xe4
function function_a234f527() {
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_they_gotta_siege_bot_0");
    level.var_2fd26037 dialog::say("hend_we_don_t_have_the_fi_0", 2);
    level dialog::remote("kane_it_s_heavily_armored_0");
    battlechatter::function_d9f49fba(1);
    level util::waittill_either("cloudmountain_siegebots_dead", "cloudmountain_siegebots_skipped");
    wait(2);
    level thread function_b2ae6383();
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x2473d90a, Offset: 0x35e0
// Size: 0x17a
function function_b2ae6383(var_b146902) {
    if (!isdefined(var_b146902)) {
        var_b146902 = 0;
    }
    if (!var_b146902) {
        battlechatter::function_d9f49fba(0);
        level dialog::remote("kane_server_room_s_locate_0", 1);
        objectives::show("cp_waypoint_breadcrumb");
        level.var_2fd26037 dialog::say("hend_guess_we_re_going_up_0");
        battlechatter::function_d9f49fba(1);
    }
    level thread function_170b0353(var_b146902);
    level thread namespace_f1b4cbbc::function_6c35b4f3();
    trigger::wait_till("trig_cloud_mountain_level_2_start");
    wait(2);
    battlechatter::function_d9f49fba(0);
    level dialog::function_13b3b16a("plyr_third_floor_where_n_0");
    level dialog::remote("kane_server_room_directly_0");
    battlechatter::function_d9f49fba(1);
    level notify(#"hash_e36f3648");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xd92e7815, Offset: 0x3768
// Size: 0x46a
function function_170b0353(var_b146902) {
    if (!isdefined(var_b146902)) {
        var_b146902 = 0;
    }
    level endon(#"hash_be472a4a");
    if (!var_b146902) {
        if (!level flag::get("cloudmountain_second_floor_vo")) {
            trigger::wait_till("trig_cloudmountain_second_floor_vo");
            battlechatter::function_d9f49fba(0);
            level.var_2fd26037 dialog::say("hend_take_the_second_floo_0");
            level dialog::remote("kane_ex_fil_on_marker_bi_0", 1);
            level.var_2fd26037 dialog::say("hend_copy_that_0");
            battlechatter::function_d9f49fba(1);
        }
    }
    level waittill(#"hash_e36f3648");
    wait(5);
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_you_need_to_hustle_0");
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("cloudmountain_hunter_spawned");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_kane_they_gotta_hun_0", 2);
    level dialog::remote("kane_do_not_engage_the_hu_1");
    level dialog::remote("kane_long_as_you_re_in_th_0");
    level.var_2fd26037 dialog::say("hend_fan_fucking_tastic_1");
    level.var_2fd26037 dialog::say("hend_more_reinforcements_0", 2);
    level dialog::remote("kane_leave_em_goh_xiula_0");
    battlechatter::function_d9f49fba(1);
    if (!level flag::get("end_level_2_sniper_vo")) {
        foreach (player in level.activeplayers) {
            player thread function_e2e19ed7("cm_level_2_snipers", "end_level_2_sniper_vo");
        }
    }
    level flag::wait_till("cloudmountain_level_3_catwalk_vo");
    level flag::set("end_level_2_sniper_vo");
    if (!level flag::get("end_level_3_sniper_vo")) {
        battlechatter::function_d9f49fba(0);
        level.var_2fd26037 dialog::say("hend_they_re_on_the_walkw_0", 1);
        battlechatter::function_d9f49fba(1);
        foreach (player in level.activeplayers) {
            player thread function_e2e19ed7("cm_level_3_snipers", "end_level_3_sniper_vo");
        }
    }
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0x32ca960a, Offset: 0x3be0
// Size: 0x204
function function_e2e19ed7(var_69e64c43, var_2148cdcc) {
    level endon(var_2148cdcc);
    self endon(#"death");
    var_4d8945 = 0;
    while (!var_4d8945) {
        n_damage, e_attacker = self waittill(#"damage");
        var_5e764d1a = spawner::get_ai_group_ai(var_69e64c43);
        if (var_5e764d1a.size) {
            foreach (ai_sniper in var_5e764d1a) {
                if (ai_sniper == e_attacker) {
                    var_2d3d7b7 = [];
                    if (var_69e64c43 == "cm_level_2_snipers") {
                        var_2d3d7b7[0] = "hend_sniper_spotted_on_th_0";
                        var_2d3d7b7[1] = "hend_i_got_a_sniper_on_th_0";
                    } else {
                        var_2d3d7b7[0] = "hend_54i_sniper_on_the_ba_0";
                        var_2d3d7b7[1] = "hend_sniper_on_the_walkwa_0";
                    }
                    battlechatter::function_d9f49fba(0);
                    level.var_2fd26037 dialog::say(namespace_27a45d31::function_7ff50323(var_2d3d7b7));
                    battlechatter::function_d9f49fba(1);
                    var_4d8945 = 1;
                    break;
                }
            }
            continue;
        }
        break;
    }
    level flag::set(var_2148cdcc);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x89c571c8, Offset: 0x3df0
// Size: 0xfc
function function_333f5b5b() {
    level endon(#"hash_a68d9993");
    trigger::wait_till("trig_cloudmountain_first_floor_backup");
    spawn_manager::enable("sm_cloudmountain_level_2_amws");
    spawn_manager::enable("sm_cloudmountain_level_2_warlord");
    savegame::checkpoint_save();
    spawn_manager::wait_till_complete("sm_cloudmountain_level_2_amws");
    spawner::waittill_ai_group_ai_count("cloudmountain_first_floor_backup", 0);
    var_f62f0db4 = getnode("hendricks_cloudmountain_stairs", "targetname");
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 setgoal(var_f62f0db4, 1);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x2d78566f, Offset: 0x3ef8
// Size: 0x84
function function_a288e474() {
    self endon(#"death");
    self.goalradius = 1024;
    self.goalheight = 320;
    self setgoal(level.activeplayers[0]);
    self namespace_69ee7109::function_13ed0a8b(1);
    self namespace_27a45d31::function_f61c0df8("node_cloud_mountain_warlord_preferred", 1, 2);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x87b3729, Offset: 0x3f88
// Size: 0x54
function function_7dffd386() {
    trigger::wait_till("trig_cloudmountain_first_floor_backup");
    if (!level flag::get("stalagtites_dropped")) {
        trigger::use("cloudmountain_entrance_stalagmite_01");
    }
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0x3294d3b0, Offset: 0x3fe8
// Size: 0x3c
function function_ace9f6d8(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("objective_cloudmountain_done");
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0xd0046065, Offset: 0x4030
// Size: 0x274
function function_8ce887a2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::set("cp_level_biodomes_servers");
        namespace_27a45d31::function_bff1a867(str_objective);
        level flag::set("back_door_opened");
        var_b06d4473 = getent("back_door_player_clip", "targetname");
        var_b06d4473 delete();
        var_31861e2e = getent("trig_level_2_robot_spawns", "targetname");
        if (isdefined(var_31861e2e)) {
            var_31861e2e delete();
        }
        function_8232942d();
        function_56019233();
        level thread namespace_27a45d31::function_753a859(str_objective);
        level.var_2fd26037 colors::enable();
        level thread function_710c7f6a();
        level thread function_11f04863();
        level thread function_85070883();
        level thread namespace_27a45d31::function_cc20e187("cloudmountain");
        load::function_a2995f22();
        level thread function_b2ae6383(1);
        level thread function_170b0353(1);
    }
    spawn_manager::enable("sm_cloud_mountain_riot_shield");
    level.var_2fd26037.goalradius = 256;
    trigger::wait_till("trig_turret_hallway_enemy_spawns");
    skipto::function_be8adfb8("objective_cloudmountain_level_2");
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0xfbdc987e, Offset: 0x42b0
// Size: 0x3c
function function_2013f39c(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("objective_cloudmountain_level_2_done");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x7df73b21, Offset: 0x42f8
// Size: 0x84
function function_8232942d() {
    var_82ac908a = getent("trig_cloudmountain_left_stairs_spawns", "targetname");
    var_82ac908a delete();
    var_7870fb88 = getent("trig_sm_level_1_rushers", "targetname");
    var_7870fb88 delete();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x252e926c, Offset: 0x4388
// Size: 0xe2
function function_56019233() {
    var_b6a97ee5 = getentarray("cloudmountain_level_1_glass_triggers", "script_noteworthy");
    foreach (var_799e4c3a in var_b6a97ee5) {
        glassradiusdamage(var_799e4c3a.origin, 100, 500, 500);
        var_799e4c3a delete();
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xc055c5d3, Offset: 0x4478
// Size: 0x170
function function_9d75973(var_b49710a9) {
    level endon(#"hash_478882aa");
    var_16de839d = getent("trig_exhibit_" + var_b49710a9, "targetname");
    while (true) {
        var_16de839d trigger::wait_till();
        switch (var_b49710a9) {
        case 102:
            var_16de839d dialog::say("Welcome to the Cloud Forest wildlife exhibit. Please take a moment to read the rules of conduct.", 0, 1);
            break;
        case 103:
            var_16de839d dialog::say("Hundreds of different animal species make their home among the flora of Cloud Forests across Southeast Asia.", 0, 1);
            break;
        case 104:
            var_16de839d dialog::say("Amphibians such as this Spotted Tree Frog are particularly well suited to the unique climate found here.", 0, 1);
            break;
        case 105:
            var_16de839d dialog::say("Tree Shrews are descended from one of the earliest known mammals on earth. They forage in the dense undergrowth at all hours of the day.", 0, 1);
            break;
        case 106:
            var_16de839d dialog::say("Up ahead is the overlook and elevator access to the Cloud Walk. Watch your step! Walkways are slippery when wet.", 0, 1);
            break;
        }
        wait(15);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xeab3167d, Offset: 0x45f0
// Size: 0xcc
function function_11f04863() {
    trigger::wait_till("level_2_catwalk_spawns", "targetname");
    e_door = getent("dome_side_door", "targetname");
    e_door connectpaths();
    e_door movez(100, 2);
    e_door waittill(#"movedone");
    level flag::wait_till("supertree_door_close");
    e_door movez(-100, 2);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xb3cb33d, Offset: 0x46c8
// Size: 0x1b4
function function_d532cc21() {
    level flag::init("stalagtites_dropped");
    var_897e5d1 = struct::get("stalactite_kill_zone", "targetname");
    trigger::wait_till("cloudmountain_entrance_stalagmite_01");
    level thread scene::play("p7_fxanim_cp_biodomes_stalagmite_01_bundle");
    level waittill(#"hash_422a3570");
    var_2ef43a6a = getdamageableentarray(var_897e5d1.origin, var_897e5d1.radius);
    var_2ef43a6a = array::exclude(var_2ef43a6a, level.activeplayers);
    if (var_2ef43a6a.size > 0) {
        namespace_769dc23f::function_8ca89944();
        foreach (victim in var_2ef43a6a) {
            victim kill();
        }
    }
    level flag::set("stalagtites_dropped");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x63d8464c, Offset: 0x4888
// Size: 0xe4
function function_45d0a02a() {
    self endon(#"death");
    level flag::set("cloudmountain_hunter_spawned");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self.nocybercom = 1;
    nd_start = getvehiclenode(self.target, "targetname");
    if (isdefined(nd_start)) {
        self vehicle_ai::start_scripted();
        self vehicle::get_on_and_go_path(nd_start);
        self delete();
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xb088644, Offset: 0x4978
// Size: 0x24
function function_715d6f43() {
    self endon(#"death");
    self ai::set_ignoreme(1);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x6eeb560c, Offset: 0x49a8
// Size: 0x94
function function_ec47b2e6() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    var_9de10fe3 = getnode(self.target, "targetname");
    if (isdefined(var_9de10fe3)) {
        self setgoal(var_9de10fe3, 1);
        self waittill(#"goal");
    }
    self delete();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x2f5d0a80, Offset: 0x4a48
// Size: 0x108
function function_2c36cacd() {
    self endon(#"death");
    self.goalradius = 4;
    self ai::set_ignoreall(1);
    trigger::wait_till("trig_lookat_level_3_surprised");
    wait(randomfloatrange(0.1, 0.5));
    self scene::play("cin_gen_vign_confusion_02", self);
    var_284ca6ef = getent("trig_level_3_catwalks_goal", "targetname");
    if (isdefined(var_284ca6ef)) {
        self setgoal(var_284ca6ef);
        self waittill(#"goal");
    }
    self ai::set_ignoreall(0);
    self.goalradius = 1024;
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xdcf32cd6, Offset: 0x4b58
// Size: 0x2bc
function function_e99db423() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self thread function_d7238641();
    var_f64bb476 = getent(self.target, "targetname");
    var_f64bb476 thread scene::init("p7_fxanim_cp_sgen_charging_station_open_01_bundle", var_f64bb476);
    str_scene = "cin_bio_07_03_climb_aie_charging_station";
    s_align = struct::get(var_f64bb476.target, "targetname");
    s_align thread scene::init(str_scene, self);
    while (true) {
        var_a3ef017f = 0;
        foreach (player in level.players) {
            n_distance_sq = distance2dsquared(self.origin, player.origin);
            if (player util::is_player_looking_at(self.origin) && n_distance_sq < 1000000 || n_distance_sq < 360000) {
                var_a3ef017f = 1;
                break;
            }
        }
        if (var_a3ef017f) {
            break;
        }
        wait(0.05);
    }
    s_align thread scene::play(str_scene, self);
    self waittill(#"glass_break");
    var_f64bb476 thread scene::play("p7_fxanim_cp_sgen_charging_station_open_01_bundle", var_f64bb476);
    self ai::set_ignoreme(0);
    var_2104bfe4 = self findbestcovernode();
    if (isdefined(var_2104bfe4)) {
        self setgoal(var_2104bfe4);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x2b76cf3c, Offset: 0x4e20
// Size: 0x34
function function_d7238641() {
    self endon(#"death");
    level waittill(#"hash_d7238641");
    self delete();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x70624c4, Offset: 0x4e60
// Size: 0x5c
function function_a52ff7c1() {
    function_6f311542();
    trigger::wait_till("trig_cloudmountain_elevators");
    spawner::simple_spawn("cloudmountain_elevator_enemy", &function_f5170df1, "cloudmountain");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x5c0c8180, Offset: 0x4ec8
// Size: 0x86
function function_7c81648() {
    var_9396ef10 = getspawnerarray("catwalk", "script_noteworthy");
    for (i = 0; i < var_9396ef10.size; i++) {
        var_9396ef10[i] spawner::add_spawn_function(&function_84f859bf);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x6f0da646, Offset: 0x4f58
// Size: 0x10
function function_84f859bf() {
    self.goalradius = 400;
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x582fa1ed, Offset: 0x4f70
// Size: 0xc4
function function_a36395f0() {
    var_3d912af2 = getentarray("cloudmountain_spawn_trigger", "script_noteworthy");
    foreach (trigger in var_3d912af2) {
        trigger delete();
    }
    function_8232942d();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xfb80474a, Offset: 0x5040
// Size: 0x94
function function_85070883() {
    trigger::wait_till("trig_cloud_mountain_reinforcements");
    spawner::add_spawn_function_group("sp_cloud_mountain_reinforcements_wasps", "targetname", &function_947a1ae8);
    spawn_manager::enable("sm_cloud_mountain_reinforcements");
    spawn_manager::enable("sm_cloud_mountain_reinforcements_wasps");
    spawn_manager::enable("sm_cloud_mountain_retreaters");
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0xa12ebf8, Offset: 0x50e0
// Size: 0x344
function function_df51ef25(str_objective, var_74cd64bc) {
    namespace_27a45d31::function_ddb0eeea("turret_hallway_init");
    if (!sessionmodeiscampaignzombiesgame()) {
        level scene::init("server_room_access_start", "targetname");
    }
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_27a45d31::function_bff1a867(str_objective);
        level.var_2fd26037 notify(#"hash_93bef291");
        level.var_2fd26037 colors::enable();
        objectives::set("cp_level_biodomes_servers");
        level thread namespace_27a45d31::function_753a859(str_objective);
        level thread namespace_27a45d31::function_cc20e187("cloudmountain");
        function_a36395f0();
        load::function_a2995f22();
        level thread namespace_f1b4cbbc::function_6c35b4f3();
    }
    level flag::init("turret_hallway_phalanx_dead");
    level thread function_ee13f890();
    level thread function_3679c70a();
    level thread function_f52ce87b();
    level thread function_de8fde30();
    spawner::waittill_ai_group_cleared("turret_hallway_group");
    function_58b4a5d6();
    level flag::set("turret_hall_clear");
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand()) {
            player laststand::auto_revive(player, 0);
        }
        if (isalive(player.hijacked_vehicle_entity)) {
            player.hijacked_vehicle_entity namespace_7cb6cd95::function_664c9cd6();
        }
    }
    skipto::function_be8adfb8("objective_turret_hallway");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xfb1755, Offset: 0x5430
// Size: 0x22c
function function_3679c70a() {
    level flag::wait_till("hendricks_near_turrets");
    battlechatter::function_d9f49fba(0);
    var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
    if (var_9d979b27.size > 0) {
        level.var_2fd26037 dialog::say("hend_focus_on_the_turrets_0");
    }
    var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
    if (var_9d979b27.size > 0) {
        var_653d9a07 = 0;
        var_85ee3d97 = 0;
        foreach (player in level.activeplayers) {
            if (isdefined(player.grenadetypesecondary.isemp) && player.grenadetypesecondary.isemp && player.grenadetypesecondarycount > 0) {
                var_653d9a07 = 1;
            }
            if (isdefined(player.grenadetypeprimary) && player.grenadetypeprimarycount > 0) {
                var_85ee3d97 = 1;
            }
        }
        if (var_653d9a07) {
            level dialog::remote("kane_your_emp_grenade_sho_0");
            return;
        }
        if (var_85ee3d97) {
            level dialog::remote("kane_toss_a_frag_in_there_0");
        }
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x5f9f1f4b, Offset: 0x5668
// Size: 0x17c
function function_f52ce87b() {
    level flag::wait_till("turret_hallway_phalanx");
    level flag::set("end_level_3_sniper_vo");
    v_start = struct::get("turret_hallway_phalanx_start").origin;
    v_end = struct::get("turret_hallway_phalanx_end").origin;
    var_1b6ee6b2 = 2;
    if (level.var_641fcd9c.size > 0) {
        var_1b6ee6b2 = 3;
    }
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize("phalanx_diagonal_left", v_start, v_end, 1, var_1b6ee6b2);
    while (phalanx.tier1robots_.size + phalanx.tier2robots_.size + phalanx.tier3robots_.size > 0) {
        wait(0.25);
    }
    level flag::set("turret_hallway_phalanx_dead");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xca5d3758, Offset: 0x57f0
// Size: 0x84
function function_de8fde30() {
    exploder::exploder("turret_light");
    trigger::wait_till("trig_turret_lights_damaged", "targetname");
    exploder::kill_exploder("turret_light");
    exploder::exploder("fx_turrethallway_turret_smk");
    scene::play("p7_fxanim_gp_floodlight_01_bundle");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x3dd8ddac, Offset: 0x5880
// Size: 0xce
function function_2c72fa5a() {
    self turret::enable_laser(1, 0);
    switch (self.script_string) {
    case 147:
        objectives::set("cp_level_biodomes_cloud_mountain_turret_left", self);
        self waittill(#"death");
        objectives::complete("cp_level_biodomes_cloud_mountain_turret_left", self);
        break;
    case 148:
        objectives::set("cp_level_biodomes_cloud_mountain_turret_right", self);
        self waittill(#"death");
        objectives::complete("cp_level_biodomes_cloud_mountain_turret_right", self);
        break;
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x88e03a5f, Offset: 0x5958
// Size: 0x44
function function_d8eaa27f(var_9d979b27) {
    level endon(#"hash_48527e55");
    function_c80e1213("turret_left");
    function_c80e1213("turret_right");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x73ab42d5, Offset: 0x59a8
// Size: 0xf4
function function_c80e1213(var_3199aef) {
    var_974cc07 = getnode("hendricks_" + var_3199aef, "targetname");
    level.var_2fd26037 setgoal(var_974cc07, 1);
    a_turrets = getaiarray(var_3199aef, "script_label");
    if (isalive(a_turrets[0])) {
        level.var_2fd26037 settargetentity(a_turrets[0]);
        while (isalive(a_turrets[0])) {
            wait(0.05);
        }
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xc7618814, Offset: 0x5aa8
// Size: 0x134
function function_ee13f890() {
    level flag::wait_till("a_player_sees_hallway_turrets");
    objectives::complete("cp_level_biodomes_servers");
    objectives::set("cp_level_biodomes_destroy_hallway_turrets");
    var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
    foreach (var_c316ad54 in var_9d979b27) {
        var_c316ad54 thread function_2c72fa5a();
    }
    level flag::wait_till("turret_hallway_phalanx_dead");
    function_d8eaa27f(var_9d979b27);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x52dc46e2, Offset: 0x5be8
// Size: 0x44
function function_58b4a5d6() {
    for (var_a4854031 = 1; var_a4854031; var_a4854031 = function_50c932d0()) {
        wait(1);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x5b36f128, Offset: 0x5c38
// Size: 0xf4
function function_50c932d0() {
    var_53efc9b3 = getent("turret_hallway_enemy_check_volume", "targetname");
    var_da0978dc = getaispeciesarray("axis", "all");
    foreach (e_enemy in var_da0978dc) {
        if (e_enemy istouching(var_53efc9b3)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0xddc3d540, Offset: 0x5d38
// Size: 0xcc
function function_9cfbecff(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_biodomes_destroy_hallway_turrets");
    objectives::set("cp_level_biodomes_awaiting_update");
    namespace_27a45d31::function_ddb0eeea("turret_hallway_done");
    getent("trig_turret_hallway_enemy_spawns", "targetname") delete();
    getent("trig_turret_hallway_defender_spawns", "targetname") delete();
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0x916d5abb, Offset: 0x5e10
// Size: 0x32c
function function_e696b86c(str_objective, var_74cd64bc) {
    namespace_27a45d31::function_ddb0eeea("xiulan_vignette_init");
    namespace_27a45d31::function_a22e7052(0, "server_room_window_mantle", "script_noteworthy");
    level thread util::function_d8eaed3d(2);
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_27a45d31::function_bff1a867(str_objective);
        level.var_2fd26037.goalradius = 32;
        objectives::set("cp_level_biodomes_awaiting_update");
        function_a36395f0();
        level scene::init("server_room_access_start", "targetname");
        level thread namespace_27a45d31::function_753a859(str_objective);
        var_777355da = getentarray("hallway_turret", "script_noteworthy");
        a_turrets = spawner::simple_spawn(var_777355da);
        array::run_all(a_turrets, &kill);
        level thread namespace_27a45d31::function_cc20e187("cloudmountain");
        load::function_a2995f22();
    }
    level.var_2fd26037 colors::disable();
    var_5cb57398 = getnode("nd_turret_win_idle", "targetname");
    level.var_2fd26037 setgoal(var_5cb57398);
    level thread function_9c35b4f7();
    e_clip = getent("turret_hallway_door_ai_clip", "targetname");
    e_clip delete();
    var_e5214b43 = getent("server_room_initial_bullet_brush_outer", "targetname");
    var_e5214b43 hide();
    var_f3ad8f26 = getent("server_room_initial_bullet_brush_inner", "targetname");
    var_f3ad8f26 hide();
    level thread scene::init("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
    level function_cd4c4257();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x9dba1d96, Offset: 0x6148
// Size: 0x9c
function function_cd4c4257() {
    level thread namespace_f1b4cbbc::function_973b77f9();
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_shit_she_s_uploadi_0");
    level dialog::remote("kane_it_s_uploading_direc_0");
    level notify(#"hash_9b74c38e");
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0x90cba906, Offset: 0x61f0
// Size: 0x9c
function function_e638433c() {
    self endon(#"death");
    self waittill(#"goal");
    v_look = struct::get("hallway_look_target").origin;
    self orientmode("face direction", self.origin - v_look);
    self waittill(#"enemy");
    self orientmode("face enemy");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xd7ecfa10, Offset: 0x6298
// Size: 0x10
function function_a0e7b9b7() {
    self.ignoreme = 1;
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xdadbd131, Offset: 0x62b0
// Size: 0x2fc
function function_9c35b4f7() {
    level waittill(#"hash_9b74c38e");
    v_offset = (0, 0, 0);
    var_e1e45904 = getent("trig_server_room_door_use_object", "targetname");
    var_e1e45904 show();
    var_ca0e9b65 = util::function_14518e76(var_e1e45904, %cp_level_biodomes_server_door, %CP_MI_SING_BIODOMES_CLOUDMOUNTAIN_ACCESS_TERMINAL, &function_9a82e132);
    level waittill(#"hash_69d6458d");
    a_enemies = getaiteamarray("axis");
    array::run_all(a_enemies, &delete);
    level clientfield::set("set_exposure_bank", 1);
    level thread function_d28364c1();
    level thread dialog::function_13b3b16a("plyr_we_have_to_take_her_0", 1);
    level thread namespace_f1b4cbbc::function_3919d226();
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh010", &function_2db7566e, "play");
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh020", &function_3de47a8b, "play");
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh090", &function_cbdd0b50, "play");
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh170", &function_7dedb1f0, "play");
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh190", &function_f1df85b9, "play");
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh260", &function_d065fdd0, "done");
    level.var_2fd26037.ignoreall = 1;
    if (isdefined(level.var_d9cf116b)) {
        level thread [[ level.var_d9cf116b ]]();
    }
    level scene::play("server_room_access_start", "targetname", level.var_f2be4c1f);
    skipto::function_be8adfb8("objective_xiulan_vignette");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x0
// Checksum 0xf9393aa0, Offset: 0x65b8
// Size: 0x2c
function function_934481ae(e_door) {
    objectives::set("cp_level_biodomes_server_door", e_door);
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xdba04c5d, Offset: 0x65f0
// Size: 0xa2
function function_9a82e132(e_player) {
    level.var_f2be4c1f = e_player;
    var_485a1dbf = struct::get("s_server_room_hack_pos");
    playsoundatposition("evt_hack_panel", var_485a1dbf.origin);
    self gameobjects::disable_object();
    objectives::complete("cp_level_biodomes_server_door");
    level notify(#"hash_69d6458d");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xd13d7e03, Offset: 0x66a0
// Size: 0xba
function function_2db7566e(a_ents) {
    foreach (player in level.players) {
        player cybercom::function_f8669cbf(1);
        player clientfield::increment_to_player("hack_dni_fx");
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x92637095, Offset: 0x6768
// Size: 0x74
function function_7dedb1f0(a_ents) {
    level waittill(#"hash_f7774ee4");
    level thread function_a91388d2(1);
    level waittill(#"hash_127c12ee");
    level flag::wait_till("server_control_room_door_open");
    level thread function_a91388d2(0);
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x9af95c5c, Offset: 0x67e8
// Size: 0x94
function function_d065fdd0(a_ents) {
    level notify(#"hash_d065fdd0");
    level clientfield::set("set_exposure_bank", 0);
    level util::function_93831e79("s_server_room_scene_end_warps");
    level thread util::clear_streamer_hint();
    videostart("cp_biodomes_env_serverhackvid4looping", 1);
}

// Namespace namespace_f5edec75
// Params 3, eflags: 0x0
// Checksum 0x90fbe0c4, Offset: 0x6888
// Size: 0xcc
function function_4a1b1d4c(team, player, success) {
    if (isdefined(success) && success) {
        self gameobjects::disable_object();
        var_2fc559ed = getent("server_room_door", "targetname");
        var_2fc559ed movez(100, 2);
        var_2fc559ed connectpaths();
        var_2fc559ed waittill(#"movedone");
        var_2fc559ed delete();
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x165b998b, Offset: 0x6960
// Size: 0x24
function function_3de47a8b(a_ents) {
    videostart("cp_biodomes_env_serverhackvid1");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x41b2dc60, Offset: 0x6990
// Size: 0x24
function function_cbdd0b50(a_ents) {
    videostart("cp_biodomes_env_serverhackvid2");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xa713e242, Offset: 0x69c0
// Size: 0x24
function function_f1df85b9(a_ents) {
    videostart("cp_biodomes_env_serverhackvid3");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x2a783964, Offset: 0x69f0
// Size: 0xdc
function function_a91388d2(b_open) {
    var_4fe84cbf = getent("server_control_room_door", "targetname");
    if (b_open) {
        var_4fe84cbf movey(50, 0.5);
        var_4fe84cbf waittill(#"movedone");
        level flag::set("server_control_room_door_open");
        return;
    }
    var_4fe84cbf movey(-50, 0.5);
    var_4fe84cbf waittill(#"movedone");
    level flag::clear("server_control_room_door_open");
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0xcd355b71, Offset: 0x6ad8
// Size: 0x154
function function_6be20b72(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("xiulan_vignette_done");
    objectives::complete("cp_level_biodomes_mainobj_capture_data_drives");
    var_2fc559ed = getent("server_room_door", "targetname");
    if (isdefined(var_2fc559ed)) {
        var_2fc559ed connectpaths();
        var_2fc559ed delete();
    }
    var_d9a05e72 = getent("server_room_door_clip", "targetname");
    if (isdefined(var_d9a05e72)) {
        var_d9a05e72 connectpaths();
        var_d9a05e72 delete();
    }
    getent("trig_server_room_door_use_object", "targetname") delete();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xf854b37c, Offset: 0x6c38
// Size: 0x280
function function_d28364c1() {
    level waittill(#"hash_67213d76");
    var_e5214b43 = getent("server_room_initial_bullet_brush_outer", "targetname");
    var_f3ad8f26 = getent("server_room_initial_bullet_brush_inner", "targetname");
    var_1c634edb = spawner::simple_spawn_single("server_room_initial_bullet_shooter");
    var_1c634edb endon(#"death");
    var_6b372cba = getnode("initial_shooter_node", "targetname");
    var_1c634edb setgoal(var_6b372cba, 1);
    if (!scene::function_b1f75ee9()) {
        var_1c634edb ai::set_ignoreme(1);
        var_1c634edb ai::set_ignoreall(1);
        var_1c634edb.perfectaim = 1;
        level waittill(#"hash_ab045282");
        var_1c634edb ai::set_ignoreall(0);
        var_1c634edb ai::shoot_at_target("normal", var_e5214b43, "tag_origin");
        var_18ee9c37 = getent("trig_initial_bullet_damage", "targetname");
        var_18ee9c37 util::waittill_notify_or_timeout("damage", 3);
        var_1c634edb.perfectaim = 0;
        var_1c634edb ai::set_ignoreme(0);
        var_1c634edb clearforcedgoal();
    }
    var_1c634edb.script_accuracy = 0.05;
    var_e5214b43 show();
    var_f3ad8f26 show();
    wait(5);
    var_1c634edb.script_accuracy = 1;
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0xac877075, Offset: 0x6ec0
// Size: 0x354
function function_8dacf956(str_objective, var_74cd64bc) {
    namespace_27a45d31::function_ddb0eeea("server_room_defend_init");
    objectives::complete("cp_level_biodomes_awaiting_update");
    getent("server_koolaid", "targetname") disconnectpaths();
    level thread function_a78ec4a();
    if (var_74cd64bc) {
        namespace_27a45d31::function_bff1a867(str_objective);
        function_a36395f0();
        level function_a91388d2(0);
        level thread scene::init("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
        namespace_27a45d31::function_a22e7052(0, "server_room_window_mantle", "script_noteworthy");
        var_777355da = getentarray("hallway_turret", "script_noteworthy");
        a_turrets = spawner::simple_spawn(var_777355da);
        array::run_all(a_turrets, &kill);
        e_clip = getent("turret_hallway_door_ai_clip", "targetname");
        e_clip delete();
        level thread namespace_27a45d31::function_753a859(str_objective);
        level flag::wait_till("all_players_spawned");
        level thread util::delay_notify(1, "server_room_intro_done");
    }
    hidemiscmodels("fxanim_cloud_mountain");
    level thread function_17d3780e();
    level thread function_d813e7f(var_74cd64bc);
    level thread function_564d6426();
    function_2d01c10e();
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand()) {
            player laststand::auto_revive(player, 0);
        }
    }
    skipto::function_be8adfb8("objective_server_room_defend");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x5e2a0d2d, Offset: 0x7220
// Size: 0x3c
function function_17d3780e() {
    level waittill(#"hash_d065fdd0");
    level notify(#"hash_5891b40a");
    objectives::set("cp_level_biodomes_defend_server_room", level.var_2fd26037);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x15c918c1, Offset: 0x7268
// Size: 0xfc
function function_a78ec4a() {
    level trigger::wait_till("server_room_all_players_in");
    var_2d1826b2 = getent("turret_hallway_front_door", "targetname");
    var_f2087d4a = getent("turret_hallway_door_clip", "targetname");
    var_f2087d4a linkto(var_2d1826b2);
    var_2d1826b2 connectpaths();
    var_2d1826b2 movez(-100, 1);
    var_2d1826b2 waittill(#"movedone");
    var_2d1826b2 disconnectpaths();
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x99424f13, Offset: 0x7370
// Size: 0xc52
function function_2d01c10e() {
    level.var_2e1f1d9a = [];
    level.var_2e1f1d9a[0] = getent("server_room_window_target0", "targetname");
    level.var_2e1f1d9a[1] = getent("server_room_window_target1", "targetname");
    level.var_2e1f1d9a[2] = getent("server_room_window_target2", "targetname");
    level.var_2e1f1d9a[3] = getent("server_room_window_target3", "targetname");
    a_nodes = getnodearray("swat_node", "script_noteworthy");
    foreach (node in a_nodes) {
        setenablenode(node, 0);
    }
    spawner::add_spawn_function_group("server_room_enemy_window", "targetname", &function_229a8bc9);
    spawner::add_spawn_function_group("server_room_enemy_elevator1", "targetname", &function_f5170df1, "server_room");
    spawner::add_spawn_function_group("server_room_enemy_elevator2", "targetname", &function_40ff4c80, "server_room");
    spawner::add_spawn_function_group("server_room_enemy_swat1", "targetname", &function_7b66a225);
    level waittill(#"hash_d065fdd0");
    level thread dialog::remote("kane_he_s_fine_0");
    savegame::checkpoint_save();
    level thread namespace_f1b4cbbc::function_46333a8a();
    playsoundatposition("evt_server_def_walla_1st", (603, 12812, 1184));
    playsoundatposition("evt_server_def_walla_2nd", (900, 12750, 1140));
    level notify(#"hash_f3c45157");
    wait(2);
    spawner::simple_spawn("server_room_enemy_window");
    spawner::add_spawn_function_ai_group("top_floor", &function_13ed10e0);
    spawn_manager::enable("server_room_wave_2_1");
    level util::waittill_notify_or_timeout("top_floor_breached", 10);
    spawn_manager::enable("server_room_wave_2_2");
    if (level flag::get("top_floor_breached")) {
        level thread dialog::function_13b3b16a("plyr_breach_on_the_second_0");
    }
    if (level.players.size < 3) {
        function_dbcb1086(1, 15, "top_floor");
    } else {
        function_dbcb1086(2, 10, "top_floor");
    }
    savegame::checkpoint_save();
    level thread dialog::remote("kane_download_at_twenty_p_0");
    playsoundatposition("evt_server_def_walla_3rd", (900, 12750, 1140));
    spawner::add_spawn_function_group("sp_server_room_background", "targetname", &namespace_6f13ba4a::function_76c56ee1);
    spawn_manager::enable("sm_server_room_background");
    level thread function_963807b1();
    level waittill(#"hash_b4a4fe67");
    if (level.players.size > 2) {
        function_dbcb1086(3, 10, "window", "top_floor", "hallway");
    } else {
        function_dbcb1086(3, 45, "window", "top_floor");
    }
    savegame::checkpoint_save();
    level dialog::remote("kane_download_at_forty_pe_0");
    playsoundatposition("evt_server_def_walla_bots_a", (1117, 13871, 1116));
    level function_88e395d2();
    spawner::simple_spawn("server_room_enemy_elevator1");
    if (level.players.size > 2) {
        spawner::simple_spawn("server_room_enemy_elevator2");
    }
    level thread function_28931f52();
    if (level.players.size > 2) {
        function_dbcb1086(5, 45, "hallway", "top_floor");
    } else {
        function_dbcb1086(8, 30, "hallway");
    }
    savegame::checkpoint_save();
    level function_88e395d2();
    spawner::simple_spawn("server_room_enemy_elevator1");
    if (level.players.size > 2) {
        spawner::simple_spawn("server_room_enemy_elevator2");
        wait(2);
        spawn_manager::enable("server_room_topfloor_fodder_manager", &function_d2bb2597);
    }
    level dialog::function_13b3b16a("plyr_more_hostiles_from_t_0");
    level thread dialog::remote("kane_download_at_sixty_pe_0", 1);
    playsoundatposition("evt_server_def_walla_bots_b", (1117, 13871, 1116));
    function_dbcb1086(2, 5, "hallway");
    if (level.players.size > 1) {
        spawn_manager::enable("server_room_fodder_manager_stairs", &function_d2bb2597);
    }
    spawn_manager::kill("server_room_topfloor_fodder_manager");
    function_dbcb1086(0, 25, "top_floor", "hallway", "window");
    savegame::checkpoint_save();
    level dialog::function_13b3b16a("plyr_we_gotta_get_the_hel_0");
    level thread dialog::remote("kane_download_at_eighty_p_0");
    playsoundatposition("evt_server_def_walla_4th", (1278, 13578, 1276));
    wait(3);
    function_560d15cf();
    wait(3);
    spawn_manager::enable("server_room_final_wave_manager", &function_d2bb2597);
    function_dbcb1086(2, 2, "final_wave");
    spawn_manager::enable("server_room_fodder_manager_stairs", &function_d2bb2597);
    if (level.players.size > 2) {
        wait(0.25);
        spawner::simple_spawn("server_room_enemy_hallway_final");
        var_31a99ad4 = getentarray("server_room_enemy_hallway_final_ai", "targetname");
        level thread function_ca5f1131(var_31a99ad4, "smoke_grenade_final_hallway1_start");
        wait(2);
        var_31a99ad4 = getentarray("server_room_enemy_hallway_final_ai", "targetname");
    }
    function_dbcb1086(3, 30, "hallway", "top_floor", "final_wave");
    spawn_manager::kill("server_room_fodder_manager_stairs");
    if (isalive(level.var_c7a78bed)) {
        level.var_c7a78bed waittill(#"death");
        level.var_c7a78bed namespace_69ee7109::function_94b1213d();
    }
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    wait(2);
    savegame::checkpoint_save();
    level thread dialog::remote("kane_download_complete_e_0");
    spawn_manager::kill("server_room_final_wave_manager");
    function_7ed3a33e();
    function_dbcb1086(0, 60, "window", "top_floor", "hallway", "final_wave");
    do {
        var_70369b18 = 0;
        a_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_enemies) {
            if (isalive(ai_enemy)) {
                if (ai_enemy.archetype === "human" || ai_enemy.archetype === "robot") {
                    var_70369b18 = 1;
                }
            }
        }
        wait(0.05);
    } while (var_70369b18);
    level notify(#"hash_fd7af6ca");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x29a655d4, Offset: 0x7fd0
// Size: 0x124
function function_229a8bc9() {
    self endon(#"death");
    self ai::set_behavior_attribute("sprint", 1);
    self util::waittill_any("goal", "near_goal");
    self ai::set_behavior_attribute("sprint", 0);
    str_scene_name = "cin_bio_10_01_serverroom_aie_breakin_enemy0" + self.script_int;
    self scene::init(str_scene_name, self);
    level waittill(#"hash_14bb5165");
    self scene::play(str_scene_name, self);
    level flag::wait_till("window_broken");
    self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
}

// Namespace namespace_f5edec75
// Params 2, eflags: 0x1 linked
// Checksum 0xd66f53cd, Offset: 0x8100
// Size: 0x1ce
function function_ca5f1131(a_enemies, var_7bcec858) {
    var_92792721 = getweapon("willy_pete_nd");
    var_aaeb38b0 = struct::get(var_7bcec858, "targetname");
    var_c863acc3 = struct::get(var_aaeb38b0.target, "targetname");
    var_b7ac748c = vectornormalize(var_c863acc3.origin - var_aaeb38b0.origin) * -56;
    foreach (ai in a_enemies) {
        if (isalive(ai) && isweapon(var_92792721)) {
            var_c863acc3 fx::play("smoke_grenade", var_c863acc3.origin);
            break;
        }
        var_c863acc3 fx::play("smoke_grenade", var_c863acc3.origin);
        break;
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xefb1610f, Offset: 0x82d8
// Size: 0x12c
function function_560d15cf() {
    var_479db1f9 = struct::get("warlord_smash", "targetname");
    playsoundatposition("evt_breach_warning", var_479db1f9.origin);
    wait(2);
    level thread scene::play("p7_fxanim_cp_biodomes_warlord_breach_01_bundle");
    playrumbleonposition("cp_biodomes_server_room_breach_rumble", var_479db1f9.origin);
    spawn_manager::enable("sm_server_room_riot_shield_breach");
    var_bfaffc0d = getent("server_koolaid", "targetname");
    var_bfaffc0d connectpaths();
    var_bfaffc0d delete();
    level thread dialog::remote("kane_hostiles_breaching_t_0", 1);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xf00783bb, Offset: 0x8410
// Size: 0x1e2
function function_7ed3a33e() {
    var_e17601b = [];
    var_ca9eeae1 = spawner::get_ai_group_ai("window");
    var_4ba8bf11 = spawner::get_ai_group_ai("top_floor");
    var_ef02bf0d = spawner::get_ai_group_ai("hallway");
    var_be5f20b9 = spawner::get_ai_group_ai("final_wave");
    var_e17601b = arraycombine(var_ca9eeae1, var_4ba8bf11, 1, 0);
    var_e17601b = arraycombine(var_e17601b, var_ef02bf0d, 1, 0);
    var_e17601b = arraycombine(var_e17601b, var_be5f20b9, 1, 0);
    e_goal = getent("server_room_window_goal_volume", "targetname");
    foreach (enemy in var_e17601b) {
        enemy setgoal(e_goal, 1);
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x3458b6ad, Offset: 0x8600
// Size: 0xe8
function function_451e55d0(var_190535de) {
    var_190535de endon(#"death");
    var_190535de.ignoreall = 1;
    var_7b6710fa = getent("server_room_window_goal_volume", "targetname");
    while (var_190535de istouching(var_7b6710fa) == 0) {
        wait(0.1);
        if (self getvelocity() == 0) {
            var_190535de setgoal(getnode("server_window_node", "targetname"));
        }
    }
    var_190535de.ignoreall = 0;
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x0
// Checksum 0xf04d0e91, Offset: 0x86f0
// Size: 0x184
function function_7f9c1afd() {
    self endon(#"death");
    var_bfbe03c6 = getent("server_room_entrance_goal_volume", "targetname");
    if (level flag::get("window_broken") == 0) {
        function_451e55d0(self);
    } else {
        self setgoal(var_bfbe03c6);
        return;
    }
    while (level flag::get("window_broken") == 0) {
        var_68b2835f = arraygetclosest(self.origin, level.var_2e1f1d9a);
        self ai::shoot_at_target("normal", var_68b2835f, undefined, 1);
        wait(1);
    }
    self setgoal(getnode("server_room_goal", "targetname"), 0, 256);
    self util::waittill_any("goal", "near_goal");
    self setgoal(var_bfbe03c6);
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xa0d08424, Offset: 0x8880
// Size: 0x184
function function_d813e7f(var_74cd64bc) {
    if (level scene::is_active("cin_bio_09_02_accessdrives_1st_sever_end_loop")) {
        level scene::stop("cin_bio_09_02_accessdrives_1st_sever_end_loop");
    }
    level waittill(#"hash_d065fdd0");
    level.var_2fd26037 notify(#"hash_93bef291");
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.ignoreall = 1;
    level.var_2fd26037 ai::set_ignoreme(1);
    level.var_2fd26037.goalradius = 1;
    var_f18b8368 = struct::get("hendricks_works_computer", "script_noteworthy");
    if (var_74cd64bc) {
        level thread function_a91388d2(1);
    }
    level.var_2fd26037 skipto::function_d9b1ee00(var_f18b8368);
    level.var_2fd26037 setgoal(level.var_2fd26037.origin);
    level thread scene::init("cin_bio_10_01_serverroom_vign_hack_loop");
}

// Namespace namespace_f5edec75
// Params 4, eflags: 0x1 linked
// Checksum 0x3231aa83, Offset: 0x8a10
// Size: 0x140
function function_9ed4c7c0(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_27a45d31::function_ddb0eeea("server_room_defend_done");
    objectives::complete("cp_level_biodomes_defend_server_room", level.var_2fd26037);
    objectives::complete("cp_level_biodomes_mainobj_upload_data");
    e_window = getent("server_window", "targetname");
    if (isdefined(e_window)) {
        e_window delete();
    }
    if (level scene::is_active("cin_bio_09_02_accessdrives_1st_sever_end_loop")) {
        level scene::stop("cin_bio_09_02_accessdrives_1st_sever_end_loop");
    }
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 clearforcedgoal();
        level.var_2fd26037.goalradius = 1024;
    }
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x3ffde1ec, Offset: 0x8b58
// Size: 0x39c
function function_f5170df1(str_location) {
    self endon(#"death");
    var_7da22691 = getent(self.script_noteworthy + "_l", "targetname");
    var_91c4d84f = getent(self.script_noteworthy + "_r", "targetname");
    self ai::set_ignoreall(1);
    self.goalradius = 1;
    level thread function_8bf5e64e(str_location);
    playsoundatposition("evt_elevator_ding", var_7da22691.origin);
    var_7da22691.var_92bda14 = var_7da22691.origin;
    var_91c4d84f.var_92bda14 = var_91c4d84f.origin;
    var_aa55666b = struct::get(var_7da22691.target, "targetname");
    var_2bc53ed1 = struct::get(var_91c4d84f.target, "targetname");
    var_7da22691.var_ee4758e4 = var_aa55666b.origin;
    var_91c4d84f.var_ee4758e4 = var_2bc53ed1.origin;
    var_7da22691 moveto(var_7da22691.var_ee4758e4, 1);
    var_91c4d84f moveto(var_91c4d84f.var_ee4758e4, 1);
    var_7da22691 waittill(#"movedone");
    level thread function_c9d85cf6(self, var_7da22691, var_91c4d84f);
    nd_target = getnode(self.target, "targetname");
    self setgoal(nd_target);
    function_524e3ee1(self);
    self ai::set_ignoreall(0);
    if (str_location == "cloudmountain") {
        self ai::set_behavior_attribute("move_mode", "rusher");
        return;
    }
    self util::waittill_any("goal", "near_goal");
    self.goalradius = 2048;
    self util::waittill_any_timeout(5, "damage", "pain");
    e_volume = getent("server_room_entrance_goal_volume", "targetname");
    self setgoal(e_volume);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xd02579db, Offset: 0x8f00
// Size: 0x164
function function_40ff4c80() {
    self endon(#"death");
    var_7da22691 = getent(self.script_noteworthy + "_l", "targetname");
    var_91c4d84f = getent(self.script_noteworthy + "_r", "targetname");
    self ai::set_ignoreall(1);
    self.goalradius = 1;
    var_7da22691 waittill(#"movedone");
    wait(0.1);
    nd_target = getnode(self.target, "targetname");
    self setgoal(nd_target, 0, -56);
    function_524e3ee1(self);
    self ai::set_ignoreall(0);
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x737549f0, Offset: 0x9070
// Size: 0xbc
function function_88e395d2() {
    var_5a7d265d = getentarray("turret_elevator_doors", "script_noteworthy");
    foreach (var_47eb21b2 in var_5a7d265d) {
        var_47eb21b2 connectpaths();
    }
    wait(0.5);
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x62bccfda, Offset: 0x9138
// Size: 0xec
function function_8bf5e64e(str_location) {
    if (level flag::get("elevator_light_on_" + str_location) == 0) {
        n_duration = 3;
        level flag::set("elevator_light_on_" + str_location);
        if (str_location == "server_room") {
            exploder::exploder_duration("objective_server_room_def_elevator_lights", n_duration);
        } else if (str_location == "cloudmountain") {
            exploder::exploder_duration("fx_cloudmt_elevator_1st_l", n_duration);
        }
        wait(n_duration);
        level flag::clear("elevator_light_on_" + str_location);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x69a586bf, Offset: 0x9230
// Size: 0x1ee
function function_28931f52() {
    spawner::simple_spawn("server_room_enemy_swat1");
    if (level.players.size > 2) {
        spawner::simple_spawn("server_room_enemy_swat2");
    }
    var_c47e641c = getent("staging_area", "targetname");
    var_a7af994d = 0;
    while (var_a7af994d == 0) {
        wait(1);
        var_3635f2f4 = 0;
        var_13f4f150 = getaiarray("server_room_enemy_swat1_ai", "targetname");
        var_aa5462d4 = var_13f4f150.size;
        foreach (ai in var_13f4f150) {
            if (ai istouching(var_c47e641c)) {
                var_3635f2f4++;
            }
        }
        if (var_aa5462d4 < 4 || var_3635f2f4 >= var_aa5462d4 * 0.7) {
            var_a7af994d = 1;
        }
        if (var_3635f2f4 > 0 || var_a7af994d == 1) {
            level thread function_ca5f1131(var_13f4f150, "smoke_grenade_final_hallway2_start");
        }
    }
    level notify(#"hash_70f54e3");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x1e91f3c, Offset: 0x9428
// Size: 0x16c
function function_7b66a225() {
    self endon(#"death");
    self.goalradius = 1;
    var_c4d6a8bf = getnode(self.target, "targetname");
    setenablenode(var_c4d6a8bf);
    self setgoal(var_c4d6a8bf, 0, 1);
    level waittill(#"hash_70f54e3");
    var_ccb21e50 = getnodearray("swat_node_" + self.script_noteworthy, "targetname");
    var_aafc13f3 = array::random(var_ccb21e50);
    self setgoal(var_aafc13f3, 0, -56);
    setenablenode(var_c4d6a8bf, 0);
    self util::waittill_any("goal", "pain", "near_goal", "damage");
    self setgoal(self.origin, 0, 512);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xf9418c14, Offset: 0x95a0
// Size: 0x4c
function function_d2bb2597() {
    e_goal = getent("server_room_entrance_goal_volume", "targetname");
    self setgoal(e_goal);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x877202bc, Offset: 0x95f8
// Size: 0x18c
function function_13ed10e0() {
    self endon(#"death");
    s_door = struct::get("top_floor_door");
    self setgoal(s_door.origin, 0, 100);
    self waittill(#"goal");
    if (level flag::get("top_floor_breached") == 0) {
        if (!level scene::is_playing("p7_fxanim_gp_door_broken_open_01_bundle")) {
            level thread scene::play("p7_fxanim_gp_door_broken_open_01_bundle");
        }
        e_door = getent("top_floor_door_clip", "targetname");
        if (isdefined(e_door)) {
            playrumbleonposition("cp_biodomes_server_room_top_floor_door_rumble", e_door.origin);
            e_door delete();
        }
        level flag::wait_till("top_floor_breached");
    }
    self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xc42b9f39, Offset: 0x9790
// Size: 0x2c
function function_564d6426() {
    level waittill(#"hash_1ca4dee3");
    level flag::set("top_floor_breached");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x4a72e460, Offset: 0x97c8
// Size: 0x23c
function function_963807b1() {
    level endon(#"hash_6a76551d");
    level notify(#"hash_14bb5165");
    level thread scene::play("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
    level waittill(#"hash_53ff6d53");
    e_window = getent("server_window", "targetname");
    foreach (player in level.activeplayers) {
        if (player util::is_looking_at(e_window, 0.3)) {
            player thread dialog::function_13b3b16a("plyr_shit_they_re_blowin_0", 0.25);
        }
    }
    level waittill(#"hash_578006af");
    level flag::set("window_broken");
    if (isdefined(e_window)) {
        earthquake(1, 1, e_window.origin, 1000);
        playrumbleonposition("cp_biodomes_server_room_window_rumble", e_window.origin);
        e_window delete();
    }
    level thread namespace_27a45d31::function_a22e7052(1, "server_room_window_mantle", "script_noteworthy");
    level waittill(#"hash_99d5298d");
    wait(1);
    level thread function_72d7b33c();
    level thread dialog::remote("kane_hostiles_ziplining_i_0");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x2a08d178, Offset: 0x9a10
// Size: 0x2fe
function function_72d7b33c() {
    level endon(#"hash_6a76551d");
    level.var_1a0f3432 = 0;
    spawner::simple_spawn("server_room_enemy_rope2_guy1", &function_dde40552);
    wait(randomfloat(0.5));
    spawner::simple_spawn("server_room_enemy_rope1_guy1", &function_dde40552);
    wait(randomfloatrange(1, 4));
    spawner::simple_spawn("server_room_enemy_rope2_guy2", &function_dde40552);
    wait(randomfloat(0.5));
    spawner::simple_spawn("server_room_enemy_rope1_guy2", &function_dde40552);
    wait(randomfloatrange(1, 4));
    spawner::simple_spawn("server_room_enemy_rope2_guy3", &function_dde40552);
    wait(randomfloat(0.5));
    spawner::simple_spawn("server_room_enemy_rope1_guy3", &function_dde40552);
    if (level.players.size > 2) {
        wait(randomfloatrange(1, 3));
        spawner::simple_spawn("server_room_enemy_rope2_guy1", &function_dde40552);
        wait(randomfloat(0.5));
        spawner::simple_spawn("server_room_enemy_rope1_guy1", &function_dde40552);
        wait(randomfloatrange(1, 3));
        spawner::simple_spawn("server_room_enemy_rope2_guy2", &function_dde40552);
        wait(randomfloat(0.5));
        spawner::simple_spawn("server_room_enemy_rope1_guy2", &function_dde40552);
    }
    spawner::add_spawn_function_ai_group("top_floor", &function_d2bb2597);
    spawn_manager::enable("server_room_topfloor_fodder_manager");
    level notify(#"hash_b4a4fe67");
    wait(10);
    level notify(#"hash_4551b516");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x95b45ca1, Offset: 0x9d18
// Size: 0x3b0
function function_dde40552() {
    self endon(#"death");
    var_4e03b768 = struct::get("vtol_dropoff_" + self.script_noteworthy);
    s_landing = struct::get("vtol_landing_" + self.script_noteworthy);
    self forceteleport(var_4e03b768.origin, var_4e03b768.angles);
    var_c312dab9 = util::spawn_model("tag_origin", var_4e03b768.origin, var_4e03b768.angles);
    var_c312dab9 thread scene::play("cin_gen_traversal_zipline_enemy02_idle", self);
    var_b39127dd = util::spawn_model("wpn_t7_zipline_trolley_prop", self gettagorigin("tag_weapon_left"), self gettagangles("tag_weapon_left"));
    var_b39127dd linkto(self, "tag_weapon_left");
    self thread function_e87de176(array(var_c312dab9, var_b39127dd));
    n_dist = distance(var_4e03b768.origin, s_landing.origin);
    n_time = n_dist / 500;
    var_c312dab9 moveto(s_landing.origin, n_time);
    var_c312dab9 playloopsound("evt_vtol_npc_move");
    self thread function_f879ebc4(var_c312dab9);
    var_c312dab9 waittill(#"movedone");
    var_c312dab9 stoploopsound(0.5);
    var_c312dab9 playsound("evt_vtol_npc_detach");
    v_on_navmesh = getclosestpointonnavmesh(var_c312dab9.origin, 100, 48);
    if (isdefined(v_on_navmesh)) {
        var_c312dab9 moveto(v_on_navmesh, 0.25);
    }
    var_c312dab9 scene::play("cin_gen_traversal_zipline_enemy02_dismount", self);
    self notify(#"hash_4d91a838");
    self unlink();
    util::wait_network_frame();
    var_c312dab9 delete();
    var_b39127dd delete();
    self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
    level waittill(#"hash_fd7af6ca");
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0x8afa3a3a, Offset: 0xa0d0
// Size: 0x44
function function_f879ebc4(var_c312dab9) {
    var_c312dab9 endon(#"movedone");
    self waittill(#"death");
    var_c312dab9 stoploopsound(0.5);
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xdc6e22df, Offset: 0xa120
// Size: 0xea
function function_e87de176(var_4ca5dd1f) {
    self endon(#"hash_4d91a838");
    self waittill(#"death");
    namespace_769dc23f::function_72f8596b();
    self unlink();
    self startragdoll(1);
    foreach (entity in var_4ca5dd1f) {
        entity delete();
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xeeedd195, Offset: 0xa218
// Size: 0x2c
function function_c81145c2() {
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xe6f13e08, Offset: 0xa250
// Size: 0x2c
function function_6a4cb712() {
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x8557eb50, Offset: 0xa288
// Size: 0x64
function function_4df7264d() {
    self ai::set_behavior_attribute("sprint", 1);
    util::waittill_either("goal", "damage");
    self ai::set_behavior_attribute("sprint", 0);
}

// Namespace namespace_f5edec75
// Params 3, eflags: 0x1 linked
// Checksum 0x16e41dc3, Offset: 0xa2f8
// Size: 0xd4
function function_c9d85cf6(var_9ae72db, var_7da22691, var_91c4d84f) {
    level flag::wait_till(var_9ae72db.script_noteworthy + "_cleared");
    var_7da22691 moveto(var_7da22691.var_92bda14, 1);
    var_91c4d84f moveto(var_91c4d84f.var_92bda14, 1);
    var_7da22691 waittill(#"movedone");
    var_7da22691 disconnectpaths();
    var_91c4d84f disconnectpaths();
}

// Namespace namespace_f5edec75
// Params 1, eflags: 0x1 linked
// Checksum 0xddc644c5, Offset: 0xa3d8
// Size: 0xa4
function function_524e3ee1(var_9ae72db) {
    var_9ae72db endon(#"death");
    var_3f69ee40 = getent(var_9ae72db.script_noteworthy + "_elevator_trigger", "targetname");
    while (var_9ae72db istouching(var_3f69ee40) || util::any_player_is_touching(var_3f69ee40, "allies")) {
        wait(0.5);
    }
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0x72eb2f89, Offset: 0xa488
// Size: 0x8c
function function_6f311542() {
    var_b05a0766 = getent("lobby_elevator_door_01_l", "targetname");
    var_c3cad8fd = getent("lobby_elevator_door_01_r", "targetname");
    var_b05a0766 disconnectpaths();
    var_c3cad8fd disconnectpaths();
}

// Namespace namespace_f5edec75
// Params 6, eflags: 0x1 linked
// Checksum 0xf844d9d3, Offset: 0xa520
// Size: 0x214
function function_dbcb1086(var_fc05da5a, n_timer, var_32af39a0, var_a4b6a8db, var_7eb42e72, var_f0bb9dad) {
    wait(1);
    if (isdefined(var_f0bb9dad)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) + spawner::get_ai_group_sentient_count(var_7eb42e72) + spawner::get_ai_group_sentient_count(var_f0bb9dad) > var_fc05da5a) {
            wait(1);
            n_timer -= 1;
        }
    } else if (isdefined(var_7eb42e72)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) + spawner::get_ai_group_sentient_count(var_7eb42e72) > var_fc05da5a) {
            wait(1);
            n_timer -= 1;
        }
    } else if (isdefined(var_a4b6a8db)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) > var_fc05da5a) {
            wait(1);
            n_timer -= 1;
        }
    } else {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) > var_fc05da5a) {
            wait(1);
            n_timer -= 1;
        }
    }
    wait(3);
}

// Namespace namespace_f5edec75
// Params 0, eflags: 0x1 linked
// Checksum 0xa11dfa95, Offset: 0xa740
// Size: 0x54
function function_947a1ae8() {
    self endon(#"death");
    e_volume = getent(self.target, "targetname");
    self setgoal(e_volume, 1);
}

