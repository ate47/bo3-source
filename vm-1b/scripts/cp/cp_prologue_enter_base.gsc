#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_enter_base;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_security_camera;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/voice/voice_prologue;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_prologue_enter_base;

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x461024fd, Offset: 0x16a8
// Size: 0x22
function function_1605fd36() {
    function_f6fcb9d5();
    level thread function_69685279();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x16d8
// Size: 0x2
function function_f6fcb9d5() {
    
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3fff6a7e, Offset: 0x16e8
// Size: 0x2ca
function function_69685279() {
    level cp_prologue_util::function_6a5f89cb("skipto_nrc_knocking");
    if (isdefined(level.var_f22c67b)) {
        level thread [[ level.var_f22c67b ]]();
    }
    foreach (ai_ally in level.var_681ad194) {
        ai_ally.goalradius = 16;
        ai_ally setgoal(getnode("ally0" + ai_ally.var_a89679b6 + "_start_node", "targetname"));
    }
    battlechatter::function_d9f49fba(0);
    cp_prologue_util::function_47a62798(1);
    cp_prologue_util::function_25e841ea();
    level thread function_599e2f36();
    util::delay(2, undefined, &function_b206d9a7);
    level thread function_e4486a45();
    if (isdefined(level.var_a8f1dac7)) {
        level thread [[ level.var_a8f1dac7 ]]();
    }
    spawner::waittill_ai_group_cleared("tower_guards");
    array::run_all(level.activeplayers, &util::function_16c71b8, 1);
    array::thread_all(level.activeplayers, &cp_mi_eth_prologue::function_7072c5d8);
    level thread function_63075f1d();
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037.allowbattlechatter["bc"] = 1;
    level thread function_127fb1fb();
    level thread function_5dc7beec();
    level thread function_a7dec0e7();
    scene::add_scene_func("cin_pro_03_01_blendin_vign_movedown_tower_hendricks", &function_c9e3016d, "play");
    scene::add_scene_func("cin_pro_03_01_blendin_vign_movedown_tower_hendricks", &function_fe6bccbc, "play");
    level scene::play("cin_pro_03_01_blendin_vign_movedown_tower_hendricks");
    level flag::wait_till("player_reached_tower_bottom");
    skipto::function_be8adfb8("skipto_nrc_knocking");
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x71487a7a, Offset: 0x19c0
// Size: 0x2a
function function_fe6bccbc(a_ents) {
    level waittill(#"hash_948ccb30");
    level thread dialog::function_13b3b16a("plyr_so_as_long_as_we_d_0");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x5394a9d1, Offset: 0x19f8
// Size: 0x102
function function_e4486a45() {
    level scene::init("cin_pro_02_01_knocking_vign_nrc_breach_soldiers");
    level thread scene::play("cin_pro_02_01_knocking_vign_approach_opendoor", level.var_2fd26037);
    level.var_2fd26037 waittill(#"open_door");
    level.var_2fd26037 setgoal(getnode("nd_nrc_knocking_hendrics_retreat", "targetname"), 1);
    level.var_2fd26037 thread dialog::say("hend_let_s_get_this_done_0");
    level thread namespace_21b2c1f2::function_e245d17f();
    level.var_2fd26037.allowbattlechatter["bc"] = 0;
    battlechatter::function_d9f49fba(1);
    level thread function_d511e678();
    level thread scene::play("cin_pro_02_01_knocking_vign_nrc_breach_soldiers");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x1b71461d, Offset: 0x1b08
// Size: 0xda
function function_d511e678() {
    var_b0b3b56f = struct::get("prologue_nrc_kocking_door1", "targetname");
    [[ var_b0b3b56f.c_door ]]->unlock();
    [[ var_b0b3b56f.c_door ]]->open();
    var_3eac4634 = struct::get("prologue_nrc_kocking_door2", "targetname");
    [[ var_3eac4634.c_door ]]->unlock();
    [[ var_3eac4634.c_door ]]->open();
    var_a2da988e = getent("nrc_knocking_door_sight_clip", "targetname");
    var_a2da988e delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x6289ae7b, Offset: 0x1bf0
// Size: 0x12a
function function_b206d9a7() {
    cp_prologue_util::function_d1f1caad("trig_control_room_exit");
    level thread scene::play("cin_pro_03_01_blendin_vign_vtol_sweep");
    level thread scene::play("p7_fxanim_cp_prologue_control_tower_ceiling_tiles_02_bundle");
    var_2ef9d306 = getent("sp_vtol_sweep_at_start_ai", "targetname");
    if (isdefined(var_2ef9d306)) {
        var_2ef9d306 thread cp_prologue_util::function_c56034b7();
    }
    wait 1.2;
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.1, 0.1, 1000, 20, "buzz_high");
    level thread scene::play("dead_turret_01", "targetname");
    level thread scene::play("dead_turret_02", "targetname");
    level thread scene::play("dead_turret_03", "targetname");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xe10cef, Offset: 0x1d28
// Size: 0x62
function function_568a781d() {
    function_f2908b1c();
    spawner::add_spawn_function_group("start_through_take_out_guards", "script_aigroup", &function_654eeb65);
    level thread function_bc06f066();
    level thread function_b3440908();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1d98
// Size: 0x2
function function_f2908b1c() {
    
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x656ff1c1, Offset: 0x1da8
// Size: 0x18a
function function_b3440908() {
    level cp_prologue_util::function_6a5f89cb("skipto_blend_in");
    foreach (ai_ally in level.var_681ad194) {
        ai_ally ai::set_ignoreme(1);
        ai_ally ai::set_pacifist(1);
    }
    level thread function_be42a33f();
    if (isdefined(level.var_4d823ef7)) {
        level thread [[ level.var_4d823ef7 ]]();
    }
    cp_prologue_util::function_25e841ea();
    level thread function_e2ed5f34();
    cp_prologue_util::function_47a62798(1);
    level scene::init("cin_pro_03_02_blendin_vign_destruction_putoutfire");
    level thread function_4358b88b();
    level thread function_11855253();
    level flag::wait_till("tower_doors_open");
    level util::clientnotify("sndCloseFT");
    level flag::wait_till("player_entering_tunnel");
    function_374cf6ee();
    skipto::function_be8adfb8("skipto_blend_in");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x518732b4, Offset: 0x1f40
// Size: 0x3a
function function_e2ed5f34() {
    self endon(#"death");
    self endon(#"objective_blend_in_done");
    level waittill(#"hash_c52fa561");
    wait 1.5;
    level thread objectives::breadcrumb("blending_in_breadcrumb_3");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3c07e11f, Offset: 0x1f88
// Size: 0x232
function function_bc06f066() {
    level thread function_5b8bdfba();
    level flag::wait_till("tower_doors_open");
    battlechatter::function_d9f49fba(1);
    str_trig = "t_tarmac_vo_need_medic";
    var_1a7dfed0 = array("need_medic");
    var_61ae76d5 = array("tarmac_soldier_ai");
    var_9e3b0b67 = array(0);
    level thread function_bafd79f6(str_trig, var_1a7dfed0, var_61ae76d5, var_9e3b0b67);
    str_trig = "t_tarmac_vo_get_the_fire_out";
    var_1a7dfed0 = array("put_out_fire_hurry");
    var_61ae76d5 = array("tarmac_soldier_f_ai");
    var_9e3b0b67 = array(0);
    level thread function_bafd79f6(str_trig, var_1a7dfed0, var_61ae76d5, var_9e3b0b67);
    str_trig = "t_tarmac_vo_truck_conversation";
    var_1a7dfed0 = array("what_happened", "dead_malfuctioned");
    var_61ae76d5 = array("tarmac_soldier_truck_02_ai", "tarmac_soldier_truck_03_ai");
    var_9e3b0b67 = array(0, 1.5);
    level thread function_bafd79f6(str_trig, var_1a7dfed0, var_61ae76d5, var_9e3b0b67);
    level thread function_bf532adb();
    level thread function_3eb38d8d();
    level waittill(#"hash_c52fa561");
    level.var_2fd26037 dialog::say("hend_shit_keep_your_hea_0");
    var_49b32118 = getent("pa_vox_tarmac", "targetname");
    var_49b32118 thread dialog::say("nrcp_all_available_person_0", 2);
    level thread function_637dbd55();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x914d0fad, Offset: 0x21c8
// Size: 0x5a
function function_5b8bdfba() {
    wait 3;
    var_216b2dcb = spawn("script_origin", (-1001, -1422, -41));
    var_216b2dcb dialog::say("nrcp_all_available_person_0");
    wait 1;
    var_216b2dcb delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xf075f0c3, Offset: 0x2230
// Size: 0x5b
function function_e5670bf5() {
    self endon(#"death");
    self notify(#"hash_2605e152", "get_to_control_tower");
    wait 2;
    self notify(#"hash_2605e152", "move_move");
    wait 1.5;
    self notify(#"hash_2605e152", "more_men");
    wait 2;
    self notify(#"hash_c80e029a", "put_out_fire_men");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xac38bd12, Offset: 0x2298
// Size: 0x62
function function_bf532adb() {
    level endon(#"objective_take_out_guards_done");
    var_46100e43 = getent("t_tarmac_vo_firetruck", "targetname");
    var_46100e43 endon(#"death");
    var_46100e43 trigger::wait_till();
    var_46100e43 playsound("nrcm0_put_out_that_fire_w_0");
}

// Namespace cp_prologue_enter_base
// Params 4, eflags: 0x0
// Checksum 0xa4fcea79, Offset: 0x2308
// Size: 0x9a
function function_bafd79f6(var_d72a94c2, var_1a7dfed0, var_61ae76d5, var_9e3b0b67) {
    self endon(#"death");
    level endon(#"objective_take_out_guards_done");
    var_46100e43 = getent(var_d72a94c2, "targetname");
    var_a939b0c9 = var_46100e43.origin;
    level trigger::wait_till(var_d72a94c2, "targetname", undefined, 0);
    function_f9be6553(var_a939b0c9, var_1a7dfed0, var_61ae76d5, var_9e3b0b67);
}

// Namespace cp_prologue_enter_base
// Params 4, eflags: 0x0
// Checksum 0xe2b71ee3, Offset: 0x23b0
// Size: 0xaf
function function_f9be6553(var_97fbbd0a, var_1a7dfed0, var_61ae76d5, var_9e3b0b67) {
    level endon(#"objective_take_out_guards_done");
    for (i = 0; i < var_1a7dfed0.size; i++) {
        var_79cf4848 = getentarray(var_61ae76d5[i], "targetname");
        if (isdefined(var_79cf4848) && var_79cf4848.size > 0) {
            ai_speaker = arraygetclosest(var_97fbbd0a, var_79cf4848);
            wait var_9e3b0b67[i];
            ai_speaker notify(#"hash_2605e152", var_1a7dfed0[i]);
        }
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x9c9bb48f, Offset: 0x2468
// Size: 0x1fd
function function_3eb38d8d() {
    var_459dddeb = 0;
    var_5f00f64d = 12;
    var_1f9b6382 = 0;
    var_38fe7be4 = 35;
    var_f998e919 = 0;
    var_ab05eb1f = 50;
    s_struct = struct::get("s_player_exits_tower", "targetname");
    v_forward = anglestoforward(s_struct.angles);
    start_time = gettime();
    while (true) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            v_dir = vectornormalize(s_struct.origin - a_players[i].origin);
            dp = vectordot(v_forward, v_dir);
            if (dp < 0) {
                return;
            }
        }
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > var_5f00f64d && var_459dddeb == 0) {
            level.var_2fd26037 dialog::say("hend_on_me_nice_and_easy_0");
            var_459dddeb = 1;
        }
        if (dt > var_38fe7be4 && var_1f9b6382 == 0) {
            level.var_2fd26037 dialog::say("hend_security_station_is_0");
            var_1f9b6382 = 1;
        }
        if (dt > var_ab05eb1f && var_f998e919 == 0) {
            level.var_2fd26037 dialog::say("hend_keep_moving_don_t_b_0");
            var_f998e919 = 1;
            break;
        }
        wait 0.05;
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xa4f75224, Offset: 0x2670
// Size: 0x105
function function_637dbd55() {
    trigger::wait_till("t_tarmac_we_need_a_medic");
    var_459dddeb = 0;
    var_5f00f64d = 30;
    var_1f9b6382 = 0;
    var_38fe7be4 = 50;
    start_time = gettime();
    while (level flag::get("player_entering_tunnel") == 0) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > var_5f00f64d && var_459dddeb == 0) {
            level.var_2fd26037 dialog::say("hend_stay_on_me_we_need_0");
            var_459dddeb = 1;
        }
        if (dt > var_38fe7be4 && var_1f9b6382 == 0) {
            level.var_2fd26037 dialog::say("hend_clock_s_ticking_we_0");
            var_1f9b6382 = 1;
            break;
        }
        wait 0.05;
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x30f58a13, Offset: 0x2780
// Size: 0x5a
function function_4358b88b() {
    level thread function_599e2f36();
    level thread scene::play("cin_pro_03_02_blendin_vign_attendfire");
    level thread function_b49762e5();
    level thread function_12fd44e1();
    level thread tunnel_entrance_guard();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x5a8b9e23, Offset: 0x27e8
// Size: 0xba
function function_11855253() {
    level thread function_ae8c8b7b();
    level thread scene::add_scene_func("cin_pro_03_02_blendin_vign_call_for_help", &function_9b773ab2);
    level thread scene::play("cin_pro_03_02_blendin_vign_call_for_help");
    scene::add_scene_func("cin_pro_03_02_blendin_vign_tarmac_cross", &function_cdc39276, "play");
    level scene::play("cin_pro_03_01_blendin_vign_movedown_tower_exit_hendr");
    level waittill(#"hash_c64e52db");
    level flag::set("hendr_crossed_tarmac");
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0xfa173b85, Offset: 0x28b0
// Size: 0x102
function function_c9e3016d(a_ents) {
    level waittill(#"hash_23c82471");
    level scene::init("cin_pro_03_02_blendin_vign_tarmac_cross");
    level scene::init("cin_pro_03_02_blendin_vign_call_for_help");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_injured");
    level scene::init("cin_pro_03_02_blendin_vign_attendfire");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_help");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_putoutfire");
    level scene::init("tarmac_guys_on_fire");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_onfire_guy01");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_onfire_guy03");
    level scene::init("cin_pro_03_02_blendin_vign_destruction_onfire_guy02");
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x15bde6ae, Offset: 0x29c0
// Size: 0xba
function function_9b773ab2(a_ents) {
    var_5d7f4f0f = a_ents["tarmac_soldier_seek_help_m"];
    var_5d7f4f0f dialog::say("nrcg_hurry_come_quickly_0", 2);
    var_5d7f4f0f ai::set_ignoreall(1);
    var_5d7f4f0f ai::set_ignoreme(1);
    var_5d7f4f0f setgoal(getnode("tarmac_help_goal", "targetname"), 1);
    var_5d7f4f0f thread function_e5670bf5();
    var_5d7f4f0f waittill(#"goal");
    var_5d7f4f0f delete();
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x252921a3, Offset: 0x2a88
// Size: 0x14a
function function_cdc39276(a_ents) {
    level thread dialog::function_13b3b16a("plyr_i_ll_follow_your_lea_0");
    level thread function_e78eadc4();
    level.var_fdb31b75 = a_ents["tarmac_cross_truck_02"];
    a_ents["hendricks"] waittill(#"hash_d9dc5e2b");
    level thread scene::play("cin_pro_03_02_blendin_vign_destruction_onfire_guy01");
    a_ents["hendricks"] waittill(#"hash_8dd76959");
    level thread scene::play("cin_pro_03_02_blendin_vign_destruction_onfire_guy03");
    a_ents["hendricks"] waittill(#"hash_67d4eef0");
    level thread scene::play("cin_pro_03_02_blendin_vign_destruction_onfire_guy02");
    a_ents["hendricks"] waittill(#"hash_18dec1ef");
    wait 0.5;
    if (!scene::is_playing("cin_pro_03_02_blendin_vign_destruction_putoutfire")) {
        level thread scene::play("cin_pro_03_02_blendin_vign_destruction_putoutfire");
    }
    nd_node = getnode("hendricks_tunnel_goal", "targetname");
    a_ents["hendricks"] setgoal(nd_node, 1);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x7c3136c0, Offset: 0x2be0
// Size: 0x4a
function function_e78eadc4() {
    level flag::wait_till("show_crash_victims");
    if (!scene::is_playing("cin_pro_03_02_blendin_vign_destruction_putoutfire")) {
        level thread scene::play("cin_pro_03_02_blendin_vign_destruction_putoutfire");
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xda8ee0ed, Offset: 0x2c38
// Size: 0x16a
function function_a7dec0e7() {
    level thread function_a87bddf2();
    level.var_2fd26037.pacifist = 1;
    level.var_2fd26037.ignoreme = 1;
    foreach (ai_ally in level.var_681ad194) {
        ai_ally ai::set_ignoreme(1);
        ai_ally ai::set_pacifist(1);
    }
    level flag::wait_till("tower_doors_open");
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    a_allies = cp_prologue_util::function_6ee0e1a5();
    array::thread_all(a_allies, &ai::set_behavior_attribute, "cqb", 0);
    array::run_all(level.players, &util::function_16c71b8, 1);
    array::thread_all(level.players, &cp_mi_eth_prologue::function_7072c5d8);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xb16451a, Offset: 0x2db0
// Size: 0x52
function function_a87bddf2() {
    trigger::use("t_tower_y301");
    level waittill(#"hash_809b0d82");
    wait 3;
    trigger::use("t_tower_y302");
    wait 14;
    trigger::use("t_tower_y303");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x709dfab, Offset: 0x2e10
// Size: 0x9b
function function_be42a33f() {
    trigger::wait_till("tarmac_move_friendies");
    foreach (ai_ally in level.var_681ad194) {
        ai_ally thread function_15dea196("ally0" + ai_ally.var_a89679b6 + "_tunnel_goal", "security_cam_active");
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xa279b27, Offset: 0x2eb8
// Size: 0x102
function function_ae8c8b7b() {
    level waittill(#"hash_c4d700a5");
    var_280d5f68 = getent("controltower_exitdoor_l", "targetname");
    var_3c301126 = getent("controltower_exitdoor_r", "targetname");
    var_280d5f68 rotateto(var_280d5f68.angles + (0, -90, 0), 0.75);
    var_3c301126 rotateto(var_3c301126.angles + (0, 90, 0), 0.75);
    var_3c301126 playsound("evt_towerdoor_open");
    level thread cp_prologue_util::function_2747b8e1("damage_light", 0.05, 2, var_3c301126);
    level flag::set("tower_doors_open");
}

// Namespace cp_prologue_enter_base
// Params 2, eflags: 0x0
// Checksum 0xea3674d0, Offset: 0x2fc8
// Size: 0x82
function function_15dea196(node, var_143df2c2) {
    if (!isdefined(var_143df2c2)) {
        var_143df2c2 = "none";
    }
    target_node = getnode(node, "targetname");
    self setgoal(target_node, 1);
    self util::waittill_either("goal", var_143df2c2);
    self delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x6d0f2b50, Offset: 0x3058
// Size: 0x6a
function tunnel_entrance_guard() {
    var_c620461c = getent("tunnel_entrance_guard", "targetname");
    level.var_9e8c7aef = var_c620461c spawner::spawn(1);
    level.var_9e8c7aef.ignoreme = 1;
    level.var_9e8c7aef.ignoreall = 1;
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xad2e6ed3, Offset: 0x30d0
// Size: 0x172
function function_b49762e5() {
    level thread function_d5fbb820("tarmac_wounded_1");
    level thread function_d5fbb820("tarmac_wounded_2");
    level thread scene::play("tarmac_deathpose");
    var_197aede3 = struct::get("injured_carried2", "targetname");
    var_197aede3 scene::add_scene_func(var_197aede3.scriptbundlename, &function_28d9b6cd, "play");
    var_197aede3 thread scene::play(var_197aede3.scriptbundlename);
    scene::add_scene_func("cin_pro_03_02_blendin_vign_destruction_help", &function_28d9b6cd, "play");
    level thread scene::play("cin_pro_03_02_blendin_vign_destruction_help");
    var_a7737ea8 = struct::get("injured_carried1", "targetname");
    var_a7737ea8 scene::add_scene_func(var_a7737ea8.scriptbundlename, &function_28d9b6cd, "play");
    var_a7737ea8 thread scene::play(var_a7737ea8.scriptbundlename);
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0xc264d468, Offset: 0x3250
// Size: 0x8a
function function_d70eb0dd(a_ents) {
    /#
        iprintlnbold("<dev string:x28>");
    #/
    a_str_vo = array("need_medic", "get_him_out", "more_men");
    str_vo = array::random(a_str_vo);
    a_ents["tarmac_soldier"] thread function_c4ada726(str_vo, 400);
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x619fe522, Offset: 0x32e8
// Size: 0x32
function function_28d9b6cd(a_ents) {
    a_ents["tarmac_soldier"] thread function_c4ada726("what_happened", 400);
}

// Namespace cp_prologue_enter_base
// Params 2, eflags: 0x0
// Checksum 0x18f151b7, Offset: 0x3328
// Size: 0x3f
function function_c4ada726(var_417ec882, var_a972c5dd) {
    self endon(#"death");
    level endon(#"objective_blend_in_done");
    self function_92e75cce(var_a972c5dd);
    self notify(#"hash_2605e152", var_417ec882);
}

// Namespace cp_prologue_enter_base
// Params 2, eflags: 0x0
// Checksum 0x69e361, Offset: 0x3370
// Size: 0xcf
function function_92e75cce(n_range, var_b0ecff80) {
    if (!isdefined(var_b0ecff80)) {
        var_b0ecff80 = 1;
    }
    self endon(#"death");
    var_a972c5dd = n_range * n_range;
    do {
        var_df983850 = 0;
        foreach (player in level.activeplayers) {
            var_df983850 = var_df983850 || distancesquared(self.origin, player.origin) <= var_a972c5dd;
        }
        if (!var_df983850) {
            wait var_b0ecff80;
        }
    } while (!var_df983850);
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x5957d648, Offset: 0x3448
// Size: 0x11a
function function_cbd1cf8b(str_scene) {
    var_e4d0f603 = getent("spawner_tsa_guard", "targetname");
    ai_victim = spawner::simple_spawn_single(var_e4d0f603);
    ai_victim disableaimassist();
    ai_victim ai::set_ignoreall(1);
    ai_victim ai::set_ignoreme(1);
    ai_victim.health = int(ai_victim.health * 0.25);
    ai_victim thread function_b79bfbce();
    level thread scene::play(str_scene, ai_victim);
    ai_victim util::delay(0.5, undefined, &kill);
    ai_victim waittill(#"death");
    if (isdefined(ai_victim)) {
        ai_victim startragdoll(1);
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xca476fd0, Offset: 0x3570
// Size: 0x22
function function_b79bfbce() {
    self endon(#"death");
    level waittill(#"tower_doors_open");
    self kill();
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x8e072cf9, Offset: 0x35a0
// Size: 0xa2
function function_d5fbb820(str_scene) {
    var_e4d0f603 = getent("tarmac_soldier", "targetname");
    if (randomint(100) > 70) {
        var_e4d0f603 = getent("tarmac_soldier_f", "targetname");
    }
    ai_victim = spawner::simple_spawn_single(var_e4d0f603);
    ai_victim disableaimassist();
    level thread scene::play(str_scene, ai_victim);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x1b494766, Offset: 0x3650
// Size: 0x12
function function_654eeb65() {
    self.ignoreme = 1;
    self.ignoreall = 1;
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x8b9c1020, Offset: 0x3670
// Size: 0x28a
function function_12fd44e1() {
    level flag::wait_till("tower_doors_open");
    exploder::exploder("fx_exploder_glass_tower");
    if (!scene::is_active("p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle")) {
        level thread scene::play("p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle");
    }
    level thread function_d5fbb820("wounded_crawl_1");
    level thread function_d5fbb820("wounded_crawl_2");
    level thread function_d5fbb820("wounded_crawl_3");
    level thread scene::play("cin_pro_03_02_blendin_vign_destruction_injured");
    wait 6;
    level thread scene::play("tarmac_guys_on_fire");
    level waittill(#"hash_f3f03044");
    level scene::stop("p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle");
    level scene::stop("cin_pro_03_02_blendin_vign_destruction_injured");
    level scene::stop("cin_pro_03_02_blendin_vign_attendfire");
    level scene::stop("tarmac_deathpose");
    level scene::stop("cin_pro_03_02_blendin_vign_destruction_help");
    level scene::stop("tarmac_wounded_1");
    level scene::stop("tarmac_wounded_2");
    level scene::stop("injured_carried2", "targetname");
    level scene::stop("injured_carried1", "targetname");
    level scene::stop("cin_pro_03_02_blendin_vign_destruction_putoutfire");
    wait 0.1;
    level struct::function_368120a1("scene", "p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle");
    level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_injured");
    level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_attendfire");
    level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_help");
    level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_putoutfire");
}

// Namespace cp_prologue_enter_base
// Params 2, eflags: 0x0
// Checksum 0xbeafaee5, Offset: 0x3908
// Size: 0x9a
function function_1a72a604(str_node, var_5e550f5) {
    if (!isdefined(var_5e550f5)) {
        var_5e550f5 = 1;
    }
    self notsolid();
    var_51a35d76 = getvehiclenode(str_node, "targetname");
    self.drivepath = var_5e550f5;
    self.angles = var_51a35d76.angles;
    self thread vehicle::get_on_and_go_path(var_51a35d76);
    self waittill(#"reached_end_node");
    self delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xb56e02c3, Offset: 0x39b0
// Size: 0x1a
function function_374cf6ee() {
    level clientfield::set("blend_in_cleanup", 1);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x2dffb911, Offset: 0x39d8
// Size: 0x107
function function_599e2f36() {
    if (isdefined(level.var_8d6df5cb)) {
        return;
    }
    level.var_8d6df5cb = 1;
    a_vehicles = [];
    a_vehicles[a_vehicles.size] = "tarmac_cargo_short";
    a_vehicles[a_vehicles.size] = "tarmac_cargo_long";
    a_vehicles[a_vehicles.size] = "tarmac_humvee";
    for (i = 0; i < 12; i++) {
        index = randomintrange(0, a_vehicles.size);
        var_39eb2d3a = a_vehicles[index] + "_far";
        var_6be5d72c = vehicle::simple_spawn_single(var_39eb2d3a);
        var_6be5d72c thread function_1a72a604("tunnel_truck2_node");
        var_465e9706 = randomfloatrange(10, 15);
        wait var_465e9706;
        if (level flag::get("stop_tunnel_spawns")) {
            break;
        }
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xc5a87390, Offset: 0x3ae8
// Size: 0xb5
function tarmac_cargo_enter_far_base() {
    delays = [];
    delays[delays.size] = 1.75;
    delays[delays.size] = 7.5;
    delays[delays.size] = 12;
    delays[delays.size] = 8;
    delays[delays.size] = 12;
    for (num = 0; num < 2; num++) {
        for (i = 0; i < delays.size; i++) {
            var_5e344df1 = vehicle::simple_spawn_single("tarmac_cargo_enter_far_base");
            var_5e344df1 thread function_1a72a604("nd_tarmac_cargo_enter_far_base");
            wait delays[i];
        }
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xccaf7637, Offset: 0x3ba8
// Size: 0x63
function function_63075f1d() {
    foreach (player in level.activeplayers) {
        player thread function_3f3cae8c();
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3a150e18, Offset: 0x3c18
// Size: 0xf9
function function_3f3cae8c() {
    self endon(#"death");
    var_1dd38210 = getent("info_crouch_tutorial", "targetname");
    self flag::wait_till("tutorial_allowed");
    self flag::set_val("tutorial_allowed", 0);
    while (!self istouching(var_1dd38210)) {
        wait 0.1;
    }
    self util::show_hint_text(%CP_MI_ETH_PROLOGUE_TUTORIAL_CROUCH, 0, undefined, 10);
    self.var_9db68ebf = 0;
    while (!self.var_9db68ebf) {
        if (self stancebuttonpressed()) {
            self util::hide_hint_text();
            self.var_9db68ebf = 1;
            self flag::set_val("tutorial_allowed", 1);
            continue;
        }
        wait 0.05;
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x41322aa2, Offset: 0x3d20
// Size: 0x42
function function_127fb1fb() {
    level thread function_cf7b5db7();
    level thread function_11ec608d();
    level thread function_809b0d82();
    level thread function_3e901e16();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xfde8f0e9, Offset: 0x3d70
// Size: 0x10a
function function_5dc7beec() {
    level thread function_cbd1cf8b("tsa_guard_wound_1");
    level thread function_cbd1cf8b("tsa_guard_wound_2");
    level thread function_cbd1cf8b("tsa_guard_wound_3");
    level thread function_cbd1cf8b("tsa_guard_wound_4");
    level thread function_cbd1cf8b("tsa_guard_wound_5");
    trigger::wait_till("close_security_door_trig");
    level scene::stop("tsa_guard_wound_1");
    level scene::stop("tsa_guard_wound_2");
    level scene::stop("tsa_guard_wound_3");
    level scene::stop("tsa_guard_wound_4");
    level scene::stop("tsa_guard_wound_5");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xf54b1913, Offset: 0x3e88
// Size: 0x17a
function function_cf7b5db7() {
    flag::wait_till("player_trigger_gear_drop");
    level thread scene::play("landing_gear_anim", "targetname");
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.3, 0.6, 600, 3);
    exploder::exploder("light_exploder_controltower_inset_red");
    level thread scene::play("p7_fxanim_cp_prologue_control_tower_debris_01_bundle");
    level thread scene::play("p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle");
    trigger::wait_till("trig_plane_tail_explosion");
    videostop("cp_prologue_env_post_crash");
    level thread scene::play("plane_tail_explosion", "targetname");
    level thread scene::play("p7_fxanim_cp_prologue_control_tower_ceiling_tiles_03_bundle");
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.4, 1.2, 10000, 6);
    level thread function_4febd2da();
    function_6bad1a34();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xbe964b41, Offset: 0x4010
// Size: 0x1a
function function_4febd2da() {
    wait 2;
    playsoundatposition("amb_tower_shake", (0, 0, 0));
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xa3f0684a, Offset: 0x4038
// Size: 0xa2
function function_6bad1a34() {
    level waittill(#"hash_c52fa561");
    level thread scene::play("plane_cockpit_explosion", "targetname");
    exploder::exploder("fx_exploder_plane_exp");
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.5, 1.2, 10000, 4);
    level.var_fdb31b75 scene::play("cin_pro_03_01_blendin_vign_truck_spray", level.var_fdb31b75);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xce0422b4, Offset: 0x40e8
// Size: 0x32
function function_397b8620() {
    level flag::wait_till("explosion_fallback_flag");
    trigger::use("trig_lookat_explosion");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x818b958b, Offset: 0x4128
// Size: 0x9f
function function_11ec608d() {
    while (!level flag::get("tower_doors_open")) {
        wait randomfloatrange(5, 12);
        level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.4, 0.5, 800, 2);
        playsoundatposition("amb_tower_shake", (0, 0, 0));
        level notify(#"hash_c988e5af");
    }
    level notify(#"hash_f8e975b8");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xaefa65c3, Offset: 0x41d0
// Size: 0x52
function function_809b0d82() {
    trigger_hit = trigger::wait_till("t_glass_floor_cracks");
    level notify(#"hash_809b0d82");
    level notify(#"hash_fc089399");
    trigger_hit.who playrumbleonentity("damage_heavy");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xd2dfff98, Offset: 0x4230
// Size: 0x9a
function function_3e901e16() {
    level thread function_f494e193();
    trigger::wait_till("t_tower_wheels");
    wait 0.5;
    level thread scene::play("p7_fxanim_cp_prologue_control_tower_ceiling_tiles_01_bundle");
    level waittill(#"hash_809b0d82");
    level flag::wait_till("player_entering_tunnel");
    scene::stop("p7_fxanim_cp_prologue_control_tower_debris_01_bundle");
    scene::stop("p7_fxanim_cp_prologue_control_tower_ceiling_tiles_01_bundle");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xf90e528f, Offset: 0x42d8
// Size: 0x42
function function_f494e193() {
    level endon(#"hash_5893f877");
    level flag::wait_till("control_tower_debris");
    level thread scene::skipto_end("p7_fxanim_cp_prologue_control_tower_debris_01_bundle", undefined, undefined, 0.15, 0);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3ae67ae2, Offset: 0x4328
// Size: 0x12
function function_e38f7be3() {
    level thread function_381bb7f6();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x26cd28c5, Offset: 0x4348
// Size: 0x11a
function function_381bb7f6() {
    cp_prologue_util::function_25e841ea();
    battlechatter::function_d9f49fba(0);
    cp_prologue_util::function_47a62798(1);
    level.var_2fd26037.pacifist = 1;
    level.var_2fd26037.ignoreme = 1;
    array::run_all(level.players, &util::function_16c71b8, 1);
    array::thread_all(level.players, &cp_mi_eth_prologue::function_7072c5d8);
    level thread function_8292daf3();
    level thread function_e8173f7f();
    level thread function_65e80b9e();
    level thread function_d095f82f();
    level thread function_e6ec4fe5();
    level thread function_21dd3be1();
    level.var_2fd26037 function_1978850f();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x937ab498, Offset: 0x4470
// Size: 0x132
function function_1978850f() {
    level scene::init("cin_pro_04_01_takeout_vign_kiosk_kill");
    level flag::wait_till("hendr_crossed_tarmac");
    level flag::wait_till("start_hendr_kill");
    level thread function_f126566f();
    level thread function_eb28ee9b();
    level scene::add_scene_func("cin_pro_04_01_takeout_vign_keycard", &namespace_e09822e3::function_30b1de21);
    level scene::add_scene_func("cin_pro_05_01_securitycam_1st_stealth_kill_prepare", &namespace_e09822e3::function_d6557dc4);
    level scene::add_scene_func("cin_pro_05_01_securitycam_1st_stealth_kill_prepare", &namespace_e09822e3::function_9887d555, "done");
    level scene::add_scene_func("cin_pro_04_01_takeout_vign_kiosk_kill", &function_6f98f3af, "play");
    level scene::play("cin_pro_04_01_takeout_vign_kiosk_kill");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x8e98b0cc, Offset: 0x45b0
// Size: 0x122
function function_eb28ee9b() {
    level waittill(#"hash_eb28ee9b");
    var_7e130296 = getent("blend_security_door_lt", "targetname");
    var_2a3f9df8 = getent("blend_security_door_rt", "targetname");
    var_7e130296 rotateyaw(89, 0.5);
    var_2a3f9df8 rotateyaw(90 * -1, 0.5);
    playsoundatposition("evt_tunnel_gate_open", var_2a3f9df8.origin);
    level thread function_60b83ce9();
    level waittill(#"hash_2170cc63");
    level thread objectives::breadcrumb("blending_in_breadcrumb_4");
    level waittill(#"hash_7a8dce93");
    level flag::set("activate_bc_5");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x841f9fc2, Offset: 0x46e0
// Size: 0x143
function function_60b83ce9() {
    t_door = getent("kiosk_guard_door", "targetname");
    level thread cp_prologue_util::function_21f52196("kiosk_doors", t_door, "t_regroup_past_guards");
    while (!cp_prologue_util::function_cdd726fb("kiosk_doors")) {
        wait 0.5;
    }
    var_7e130296 = getent("blend_security_door_lt", "targetname");
    var_2a3f9df8 = getent("blend_security_door_rt", "targetname");
    var_7e130296 rotateyaw(89 * -1, 0.25);
    var_2a3f9df8 rotateyaw(90, 0.25);
    playsoundatposition("evt_tunnel_gate_open", var_2a3f9df8.origin);
    level notify(#"hash_b5e3e8ba");
    level notify(#"hash_f3f03044");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x909d42b2, Offset: 0x4830
// Size: 0x22
function function_8292daf3() {
    level thread function_7f967b5b();
    level thread function_3921e3de();
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0xbbb9c17c, Offset: 0x4860
// Size: 0x22
function function_587c5a03(sndent) {
    self waittill(#"death");
    sndent delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xf7f6fb0b, Offset: 0x4890
// Size: 0x5a
function function_3921e3de() {
    level notify(#"siren");
    level scene::init("forkilft_anim");
    trigger::wait_till("trigger_obj_enter_tunnels_end");
    level thread scene::skipto_end("forkilft_anim", undefined, undefined, 0.33);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x751c7fb8, Offset: 0x48f8
// Size: 0x7e
function function_d095f82f() {
    e_turret = spawner::simple_spawn_single("tunnel_turret_1");
    e_turret thread function_927f3ae0(0.1);
    e_turret.scanning_arc = 30;
    e_turret = spawner::simple_spawn_single("tunnel_turret_2");
    e_turret thread function_927f3ae0(0.5);
    e_turret.scanning_arc = 30;
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0x8dbcde5, Offset: 0x4980
// Size: 0xe2
function function_927f3ae0(var_5232cb44) {
    self turret::enable_laser(0, 0);
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i].ignoreme = 1;
    }
    level.var_2fd26037.ignoreme = 1;
    level thread function_3d9b2dbc();
    level waittill(#"hash_1a6eba1f");
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i].ignoreme = 0;
    }
    level.var_2fd26037.ignoreme = 0;
    wait var_5232cb44;
    self delete();
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xf529fe4, Offset: 0x4a70
// Size: 0x65
function function_3d9b2dbc() {
    level endon(#"objective_take_out_guards_done");
    while (true) {
        level waittill(#"hash_25ea191a");
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            a_players[i].ignoreme = 1;
        }
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x73203754, Offset: 0x4ae0
// Size: 0x15a
function function_65e80b9e() {
    function_173d3769("close", 1);
    var_813b7ee8 = vehicle::simple_spawn_single("sp_truck_tarmac_enter_base");
    var_813b7ee8 thread function_1a72a604("nd_truck_tarmac_enter_base", 0);
    var_813b7ee8 playloopsound("evt_tunnel_truck_script_drive_lp");
    level waittill(#"hash_3bc05b4");
    var_813b7ee8 setspeed(0, 15, 15);
    var_813b7ee8 playsound("evt_tunnel_truck_brake");
    var_813b7ee8 thread function_8677e162();
    level thread function_790e40ec();
    level waittill(#"hash_236f4ebe");
    var_813b7ee8 setspeed(20, 15, 15);
    var_813b7ee8 resumespeed(20);
    var_813b7ee8 playloopsound("evt_tunnel_truck_script_drive_lp", 0.2);
    util::delay(2, undefined, &function_173d3769, "open");
    level waittill(#"hash_bed7581c");
    function_173d3769("close");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xdbaead45, Offset: 0x4c48
// Size: 0x42
function function_8677e162() {
    self stoploopsound(0.75);
    wait 0.25;
    self playloopsound("evt_tunnel_truck_script_idle_lp", 0.25);
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x7eef1bb4, Offset: 0x4c98
// Size: 0x10d
function function_790e40ec() {
    var_b8823447 = getentarray("tunnel_traffic_barrier", "targetname");
    var_ecbf6327 = var_b8823447[0];
    var_ecbf6327 playsound("evt_tunnel_truck_trafficarm");
    var_ecbf6327 rotateroll(60, 1.5, 0.5, 0.3);
    var_ecbf6327 waittill(#"rotatedone");
    level notify(#"hash_236f4ebe");
    level waittill(#"hash_a4ce8e72");
    var_ecbf6327 playsound("evt_tunnel_truck_trafficarm");
    var_ecbf6327 rotateroll(60 * -1, 1.5, 0.5, 0.3);
    var_ecbf6327 waittill(#"rotatedone");
}

// Namespace cp_prologue_enter_base
// Params 2, eflags: 0x0
// Checksum 0x8277b33f, Offset: 0x4db0
// Size: 0x1fa
function function_173d3769(str_state, var_abf03d83) {
    if (!isdefined(var_abf03d83)) {
        var_abf03d83 = 0;
    }
    var_3c301126 = getent("tunnel_vault_door_r", "targetname");
    var_280d5f68 = getent("tunnel_vault_door_l", "targetname");
    if (!var_abf03d83) {
        var_3c301126 playsound("evt_tunnel_door_start");
        var_3c301126 playloopsound("evt_tunnel_door_loop", 1);
    }
    if (str_state == "open") {
        if (var_abf03d83) {
            var_3c301126 rotateyaw(90, 0.05);
            var_280d5f68 rotateyaw(90 * -1, 0.05);
        } else {
            var_3c301126 rotateyaw(90, 6, 1, 1);
            var_280d5f68 rotateyaw(90 * -1, 6, 1, 1);
        }
    } else if (var_abf03d83) {
        var_3c301126 rotateyaw(90 * -1, 0.05);
        var_280d5f68 rotateyaw(90, 0.05);
    } else {
        var_3c301126 rotateyaw(90 * -1, 6, 1, 1);
        var_280d5f68 rotateyaw(90, 6, 1, 1);
    }
    var_3c301126 waittill(#"rotatedone");
    var_3c301126 stoploopsound(0.5);
    var_3c301126 playsound("evt_tunnel_door_stop");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x40d8b855, Offset: 0x4fb8
// Size: 0xab
function function_e8173f7f() {
    level waittill(#"hash_81d6c615");
    var_98f0d423 = getaiarray("start_through_take_out_guards", "script_aigroup");
    foreach (var_480743 in var_98f0d423) {
        if (isalive(var_480743)) {
            var_480743 delete();
        }
    }
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3f9a0efe, Offset: 0x5070
// Size: 0x6a
function function_7f967b5b() {
    level scene::init("cin_pro_04_01_takeout_vign_vault_doors");
    level waittill(#"hash_f199baa");
    level thread scene::play("cin_pro_04_01_takeout_vign_vault_doors");
    trigger::wait_till("close_security_door_trig");
    level scene::stop("cin_pro_04_01_takeout_vign_vault_doors");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x61ac8414, Offset: 0x50e8
// Size: 0xb2
function function_f126566f() {
    wait 2;
    level thread scene::init("cin_pro_04_01_takeout_vign_truck_prisoners");
    wait 4;
    level thread scene::init("cin_pro_04_02_takeout_vign_truck_unload");
    level flag::wait_till("start_tunnel_trucks");
    level thread scene::play("cin_pro_04_01_takeout_vign_truck_prisoners");
    wait 4;
    level thread scene::play("cin_pro_04_02_takeout_vign_truck_unload");
    level waittill(#"hash_81d6c615");
    scene::stop("cin_pro_04_01_takeout_vign_truck_prisoners");
    scene::stop("cin_pro_04_02_takeout_vign_truck_unload");
}

// Namespace cp_prologue_enter_base
// Params 1, eflags: 0x0
// Checksum 0xcc3b8997, Offset: 0x51a8
// Size: 0x52
function function_6f98f3af(a_ents) {
    level waittill(#"hash_1a725b50");
    wait 10;
    e_ent = getent("pa_vox_security_cameras", "targetname");
    e_ent dialog::say("nrcp_emergency_protocol_0");
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0xb8027396, Offset: 0x5208
// Size: 0x152
function function_e6ec4fe5() {
    var_dd4fa3f4 = spawner::simple_spawn_single("balcony_guy1");
    var_dd4fa3f4 ai::set_pacifist(1);
    var_dd4fa3f4 thread ai::patrol(getnode("tunnel_patrol_1", "targetname"));
    var_4f57132f = spawner::simple_spawn_single("balcony_guy2");
    var_4f57132f ai::set_pacifist(1);
    var_4f57132f thread ai::patrol(getnode("tunnel_patrol_2", "targetname"));
    trigger::wait_till("spawn_balcony_patrol");
    var_295498c6 = spawner::simple_spawn_single("balcony_guy3");
    var_295498c6 ai::set_pacifist(1);
    var_295498c6 thread ai::patrol(getnode("tunnel_patrol_3", "targetname"));
}

// Namespace cp_prologue_enter_base
// Params 0, eflags: 0x0
// Checksum 0x3644663b, Offset: 0x5368
// Size: 0x242
function function_21dd3be1() {
    t_door = getent("tunnel_keycard_door", "targetname");
    level thread cp_prologue_util::function_21f52196("keycard_doors", t_door);
    e_left_door = getent("tunnel_vault_upperdoor_L", "targetname");
    v_side = anglestoright(e_left_door.angles);
    e_right_door = getent("tunnel_vault_upperdoor_R", "targetname");
    move_amount = 52;
    var_33219fd6 = e_left_door.origin + v_side * move_amount * -1;
    e_left_door moveto(var_33219fd6, 0.1);
    var_dac99ad = e_right_door.origin + v_side * move_amount;
    e_right_door moveto(var_dac99ad, 0.1);
    level waittill(#"hash_2170cc63");
    playsoundatposition("evt_tunnel_upper_door", e_left_door.origin);
    var_33219fd6 = e_left_door.origin + v_side * move_amount;
    e_left_door moveto(var_33219fd6, 1.5);
    var_dac99ad = e_right_door.origin + v_side * move_amount * -1;
    e_right_door moveto(var_dac99ad, 1.5);
    while (!cp_prologue_util::function_cdd726fb("keycard_doors")) {
        wait 0.5;
    }
    var_33219fd6 = e_left_door.origin + v_side * move_amount * -1;
    e_left_door moveto(var_33219fd6, 0.1);
    var_dac99ad = e_right_door.origin + v_side * move_amount;
    e_right_door moveto(var_dac99ad, 0.1);
}

