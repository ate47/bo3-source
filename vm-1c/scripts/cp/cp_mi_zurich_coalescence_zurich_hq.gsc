#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_sacrifice;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/visionset_mgr_shared;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_b73b0f52;

// Namespace namespace_b73b0f52
// Params 2, eflags: 0x1 linked
// Checksum 0x37c96f76, Offset: 0xf08
// Size: 0x474
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    level flag::init("hq_decon_deactivated");
    level flag::init("hq_locker_room_open");
    level flag::init("hq_lmg_robots_destroyed");
    spawner::add_spawn_function_group("hq_turrets", "script_noteworthy", &function_5268b119);
    spawner::add_spawn_function_group("hq_stairs_robots_spawn_manager_guy", "targetname", &function_b87db3a3);
    spawner::add_spawn_function_group("hq_lmg_robots", "script_noteworthy", &function_b6d67e55);
    spawner::add_spawn_function_group("hq_defend_robots_spawn_manager_guy", "targetname", &function_56de520f);
    spawner::add_spawn_function_group("hq_stairs_siegebot", "targetname", &function_3b671c19);
    spawner::add_spawn_function_group("hq_elevator_siegebot", "targetname", &function_e877afeb);
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_8e9083ff::function_da579a5d(str_objective, 0);
        level thread function_44ee5cb7();
        scene::add_scene_func("p7_fxanim_cp_zurich_coalescence_tower_door_open_bundle", &namespace_8e9083ff::function_162b9ea0, "init");
        level scene::init("p7_fxanim_cp_zurich_coalescence_tower_door_open_bundle");
        level clientfield::set("hq_amb", 1);
        load::function_a2995f22();
    }
    if (isdefined(level.var_f2c0d73)) {
        level thread [[ level.var_f2c0d73 ]]();
    }
    level thread namespace_67110270::function_ce97ecac();
    umbragate_set("hq_entrance_umbra_gate", 1);
    var_306008cd = namespace_8e9083ff::function_b0dd51f4("hq_iff_override_robots", "script_string");
    level.var_3d556bcd thread function_87324847();
    exploder::stop_exploder("streets_tower_wasp_swarm");
    level thread function_371b16ae();
    level thread function_f8e4b283();
    level thread function_c5e1700c();
    level thread namespace_8e9083ff::function_2361541e("hq");
    level thread namespace_8e9083ff::function_c049667c(1);
    level thread function_f05c4095();
    level thread function_4cf537aa();
    level thread function_9006ed1d();
    level thread function_68b74f29();
    level thread function_c198b862();
    savegame::checkpoint_save();
    level thread function_19d7c072();
    level thread function_51e389ee(var_74cd64bc);
    level function_457da6c2();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x194afd98, Offset: 0x1388
