#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_flood;

// Namespace cp_mi_sing_sgen_flood
// Params 2, eflags: 0x0
// Checksum 0x4903c611, Offset: 0x17b0
// Size: 0x45a
function function_37c559db(str_objective, var_74cd64bc) {
    init_flags();
    spawn_manager::function_41cd3a68(30);
    spawner::add_spawn_function_group("flood_combat_runners", "script_noteworthy", &function_ac25b5d5);
    array::run_all(getentarray("floor_door_hint_trigger", "targetname"), &triggerenable, 0);
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        cp_mi_sing_sgen_pallas::function_4ef8cf79();
        getent("pallas_lift_front", "targetname") util::self_delete();
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        array::run_all(getaiteamarray("axis"), &delete);
        load::function_a2995f22();
        if (level.var_31aefea8 === "dev_flood_combat") {
            level.players[0] setorigin((1152, -3864, -4876));
            level.players[0] setplayerangles((0, 0, 0));
        }
    } else {
        util::streamer_wait(undefined, 1, 3);
        level util::function_f7beb173();
        util::screen_fade_in(0.5, "black", "hide_trans_flood");
    }
    level thread namespace_cba4cc55::set_door_state("charging_station_entrance", "open");
    level clientfield::set("w_underwater_state", 1);
    setdvar("phys_buoyancy", 1);
    spawner::add_spawn_function_group("flood_reinforcement_robot", "script_noteworthy", &function_ae51faf3);
    level.var_2fd26037 ai::set_behavior_attribute("can_melee", 0);
    level.var_2fd26037 ai::set_behavior_attribute("can_be_meleed", 0);
    level thread function_aa1d0311();
    function_74594539();
    var_7082999f = struct::get_array("charging_station_spawn_point");
    array::thread_all(var_7082999f, &util::delay_notify, 5, "post_pallas");
    array::thread_all(getentarray("water_spout_trigger", "targetname"), &function_80012633);
    array::thread_all(getentarray("stumble_trigger", "targetname"), &namespace_cba4cc55::function_aef08215);
    main();
    skipto::function_be8adfb8("flood_combat");
}

// Namespace cp_mi_sing_sgen_flood
// Params 4, eflags: 0x0
// Checksum 0xc14d171, Offset: 0x1c18
// Size: 0x32
function function_ebe27bf1(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_99202726::function_bc2458f5();
}

// Namespace cp_mi_sing_sgen_flood
// Params 2, eflags: 0x0
// Checksum 0x40b875c0, Offset: 0x1c58
// Size: 0x432
function function_ba34fbda(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level flag::init("hendricks_defend_started");
        level flag::init("flood_defend_hendricks_at_door");
        array::run_all(getentarray("floor_door_hint_trigger", "targetname"), &triggerenable, 0);
        sgen::function_bff1a867(str_objective);
        cp_mi_sing_sgen_pallas::function_4ef8cf79();
        getent("pallas_lift_front", "targetname") util::self_delete();
        level flag::set("pallas_lift_front_open");
        level flag::wait_till("all_players_spawned");
        array::run_all(getaiteamarray("axis"), &delete);
        if (level.var_31aefea8 === "dev_flood_combat") {
            level.players[0] setorigin((1152, -3864, -4876));
            level.players[0] setplayerangles((0, 0, 0));
        }
        level clientfield::set("w_underwater_state", 1);
        setdvar("phys_buoyancy", 1);
        spawner::add_spawn_function_group("flood_reinforcement_robot", "script_noteworthy", &function_ae51faf3);
        level.var_2fd26037 ai::set_behavior_attribute("can_melee", 0);
        level.var_2fd26037 ai::set_behavior_attribute("can_be_meleed", 0);
        function_61810cbd();
        array::thread_all(getentarray("water_spout_trigger", "targetname"), &function_80012633);
        level thread function_e9256bf8();
        level thread function_e9c576dc();
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        objectives::set("cp_level_sgen_get_to_surface");
        level thread objectives::breadcrumb("flood_combat_breadcrumb_end_trig");
        level thread function_73cf7557();
        var_c3f856f0 = getent("flood_defend_out_of_boundary_trig", "targetname");
        var_c3f856f0 setvisibletoall();
        load::function_a2995f22();
    }
    spawner::add_spawn_function_group("flood_defend_catwalk_spawn_zone_robot", "targetname", &function_1348c36b);
    defend_main(var_74cd64bc);
    spawn_manager::function_41cd3a68(32);
    skipto::function_be8adfb8("flood_defend");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xf7391588, Offset: 0x2098
// Size: 0x82
function function_1348c36b() {
    n_level = 2;
    n_chance = namespace_cba4cc55::function_411dc61b(15, 11);
    if (n_chance > randomintrange(0, 100)) {
        n_level = 3;
    }
    self.goalradius = 256;
    self ai::set_behavior_attribute("rogue_control", "forced_level_" + n_level);
}

