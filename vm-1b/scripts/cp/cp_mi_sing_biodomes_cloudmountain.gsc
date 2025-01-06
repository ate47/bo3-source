#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_laststand;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_biodomes_cloudmountain;

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x26c0
// Size: 0x2
function precache() {
    
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xd6bea320, Offset: 0x26d0
// Size: 0x192
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8a783b3a, Offset: 0x2870
// Size: 0x2a2
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0xf7b0437d, Offset: 0x2b20
// Size: 0x172
function objective_cloudmountain_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_cloudmountain_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        cp_mi_sing_biodomes::function_cef897cf(str_objective);
        level flag::set("back_door_opened");
        var_b06d4473 = getent("back_door_player_clip", "targetname");
        var_b06d4473 delete();
        spawn_manager::enable("cloud_mountain_siegebot_manager");
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        level thread cp_mi_sing_biodomes_warehouse::function_cb52a73();
        level thread cp_mi_sing_biodomes_warehouse::function_1b03da0e();
        level thread cp_mi_sing_biodomes_util::function_cc20e187("warehouse");
        level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain", 1);
        load::function_a2995f22();
    }
    hidemiscmodels("fxanim_markets2");
    level thread namespace_f1b4cbbc::function_2e34977e();
    level thread function_6da34baf();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x2d509463, Offset: 0x2ca0
// Size: 0x17a
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
    level thread cloud_mountain_reinforcements();
    level thread function_333f5b5b();
    level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass1");
    level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass2");
    level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass3");
    trigger::wait_till("trig_cloud_mountain_level_2_start");
    level.var_2fd26037 colors::enable();
    level.var_2fd26037 clearforcedgoal();
    skipto::function_be8adfb8("objective_cloudmountain");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x609ae444, Offset: 0x2e28
