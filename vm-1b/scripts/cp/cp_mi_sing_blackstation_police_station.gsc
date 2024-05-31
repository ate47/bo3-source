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
// Checksum 0xcf7dc62a, Offset: 0x10d8
// Size: 0xf2
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
// Checksum 0x42a32918, Offset: 0x11d8
// Size: 0x9a
function function_88d892b9(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level scene::init("p7_fxanim_cp_blackstation_apartment_collapse_bundle");
    objectives::set("cp_level_blackstation_goto_comm_relay");
    objectives::hide("cp_level_blackstation_goto_comm_relay");
    objectives::hide("cp_level_blackstation_qzone");
    showmiscmodels("collapse_frogger_water");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x47af69e2, Offset: 0x1280
// Size: 0x1f2
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
// Checksum 0xb32d90e2, Offset: 0x1480
// Size: 0x4a
function function_5723cc6() {
    self endon(#"death");
    level endon(#"hash_39e22858");
    level flag::wait_till("flag_waypoint_police_station01");
    self waittill(#"weapon_fired");
    level flag::set("flag_lobby_engaged");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x1df3e1ee, Offset: 0x14d8
// Size: 0x52
function function_969d668a() {
    level flag::wait_till("flag_waypoint_police_station03");
    battlechatter::function_d9f49fba(0);
    level flag::wait_till("flag_kane_intro_complete");
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x3bf5b222, Offset: 0x1538
// Size: 0x32
function function_edabcebb() {
    level flag::wait_till("flag_enter_police_station");
    level thread objectives::breadcrumb("police_station_breadcrumb");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x87cd4436, Offset: 0x1578
// Size: 0x7a
function function_2397a7b2() {
    trigger::wait_till("trig_police__station_group03", undefined, undefined, 0);
    var_56b381f2 = getent("police_station_warlord", "targetname");
    playrumbleonposition("cp_blackstation_rumble_breach", var_56b381f2.origin);
    playsoundatposition("evt_kane_explosion", (0, 0, 0));
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x423bdea3, Offset: 0x1600
// Size: 0x132
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
// Checksum 0xbdef6966, Offset: 0x1740
// Size: 0xcb
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
// Checksum 0x7efb6325, Offset: 0x1818
// Size: 0x62
function function_d87a714f() {
    trigger::wait_till("trigger_riot");
    level.var_2fd26037 dialog::say("hend_bastards_have_riot_s_0", 1);
    level.var_2fd26037 dialog::say("hend_hit_em_with_some_fr_0", 0.5);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x52ad7240, Offset: 0x1888
// Size: 0x62
function function_a7bb8a82() {
    spawner::simple_spawn("police_station_exterior_group", &function_4fa3ec81);
    spawner::simple_spawn("police_station_exterior_robot", &function_4fa3ec81);
    level function_8b31ae9b();
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x5edf7ec0, Offset: 0x18f8
// Size: 0x372
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
// Checksum 0xaf12207f, Offset: 0x1c78
// Size: 0x4a
function function_693c6a46() {
    self waittill(#"death");
    level.var_d1cabfc++;
    if (level.var_d1cabfc > 2) {
        level flag::set("approach_ps_entrance");
        wait(1);
        level flag::set("flag_enter_police_station");
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x1ce7bc50, Offset: 0x1cd0
// Size: 0x3d
function function_2c3b5e41() {
    self endon(#"death");
    while (true) {
        swarm = level waittill(#"hash_61df3d1c");
        self setignoreent(swarm, 1);
    }
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x4cb38125, Offset: 0x1d18
// Size: 0x11a
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
// Checksum 0x8e1c7f0d, Offset: 0x1e40
// Size: 0x11a
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
// Checksum 0x88ab02a9, Offset: 0x1f68
// Size: 0x32
function function_bd78d653() {
    level endon(#"hash_d9295e03");
    self waittill(#"death");
    wait(0.5);
    level dialog::function_13b3b16a("plyr_kill_confirmed_0");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xa2f119c0, Offset: 0x1fa8
// Size: 0xd3
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
// Checksum 0xd3fa0d95, Offset: 0x2088
// Size: 0x82
function function_76021c7d() {
    self endon(#"death");
    self ai::patrol(getnode("lobby_patrol_start_point", "targetname"));
    level flag::wait_till("flag_lobby_engaged");
    self setgoalvolume(getent("lobby_defend_volume_01", "targetname"));
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x9f6d0867, Offset: 0x2118
// Size: 0x91
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
// Checksum 0x7f409cb2, Offset: 0x21b8
// Size: 0x92
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
// Checksum 0x9b34e9ee, Offset: 0x2258
// Size: 0x72
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
// Checksum 0xd1ee55ea, Offset: 0x22d8
// Size: 0x262
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
// Checksum 0xaa63b480, Offset: 0x2548
// Size: 0xbd
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
// Checksum 0xfef6269, Offset: 0x2610
// Size: 0x5a
function function_dbf996a() {
    self util::waittill_any("damage", "bulletwhizby", "grenadedanger", "enemy", "projectile_impact", "cybercom_action");
    level flag::set("flag_lobby_engaged");
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x159c71cd, Offset: 0x2678
// Size: 0x142
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
// Checksum 0xfc8c5fa2, Offset: 0x27c8
// Size: 0xe1
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
// Checksum 0x5d4b5dfb, Offset: 0x28b8
// Size: 0x6b
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
// Checksum 0x1f09759f, Offset: 0x2930
// Size: 0xda
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
// Checksum 0x9c631e08, Offset: 0x2a18
// Size: 0x2a
function function_5eb730ee() {
    self endon(#"death");
    self.goalradius = 32;
    self waittill(#"goal");
    self.goalradius = 700;
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xf9802112, Offset: 0x2a50
// Size: 0x7a
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
// Checksum 0x159514c5, Offset: 0x2ad8
// Size: 0xd2
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
// Checksum 0xff98b9dd, Offset: 0x2bb8
// Size: 0x11a
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
// Checksum 0x1519706d, Offset: 0x2ce0
// Size: 0xc2
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
// Checksum 0xc029ba29, Offset: 0x2db0
// Size: 0x3a
function function_878db82b(a_ents) {
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 colors::enable();
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0x7e44b2a9, Offset: 0x2df8
// Size: 0x1ca
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
// Checksum 0x1746cb87, Offset: 0x2fd0
// Size: 0x42
function function_37170d4a() {
    trigger::wait_till("trigger_cell_guard");
    spawner::simple_spawn("cell_guard", &function_1fb3b8c9);
}

// Namespace namespace_933eb669
// Params 0, eflags: 0x0
// Checksum 0xc9326d74, Offset: 0x3020
// Size: 0x92
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
// Checksum 0x5e3629e, Offset: 0x30c0
// Size: 0xe2
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
// Checksum 0xb305962c, Offset: 0x31b0
// Size: 0x17a
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
// Checksum 0x647f715, Offset: 0x3338
// Size: 0x11a
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
// Checksum 0xfa952974, Offset: 0x3460
// Size: 0xe2
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
// Checksum 0xed1b1a12, Offset: 0x3550
// Size: 0xb2
function function_7a574065(a_ents) {
    level flag::set("flag_kane_intro_complete");
    level flag::set("flag_intro_dialog_ended");
    wait(0.3);
    level.var_2fd26037 clearforcedgoal();
    trigger::use("trig_hendricks_comm_b0", "targetname");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "off");
    util::clear_streamer_hint();
}