// Namespace cp_mi_sing_sgen_flood
// Params 4, eflags: 0x0
// Checksum 0x2d01f62c, Offset: 0x2128
// Size: 0x132
function function_e2a342e4(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    a_ai = getaiteamarray("axis", "team3");
    foreach (ai in a_ai) {
        if (!(isdefined(ai.archetype) && ai.archetype == "robot")) {
            ai.ignoreall = 1;
            ai namespace_cba4cc55::function_ceda7454();
            continue;
        }
        ai util::self_delete();
    }
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 ai::set_behavior_attribute("can_melee", 1);
        level.var_2fd26037 ai::set_behavior_attribute("can_be_meleed", 1);
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xf8b4f769, Offset: 0x2268
// Size: 0x4a
function init_flags() {
    level flag::init("hendricks_defend_started");
    level flag::init("flood_combat_nag_playing");
    level flag::init("flood_defend_hendricks_at_door");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x35972091, Offset: 0x22c0
// Size: 0x232
function main() {
    level flag::wait_till("all_players_spawned");
    var_46cf12c3 = getent("surgical_room_entrance_close", "targetname");
    level thread function_6cfe8da3();
    level thread function_7541af2d();
    level thread function_ab5cee74();
    level thread function_e9c576dc();
    level thread function_6e0718d8();
    level thread function_ef6ea5f9();
    level thread function_1d0ccf06();
    level thread function_28b80c6f();
    level util::clientnotify("escp");
    level scene::play("cin_sgen_20_02_twinrevenge_1st_elevator");
    level flag::set("pallas_lift_front_open");
    objectives::set("cp_level_sgen_get_to_surface");
    trigger::wait_till("surprised_54i_trigger");
    level thread function_324a038c();
    level thread function_d62206d0();
    level thread function_3aaf91d3();
    level flag::wait_till("flood_combat_surgical_room_door_close");
    spawn_manager::enable("flood_combat_defend_room_fallback_spawns");
    level thread function_f6ac14bc();
    level thread function_8f417d1b();
    level thread function_a86ae95d();
    level flag::wait_till_timeout(10, "flood_defend_zone_started");
    level notify(#"cancel_hendricks_safe_zone");
    spawn_manager::kill("flood_combat_defend_room_fallback_spawns", 1);
    level flag::wait_till_timeout(30, "flood_defend_reached");
    level flag::set("flood_defend_reached");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xe4298e22, Offset: 0x2500
// Size: 0x192
function function_3aaf91d3() {
    level flag::wait_till("flood_combat_charging_zone_cleared");
    var_3f8b1d18 = getent("flood_combat_charging_zone_trig", "targetname");
    var_c3f856f0 = getent("flood_defend_out_of_boundary_trig", "targetname");
    var_c3f856f0 setvisibletoall();
    namespace_cba4cc55::set_door_state("flood_robot_room_door_open", "close");
    spawn_manager::kill("flood_combat_charging_room_spawnmanager", 1);
    spawn_manager::kill("flood_combat_robot_room_spawnmanager", 1);
    wait 0.05;
    var_b8a74cba = getaiteamarray("axis");
    foreach (var_37ba03da in var_b8a74cba) {
        if (isalive(var_37ba03da) && var_37ba03da istouching(var_3f8b1d18)) {
            var_37ba03da kill();
        }
    }
    function_82fd0598();
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x5af5c34, Offset: 0x26a0
// Size: 0x82
function defend_main(var_74cd64bc) {
    level flag::wait_till("all_players_spawned");
    level flag::set("flood_combat_charging_zone_cleared");
    spawn_manager::kill("flood_combat_defend_room_fallback2_spawns", 1);
    level thread function_73858979();
    level thread function_d8208c5();
    function_fa1f6da6(var_74cd64bc);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xd247803b, Offset: 0x2730
// Size: 0x22a
function function_1d0ccf06() {
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.goalradius = 16;
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("pallas_lift_front_open");
    level scene::play("cin_sgen_21_01_releasetorrent_vign_pushdown_hendricks", level.var_2fd26037);
    level.var_2fd26037 setgoal(getnode("flood_combat_hendricks_intro_node", "targetname"));
    level.var_2fd26037 colors::enable();
    trigger::wait_till("flood_combat_windows_start", undefined);
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 setgoal(getnode("flood_combat_hendricks_catwalk_node", "targetname"));
    function_b9f4384b("flood_combat_catwalk_front_zone_trig", undefined, 0.75);
    level.var_2fd26037 function_763735d3("flood_combat_catwalk_front_zone_trig", undefined, undefined, 0.74, "cancel_hendricks_safe_zone");
    level thread function_1459984a();
    scene::add_scene_func("cin_sgen_21_02_floodcombat_vign_traverse_hendricks", &function_235df37, "play");
    level scene::play("cin_sgen_21_02_floodcombat_vign_traverse_hendricks");
    function_5d06f10b();
    var_9de10fe3 = getnode("flood_defend_hendricks_ready_node", "targetname");
    level.var_2fd26037 setgoal(var_9de10fe3);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x58592ae, Offset: 0x2968
// Size: 0xd3
function function_1459984a() {
    var_c90f67ac = getaiteamarray("axis");
    var_bdf5e96c = getent("flood_combat_catwalk_front_zone_trig", "targetname");
    foreach (var_7d41f0cd in var_c90f67ac) {
        if (isalive(var_7d41f0cd) && var_7d41f0cd istouching(var_bdf5e96c)) {
            var_7d41f0cd.health = 1;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 3, eflags: 0x0
// Checksum 0x7785cf9b, Offset: 0x2a48
// Size: 0x9a
function function_b9f4384b(str_key, str_val, n_delay) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    level endon(#"flood_defend");
    var_bdf5e96c = getent(str_key, str_val);
    var_bdf5e96c endon(#"death");
    do {
        var_bdf5e96c waittill(#"trigger", e_triggerer);
        if (isplayer(e_triggerer)) {
            break;
        }
    } while (true);
    wait n_delay;
}

// Namespace cp_mi_sing_sgen_flood
// Params 5, eflags: 0x0
// Checksum 0x69c55848, Offset: 0x2af0
// Size: 0x164
function function_763735d3(str_key, str_val, var_26fc0075, n_delay, str_ender) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    if (!isdefined(var_26fc0075)) {
        var_26fc0075 = "robot";
    }
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    self endon(#"death");
    level endon(#"flood_defend");
    if (isdefined(str_ender)) {
        level endon(str_ender);
    }
    var_68d8f035 = getent(str_key, str_val);
    var_68d8f035 endon(#"death");
    do {
        var_68d8f035 waittill(#"trigger");
        var_f580cae3 = 0;
        a_ai_enemies = getaispeciesarray("axis", var_26fc0075);
        foreach (ai_enemy in a_ai_enemies) {
            if (isalive(ai_enemy) && ai_enemy istouching(self)) {
                var_f580cae3++;
            }
        }
        wait 1.5;
    } while (var_f580cae3 > 0);
    wait n_delay;
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x34504a44, Offset: 0x2c60
// Size: 0x32
function function_235df37(a_ents) {
    level.var_2fd26037 waittill(#"hash_c1e3417f");
    spawn_manager::kill("flood_combat_defend_room_fallback_spawns", 1);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x5d2865db, Offset: 0x2ca0
// Size: 0xda
function function_74594539() {
    level scene::init("p7_fxanim_cp_sgen_door_bursting_01_bundle");
    level thread namespace_cba4cc55::set_door_state("surgical_room_door", "open");
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_0", "open");
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_1", "open");
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_2", "open");
    level thread namespace_cba4cc55::set_door_state("flood_robot_room_door_close", "close");
    level thread namespace_cba4cc55::set_door_state("flood_robot_room_door_open", "open");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xe8df5ae8, Offset: 0x2d88
// Size: 0xc2
function function_61810cbd() {
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_0", "open");
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_1", "open");
    level thread namespace_cba4cc55::set_door_state("surgical_room_interior_entrance_doors_2", "open");
    level thread namespace_cba4cc55::set_door_state("flood_robot_room_door_close", "close");
    level thread namespace_cba4cc55::set_door_state("flood_robot_crush_door", "close");
    level thread namespace_cba4cc55::set_door_state("surgical_room_door", "close");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x8bbfaacc, Offset: 0x2e58
// Size: 0x12b
function function_e9c576dc() {
    level endon(#"defend_time_expired");
    level namespace_cba4cc55::function_40077528(0.5, 1.5, namespace_cba4cc55::function_d455824c(), 5000, 4, 7);
    while (true) {
        if (math::cointoss()) {
            v_origin = level.var_2fd26037.origin;
        } else {
            v_origin = namespace_cba4cc55::function_d455824c();
        }
        if (isdefined(v_origin)) {
            n_magnitude = randomfloatrange(0.15, 0.25);
            n_duration = randomfloatrange(0.75, 1.78);
            n_range = 5000;
            n_timeout = randomfloatrange(8, 15);
            level namespace_cba4cc55::function_40077528(n_magnitude, n_duration, v_origin, n_range);
            wait n_timeout + n_duration;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xa124f4a8, Offset: 0x2f90
// Size: 0x7d
function function_ef6ea5f9() {
    level endon(#"hash_d55f5f70");
    t_exit = getent("flood_combat_flood_hall_cleanup_trig", "targetname");
    while (true) {
        t_exit waittill(#"trigger", var_67440414);
        level flag::set("flood_runner_escaped");
        var_67440414 delete();
        wait 0.05;
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x997e1d6a, Offset: 0x3018
// Size: 0xe3
function function_3957dfeb() {
    level.var_977a4717 = 1;
    var_6cb15f43 = getaispeciesarray("axis", "human");
    foreach (var_3f3a4339 in var_6cb15f43) {
        n_wait = randomfloatrange(0.15, 0.45);
        wait n_wait;
        if (isalive(var_3f3a4339)) {
            var_3f3a4339 thread function_49ba1bae();
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x1dc7c6f, Offset: 0x3108
// Size: 0x11b
function cancel_fallback() {
    level.var_977a4717 = 0;
    var_6cb15f43 = getaispeciesarray("axis", "human");
    foreach (var_3f3a4339 in var_6cb15f43) {
        n_wait = randomfloatrange(0.15, 0.45);
        if (isalive(var_3f3a4339)) {
            var_3f3a4339 ai::set_behavior_attribute("sprint", 0);
            var_3f3a4339 notify(#"cancel_fallback");
            var_3f3a4339.goalradius = 768;
            var_3f3a4339 thread function_cf14779(undefined, 768, 512);
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 4, eflags: 0x0
// Checksum 0x5eb355e8, Offset: 0x3230
// Size: 0x142
function function_cf14779(v_origin, n_min, n_max, b_reverse) {
    if (!isdefined(v_origin)) {
        v_origin = self.origin;
    }
    if (!isdefined(n_min)) {
        n_min = 256;
    }
    if (!isdefined(n_max)) {
        n_max = 512;
    }
    if (!isdefined(b_reverse)) {
        b_reverse = 0;
    }
    self endon(#"death");
    var_ea52a6de = getnodesinradiussorted(v_origin, n_min, n_max, -128);
    if (b_reverse && var_ea52a6de.size > 1) {
        var_ea52a6de = array::reverse(var_ea52a6de);
    }
    foreach (nd_cover in var_ea52a6de) {
        if (!isnodeoccupied(nd_cover) && isalive(self)) {
            self setgoal(nd_cover);
            return;
        }
    }
    self setgoal(self.origin);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xee50707c, Offset: 0x3380
// Size: 0xdd
function function_e45d59cc() {
    level endon(#"hash_8a67e7d4");
    var_40f8cd43 = getent("flood_combat_prelab_zone_aitrig", "targetname");
    var_33dce9d8 = getent("flood_combat_defend_upper_goaltrig", "targetname");
    var_40f8cd43 endon(#"death");
    var_33dce9d8 endon(#"death");
    var_40f8cd43 setinvisibletoall();
    while (true) {
        var_40f8cd43 waittill(#"trigger", e_triggerer);
        if (isalive(e_triggerer) && e_triggerer.script_noteworthy !== "ignore_last_stand") {
            e_triggerer notify(#"cancel_fallback");
            e_triggerer setgoal(var_33dce9d8);
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x65834fe1, Offset: 0x3468
// Size: 0x32
function function_f879cf37() {
    level endon(#"hash_8a67e7d4");
    level waittill(#"hash_b7eaf12a");
    cancel_fallback();
    function_b4ed3055();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xb70d2d37, Offset: 0x34a8
// Size: 0x19b
function function_b4ed3055() {
    var_b8a74cba = getaiteamarray("axis");
    var_33dce9d8 = getent("flood_combat_defend_upper_goaltrig", "targetname");
    var_40f8cd43 = getent("flood_combat_prelab_zone_aitrig", "targetname");
    s_center = struct::get("flood_defend_flee_center");
    foreach (var_37ba03da in var_b8a74cba) {
        n_wait = randomfloatrange(0.15, 0.45);
        if (isalive(var_37ba03da) && !var_37ba03da istouching(var_33dce9d8) && !var_37ba03da istouching(var_40f8cd43)) {
            var_37ba03da.accuracy = 0.1;
            var_37ba03da.health = 1;
            var_37ba03da thread function_cf14779(s_center.origin, s_center.radius, s_center.radius, 1);
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x5ef8466c, Offset: 0x3650
// Size: 0x10a
function function_6e0718d8() {
    trigger::wait_till("flood_combat_intro_fallback_trig");
    level thread function_3957dfeb();
    trigger::wait_till("flood_combat_charging_room_spawn_trig");
    level thread cancel_fallback();
    level flag::wait_till("flood_defend_start_flood_fallback");
    trigger::use("flood_combat_door_burst_trig");
    level thread function_3957dfeb();
    trigger::wait_till("flood_combat_robot_crushed_door_trig");
    level thread cancel_fallback();
    trigger::wait_till("flood_combat_prelab_spawn_trig");
    level thread function_3957dfeb();
    level flag::wait_till("flood_combat_surgical_room_door_close");
    function_e45d59cc();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xaeb18353, Offset: 0x3768
// Size: 0x2a
function function_ac25b5d5() {
    if (isdefined(level.var_977a4717) && level.var_977a4717) {
        self function_49ba1bae();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x416a6457, Offset: 0x37a0
// Size: 0x62
function function_49ba1bae() {
    var_9de10fe3 = getnode("flood_combat_fallback_node", "targetname");
    self ai::set_behavior_attribute("sprint", 1);
    self ai::force_goal(var_9de10fe3, 256, 0, "cancel_fallback");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xba918704, Offset: 0x3810
// Size: 0x42
function function_6cfe8da3() {
    array::thread_all(getentarray("alarm_sound", "targetname"), &function_2f80e7e2);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xd4969b6b, Offset: 0x3860
// Size: 0x52
function function_2f80e7e2() {
    self playloopsound("evt_flood_alarm_" + self.script_noteworthy);
    self waittill(#"hash_67907d63");
    self stoploopsound(0.5);
    self util::self_delete();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xd3404823, Offset: 0x38c0
// Size: 0x42
function function_8f417d1b() {
    level thread scene::play("water_lt_01", "targetname");
    level scene::play("water_rt_02", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xf90116c1, Offset: 0x3910
// Size: 0x9a
function function_a86ae95d() {
    level scene::init("dividerl_lt_01", "targetname");
    level scene::init("divider_rt_02", "targetname");
    level flag::wait_till("flood_combat_start_flooding");
    level thread function_60041a78();
    level thread function_13a96c2b();
    level thread function_d253868c();
    level thread function_82a20786();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x8cc0f6e2, Offset: 0x39b8
// Size: 0x82
function function_d253868c() {
    level clientfield::set("w_flood_combat_windows_b", 1);
    wait 1.2;
    level thread scene::stop("water_lt_01", "targetname", 1);
    level thread scene::play("water_lt_01_spill", "targetname");
    level thread scene::play("dividerl_lt_01", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x2f92df6c, Offset: 0x3a48
// Size: 0x82
function function_82a20786() {
    level clientfield::set("w_flood_combat_windows_c", 1);
    wait 0.93;
    level thread scene::stop("water_rt_02", "targetname", 1);
    level thread scene::play("water_rt_02_spill", "targetname");
    level thread scene::play("divider_rt_02", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x27f9c272, Offset: 0x3ad8
// Size: 0x92
function function_e9256bf8() {
    level thread function_60041a78();
    level thread function_13a96c2b();
    level clientfield::set("w_flood_combat_windows_b", 1);
    level thread scene::skipto_end("dividerl_lt_01", "targetname");
    level clientfield::set("w_flood_combat_windows_c", 1);
    level thread scene::skipto_end("divider_rt_02", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x192c51aa, Offset: 0x3b78
// Size: 0x282
function function_60041a78() {
    wait 1;
    var_3a7682f2 = getent("flooding_start_1", "targetname");
    var_14740889 = getent("flooding_start_2", "targetname");
    var_2d385a13 = getent("evt_torrent_gush_left", "targetname");
    var_cb0d3686 = getent("evt_torrent_gush_right", "targetname");
    var_853c208b = getent("evt_torrent_gush_surface_l", "targetname");
    var_1899b97e = getent("evt_torrent_gush_surface_r", "targetname");
    if (isdefined(var_3a7682f2) && isdefined(var_14740889)) {
        playsoundatposition("evt_flood_start_1", var_3a7682f2.origin);
        playsoundatposition("evt_flood_start_2", var_14740889.origin);
    }
    if (isdefined(var_2d385a13) && isdefined(var_cb0d3686) && isdefined(var_853c208b) && isdefined(var_1899b97e)) {
        var_2d385a13 playloopsound("evt_torrent_gush");
        var_cb0d3686 playloopsound("evt_torrent_gush");
        var_853c208b playloopsound("evt_torrent_gush_surface");
        var_1899b97e playloopsound("evt_torrent_gush_surface");
        level waittill(#"hash_67907d63");
        var_2d385a13 stoploopsound(0.5);
        var_2d385a13 delete();
        var_cb0d3686 stoploopsound(0.5);
        var_cb0d3686 delete();
        var_853c208b stoploopsound(0.5);
        var_853c208b delete();
        var_1899b97e stoploopsound(0.5);
        var_1899b97e delete();
        var_3a7682f2 delete();
        var_14740889 delete();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x66765acf, Offset: 0x3e08
// Size: 0x152
function function_13a96c2b() {
    level endon(#"hash_5d38bbf8");
    e_volume = getent("flood_combat_water_sheeting", "targetname");
    e_volume endon(#"death");
    while (true) {
        foreach (player in level.players) {
            if (player istouching(e_volume)) {
                if (!(isdefined(player.tp_water_sheeting) && player.tp_water_sheeting)) {
                    player clientfield::set_to_player("tp_water_sheeting", 1);
                    player.tp_water_sheeting = 1;
                }
                continue;
            }
            if (isdefined(player.tp_water_sheeting) && player.tp_water_sheeting) {
                player clientfield::set_to_player("tp_water_sheeting", 0);
                player.tp_water_sheeting = 0;
            }
        }
        wait 1;
    }
    array::thread_all(level.players, &clientfield::set_to_player, "tp_water_sheeting", 0);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x70ba5626, Offset: 0x3f68
// Size: 0x1d5
function function_80012633() {
    level endon(#"hash_d55f5f70");
    var_3b889aff = struct::get_array(self.target, "targetname");
    v_dir = anglestoforward((0, var_3b889aff[0].angles[1], 0));
    v_org = var_3b889aff[0].origin;
    v_length = -128;
    array::thread_all(var_3b889aff, &function_d4c5fb8e, self);
    while (true) {
        self waittill(#"trigger", player);
        if (!player isonground() && isdefined(player.var_fca98bd1) && gettime() - player.var_fca98bd1 < 1000) {
            continue;
        }
        n_distance = distance2d(v_org, player.origin);
        if (n_distance > v_length) {
            continue;
        }
        if (player issprinting() && n_distance > v_length * 0.4) {
            continue;
        }
        n_push_strength = mapfloat(0, v_length, 80, 0, n_distance);
        v_player_velocity = player getvelocity();
        player setvelocity(v_player_velocity + v_dir * n_push_strength);
        if (!player isonground()) {
            player.var_fca98bd1 = gettime();
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x53f48335, Offset: 0x4148
// Size: 0x112
function function_d4c5fb8e(trigger) {
    level endon(#"hash_d55f5f70");
    var_7a88c258 = util::spawn_model("tag_origin", self.origin, self.angles);
    var_7a88c258.script_objective = "flood_defend";
    trigger::wait_till(self.target, undefined, undefined, 0);
    if (isdefined(trigger.script_string)) {
        level thread scene::play(trigger.script_string);
        level thread namespace_cba4cc55::function_40077528(0.35, randomfloatrange(0.8, 1.4), namespace_cba4cc55::function_d455824c(), 5000, 1, 2);
    }
    var_7a88c258 playsound("evt_pipe_break");
    var_7a88c258 playloopsound("evt_water_pipe_flow");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x52d92ae6, Offset: 0x4268
// Size: 0x82
function function_f6ac14bc() {
    var_fa42e2ca = spawner::simple_spawn_single("surgical_room_door_close_guy_spawner");
    level util::delay(2, "death", &namespace_cba4cc55::set_door_state, "surgical_room_door", "close");
    if (isalive(var_fa42e2ca)) {
        var_fa42e2ca function_49ba1bae();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x7d80c0d1, Offset: 0x42f8
// Size: 0x4a
function function_f899badb() {
    level thread function_cb3a24c5();
    level waittill(#"hash_65ca45df");
    spawn_manager::disable("flood_combat_reinforcements");
    spawn_manager::kill("flood_combat_reinforcements_human");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xdb60ba4f, Offset: 0x4350
// Size: 0x75
function function_cb3a24c5() {
    level endon(#"hash_65ca45df");
    while (true) {
        level namespace_cba4cc55::function_40077528(0.35, randomfloatrange(0.8, 1.4), namespace_cba4cc55::function_d455824c(), 5000, 1, 2);
        wait randomintrange(8, 15);
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0xbf88fb76, Offset: 0x43d0
// Size: 0x242
function function_fa1f6da6(var_74cd64bc) {
    level thread function_d6ee7c7d();
    level thread function_e9bcb005();
    level thread function_f879cf37();
    spawner::add_spawn_function_group("flood_defend_runner", "script_noteworthy", &function_3ed2d232);
    if (var_74cd64bc) {
        level thread function_5d06f10b();
    }
    level flag::wait_till("defend_ready");
    level flag::set("flood_defend_enemies_spawning");
    spawn_manager::enable("flood_combat_reinforcements");
    level thread function_5d080bdb();
    level flag::wait_till("hendricks_defend_started");
    spawn_manager::enable("flood_combat_reinforcements_human");
    level thread namespace_d40478f6::function_72ef07c3();
    level.var_2fd26037 ai::set_ignoreall(1);
    level thread function_f899badb();
    wait 18;
    level notify(#"hash_5097097b");
    wait 12;
    level notify(#"hash_3b0cb580");
    wait 7;
    level flag::set("defend_time_expired");
    var_fbee94bb = getent("floor_door_hint_trigger", "targetname");
    objectives::set("cp_level_sgen_use_door", var_fbee94bb.origin);
    var_8ad7c437 = util::function_14518e76(var_fbee94bb, %cp_prompt_enter_sgen_door, %CP_MI_SING_SGEN_FLOOD_USE_DOOR, &function_d0378b1a);
    level waittill(#"hash_37c452a9");
    objectives::complete("cp_level_sgen_use_door");
    objectives::set("cp_level_sgen_get_to_surface");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x51a7a481, Offset: 0x4620
// Size: 0x5a
function function_3ed2d232() {
    self ai::set_behavior_attribute("sprint", 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("sprint", 0);
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x19ce185e, Offset: 0x4688
// Size: 0x162
function function_d0378b1a(e_player) {
    level notify(#"hash_65ca45df");
    level thread namespace_d40478f6::function_973b77f9();
    self gameobjects::disable_object();
    objectives::complete("cp_level_sgen_use_door");
    if (isdefined(level.var_723afba)) {
        level thread [[ level.var_723afba ]]();
    }
    scene::add_scene_func("cin_sgen_22_01_release_torrent_1st_flood_hendricks", &function_89f9dea6, "play");
    level thread scene::play("cin_sgen_22_01_release_torrent_1st_flood_hendricks", level.var_2fd26037);
    scene::add_scene_func("cin_sgen_22_01_release_torrent_1st_flood_player", &function_581db5d8, "play");
    level scene::play("cin_sgen_22_01_release_torrent_1st_flood_player", e_player);
    level notify(#"hash_67907d63");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 colors::enable();
    spawn_manager::kill("flood_defend_catwalk_spawn_zone_spawnmanager", 1);
    level notify(#"hash_37c452a9");
    self gameobjects::destroy_object(1);
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x9850bb95, Offset: 0x47f8
// Size: 0x83
function function_581db5d8(a_ents) {
    level endon(#"hash_6ede777e");
    wait 1.5;
    foreach (player in level.players) {
        player clientfield::set_to_player("water_teleport", 1);
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0x5aea91e4, Offset: 0x4888
// Size: 0x7b
function function_82311a3e(a_ents) {
    level notify(#"hash_6ede777e");
    foreach (player in level.players) {
        player clientfield::set_to_player("water_teleport", 0);
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x7efc7857, Offset: 0x4910
// Size: 0xc2
function function_28b80c6f() {
    trigger::wait_till("trig_hallway_ceiling_collapse_01");
    level clientfield::set("ceiling_collapse", 1);
    trigger::wait_till("trig_hallway_ceiling_collapse_02");
    level clientfield::set("ceiling_collapse", 2);
    trigger::wait_till("trig_hallway_ceiling_collapse_03");
    level clientfield::set("ceiling_collapse", 3);
    trigger::wait_till("trig_hallway_ceiling_collapse_04");
    level clientfield::set("ceiling_collapse", 4);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x7a0e5522, Offset: 0x49e0
// Size: 0x192
function function_5d06f10b() {
    var_350c27ef = getnode("hendricks_flood_combat_wait", "targetname");
    level.var_2fd26037 setgoal(var_350c27ef.origin);
    level flag::wait_till("defend_ready");
    var_421ccb2d = getent("flood_defend_defend_room_zone_trig", "targetname");
    var_a3eb613f = 1;
    while (var_a3eb613f) {
        var_a3eb613f = 0;
        a_ai_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (ai_enemy istouching(var_421ccb2d)) {
                var_a3eb613f = 1;
                break;
            }
        }
        wait 0.2;
    }
    level scene::play("cin_sgen_22_01_release_torrent_vign_flood_new_hendricks_hackdoor", level.var_2fd26037);
    level flag::set("hendricks_defend_started");
    level thread scene::play("cin_sgen_22_01_release_torrent_vign_flood_new_hendricks_grabdoor", level.var_2fd26037);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x271df53b, Offset: 0x4b80
// Size: 0x6a
function function_73cf7557() {
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.goalradius = 16;
    var_9de10fe3 = getnode("flood_defend_hendricks_ready_node", "targetname");
    level.var_2fd26037 setgoal(var_9de10fe3);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xeb4dc13e, Offset: 0x4bf8
// Size: 0x62
function function_82fd0598() {
    level thread namespace_cba4cc55::set_door_state("charging_station_entrance", "close");
    array::thread_all(getentarray("pod_track_model", "targetname"), &util::self_delete);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x8f27ce05, Offset: 0x4c68
// Size: 0x52
function function_ae51faf3() {
    self ai::set_behavior_attribute("force_cover", 1);
    self ai::set_behavior_attribute("sprint", 1);
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x54f6f6a4, Offset: 0x4cc8
// Size: 0x165
function function_5d080bdb() {
    var_bdf5e96c = getent("flood_defend_catwalk_spawn_zone_trig", "targetname");
    var_408caf2f = getent(var_bdf5e96c.target, "targetname");
    var_bdf5e96c endon(#"death");
    var_bdf5e96c waittill(#"trigger");
    level thread namespace_cba4cc55::set_door_state("flood_robot_room_door_close", "open");
    level thread namespace_cba4cc55::set_door_state("flood_robot_room_door_open", "close");
    while (isdefined(var_bdf5e96c)) {
        var_bdf5e96c waittill(#"trigger");
        if (!spawn_manager::is_enabled(var_408caf2f.targetname)) {
            spawn_manager::enable(var_408caf2f.targetname);
        }
        function_5d5cec4b("flood_defend_catwalk_spawn_zone_robot", undefined, 0);
        level flag::wait_till("flood_defend_catwalk_spawn_zone_unoccupied");
        function_5d5cec4b("flood_defend_catwalk_spawn_zone_robot");
        spawn_manager::disable(var_408caf2f.targetname);
        var_bdf5e96c thread function_718c6e08();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x7c2856ee, Offset: 0x4e38
// Size: 0xa3
function function_718c6e08() {
    self endon(#"death");
    self endon(#"trigger");
    wait 4;
    var_64e85e6d = getentarray("flood_defend_catwalk_spawn_zone_robot" + "_ai", "targetname");
    foreach (var_73be40d2 in var_64e85e6d) {
        var_73be40d2 kill();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 3, eflags: 0x0
// Checksum 0x3c81b667, Offset: 0x4ee8
// Size: 0x7a
function function_5d5cec4b(var_c335265b, str_key, b_ignore) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_ignore)) {
        b_ignore = 1;
    }
    var_6bc905f9 = getentarray(var_c335265b + "_ai", str_key);
    array::thread_all(var_6bc905f9, &ai::set_ignoreall, b_ignore);
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x934255af, Offset: 0x4f70
// Size: 0x1a
function function_324a038c() {
    level scene::play("cin_sgen_21_03_floodcombat_vign_rejoin");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x9642a985, Offset: 0x4f98
// Size: 0x52
function function_d62206d0() {
    level flag::wait_till("flood_combat_door_crush_robot_start");
    level thread scene::play("cin_sgen_21_02_floodcombat_vign_escape_robot01");
    level waittill(#"hash_14bc1e1c");
    trigger::use("sgen_robot_crushed_water_trig");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x609c0b97, Offset: 0x4ff8
// Size: 0xa2
function function_d6ee7c7d() {
    var_16e2c3f6 = spawner::simple_spawn_single("flood_defend_flood_door_guy");
    level scene::init("cin_sgen_21_03_surgical_room_vign_closedoor_54i01", var_16e2c3f6);
    trigger::wait_till("flood_defend_defend_area_trig");
    if (isalive(var_16e2c3f6)) {
        var_16e2c3f6 ai::set_ignoreall(1);
        var_16e2c3f6 ai::set_ignoreme(1);
        level scene::play("cin_sgen_21_03_surgical_room_vign_closedoor_54i01", var_16e2c3f6);
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x4cb89b04, Offset: 0x50a8
// Size: 0x7a
function function_e9bcb005() {
    level thread scene::play("p7_fxanim_cp_sgen_debris_hallway_flood_bundle");
    level clientfield::set("flood_defend_hallway_flood_siege", 1);
    level thread function_5b17f290();
    level waittill(#"hash_b6f74de7");
    level thread function_ccc97d5();
    level scene::init("fxanim_flooded_lab_door", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x64696b9f, Offset: 0x5130
// Size: 0x92
function function_ccc97d5() {
    var_6117374 = spawn("script_origin", (26360, 1575, -6604));
    level waittill(#"hash_deaf06de");
    var_6117374 playsound("evt_flood_door_impact");
    var_6117374 playloopsound("evt_flood_metal_stress", 2);
    level waittill(#"hash_65ca45df");
    var_6117374 stoploopsound(2);
    var_6117374 delete();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xbcd10c04, Offset: 0x51d0
// Size: 0x142
function function_5b17f290() {
    var_af9cb339 = struct::get("flood_defend_wave_source_spot");
    level waittill(#"hash_401b5f85");
    var_b8a74cba = getaispeciesarray("axis", "human");
    var_b8a74cba = arraysortclosest(var_b8a74cba, var_af9cb339.origin);
    foreach (var_37ba03da in var_b8a74cba) {
        wait randomfloatrange(0.2, 0.32);
        if (isalive(var_37ba03da) && distance2d(var_37ba03da.origin, var_af9cb339.origin) <= var_af9cb339.radius) {
            var_37ba03da kill();
        }
    }
    level flag::set("flood_defend_flood_hallway_kill_zone_enabled");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x2ffcba21, Offset: 0x5320
// Size: 0x62
function function_aa1d0311() {
    level scene::init("p7_fxanim_cp_sgen_pipes_bursting_01_bundle");
    level scene::init("p7_fxanim_cp_sgen_pipes_bursting_02_bundle");
    level scene::init("p7_fxanim_cp_sgen_pipes_bursting_03_bundle");
    level scene::init("p7_fxanim_cp_sgen_pipes_bursting_04_bundle");
}

// Namespace cp_mi_sing_sgen_flood
// Params 1, eflags: 0x0
// Checksum 0xb4f2969d, Offset: 0x5390
// Size: 0x32
function function_89f9dea6(a_ents) {
    level waittill(#"hash_b1ecfdaa");
    level scene::play("fxanim_flooded_lab_door", "targetname");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xc4bafd29, Offset: 0x53d0
// Size: 0x1b2
function function_7541af2d() {
    level.var_2fd26037 dialog::say("hend_what_the_hell_was_0", randomfloatrange(0.2, 0.3));
    level.var_2fd26037 dialog::say("plyr_sounds_like_taylor_s_0", randomfloatrange(0.2, 0.3));
    level flag::wait_till("pallas_lift_front_open");
    level dialog::remote("kane_hendricks_we_have_m_0", randomfloatrange(0.1, 0.25));
    level.var_2fd26037 dialog::say("hend_you_heard_her_let_0", randomfloatrange(0.2, 0.3));
    level dialog::remote("kane_overwatch_drone_show_0", randomfloatrange(0.5, 0.76));
    level thread function_19acbb90();
    trigger::wait_till("flood_combat_charging_station_zone_trig");
    level.var_2fd26037 dialog::say("hend_get_through_them_we_0");
    level thread function_b5c83759();
    level thread important_story_vo();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x1f16ea92, Offset: 0x5590
// Size: 0xfb
function function_19acbb90() {
    level endon(#"hash_d55f5f70");
    var_846737f = 3;
    var_5b1de241 = 4;
    n_index = 0;
    var_d44c15f4 = [];
    var_d44c15f4[0] = "hend_keep_moving_the_wh_0";
    var_d44c15f4[1] = "hend_go_go_go_0";
    while (n_index < var_d44c15f4.size) {
        trigger::wait_till("flood_combat_security_room_zone_trig");
        if (!level flag::get("flood_combat_nag_playing")) {
            level flag::set("flood_combat_nag_playing");
            level.var_2fd26037 dialog::say(var_d44c15f4[n_index]);
            n_index++;
            level flag::clear("flood_combat_nag_playing");
            var_3d70d73e = randomfloatrange(var_846737f, var_5b1de241);
            wait var_3d70d73e;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0xa2a13ddc, Offset: 0x5698
// Size: 0x105
function function_b5c83759() {
    level endon(#"hash_d55f5f70");
    var_846737f = 3;
    var_5b1de241 = 6;
    n_index = 0;
    var_d44c15f4 = [];
    var_d44c15f4[0] = "hend_get_through_them_we_0";
    var_d44c15f4[1] = "hend_don_t_stop_move_m_0";
    var_d44c15f4[2] = "hend_fucking_move_0";
    while (n_index < var_d44c15f4.size) {
        var_3d70d73e = randomfloatrange(var_846737f, var_5b1de241);
        wait var_3d70d73e;
        trigger::wait_till("flood_combat_charging_station_zone_trig");
        if (!level flag::get("flood_combat_nag_playing")) {
            level flag::set("flood_combat_nag_playing");
            level.var_2fd26037 dialog::say(var_d44c15f4[n_index]);
            n_index++;
            level flag::clear("flood_combat_nag_playing");
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x74dae5b8, Offset: 0x57a8
// Size: 0x92
function important_story_vo() {
    trigger::wait_till("important_story_vo", "targetname");
    level dialog::say("plyr_start_scanning_for_t_0", randomfloatrange(0.5, 0.76));
    level dialog::remote("kane_i_m_scanning_file_tr_0", randomfloatrange(0.75, 1.25));
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x5c3b55df, Offset: 0x5848
// Size: 0x21a
function function_73858979() {
    trigger::wait_or_timeout(20, "flood_defend_defend_area_trig");
    level thread util::clientnotify("escps");
    level dialog::function_13b3b16a("plyr_kane_i_hope_you_go_0");
    level dialog::remote("kane_alright_i_ll_talk_y_0", randomfloatrange(0.1, 0.25));
    level.var_2fd26037 dialog::say("hend_what_are_you_insan_0", randomfloatrange(0.1, 0.25));
    level dialog::remote("kane_not_if_this_works_y_0", randomfloatrange(0.1, 0.25));
    level.var_2fd26037 dialog::say("hend_okay_okay_but_if_t_0", randomfloatrange(0.1, 0.25));
    level flag::set("defend_ready");
    level waittill(#"hash_5097097b");
    level dialog::remote("kane_i_ve_id_d_the_surviv_0");
    level dialog::function_13b3b16a("plyr_all_in_good_time_ka_0", 0.3);
    level waittill(#"hash_3b0cb580");
    level.var_2fd26037 dialog::say("hend_just_a_few_more_seco_0", randomfloatrange(0.1, 0.25));
    level waittill(#"defend_time_expired");
    level.var_2fd26037 dialog::say("hend_give_me_a_hand_0");
    level.var_2fd26037 thread function_3d56a972();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x91efc60d, Offset: 0x5a70
// Size: 0xdb
function function_3d56a972() {
    level endon(#"hash_65ca45df");
    var_d44c15f4 = [];
    var_d44c15f4[0] = "hend_c_mon_we_gotta_get_o_0";
    var_d44c15f4[1] = "hend_the_whole_building_s_0";
    var_d44c15f4[2] = "hend_what_are_you_waiting_3";
    var_d44c15f4[3] = "hend_help_me_with_the_doo_0";
    foreach (n_index, str_nag in var_d44c15f4) {
        wait randomfloatrange(3, 6);
        level.var_2fd26037 dialog::say(var_d44c15f4[n_index], randomfloatrange(0.1, 0.25));
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x43a0a707, Offset: 0x5b58
// Size: 0x1a
function function_ab5cee74() {
    objectives::breadcrumb("flood_combat_start_breadcrumb_trig");
}

// Namespace cp_mi_sing_sgen_flood
// Params 0, eflags: 0x0
// Checksum 0x1388e111, Offset: 0x5b80
// Size: 0x62
function function_d8208c5() {
    level thread objectives::breadcrumb("flood_combat_breadcrumb_end_trig");
    level flag::wait_till("hendricks_defend_started");
    objectives::complete("cp_waypoint_breadcrumb");
    level flag::wait_till("defend_time_expired");
}