// Size: 0x2a
function function_9a10cb7d() {
    level endon(#"cloudmountain_flanker_disable");
    level waittill(#"cloudmountain_siegebots_dead");
    spawn_manager::enable("manager_phalanx_humans_overhead");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x63257102, Offset: 0x2e60
// Size: 0x122
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x13a87593, Offset: 0x2f90
// Size: 0x122
function function_7ec07da9() {
    level endon(#"hash_1530fdbd");
    level endon(#"cloudmountain_siegebots_skipped");
    self waittill(#"death", e_attacker);
    objectives::function_66c6f97b("cp_level_biodomes_siegebot", self);
    wait 1;
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xcff45138, Offset: 0x30c0
// Size: 0xba
function function_1932917(var_f7824075) {
    self waittill(#"death");
    level endon(#"cloudmountain_siegebots_skipped");
    objectives::function_66c6f97b("cp_level_biodomes_siegebot", self);
    wait 1;
    battlechatter::function_d9f49fba(0);
    if (var_f7824075 == "player") {
        level dialog::function_13b3b16a("plyr_siege_bot_is_s_o_l_0");
    } else if (var_f7824075 == "hendricks") {
        level.var_2fd26037 dialog::say("hend_that_fucker_s_done_0");
    }
    battlechatter::function_d9f49fba(1);
    level function_a1fa89a2();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xd3f8a20f, Offset: 0x3188
// Size: 0x8b
function function_f6a70610(var_c81e3075) {
    level waittill(#"hash_69d6458d");
    foreach (var_51a7831a in var_c81e3075) {
        if (isalive(var_51a7831a)) {
            var_51a7831a kill();
        }
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x95bd4102, Offset: 0x3220
// Size: 0x7a
function function_a1fa89a2() {
    level flag::set("cloudmountain_siegebots_dead");
    level thread namespace_f1b4cbbc::function_973b77f9();
    level thread cp_mi_sing_biodomes_util::function_a1669688("cloud_mountain_entrance_bridge", "cloudmountain_lobby_retreat_volume", 2, 4);
    trigger::use("trig_hendricks_lobby_entrance_colors", "targetname", undefined, 0);
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x82082c44, Offset: 0x32a8
// Size: 0xb2
function function_a234f527() {
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_they_gotta_siege_bot_0");
    level.var_2fd26037 dialog::say("hend_we_don_t_have_the_fi_0", 2);
    level dialog::remote("kane_it_s_heavily_armored_0");
    battlechatter::function_d9f49fba(1);
    level util::waittill_either("cloudmountain_siegebots_dead", "cloudmountain_siegebots_skipped");
    wait 2;
    level thread function_b2ae6383();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x26766307, Offset: 0x3368
// Size: 0x123
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
    wait 2;
    battlechatter::function_d9f49fba(0);
    level dialog::function_13b3b16a("plyr_third_floor_where_n_0");
    level dialog::remote("kane_server_room_directly_0");
    battlechatter::function_d9f49fba(1);
    level notify(#"hash_e36f3648");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x3a0f4267, Offset: 0x3498
// Size: 0x36b
function function_170b0353(var_b146902) {
    if (!isdefined(var_b146902)) {
        var_b146902 = 0;
    }
    level endon(#"a_player_sees_hallway_turrets");
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
    wait 5;
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0xda1f9b21, Offset: 0x3810
// Size: 0x182
function function_e2e19ed7(var_69e64c43, var_2148cdcc) {
    level endon(var_2148cdcc);
    self endon(#"death");
    var_4d8945 = 0;
    while (!var_4d8945) {
        self waittill(#"damage", n_damage, e_attacker);
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
                    level.var_2fd26037 dialog::say(cp_mi_sing_biodomes_util::function_7ff50323(var_2d3d7b7));
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xc50c863f, Offset: 0x39a0
// Size: 0xea
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x97d22ed0, Offset: 0x3a98
// Size: 0x62
function function_a288e474() {
    self endon(#"death");
    self.goalradius = 1024;
    self.goalheight = 320;
    self setgoal(level.activeplayers[0]);
    self namespace_69ee7109::function_13ed0a8b(1);
    self cp_mi_sing_biodomes_util::function_f61c0df8("node_cloud_mountain_warlord_preferred", 1, 2);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8058a9ef, Offset: 0x3b08
// Size: 0x4a
function function_7dffd386() {
    trigger::wait_till("trig_cloudmountain_first_floor_backup");
    if (!level flag::get("stalagtites_dropped")) {
        trigger::use("cloudmountain_entrance_stalagmite_01");
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0x4afee5c0, Offset: 0x3b60
// Size: 0x3a
function objective_cloudmountain_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_cloudmountain_done");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0x24b5fc14, Offset: 0x3ba8
// Size: 0x20a
function function_8ce887a2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::set("cp_level_biodomes_servers");
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level flag::set("back_door_opened");
        var_b06d4473 = getent("back_door_player_clip", "targetname");
        var_b06d4473 delete();
        var_31861e2e = getent("trig_level_2_robot_spawns", "targetname");
        if (isdefined(var_31861e2e)) {
            var_31861e2e delete();
        }
        function_8232942d();
        function_56019233();
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        level.var_2fd26037 colors::enable();
        level thread function_710c7f6a();
        level thread function_11f04863();
        level thread cloud_mountain_reinforcements();
        level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
        load::function_a2995f22();
        level thread function_b2ae6383(1);
        level thread function_170b0353(1);
    }
    spawn_manager::enable("sm_cloud_mountain_riot_shield");
    level.var_2fd26037.goalradius = 256;
    trigger::wait_till("trig_turret_hallway_enemy_spawns");
    skipto::function_be8adfb8("objective_cloudmountain_level_2");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0xfe71535c, Offset: 0x3dc0
// Size: 0x3a
function objective_cloudmountain_level_2_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_cloudmountain_level_2_done");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x9bbb2325, Offset: 0x3e08
// Size: 0x72
function function_8232942d() {
    var_82ac908a = getent("trig_cloudmountain_left_stairs_spawns", "targetname");
    var_82ac908a delete();
    var_7870fb88 = getent("trig_sm_level_1_rushers", "targetname");
    var_7870fb88 delete();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8f7c7570, Offset: 0x3e88
// Size: 0xab
function function_56019233() {
    var_b6a97ee5 = getentarray("cloudmountain_level_1_glass_triggers", "script_noteworthy");
    foreach (var_799e4c3a in var_b6a97ee5) {
        glassradiusdamage(var_799e4c3a.origin, 100, 500, 500);
        var_799e4c3a delete();
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xddfd1b4f, Offset: 0x3f40
// Size: 0x12b
function function_9d75973(var_b49710a9) {
    level endon(#"hash_478882aa");
    var_16de839d = getent("trig_exhibit_" + var_b49710a9, "targetname");
    while (true) {
        var_16de839d trigger::wait_till();
        switch (var_b49710a9) {
        case "A":
            var_16de839d dialog::say("Welcome to the Cloud Forest wildlife exhibit. Please take a moment to read the rules of conduct.", 0, 1);
            break;
        case "B":
            var_16de839d dialog::say("Hundreds of different animal species make their home among the flora of Cloud Forests across Southeast Asia.", 0, 1);
            break;
        case "C":
            var_16de839d dialog::say("Amphibians such as this Spotted Tree Frog are particularly well suited to the unique climate found here.", 0, 1);
            break;
        case "D":
            var_16de839d dialog::say("Tree Shrews are descended from one of the earliest known mammals on earth. They forage in the dense undergrowth at all hours of the day.", 0, 1);
            break;
        case "E":
            var_16de839d dialog::say("Up ahead is the overlook and elevator access to the Cloud Walk. Watch your step! Walkways are slippery when wet.", 0, 1);
            break;
        }
        wait 15;
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xee7b9d4e, Offset: 0x4078
// Size: 0xaa
function function_11f04863() {
    trigger::wait_till("level_2_catwalk_spawns", "targetname");
    e_door = getent("dome_side_door", "targetname");
    e_door connectpaths();
    e_door movez(100, 2);
    e_door waittill(#"movedone");
    level flag::wait_till("supertree_door_close");
    e_door movez(-100, 2);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x1541a707, Offset: 0x4130
// Size: 0x142
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xbea1deb7, Offset: 0x4280
// Size: 0xaa
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xaa061277, Offset: 0x4338
// Size: 0x1a
function function_715d6f43() {
    self endon(#"death");
    self ai::set_ignoreme(1);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x48a9fada, Offset: 0x4360
// Size: 0x7a
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x3f7f8ca5, Offset: 0x43e8
// Size: 0xde
function function_2c36cacd() {
    self endon(#"death");
    self.goalradius = 4;
    self ai::set_ignoreall(1);
    trigger::wait_till("trig_lookat_level_3_surprised");
    wait randomfloatrange(0.1, 0.5);
    self scene::play("cin_gen_vign_confusion_02", self);
    var_284ca6ef = getent("trig_level_3_catwalks_goal", "targetname");
    if (isdefined(var_284ca6ef)) {
        self setgoal(var_284ca6ef);
        self waittill(#"goal");
    }
    self ai::set_ignoreall(0);
    self.goalradius = 1024;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xf8e95051, Offset: 0x44d0
// Size: 0x202
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
        wait 0.05;
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x2fe2b6ea, Offset: 0x46e0
// Size: 0x22
function function_d7238641() {
    self endon(#"death");
    level waittill(#"hash_d7238641");
    self delete();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8c731424, Offset: 0x4710
// Size: 0x5a
function function_a52ff7c1() {
    function_6f311542();
    trigger::wait_till("trig_cloudmountain_elevators");
    spawner::simple_spawn("cloudmountain_elevator_enemy", &function_f5170df1, "cloudmountain");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xbdc07084, Offset: 0x4778
// Size: 0x69
function function_7c81648() {
    var_9396ef10 = getspawnerarray("catwalk", "script_noteworthy");
    for (i = 0; i < var_9396ef10.size; i++) {
        var_9396ef10[i] spawner::add_spawn_function(&function_84f859bf);
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x6233141c, Offset: 0x47f0
// Size: 0xe
function function_84f859bf() {
    self.goalradius = 400;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x291fd4c0, Offset: 0x4808
// Size: 0x9a
function function_a36395f0() {
    var_3d912af2 = getentarray("cloudmountain_spawn_trigger", "script_noteworthy");
    foreach (trigger in var_3d912af2) {
        trigger delete();
    }
    function_8232942d();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8027e7a5, Offset: 0x48b0
// Size: 0x92
function cloud_mountain_reinforcements() {
    trigger::wait_till("trig_cloud_mountain_reinforcements");
    spawner::add_spawn_function_group("sp_cloud_mountain_reinforcements_wasps", "targetname", &function_947a1ae8);
    spawn_manager::enable("sm_cloud_mountain_reinforcements");
    spawn_manager::enable("sm_cloud_mountain_reinforcements_wasps");
    spawn_manager::enable("sm_cloud_mountain_retreaters");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0xbe11d848, Offset: 0x4950
// Size: 0x262
function function_df51ef25(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("turret_hallway_init");
    level scene::init("server_room_access_start", "targetname");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level.var_2fd26037 notify(#"hash_93bef291");
        level.var_2fd26037 colors::enable();
        objectives::set("cp_level_biodomes_servers");
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
        function_a36395f0();
        load::function_a2995f22();
        level thread namespace_f1b4cbbc::function_6c35b4f3();
    }
    level flag::init("turret_hallway_phalanx_dead");
    level thread function_ee13f890();
    level thread function_3679c70a();
    level thread turret_hallway_phalanx();
    level thread function_de8fde30();
    spawner::waittill_ai_group_cleared("turret_hallway_group");
    function_58b4a5d6();
    level flag::set("turret_hall_clear");
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand()) {
            player laststand::auto_revive(player, 0);
        }
    }
    skipto::function_be8adfb8("objective_turret_hallway");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x779cf6a7, Offset: 0x4bc0
// Size: 0x1a2
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x4d8a872c, Offset: 0x4d70
// Size: 0x122
function turret_hallway_phalanx() {
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
        wait 0.25;
    }
    level flag::set("turret_hallway_phalanx_dead");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x75e37903, Offset: 0x4ea0
// Size: 0x82
function function_de8fde30() {
    exploder::exploder("turret_light");
    trigger::wait_till("trig_turret_lights_damaged", "targetname");
    exploder::kill_exploder("turret_light");
    exploder::exploder("fx_turrethallway_turret_smk");
    scene::play("p7_fxanim_gp_floodlight_01_bundle");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x78241098, Offset: 0x4f30
// Size: 0xad
function function_2c72fa5a() {
    self turret::enable_laser(1, 0);
    switch (self.script_string) {
    case "turret_left":
        objectives::set("cp_level_biodomes_cloud_mountain_turret_left", self);
        self waittill(#"death");
        objectives::complete("cp_level_biodomes_cloud_mountain_turret_left", self);
        break;
    case "turret_right":
        objectives::set("cp_level_biodomes_cloud_mountain_turret_right", self);
        self waittill(#"death");
        objectives::complete("cp_level_biodomes_cloud_mountain_turret_right", self);
        break;
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x4396abab, Offset: 0x4fe8
// Size: 0x42
function function_d8eaa27f(var_9d979b27) {
    level endon(#"turret_hall_clear");
    function_c80e1213("turret_left");
    function_c80e1213("turret_right");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x65cb48d5, Offset: 0x5038
// Size: 0xc9
function function_c80e1213(var_3199aef) {
    nd_cover = getnode("hendricks_" + var_3199aef, "targetname");
    level.var_2fd26037 setgoal(nd_cover, 1);
    a_turrets = getaiarray(var_3199aef, "script_label");
    if (isalive(a_turrets[0])) {
        level.var_2fd26037 settargetentity(a_turrets[0]);
        while (isalive(a_turrets[0])) {
            wait 0.05;
        }
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8efdb2c7, Offset: 0x5110
// Size: 0xfa
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xbd359ed3, Offset: 0x5218
// Size: 0x2f
function function_58b4a5d6() {
    for (var_a4854031 = 1; var_a4854031; var_a4854031 = function_50c932d0()) {
        wait 1;
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xf5695825, Offset: 0x5250
// Size: 0xba
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0x6009ce63, Offset: 0x5318
// Size: 0xca
function function_9cfbecff(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_biodomes_destroy_hallway_turrets");
    objectives::set("cp_level_biodomes_awaiting_update");
    cp_mi_sing_biodomes_util::function_ddb0eeea("turret_hallway_done");
    getent("trig_turret_hallway_enemy_spawns", "targetname") delete();
    getent("trig_turret_hallway_defender_spawns", "targetname") delete();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0xf8c2674a, Offset: 0x53f0
// Size: 0x2aa
function function_e696b86c(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("xiulan_vignette_init");
    cp_mi_sing_biodomes_util::function_a22e7052(0, "server_room_window_mantle", "script_noteworthy");
    level thread util::function_d8eaed3d(2);
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level.var_2fd26037.goalradius = 32;
        objectives::set("cp_level_biodomes_awaiting_update");
        function_a36395f0();
        level scene::init("server_room_access_start", "targetname");
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        var_777355da = getentarray("hallway_turret", "script_noteworthy");
        a_turrets = spawner::simple_spawn(var_777355da);
        array::run_all(a_turrets, &kill);
        level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xf422a424, Offset: 0x56a8
// Size: 0x6a
function function_cd4c4257() {
    level thread namespace_f1b4cbbc::function_973b77f9();
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_shit_she_s_uploadi_0");
    level dialog::remote("kane_it_s_uploading_direc_0");
    level notify(#"hash_9b74c38e");
    battlechatter::function_d9f49fba(1);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x1807e1ad, Offset: 0x5720
// Size: 0x7a
function function_e638433c() {
    self endon(#"death");
    self waittill(#"goal");
    v_look = struct::get("hallway_look_target").origin;
    self orientmode("face direction", self.origin - v_look);
    self waittill(#"enemy");
    self orientmode("face enemy");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x1d1c9c26, Offset: 0x57a8
// Size: 0xa
function function_a0e7b9b7() {
    self.ignoreme = 1;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x95496a48, Offset: 0x57c0
// Size: 0x2aa
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
    level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh260", &server_room_intro_done, "done");
    level.var_2fd26037.ignoreall = 1;
    if (isdefined(level.var_d9cf116b)) {
        level thread [[ level.var_d9cf116b ]]();
    }
    level scene::play("server_room_access_start", "targetname", level.var_f2be4c1f);
    skipto::function_be8adfb8("objective_xiulan_vignette");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x4732238b, Offset: 0x5a78
// Size: 0x22
function function_934481ae(e_door) {
    objectives::set("cp_level_biodomes_server_door", e_door);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x84cc733d, Offset: 0x5aa8
// Size: 0x83
function function_9a82e132(e_player) {
    level.var_f2be4c1f = e_player;
    var_485a1dbf = struct::get("s_server_room_hack_pos");
    playsoundatposition("evt_hack_panel", var_485a1dbf.origin);
    self gameobjects::disable_object();
    objectives::complete("cp_level_biodomes_server_door");
    level notify(#"hash_69d6458d");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x7e9888b5, Offset: 0x5b38
// Size: 0x83
function function_2db7566e(a_ents) {
    foreach (player in level.players) {
        player cybercom::function_f8669cbf(1);
        player clientfield::increment_to_player("hack_dni_fx");
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xfac1435b, Offset: 0x5bc8
// Size: 0x42
function function_7dedb1f0(a_ents) {
    level waittill(#"hash_f7774ee4");
    level thread function_a91388d2(1);
    level waittill(#"hash_127c12ee");
    level thread function_a91388d2(0);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xb3f6c709, Offset: 0x5c18
// Size: 0x6a
function server_room_intro_done(a_ents) {
    level notify(#"server_room_intro_done");
    level clientfield::set("set_exposure_bank", 0);
    level util::function_93831e79("s_server_room_scene_end_warps");
    level thread util::clear_streamer_hint();
    videostart("cp_biodomes_env_serverhackvid4looping", 1);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 3, eflags: 0x0
// Checksum 0xc8ade4cf, Offset: 0x5c90
// Size: 0xaa
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xfbb47a30, Offset: 0x5d48
// Size: 0x22
function function_3de47a8b(a_ents) {
    videostart("cp_biodomes_env_serverhackvid1");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x9d9075a4, Offset: 0x5d78
// Size: 0x22
function function_cbdd0b50(a_ents) {
    videostart("cp_biodomes_env_serverhackvid2");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xb3f08ab9, Offset: 0x5da8
// Size: 0x22
function function_f1df85b9(a_ents) {
    videostart("cp_biodomes_env_serverhackvid3");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x8fb905e4, Offset: 0x5dd8
// Size: 0x72
function function_a91388d2(b_open) {
    var_4fe84cbf = getent("server_control_room_door", "targetname");
    if (b_open) {
        var_4fe84cbf movey(50, 0.5);
        return;
    }
    var_4fe84cbf movey(-50, 0.5);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0x78d8062e, Offset: 0x5e58
// Size: 0x122
function function_6be20b72(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("xiulan_vignette_done");
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x8f2965df, Offset: 0x5f88
// Size: 0x1f6
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
    wait 5;
    var_1c634edb.script_accuracy = 1;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0x6cb8d0d0, Offset: 0x6188
// Size: 0x2b2
function function_8dacf956(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("server_room_defend_init");
    objectives::complete("cp_level_biodomes_awaiting_update");
    getent("server_koolaid", "targetname") disconnectpaths();
    level thread function_a78ec4a();
    if (var_74cd64bc) {
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        function_a36395f0();
        level function_a91388d2(0);
        level thread scene::init("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
        cp_mi_sing_biodomes_util::function_a22e7052(0, "server_room_window_mantle", "script_noteworthy");
        var_777355da = getentarray("hallway_turret", "script_noteworthy");
        a_turrets = spawner::simple_spawn(var_777355da);
        array::run_all(a_turrets, &kill);
        e_clip = getent("turret_hallway_door_ai_clip", "targetname");
        e_clip delete();
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x3d2159da, Offset: 0x6448
// Size: 0x32
function function_17d3780e() {
    level waittill(#"server_room_intro_done");
    level notify(#"hash_5891b40a");
    objectives::set("cp_level_biodomes_defend_server_room", level.var_2fd26037);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x2b3a5165, Offset: 0x6488
// Size: 0xca
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x29a65d87, Offset: 0x6560
// Size: 0x98b
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
    level waittill(#"server_room_intro_done");
    level thread dialog::remote("kane_he_s_fine_0");
    savegame::checkpoint_save();
    level thread namespace_f1b4cbbc::function_46333a8a();
    playsoundatposition("evt_server_def_walla_1st", (603, 12812, 1184));
    playsoundatposition("evt_server_def_walla_2nd", (900, 12750, 1140));
    level notify(#"hash_f3c45157");
    wait 2;
    spawner::simple_spawn("server_room_enemy_window");
    spawner::add_spawn_function_ai_group("top_floor", &top_floor_door);
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
    spawner::add_spawn_function_group("sp_server_room_background", "targetname", &cp_mi_sing_biodomes_fighttothedome::function_76c56ee1);
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
        wait 2;
        spawn_manager::enable("server_room_topfloor_fodder_manager", &function_d2bb2597);
    }
    level dialog::function_13b3b16a("plyr_more_hostiles_from_t_0");
    level thread dialog::remote("kane_download_at_sixty_pe_0", 1);
    playsoundatposition("evt_server_def_walla_bots_b", (1117, 13871, 1116));
    function_dbcb1086(2, 5, "hallway");
    if (level.players.size > 1) {
        spawn_manager::enable("server_room_fodder_manager_stairs", &function_d2bb2597);
    }
    spawn_manager::disable("server_room_topfloor_fodder_manager");
    function_dbcb1086(0, 25, "top_floor", "hallway", "window");
    savegame::checkpoint_save();
    level dialog::function_13b3b16a("plyr_we_gotta_get_the_hel_0");
    level thread dialog::remote("kane_download_at_eighty_p_0");
    playsoundatposition("evt_server_def_walla_4th", (1278, 13578, 1276));
    wait 3;
    function_560d15cf();
    wait 3;
    spawn_manager::enable("server_room_final_wave_manager", &function_d2bb2597);
    function_dbcb1086(2, 2, "final_wave");
    spawn_manager::enable("server_room_fodder_manager_stairs", &function_d2bb2597);
    if (level.players.size > 2) {
        wait 0.25;
        spawner::simple_spawn("server_room_enemy_hallway_final");
        var_31a99ad4 = getentarray("server_room_enemy_hallway_final_ai", "targetname");
        level thread function_ca5f1131(var_31a99ad4, "smoke_grenade_final_hallway1_start");
        wait 2;
        var_31a99ad4 = getentarray("server_room_enemy_hallway_final_ai", "targetname");
    }
    function_dbcb1086(3, 30, "hallway", "top_floor", "final_wave");
    spawn_manager::disable("server_room_fodder_manager_stairs");
    if (isalive(level.var_c7a78bed)) {
        level.var_c7a78bed waittill(#"death");
        level.var_c7a78bed namespace_69ee7109::function_94b1213d();
    }
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    wait 2;
    savegame::checkpoint_save();
    level thread dialog::remote("kane_download_complete_e_0");
    spawn_manager::disable("server_room_final_wave_manager");
    function_7ed3a33e();
    function_dbcb1086(0, 60, "window", "top_floor", "hallway", "final_wave");
    level notify(#"hash_fd7af6ca");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x2b4d9dc0, Offset: 0x6ef8
// Size: 0xf2
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 2, eflags: 0x0
// Checksum 0x8b74a14, Offset: 0x6ff8
// Size: 0x16d
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x25e95f18, Offset: 0x7170
// Size: 0xfa
function function_560d15cf() {
    var_479db1f9 = struct::get("warlord_smash", "targetname");
    playsoundatposition("evt_breach_warning", var_479db1f9.origin);
    wait 2;
    level thread scene::play("p7_fxanim_cp_biodomes_warlord_breach_01_bundle");
    playrumbleonposition("cp_biodomes_server_room_breach_rumble", var_479db1f9.origin);
    spawn_manager::enable("sm_server_room_riot_shield_breach");
    var_bfaffc0d = getent("server_koolaid", "targetname");
    var_bfaffc0d connectpaths();
    var_bfaffc0d delete();
    level thread dialog::remote("kane_hostiles_breaching_t_0", 1);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xea1aaa4e, Offset: 0x7278
// Size: 0x15b
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x1ff4dc25, Offset: 0x73e0
// Size: 0xca
function function_451e55d0(var_190535de) {
    var_190535de endon(#"death");
    var_190535de.ignoreall = 1;
    var_7b6710fa = getent("server_room_window_goal_volume", "targetname");
    while (var_190535de istouching(var_7b6710fa) == 0) {
        wait 0.1;
        if (self getvelocity() == 0) {
            var_190535de setgoal(getnode("server_window_node", "targetname"));
        }
    }
    var_190535de.ignoreall = 0;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x450db729, Offset: 0x74b8
// Size: 0x142
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
        wait 1;
    }
    self setgoal(getnode("server_room_goal", "targetname"), 0, 256);
    self util::waittill_any("goal", "near_goal");
    self setgoal(var_bfbe03c6);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x2a91727, Offset: 0x7608
// Size: 0x13a
function function_d813e7f(var_74cd64bc) {
    if (level scene::is_active("cin_bio_09_02_accessdrives_1st_sever_end_loop")) {
        level scene::stop("cin_bio_09_02_accessdrives_1st_sever_end_loop");
    }
    level waittill(#"server_room_intro_done");
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 4, eflags: 0x0
// Checksum 0x735e6e22, Offset: 0x7750
// Size: 0x116
function function_9ed4c7c0(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("server_room_defend_done");
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x24f4380f, Offset: 0x7870
// Size: 0x2ca
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x5b0b931a, Offset: 0x7b48
// Size: 0x11a
function function_40ff4c80() {
    self endon(#"death");
    var_7da22691 = getent(self.script_noteworthy + "_l", "targetname");
    var_91c4d84f = getent(self.script_noteworthy + "_r", "targetname");
    self ai::set_ignoreall(1);
    self.goalradius = 1;
    var_7da22691 waittill(#"movedone");
    wait 0.1;
    nd_target = getnode(self.target, "targetname");
    self setgoal(nd_target, 0, -56);
    function_524e3ee1(self);
    self ai::set_ignoreall(0);
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xfbd057a8, Offset: 0x7c70
// Size: 0x92
function function_88e395d2() {
    var_5a7d265d = getentarray("turret_elevator_doors", "script_noteworthy");
    foreach (var_47eb21b2 in var_5a7d265d) {
        var_47eb21b2 connectpaths();
    }
    wait 0.5;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x771d9400, Offset: 0x7d10
// Size: 0xba
function function_8bf5e64e(str_location) {
    if (level flag::get("elevator_light_on_" + str_location) == 0) {
        n_duration = 3;
        level flag::set("elevator_light_on_" + str_location);
        if (str_location == "server_room") {
            exploder::exploder_duration("objective_server_room_def_elevator_lights", n_duration);
        } else if (str_location == "cloudmountain") {
            exploder::exploder_duration("fx_cloudmt_elevator_1st_l", n_duration);
        }
        wait n_duration;
        level flag::clear("elevator_light_on_" + str_location);
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x60e2e010, Offset: 0x7dd8
// Size: 0x17f
function function_28931f52() {
    spawner::simple_spawn("server_room_enemy_swat1");
    if (level.players.size > 2) {
        spawner::simple_spawn("server_room_enemy_swat2");
    }
    var_c47e641c = getent("staging_area", "targetname");
    var_a7af994d = 0;
    while (var_a7af994d == 0) {
        wait 1;
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xccc301aa, Offset: 0x7f60
// Size: 0x122
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x82dcde73, Offset: 0x8090
// Size: 0x42
function function_d2bb2597() {
    e_goal = getent("server_room_entrance_goal_volume", "targetname");
    self setgoal(e_goal);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x91bba039, Offset: 0x80e0
// Size: 0x142
function top_floor_door() {
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x899faba1, Offset: 0x8230
// Size: 0x22
function function_564d6426() {
    level waittill(#"hash_1ca4dee3");
    level flag::set("top_floor_breached");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0xdb219a56, Offset: 0x8260
// Size: 0x1b2
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
    level thread cp_mi_sing_biodomes_util::function_a22e7052(1, "server_room_window_mantle", "script_noteworthy");
    level waittill(#"hash_99d5298d");
    wait 1;
    level thread function_72d7b33c();
    level thread dialog::remote("kane_hostiles_ziplining_i_0");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x308e00e0, Offset: 0x8420
// Size: 0x2bf
function function_72d7b33c() {
    level endon(#"hash_6a76551d");
    level.var_1a0f3432 = 0;
    spawner::simple_spawn("server_room_enemy_rope2_guy1", &function_dde40552);
    wait randomfloat(0.5);
    spawner::simple_spawn("server_room_enemy_rope1_guy1", &function_dde40552);
    wait randomfloatrange(1, 4);
    spawner::simple_spawn("server_room_enemy_rope2_guy2", &function_dde40552);
    wait randomfloat(0.5);
    spawner::simple_spawn("server_room_enemy_rope1_guy2", &function_dde40552);
    wait randomfloatrange(1, 4);
    spawner::simple_spawn("server_room_enemy_rope2_guy3", &function_dde40552);
    wait randomfloat(0.5);
    spawner::simple_spawn("server_room_enemy_rope1_guy3", &function_dde40552);
    if (level.players.size > 2) {
        wait randomfloatrange(1, 3);
        spawner::simple_spawn("server_room_enemy_rope2_guy1", &function_dde40552);
        wait randomfloat(0.5);
        spawner::simple_spawn("server_room_enemy_rope1_guy1", &function_dde40552);
        wait randomfloatrange(1, 3);
        spawner::simple_spawn("server_room_enemy_rope2_guy2", &function_dde40552);
        wait randomfloat(0.5);
        spawner::simple_spawn("server_room_enemy_rope1_guy2", &function_dde40552);
    }
    spawner::add_spawn_function_ai_group("top_floor", &function_d2bb2597);
    spawn_manager::enable("server_room_topfloor_fodder_manager");
    level notify(#"hash_b4a4fe67");
    wait 10;
    level notify(#"hash_4551b516");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x96b28a4a, Offset: 0x86e8
// Size: 0x2f4
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xb742df57, Offset: 0x89e8
// Size: 0x32
function function_f879ebc4(var_c312dab9) {
    var_c312dab9 endon(#"movedone");
    self waittill(#"death");
    var_c312dab9 stoploopsound(0.5);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0x8f1007cf, Offset: 0x8a28
// Size: 0xa3
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

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x98a918ba, Offset: 0x8ad8
// Size: 0x22
function function_c81145c2() {
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x25664197, Offset: 0x8b08
// Size: 0x22
function function_6a4cb712() {
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x41ebbef, Offset: 0x8b38
// Size: 0x52
function function_4df7264d() {
    self ai::set_behavior_attribute("sprint", 1);
    util::waittill_either("goal", "damage");
    self ai::set_behavior_attribute("sprint", 0);
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 3, eflags: 0x0
// Checksum 0x943ff4a, Offset: 0x8b98
// Size: 0x9a
function function_c9d85cf6(ai_spawn, var_7da22691, var_91c4d84f) {
    level flag::wait_till(ai_spawn.script_noteworthy + "_cleared");
    var_7da22691 moveto(var_7da22691.var_92bda14, 1);
    var_91c4d84f moveto(var_91c4d84f.var_92bda14, 1);
    var_7da22691 waittill(#"movedone");
    var_7da22691 disconnectpaths();
    var_91c4d84f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 1, eflags: 0x0
// Checksum 0xa9f6b2b4, Offset: 0x8c40
// Size: 0x81
function function_524e3ee1(ai_spawn) {
    ai_spawn endon(#"death");
    var_3f69ee40 = getent(ai_spawn.script_noteworthy + "_elevator_trigger", "targetname");
    while (ai_spawn istouching(var_3f69ee40) || util::any_player_is_touching(var_3f69ee40, "allies")) {
        wait 0.5;
    }
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x80f64269, Offset: 0x8cd0
// Size: 0x72
function function_6f311542() {
    var_b05a0766 = getent("lobby_elevator_door_01_l", "targetname");
    var_c3cad8fd = getent("lobby_elevator_door_01_r", "targetname");
    var_b05a0766 disconnectpaths();
    var_c3cad8fd disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 6, eflags: 0x0
// Checksum 0x54fbc0fa, Offset: 0x8d50
// Size: 0x168
function function_dbcb1086(var_fc05da5a, n_timer, var_32af39a0, var_a4b6a8db, var_7eb42e72, var_f0bb9dad) {
    wait 1;
    if (isdefined(var_f0bb9dad)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) + spawner::get_ai_group_sentient_count(var_7eb42e72) + spawner::get_ai_group_sentient_count(var_f0bb9dad) > var_fc05da5a) {
            wait 1;
            n_timer -= 1;
        }
    } else if (isdefined(var_7eb42e72)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) + spawner::get_ai_group_sentient_count(var_7eb42e72) > var_fc05da5a) {
            wait 1;
            n_timer -= 1;
        }
    } else if (isdefined(var_a4b6a8db)) {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) + spawner::get_ai_group_sentient_count(var_a4b6a8db) > var_fc05da5a) {
            wait 1;
            n_timer -= 1;
        }
    } else {
        while (n_timer > 0 && spawner::get_ai_group_sentient_count(var_32af39a0) > var_fc05da5a) {
            wait 1;
            n_timer -= 1;
        }
    }
    wait 3;
}

// Namespace cp_mi_sing_biodomes_cloudmountain
// Params 0, eflags: 0x0
// Checksum 0x20f4c86d, Offset: 0x8ec0
// Size: 0x4a
function function_947a1ae8() {
    self endon(#"death");
    e_volume = getent(self.target, "targetname");
    self setgoal(e_volume, 1);
}

