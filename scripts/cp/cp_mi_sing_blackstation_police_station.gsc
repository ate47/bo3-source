#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai/phalanx;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_cross_debris;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_laststand;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#namespace namespace_933eb669;

// Namespace namespace_933eb669
// Params 2, eflags: 0x0
// Checksum 0x1e0cd776, Offset: 0x10d8
// Size: 0x114
function function_23a0cc93(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_police_station");
        level function_a7bb8a82();
        load::function_a2995f22();
    }
    level thread namespace_79e1cd97::function_6778ea09("light_ne");
    level thread scene::init("p7_fxanim_cp_blackstation_police_station_ceiling_tiles_bundle");
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 1);
    streamerrequest("set", "cp_mi_sing_blackstation_objective_kane_intro");
    function_fa216142();
}

// Namespace namespace_933eb669
// Params 4, eflags: 0x0
// Checksum 0xb3e2fc2f, Offset: 0x11f8
// Size: 0xa4
function function_88d892b9(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level scene::init("p7_fxanim_cp_blackstation_apartment_collapse_bundle");
    objectives::set("cp_level_blackstation_goto_comm_relay");
    objectives::hide("cp_level_blackstation_goto_comm_relay");
    objectives::hide("cp_level_blackstation_qzone");
    showmiscmodels("collapse_frogger_water");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x59aa9a32, Offset: 0x12a8
// Size: 0x2b4
function function_fa216142() {
    level.var_2fd26037 thread function_7f3763ee();
    level.var_d1cabfc = 0;
    level thread function_a331bab9();
    level thread function_2397a7b2();
    level thread function_1932762c();
    level thread function_e2038b3();
    level thread function_d87a714f();
    level thread function_edabcebb();
    level thread function_f832655c();
    level thread function_2afc85c();
    level thread function_7902424c();
    level thread function_d7f282ac();
    level thread namespace_79e1cd97::function_90db9f9c();
    level thread function_e27b9e3c();
    level thread function_656de5b5();
    level thread function_f6f7ab3d();
    level thread function_969d668a();
    level thread function_37170d4a();
    level thread namespace_23567e72::function_26aa602b();
    foreach (player in level.activeplayers) {
        player thread function_5723cc6();
        player thread namespace_79e1cd97::function_d870e0("trig_police_station_lobby_in_position");
        player thread namespace_79e1cd97::function_d870e0("trig_spawn_upstairs_intro");
    }
    spawner::add_spawn_function_group("police_station_warlord", "script_noteworthy", &function_b45ce54a);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf8fe164, Offset: 0x1568
// Size: 0x5c
function function_5723cc6() {
    self endon(#"death");
    level endon(#"hash_39e22858");
    level flag::wait_till("flag_waypoint_police_station01");
    self waittill(#"weapon_fired");
    level flag::set("flag_lobby_engaged");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xc3aa4c52, Offset: 0x15d0
// Size: 0x74
function function_969d668a() {
    level flag::wait_till("flag_waypoint_police_station03");
    battlechatter::function_d9f49fba(0);
    level flag::wait_till("flag_kane_intro_complete");
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x1e182c0d, Offset: 0x1650
// Size: 0x44
function function_edabcebb() {
    level flag::wait_till("flag_enter_police_station");
    level thread objectives::breadcrumb("police_station_breadcrumb");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x809b9617, Offset: 0x16a0
// Size: 0x94
function function_2397a7b2() {
    trigger::wait_till("trig_police__station_group03", undefined, undefined, 0);
    var_56b381f2 = getent("police_station_warlord", "targetname");
    playrumbleonposition("cp_blackstation_rumble_breach", var_56b381f2.origin);
    playsoundatposition("evt_kane_explosion", (0, 0, 0));
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x1aa98b2f, Offset: 0x1740
// Size: 0x174
function function_1932762c() {
    level flag::wait_till("flag_lobby_setup");
    level thread namespace_4297372::function_bed0eaad();
    level flag::wait_till("flag_police_station_hendricks_cqb");
    if (!level flag::get("flag_lobby_engaged")) {
        level.var_2fd26037 thread dialog::say("hend_quiet_0");
    }
    level flag::wait_till("vo_hendricks_first");
    level.var_2fd26037 dialog::say("hend_moving_to_first_floo_0");
    trigger::wait_till("hend_moving_to_second", undefined, undefined, 0);
    level.var_2fd26037 dialog::say("hend_moving_to_second_flo_0");
    trigger::wait_till("hend_moving_to_third", undefined, undefined, 0);
    level.var_2fd26037 dialog::say("hend_moving_to_third_floo_0");
    level thread namespace_4297372::function_973b77f9();
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x5a91da16, Offset: 0x18c0
// Size: 0xf2
function function_e2038b3() {
    level endon(#"hash_262a14ee");
    level flag::wait_till("ps_enter_vo");
    level.var_2fd26037 dialog::say("hend_hostiles_above_and_0");
    level flag::wait_till("ps_upstairs_intro");
    if (!flag::get("flag_police_station_defend")) {
        level.var_2fd26037 dialog::say("hend_top_floor_0", 1);
    }
    level flag::wait_till("flag_police_station_defend");
    while (getaiteamarray("axis").size) {
        wait(1);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xd4e252f1, Offset: 0x19c0
// Size: 0x6c
function function_d87a714f() {
    trigger::wait_till("trigger_riot");
    level.var_2fd26037 dialog::say("hend_bastards_have_riot_s_0", 1);
    level.var_2fd26037 dialog::say("hend_hit_em_with_some_fr_0", 0.5);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x3666af6b, Offset: 0x1a38
// Size: 0x6c
function function_a7bb8a82() {
    spawner::simple_spawn("police_station_exterior_group", &function_4fa3ec81);
    spawner::simple_spawn("police_station_exterior_robot", &function_4fa3ec81);
    level function_8b31ae9b();
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xc5374d33, Offset: 0x1ab0
// Size: 0x454
function function_a331bab9() {
    level flag::wait_till("flag_lobby_setup");
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_2fd26037 ai::set_ignoreme(1);
    level flag::wait_till("flag_police_station_hendricks_cqb");
    if (!level flag::get("flag_lobby_engaged")) {
        level.var_2fd26037 dialog::say("hend_i_see_you_beat_h_0", 0.5);
        var_77d29eae = 0;
        for (i = 0; i < level.players.size; i++) {
            if (!var_77d29eae) {
                foreach (ai_enemy in level.var_4eef455c) {
                    if (isalive(ai_enemy) && ai_enemy.script_noteworthy === "police_station_gunner_target_01") {
                        ai_enemy thread function_bd78d653();
                        ai_enemy clientfield::set("kill_target_keyline", level.players[i] getentitynumber() + 1);
                        var_dd079248 = [];
                        array::add(var_dd079248, ai_enemy);
                        level.var_4eef455c = array::exclude(level.var_4eef455c, var_dd079248);
                        var_77d29eae = 1;
                    }
                }
                continue;
            }
            if (isdefined(level.var_4eef455c[i]) && level.var_4eef455c[i].script_noteworthy != "police_station_gunner_target_02") {
                level.var_4eef455c[i] clientfield::set("kill_target_keyline", level.players[i] getentitynumber() + 1);
                arrayremoveindex(level.var_4eef455c, i, 1);
            }
        }
        level flag::set("flag_lobby_ready_to_engage");
        level flag::wait_till_timeout(2, "flag_lobby_engaged");
        wait(0.5);
        level.var_2fd26037 ai::set_ignoreall(0);
        level.var_2fd26037 ai::set_ignoreme(0);
    } else {
        level.var_2fd26037 ai::set_ignoreall(0);
        level.var_2fd26037 ai::set_ignoreme(0);
        level.var_2fd26037 dialog::say("hend_they_re_onto_us_se_0");
    }
    level flag::wait_till("hendricks_subway_exit");
    level.var_2fd26037 function_cbbb2fea();
    spawner::waittill_ai_group_count("lobby_enemies", 5);
    level flag::set("approach_ps_entrance");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x16eab09e, Offset: 0x1f10
// Size: 0x7c
function function_693c6a46() {
    self waittill(#"death");
    if (!isdefined(level.var_d1cabfc)) {
        level.var_d1cabfc = 0;
    }
    level.var_d1cabfc++;
    if (level.var_d1cabfc > 2) {
        level flag::set("approach_ps_entrance");
        wait(1);
        level flag::set("flag_enter_police_station");
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xa0790630, Offset: 0x1f98
// Size: 0x50
function function_2c3b5e41() {
    self endon(#"death");
    while (true) {
        swarm = level waittill(#"hash_61df3d1c");
        self setignoreent(swarm, 1);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf61b642, Offset: 0x1ff0
// Size: 0x14c
function function_7f3763ee() {
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level flag::wait_till("approach_ps_entrance");
    trigger::use("triggercolor_ps_entrance");
    level flag::wait_till("flag_enter_police_station");
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    level flag::wait_till("police_station_enter");
    trigger::use("trig_hendricks_move_into_police_station", undefined, undefined, 0);
    level flag::wait_till("ps_regroup");
    trigger::use("triggercolor_regroup");
    trigger::wait_till("trigger_riot");
    spawn_manager::enable("police_station_group03_sm");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf972f052, Offset: 0x2148
// Size: 0x16c
function function_cbbb2fea() {
    ai_target = getent("police_station_gunner_target_02", "script_noteworthy", 1);
    if (isalive(ai_target)) {
        e_target = ai_target;
    } else {
        foreach (ai_enemy in level.var_4eef455c) {
            if (isalive(ai_enemy)) {
                e_target = ai_enemy;
                break;
            }
        }
    }
    self namespace_79e1cd97::function_4f96504c(e_target);
    if (isalive(e_target)) {
        self cybercom::function_d240e350("cybercom_fireflyswarm", e_target, 0, 1);
    }
    level.var_2fd26037 ai::set_ignoreall(0);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x9de6489c, Offset: 0x22c0
// Size: 0x44
function function_bd78d653() {
    level endon(#"hash_d9295e03");
    self waittill(#"death");
    wait(0.5);
    level dialog::function_13b3b16a("plyr_kill_confirmed_0");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xadc6256c, Offset: 0x2310
// Size: 0x112
function function_e27b9e3c() {
    level flag::wait_till("ps_upstairs_intro");
    a_ai_enemies = getaiteamarray("axis");
    a_ai_enemies = arraysortclosest(a_ai_enemies, level.var_2fd26037.origin);
    for (i = 0; i < a_ai_enemies.size; i++) {
        if (isalive(a_ai_enemies[i])) {
            level.var_2fd26037 thread namespace_79e1cd97::function_4f96504c(a_ai_enemies[i]);
            level.var_2fd26037 cybercom::function_d240e350("cybercom_fireflyswarm", a_ai_enemies[i], 0, 1);
            break;
        }
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x503754c3, Offset: 0x2430
// Size: 0x94
function function_76021c7d() {
    self endon(#"death");
    self ai::patrol(getnode("lobby_patrol_start_point", "targetname"));
    level flag::wait_till("flag_lobby_engaged");
    self setgoalvolume(getent("lobby_defend_volume_01", "targetname"));
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf4ca6a8f, Offset: 0x24d0
// Size: 0xb6
function function_8b31ae9b() {
    spawner::add_spawn_function_group("turret_gunner", "targetname", &function_e355fe3e);
    for (i = 1; i < 3; i++) {
        var_b8f9a884 = vehicle::simple_spawn_single("veh_turret_0" + i);
        var_b8f9a884 vehicle::lights_off();
        var_b8f9a884 thread turret_think();
    }
}

// Namespace namespace_933eb669
// Params 1, eflags: 0x0
// Checksum 0xc2ac7401, Offset: 0x2590
// Size: 0xc4
function function_e355fe3e(var_b8f9a884) {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    array::add(level.var_4eef455c, self);
    self thread function_dbf996a();
    level flag::wait_till("flag_lobby_engaged");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf51e1230, Offset: 0x2660
// Size: 0x9c
function turret_think() {
    self endon(#"death");
    level flag::wait_till("flag_lobby_engaged");
    wait(2);
    var_dfb53de7 = self vehicle::function_ad4ec07a("gunner1");
    if (isdefined(var_dfb53de7) && isalive(var_dfb53de7)) {
        self turret::enable(1, 1);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xb593b1b2, Offset: 0x2708
// Size: 0x2ec
function function_4fa3ec81() {
    self endon(#"death");
    self thread function_b1a1cd4d();
    self thread function_dbf996a();
    if (self.targetname == "police_station_exterior_robot_ai") {
        self thread function_693c6a46();
        self thread function_2c3b5e41();
    }
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level clientfield::set("sndStationWalla", 1);
    array::add(level.var_4eef455c, self);
    if (self.script_noteworthy === "lobby_patrol") {
        self thread function_76021c7d();
    }
    level flag::wait_till("flag_lobby_engaged");
    level clientfield::set("sndStationWalla", 0);
    self.maxsightdistsqrd = self.var_98207841;
    self ai::set_ignoreme(0);
    self.goalradius = 2048;
    if (self.targetname == "police_station_exterior_robot_ai") {
        self ai::set_ignoreall(0);
        self ai::set_behavior_attribute("move_mode", "rusher");
    } else {
        wait(randomfloatrange(0.3, 1.3));
        self ai::set_ignoreall(0);
    }
    spawner::waittill_ai_group_count("lobby_enemies", 9);
    if (self.script_noteworthy === "lobby_group_01") {
        wait(randomint(2));
        self setgoalvolume(getent("lobby_defend_volume_01", "targetname"));
        return;
    }
    if (self.script_noteworthy === "lobby_group_02") {
        wait(randomint(2));
        self setgoalvolume(getent("lobby_defend_volume_02", "targetname"));
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x89f8af09, Offset: 0x2a00
// Size: 0xf8
function function_b1a1cd4d() {
    self endon(#"death");
    level endon(#"hash_39e22858");
    self.var_98207841 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 160000;
    while (true) {
        foreach (player in level.activeplayers) {
            if (self cansee(player)) {
                level flag::set("flag_lobby_engaged");
            }
        }
        wait(0.3);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x7bf44817, Offset: 0x2b00
// Size: 0x6c
function function_dbf996a() {
    self util::waittill_any("damage", "bulletwhizby", "grenadedanger", "enemy", "projectile_impact", "cybercom_action");
    level flag::set("flag_lobby_engaged");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xe7bb3a9, Offset: 0x2b78
// Size: 0x1a4
function function_2afc85c() {
    trigger::wait_till("trig_kane_intro");
    level clientfield::set("flotsam", 0);
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand()) {
            player laststand::auto_revive(player);
        }
    }
    var_60a2aad6 = getaiteamarray("axis");
    foreach (ai in var_60a2aad6) {
        ai delete();
    }
    skipto::function_be8adfb8("objective_police_station");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x4b4b9af5, Offset: 0x2d28
// Size: 0x13e
function function_f832655c() {
    var_99450f8a = getentarray("script_worklight", "targetname");
    for (i = 0; i < var_99450f8a.size; i++) {
        var_99450f8a[i] fx::play("worklight", var_99450f8a[i].origin, var_99450f8a[i].angles, "fx_stop", 1, "tag_origin");
        var_99450f8a[i] fx::play("worklight_rays", var_99450f8a[i].origin, var_99450f8a[i].angles, "fx_stop", 1, "tag_origin");
        var_99450f8a[i] thread function_d8a1308b();
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x7c857b46, Offset: 0x2e70
// Size: 0x8a
function function_d8a1308b() {
    t_damage = getent(self.target, "targetname");
    if (isdefined(t_damage)) {
        t_damage trigger::wait_till();
    }
    level thread scene::play(t_damage.target, "targetname");
    self notify(#"hash_aae6938e");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x85ba1f3e, Offset: 0x2f08
// Size: 0xdc
function function_d7f282ac() {
    spawner::add_spawn_function_group("police_groundfloor01", "targetname", &function_5eb730ee);
    spawner::add_spawn_function_group("police_upstairs01", "targetname", &function_5eb730ee);
    spawner::add_spawn_function_group("police_station_group03", "targetname", &function_5eb730ee);
    trigger::wait_till("trigger_police_interior");
    spawn_manager::enable("police_groundfloor01_sm");
    spawn_manager::enable("police_station_group01_sm");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf5cc1493, Offset: 0x2ff0
// Size: 0x34
function function_5eb730ee() {
    self endon(#"death");
    self.goalradius = 32;
    self waittill(#"goal");
    self.goalradius = 700;
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x774b3d66, Offset: 0x3030
// Size: 0x94
function function_7902424c() {
    level flag::wait_till("ps_enter_vo");
    spawn_manager::enable("police_upstairs01_sm", 1);
    level trigger::wait_till("trig_spawn_upstairs_intro", undefined, undefined, 0);
    if (!flag::get("flag_police_station_defend")) {
        spawner::simple_spawn("police_upstairs02");
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x7e8bdce9, Offset: 0x30d0
// Size: 0x11c
function function_b45ce54a() {
    var_eaf20b66 = getnodearray("warlord_node", "script_noteworthy");
    foreach (node in var_eaf20b66) {
        self namespace_69ee7109::function_da308a83(node.origin, 5000, 10000);
    }
    var_5721137f = getnode("warlord_police_station_node", "targetname");
    if (isdefined(var_5721137f)) {
        self setgoal(var_5721137f);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xa72c4bd1, Offset: 0x31f8
// Size: 0x14c
function function_656de5b5() {
    flag::wait_till("flag_enter_cell_block");
    e_trigger = trigger::wait_till("trig_cellblock_ambush");
    if (e_trigger.who == level.var_2fd26037) {
        var_90e20a06 = getent("cellblock_ambush_spawn_01", "targetname");
        var_cbc84fe3 = var_90e20a06 spawner::spawn(1);
        var_cbc84fe3 function_f8eb4eb0();
    } else {
        var_90e20a06 = getent("cellblock_ambush_spawn_02", "targetname");
        var_cbc84fe3 = var_90e20a06 spawner::spawn(1);
    }
    if (!level flag::get("exit_cellblock")) {
        trigger::use("triger_hendricks_b7_cell_block_move", "targetname");
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf271127, Offset: 0x3350
// Size: 0xdc
function function_f8eb4eb0() {
    self endon(#"death");
    level.var_2fd26037 ai::set_ignoreall(1);
    self ai::set_ignoreall(1);
    self setgoal(self.origin, 1);
    level.var_2fd26037 colors::disable();
    self.animname = "patroller";
    level scene::add_scene_func("cin_bla_09_02_policestation_vign_ambush", &function_878db82b, "done");
    level.var_2fd26037 scene::play("cin_bla_09_02_policestation_vign_ambush");
}

// Namespace namespace_933eb669
// Params 1, eflags: 0x0
// Checksum 0x2e56952a, Offset: 0x3438
// Size: 0x3c
function function_878db82b(a_ents) {
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 colors::enable();
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x19e7ee4d, Offset: 0x3480
// Size: 0x234
function function_f6f7ab3d() {
    trigger::wait_till("trigger_phalanx");
    switch (level.players.size) {
    case 2:
        var_e64a5de5 = 3;
        break;
    case 3:
        var_e64a5de5 = 4;
        break;
    case 4:
        var_e64a5de5 = 5;
        break;
    default:
        var_e64a5de5 = 2;
        break;
    }
    v_start = struct::get("cell_phalanx_start").origin;
    v_end = struct::get("cell_phalanx_end").origin;
    var_f835ddae = getent("police_station_phalanx", "targetname");
    phalanx = new phalanx();
    [[ phalanx ]]->initialize("phanalx_wedge", v_start, v_end, 2, var_e64a5de5, var_f835ddae, var_f835ddae);
    var_ace28dfc = arraycombine(phalanx.sentienttiers_["phalanx_tier1"], phalanx.sentienttiers_["phalanx_tier2"], 0, 0);
    level thread namespace_23567e72::function_92e8d6d8(var_ace28dfc);
    a_ai = getaiteamarray("axis");
    array::wait_till(a_ai, "death");
    trigger::use("police_riotshield_color", undefined, undefined, 0);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x9ff28203, Offset: 0x36c0
// Size: 0x44
function function_37170d4a() {
    trigger::wait_till("trigger_cell_guard");
    spawner::simple_spawn("cell_guard", &function_1fb3b8c9);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x104cec99, Offset: 0x3710
// Size: 0xac
function function_1fb3b8c9() {
    self endon(#"death");
    self.goalradius = 32;
    level flag::wait_till("exit_cellblock");
    wait(randomfloatrange(1, 2.5));
    self.goalradius = 2048;
    if (level.activeplayers.size) {
        self setgoal(level.activeplayers[randomint(level.activeplayers.size)]);
    }
}

// Namespace namespace_933eb669
// Params 2, eflags: 0x0
// Checksum 0xf7b6c6a8, Offset: 0x37c8
// Size: 0x114
function function_1629236a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread namespace_79e1cd97::function_90db9f9c();
        namespace_79e1cd97::function_bff1a867("objective_kane_intro");
        level scene::init("cin_bla_10_01_kaneintro_3rd_sh010");
        load::function_a2995f22();
    }
    level thread namespace_79e1cd97::function_6778ea09("none");
    level thread function_6127b673();
    level flag::wait_till("flag_kane_intro_complete");
    level thread namespace_4297372::function_6c35b4f3();
    skipto::function_be8adfb8("objective_kane_intro");
}

// Namespace namespace_933eb669
// Params 4, eflags: 0x0
// Checksum 0x8e916cf1, Offset: 0x38e8
// Size: 0x19c
function function_5d496554(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::set("cp_level_blackstation_goto_relay");
    var_95c6d300 = getentarray("floating_trash", "targetname");
    array::thread_all(var_95c6d300, &util::self_delete);
    var_11d618f2 = arraycombine(getentarray("subway_corpse_2", "targetname"), getentarray("subway_corpse_3", "targetname"), 1, 0);
    var_11d618f2 = arraycombine(var_11d618f2, getentarray("subway_corpse_floating", "targetname"), 1, 0);
    array::thread_all(var_11d618f2, &util::self_delete);
    array::thread_all(getentarray("trigger_current", "targetname"), &namespace_79e1cd97::function_76b75dc7, "blackstation_exterior_engaged");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x942861e5, Offset: 0x3a90
// Size: 0x154
function function_6127b673() {
    foreach (player in level.activeplayers) {
        player thread namespace_79e1cd97::function_ed7faf05();
    }
    objectives::set("cp_level_blackstation_comm_relay");
    if (isdefined(level.var_a2d3ec51)) {
        level thread [[ level.var_a2d3ec51 ]]();
    }
    level thread namespace_4297372::function_5b1a53ea();
    level scene::add_scene_func("cin_bla_10_01_kaneintro_3rd_sh190", &function_80a596c6, "play");
    level scene::add_scene_func("cin_bla_10_01_kaneintro_3rd_sh190", &function_7a574065, "done");
    level scene::play("cin_bla_10_01_kaneintro_3rd_sh010");
}

// Namespace namespace_933eb669
// Params 1, eflags: 0x0
// Checksum 0xcdfd5a0, Offset: 0x3bf0
// Size: 0x104
function function_80a596c6(a_ents) {
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "slow");
    level.var_2fd26037 setgoal(getnode("hendricks_node_kane_intro_end", "targetname"), 1);
    if (!scene::function_b1f75ee9()) {
        wait(1);
        level.var_2fd26037 ai::gun_remove();
        level thread scene::play("cin_bla_10_01_kaneintro_end_idle");
        wait(1);
        level.var_2fd26037 ai::gun_recall();
        return;
    }
    level thread scene::play("cin_bla_10_01_kaneintro_end_idle");
}

// Namespace namespace_933eb669
// Params 1, eflags: 0x0
// Checksum 0x4ee78742, Offset: 0x3d00
// Size: 0xc4
function function_7a574065(a_ents) {
    level flag::set("flag_kane_intro_complete");
    level flag::set("flag_intro_dialog_ended");
    wait(0.3);
    level.var_2fd26037 clearforcedgoal();
    trigger::use("trig_hendricks_comm_b0", "targetname");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "off");
    util::clear_streamer_hint();
}