// Size: 0x48
function function_44ee5cb7() {
    level endon(#"game_ended");
    while (true) {
        wait(1);
        playsoundatposition("amb_troop_alarm", (-8326, 37739, 559));
    }
}

// Namespace namespace_b73b0f52
// Params 4, eflags: 0x1 linked
// Checksum 0xebb41828, Offset: 0x13d8
// Size: 0x3c
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_8e9083ff::function_4d032f25(0);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x67ccf0f7, Offset: 0x1420
// Size: 0xdc
function function_68b74f29() {
    level.var_3d556bcd thread function_2436a71e();
    level.var_3d556bcd dialog::say("kane_this_is_the_heart_of_0", 1);
    level dialog::function_13b3b16a("plyr_it_won_t_come_to_tha_0", 1);
    level flag::wait_till("flag_hq_security_room_clear");
    level.var_3d556bcd dialog::say("kane_how_could_hendricks_0", 1);
    level dialog::function_13b3b16a("plyr_i_don_t_think_there_0", 1);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xd9f280b3, Offset: 0x1508
// Size: 0x44
function function_c198b862() {
    namespace_8e9083ff::function_1b3dfa61("enter_facility_vo_struct_trig", undefined, 256);
    level dialog::function_13b3b16a("plyr_it_s_just_like_in_si_0");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x5c5af85f, Offset: 0x1558
// Size: 0x4c
function function_2436a71e() {
    self lookatpos(struct::get("hq_kane_lookat_pos").origin);
    wait(4);
    self lookatpos();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xf1a96a55, Offset: 0x15b0
// Size: 0x20c
function function_19d7c072() {
    var_e26726e5 = getent("hq_atrium_door_01", "targetname");
    var_e26726e5.v_start = var_e26726e5.origin;
    var_9a7f401d = getent("hq_atrium_door_02", "targetname");
    var_9a7f401d.v_start = var_9a7f401d.origin;
    e_door_clip = getent("hq_atrium_door_clip", "targetname");
    var_e26726e5 moveto(var_e26726e5.origin + (0, 0, 44), 0.5);
    var_9a7f401d moveto(var_9a7f401d.origin + (0, 0, -44), 0.5);
    var_9a7f401d waittill(#"movedone");
    e_door_clip notsolid();
    e_door_clip connectpaths();
    trigger::wait_till("hq_exit_zone_trig");
    var_e26726e5 moveto(var_e26726e5.v_start, 0.05);
    var_9a7f401d moveto(var_9a7f401d.v_start, 0.05);
    e_door_clip solid();
    e_door_clip disconnectpaths();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x2ded8329, Offset: 0x17c8
// Size: 0x11c
function function_f05c4095() {
    level thread function_6c64938e();
    trigger::wait_till("trig_hq_robots_start");
    level thread namespace_67110270::function_232f4de7();
    spawn_manager::enable("hq_defend_robots_spawn_manager");
    spawn_manager::wait_till_complete("hq_stairs_robots_spawn_manager");
    level flag::wait_till("hq_lmg_robots_destroyed");
    spawn_manager::wait_till_cleared("hq_stairs_robots_spawn_manager");
    level flag::set("flag_hq_security_room_move_upstairs");
    spawn_manager::wait_till_cleared("hq_defend_robots_spawn_manager");
    level flag::set("flag_hq_security_room_clear");
    savegame::checkpoint_save();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xcb2dfd0e, Offset: 0x18f0
// Size: 0x224
function function_4cf537aa() {
    level flag::wait_till("flag_hq_siege_bot_encounter_start");
    spawn_manager::enable("hq_stairs_siegebot_spawn_manager");
    spawn_manager::wait_till_complete("hq_stairs_siegebot_spawn_manager");
    array::thread_all(spawn_manager::function_423eae50("hq_stairs_siegebot_spawn_manager"), &function_47e79f7);
    level flag::wait_till("flag_start_elevator_siege_bot");
    spawn_manager::enable("hq_elevator_siegebot_spawn_manager");
    spawn_manager::wait_till_complete("hq_elevator_siegebot_spawn_manager");
    level function_66b77465();
    array::thread_all(spawn_manager::function_423eae50("hq_elevator_siegebot_spawn_manager"), &function_47e79f7);
    spawn_manager::wait_till_cleared("hq_elevator_siegebot_spawn_manager");
    spawn_manager::wait_till_cleared("hq_stairs_siegebot_spawn_manager");
    savegame::checkpoint_save();
    spawn_manager::enable("hq_robots_lab_reinforcement_spawn_manager");
    level flag::set("flag_hq_siege_bot_dead");
    spawn_manager::wait_till_complete("hq_robots_lab_reinforcement_spawn_manager");
    level thread function_e6db4b20();
    spawn_manager::wait_till_cleared("hq_robots_lab_reinforcement_spawn_manager");
    level thread namespace_67110270::function_bb8ce831();
    level flag::set("flag_hq_move_to_airlock");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x57c0e88a, Offset: 0x1b20
// Size: 0x60
function function_457da6c2() {
    level flag::set("hq_locker_room_open");
    level thread function_2950b33d();
    trigger::wait_till("hq_exit_zone_trig");
    level waittill(#"hash_7871b80b");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xb5644f1f, Offset: 0x1b88
// Size: 0x44
function function_9006ed1d() {
    array::thread_all(getentarray("trig_hq_break_glass", "targetname"), &function_187d0cba);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xdf62ed95, Offset: 0x1bd8
// Size: 0x44
function function_187d0cba() {
    level endon(#"hash_13a0547d");
    e_who = self waittill(#"trigger");
    e_who util::break_glass(-56);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x33f31c48, Offset: 0x1c28
// Size: 0x182
function function_6c64938e() {
    trigger::wait_till("trig_hq_robots_start");
    for (i = 1; i < 3; i++) {
        var_6a2c8ee9 = getentarray("security_checkpoint_door_0" + i, "targetname");
        foreach (var_530f952d in var_6a2c8ee9) {
            if (isdefined(var_530f952d.target)) {
                var_73c9db2b = struct::get(var_530f952d.target, "targetname");
                var_530f952d moveto(var_73c9db2b.origin, 1.5);
                var_530f952d thread function_eaedd1eb();
            }
        }
        wait(3);
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xc06faae6, Offset: 0x1db8
// Size: 0x34
function function_eaedd1eb() {
    trigger::wait_till("hq_exit_zone_trig");
    self delete();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x5c2c9c5a, Offset: 0x1df8
// Size: 0xa6
function function_66b77465() {
    e_door = getent("siegebot_elevator_door", "targetname");
    e_door movez(-116, 3);
    e_door playsound("evt_siegebot_elevator_door");
    e_door thread function_a8bf6ebc();
    e_door waittill(#"movedone");
    level notify(#"doors_open");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x9028ce7f, Offset: 0x1ea8
// Size: 0x34
function function_a8bf6ebc() {
    trigger::wait_till("hq_exit_zone_trig");
    self delete();
}

// Namespace namespace_b73b0f52
// Params 1, eflags: 0x1 linked
// Checksum 0xda3af1bf, Offset: 0x1ee8
// Size: 0x11c
function function_51e389ee(var_74cd64bc) {
    objectives::set("cp_level_zurich_apprehend_obj");
    objectives::breadcrumb("hq_security_approach_breadcrumb_trigger");
    level function_196e4f52();
    level flag::wait_till("flag_hq_siege_bot_dead");
    objectives::breadcrumb("hq_lab_exit_breadcrumb_trig");
    objectives::breadcrumb("hq_locker_room_breadcrumb_trig");
    objectives::breadcrumb("hq_decon_breadcrumb_trig");
    level flag::wait_till_all(array("flag_hq_set_sacrifice_obj", "sacrifice_kane_activation_ready"));
    objectives::hide("cp_level_zurich_apprehend_obj");
    objectives::set("cp_level_zurich_use_terminal_obj");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x99f29eac, Offset: 0x2010
// Size: 0x44
function function_196e4f52() {
    level endon(#"hash_ad88abee");
    level flag::wait_till("flag_hq_security_room_move_upstairs");
    objectives::breadcrumb("hq_lab_approach_breadcrumb_trig");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xb50330ff, Offset: 0x2060
// Size: 0xa4
function function_47e79f7() {
    objectives::hide("cp_level_zurich_apprehend_obj");
    objectives::set("cp_level_zurich_destroy_pawws_obj", self);
    objectives::set("cp_level_zurich_low_destroy", self);
    self waittill(#"death");
    objectives::function_66c6f97b("cp_level_zurich_destroy_pawws_obj", self);
    objectives::complete("cp_level_zurich_low_destroy", self);
    objectives::show("cp_level_zurich_apprehend_obj");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x884bf8a6, Offset: 0x2110
// Size: 0x3c
function function_c5e1700c() {
    getent("trig_zurich_hq_door_hack", "targetname") setcursorhint("HINT_NOICON");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x0
// Checksum 0x525adf50, Offset: 0x2158
// Size: 0x7c
function function_e2ca7f8f() {
    var_5cca3f31 = getent("trig_zurich_hq_door_hack", "targetname");
    var_5cca3f31 namespace_8e9083ff::function_d1996775();
    level function_e6db4b20();
    level flag::set("flag_hq_hack_door_open");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x184d3819, Offset: 0x21e0
// Size: 0xf0
function function_e6db4b20() {
    mdl_door = getent("hq_siegebot_exitdoor", "targetname");
    mdl_door.v_start = mdl_door.origin;
    mdl_door.v_end = mdl_door.origin + (0, 0, 128);
    n_open_time = 2;
    mdl_door playsound("evt_decon_door_open");
    mdl_door moveto(mdl_door.v_end, n_open_time);
    mdl_door thread function_45d5a571();
    wait(n_open_time / 2);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x492ad9d1, Offset: 0x22d8
// Size: 0x34
function function_45d5a571() {
    trigger::wait_till("hq_exit_zone_trig");
    self delete();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x96d88223, Offset: 0x2318
// Size: 0xcc
function function_2950b33d() {
    level thread function_ae937789();
    level flag::wait_till("hq_decon_active");
    level clientfield::set("decon_spray", 1);
    wait(12);
    level function_3319c9ae();
    level flag::set("flag_decon_door_open");
    level clientfield::set("decon_spray", 0);
    level namespace_68404a06::function_d3eae9b7();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x34360400, Offset: 0x23f0
// Size: 0x16a
function function_ae937789() {
    mdl_door = getent("hq_decon_door_entrance", "targetname");
    e_clip = getent("hq_decon_door_entrance_clip", "targetname");
    e_clip notsolid();
    level flag::wait_till("hq_decon_active");
    e_clip solid();
    mdl_door movez(-86, 2);
    mdl_door playsound("evt_decon_door_close");
    wait(2);
    spawn_manager::kill("hq_stairs_robots_spawn_manager", 1);
    a_ai_enemies = getaiteamarray();
    array::thread_all(a_ai_enemies, &namespace_8e9083ff::function_48463818);
    level notify(#"hash_7871b80b");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x7563f763, Offset: 0x2568
// Size: 0xcc
function function_3319c9ae() {
    mdl_door = getent("hq_decon_door", "targetname");
    mdl_door.v_start = mdl_door.origin;
    mdl_door.v_end = mdl_door.origin + (0, 0, 128);
    n_open_time = 2;
    mdl_door playsound("evt_decon_door_open");
    mdl_door moveto(mdl_door.v_end, n_open_time);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x0
// Checksum 0x4b98673c, Offset: 0x2640
// Size: 0x74
function function_b52a0060() {
    mdl_door = getent("hq_decon_door", "targetname");
    mdl_door playsound("evt_decon_door_close");
    mdl_door moveto(mdl_door.v_start, 0.5);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xae950eaf, Offset: 0x26c0
// Size: 0xd4
function function_8cb99e45() {
    var_107d713c = getent("hq_decon_door", "targetname");
    var_2049505e = getent("hq_decon_door_entrance", "targetname");
    e_clip = getent("hq_decon_door_entrance_clip", "targetname");
    var_107d713c delete();
    var_2049505e delete();
    e_clip delete();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x680ada65, Offset: 0x27a0
// Size: 0xb6
function function_b87db3a3() {
    self endon(#"death");
    self endon(#"hash_63f76929");
    self thread function_ee7e8dd7();
    if (isdefined(self.script_noteworthy)) {
        for (i = 1; i < 3; i++) {
            if (self.script_noteworthy == "security_robot_0" + i) {
                self waittill(#"goal");
                self ai::set_goal("security_room_attack_node_0" + i, "targetname");
            }
        }
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xe5b109b4, Offset: 0x2860
// Size: 0x5c
function function_b6d67e55() {
    if (!isdefined(level.var_64f4feb8)) {
        level.var_64f4feb8 = 0;
    }
    self waittill(#"death");
    level.var_64f4feb8++;
    if (level.var_64f4feb8 == 2) {
        level flag::set("hq_lmg_robots_destroyed");
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xb2f39724, Offset: 0x28c8
// Size: 0xbe
function function_56de520f() {
    self endon(#"death");
    self endon(#"hash_63f76929");
    self thread function_ee7e8dd7();
    if (isdefined(self.script_noteworthy)) {
        for (i = 1; i < 3; i++) {
            if (self.script_noteworthy == "security_defend_robot_0" + i) {
                level flag::wait_till("flag_hq_security_room_move_upstairs");
                self ai::set_goal("security_room_defend_node_0" + i, "script_noteworthy");
            }
        }
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xd6a788ab, Offset: 0x2990
// Size: 0x54
function function_ee7e8dd7() {
    self endon(#"death");
    trigger::wait_till("trig_move_to_lab");
    self notify(#"hash_63f76929");
    self ai::set_goal("hq_lab_defend_volume", "targetname");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x452dffac, Offset: 0x29f0
// Size: 0x8c
function function_3b671c19() {
    level endon(#"hash_ae9347d9");
    if (level.players.size < 3) {
        n_health_threshold = self.health / 2;
        while (self.health > n_health_threshold) {
            wait(1);
        }
    } else {
        self waittill(#"death");
    }
    level flag::set("flag_start_elevator_siege_bot");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x494c013f, Offset: 0x2a88
// Size: 0xac
function function_e877afeb() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self scene::init("cin_zur_02_001_siegebot_elevator_entrance", self);
    level waittill(#"doors_open");
    self scene::play("cin_zur_02_001_siegebot_elevator_entrance", self);
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xd6f45f5e, Offset: 0x2b40
// Size: 0x1c
function function_5268b119() {
    self thread turret_deactivate();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x332c6c6b, Offset: 0x2b68
// Size: 0x3c
function turret_deactivate() {
    self ai::set_ignoreall(1);
    self cybercom::function_59965309("cybercom_hijack");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x8c4282cf, Offset: 0x2bb0
// Size: 0x3c
function turret_activate() {
    self ai::set_ignoreall(0);
    self cybercom::function_a1f70a02("cybercom_hijack");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x0
// Checksum 0x5c7d45ab, Offset: 0x2bf8
// Size: 0x10e
function function_348d993a() {
    var_f765f588 = self;
    if (!isarray(self)) {
        var_f765f588 = array(self);
    }
    var_53acb497 = [];
    foreach (n_index, var_f074d981 in var_f765f588) {
        var_53acb497[n_index] = spawner::simple_spawn_single(var_f074d981);
        var_53acb497[n_index] thread turret_think();
        wait(0.05);
    }
    return var_53acb497;
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x2d2d980, Offset: 0x2d10
// Size: 0x15c
function turret_think() {
    self endon(#"death");
    n_min = 0.3;
    n_max = 1.3;
    var_39178da3 = randomfloatrange(n_min, n_max);
    n_move_time = 2;
    self.var_61ba68c8 = util::spawn_model("tag_origin", self.origin, self.angles);
    self.var_61ba68c8.script_objective = self.script_objective;
    s_moveto = struct::get(self.target);
    self linkto(self.var_61ba68c8, "tag_origin");
    self.var_61ba68c8 moveto(s_moveto.origin, n_move_time);
    self.var_61ba68c8 waittill(#"movedone");
    wait(var_39178da3);
    self turret_activate();
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x0
// Checksum 0x92bd22ac, Offset: 0x2e78
// Size: 0x11a
function function_525e4268() {
    var_53acb497 = self;
    if (!isarray(self)) {
        var_53acb497 = array(self);
    }
    foreach (var_b8f9a884 in self) {
        if (isalive(var_b8f9a884)) {
            var_b8f9a884.delete_on_death = 1;
            var_b8f9a884 notify(#"death");
            if (!isalive(var_b8f9a884)) {
                var_b8f9a884 delete();
            }
        }
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x5fff067c, Offset: 0x2fa0
// Size: 0x2fc
function function_87324847() {
    self thread function_f3b250de();
    self ai::set_behavior_attribute("forceTacticalWalk", 1);
    self setgoalnode(getnode("plaza_battle_kane_lobby_node", "targetname"));
    wait(3);
    self colors::set_force_color("r");
    trigger::use("trig_color_kane_hq_start");
    level flag::wait_till("flag_hq_kane_enter_security_room");
    self ai::set_behavior_attribute("forceTacticalWalk", 0);
    trigger::use("trig_color_kane_hq_lobby");
    level flag::wait_till("flag_hq_robots_start");
    trigger::use("trig_color_kane_hq_lobby_fight");
    level function_ee4479b3();
    level flag::wait_till_any(array("flag_hq_security_room_clear", "flag_hq_passed_turrets"));
    trigger::use("trig_color_kane_hq_siege_bot_fight");
    level flag::wait_till("flag_hq_siege_bot_dead");
    trigger::use("trig_color_kane_hq_siege_bot_fight_done");
    level flag::wait_till_any(array("flag_hq_move_to_airlock", "flag_hq_move_kane_to_locker_room"));
    trigger::use("trig_color_kane_hq_door_hack");
    self battlechatter::function_d9f49fba(0);
    if (level flag::get("flag_hq_move_kane_to_locker_room")) {
        wait(1);
    } else {
        level flag::wait_till("flag_hq_move_kane_to_locker_room");
    }
    trigger::use("trig_color_kane_hq_decon");
    level flag::wait_till("flag_hq_move_kane_into_decon");
    trigger::use("trig_color_kane_hq_in_decon");
    level flag::wait_till("flag_decon_door_open");
    trigger::use("trig_color_kane_lab_interior");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x89a84ea5, Offset: 0x32a8
// Size: 0x4c
function function_ee4479b3() {
    level endon(#"hash_ad88abee");
    level endon(#"hash_f95b7888");
    level flag::wait_till("flag_hq_security_room_move_upstairs");
    trigger::use("trig_color_kane_hq_security_room_upstairs");
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x3a74b1cf, Offset: 0x3300
// Size: 0x54
function function_f3b250de() {
    level flag::wait_till("flag_hq_set_kane_ignoreall");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x4fcf3db4, Offset: 0x3360
// Size: 0x4c
function function_371b16ae() {
    namespace_8e9083ff::function_1b3dfa61("hq_start_ravens_struct_trig", undefined, 600, 512);
    playsoundatposition("mus_coalescence_theme_lobby", (-8698, 38395, 594));
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0x5cc79a3a, Offset: 0x33b8
// Size: 0xf4
function function_f8e4b283() {
    level scene::add_scene_func("cin_gen_ambient_raven_idle_eating_raven", &namespace_8e9083ff::function_e547724d, "init");
    level scene::add_scene_func("cin_gen_ambient_raven_idle", &namespace_8e9083ff::function_e547724d, "init");
    level scene::add_scene_func("cin_gen_traversal_raven_fly_away", &namespace_8e9083ff::function_86b1cd8a);
    level thread function_762c95f0("hq_start_ravens", 600, 512);
    level thread function_762c95f0("hq_locker_room_ravens", 466, -128);
    level thread function_6e7da34e();
}

// Namespace namespace_b73b0f52
// Params 3, eflags: 0x1 linked
// Checksum 0xa637efa6, Offset: 0x34b8
// Size: 0x28a
function function_762c95f0(var_af782668, var_4d9cdec3, var_9895c1a4) {
    namespace_8e9083ff::function_1b3dfa61(var_af782668 + "_struct_trig", undefined, var_4d9cdec3, var_9895c1a4);
    a_scenes = struct::get_array(var_af782668);
    foreach (s_scene in a_scenes) {
        s_scene util::delay(randomfloat(0.15), undefined, &scene::play);
    }
    wait(0.5);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_hallucinations", 1);
    wait(0.5);
    foreach (player in level.players) {
        visionset_mgr::activate("visionset", "cp_zurich_hallucination", player);
    }
    wait(1.8);
    foreach (player in level.players) {
        visionset_mgr::deactivate("visionset", "cp_zurich_hallucination", player);
    }
}

// Namespace namespace_b73b0f52
// Params 0, eflags: 0x1 linked
// Checksum 0xec60ebba, Offset: 0x3750
// Size: 0x314
function function_6e7da34e() {
    a_scenes = struct::get_array("hq_airlock_ravens");
    array::thread_all(a_scenes, &scene::init);
    level flag::wait_till("hq_decon_active");
    wait(7);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_hallucinations", 1);
    wait(0.8);
    foreach (player in level.players) {
        visionset_mgr::activate("visionset", "cp_zurich_hallucination", player);
    }
    level notify(#"hash_755edaa4");
    foreach (s_scene in a_scenes) {
        s_scene util::delay(randomfloat(1), undefined, &scene::play);
    }
    level flag::wait_till("flag_decon_door_open");
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_hallucinations", 1);
    wait(0.8);
    foreach (player in level.players) {
        visionset_mgr::deactivate("visionset", "cp_zurich_hallucination", player);
    }
    wait(0.5);
    array::thread_all(a_scenes, &scene::stop);
}

