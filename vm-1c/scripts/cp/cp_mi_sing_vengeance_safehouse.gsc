#using scripts/cp/_load;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_market;
#using scripts/cp/_debug;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/stealth;
#using scripts/cp/_dialog;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_ce9d9fc1;

// Namespace namespace_ce9d9fc1
// Params 2, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_26524bc8
// Checksum 0xd49ae26, Offset: 0xea8
// Size: 0x1bc
function function_26524bc8(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level scene::init("cin_ven_11_safehouse_3rd_sh010");
        objectives::set("cp_level_vengeance_rescue_kane");
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        callback::on_spawned(&namespace_63b4601c::function_b9785164);
        level thread namespace_63b4601c::function_6bd25628();
        util::function_d8eaed3d(5);
        load::function_a2995f22();
    }
    if (isdefined(level.stealth)) {
        level stealth::stop();
    }
    namespace_63b4601c::function_4e8207e9("safehouse_explodes");
    function_429957e0();
    thread namespace_7c587e3e::function_1fc1836b();
    spawner::add_spawn_function_group("sniper", "script_noteworthy", &function_422af9d);
    function_bb642ec0(str_objective, var_74cd64bc);
}

// Namespace namespace_ce9d9fc1
// Params 4, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_683ab16e
// Checksum 0xbb82059f, Offset: 0x1070
// Size: 0x2d4
function function_683ab16e(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    a_enemies = getaiteamarray("axis");
    if (isdefined(a_enemies)) {
        foreach (e_enemy in a_enemies) {
            if (isdefined(e_enemy)) {
                e_enemy delete();
            }
        }
    }
    util::function_459ff829();
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh010");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh020");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh030");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh040");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh050");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh060");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh070");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh080");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh090");
    level struct::function_368120a1("scene", "cin_ven_11_safehouse_3rd_sh100");
    level struct::function_368120a1("scene", "cin_ven_08_20_balconyexplosion_vign");
    level struct::function_368120a1("scene", "cin_ven_08_30_agentlaststand_vign");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_429957e0
// Checksum 0x79467ad4, Offset: 0x1350
// Size: 0x10c
function function_429957e0() {
    level thread function_8fbe8f97();
    namespace_63b4601c::function_ac2b4535("cin_ven_11_safehouse_3rd_sh100", "safehouse_explosion_post_igc");
    var_286c5204 = struct::get("tag_align_safehouse_explosion", "targetname");
    level thread namespace_9fd035::function_83763d08();
    if (isdefined(level.var_143ab0c7)) {
        level thread [[ level.var_143ab0c7 ]]();
    }
    if (!isdefined(level.var_4c62d05f)) {
        level.var_4c62d05f = level.players[0];
    }
    var_286c5204 thread scene::play("cin_ven_11_safehouse_3rd_sh010", level.var_4c62d05f);
    level waittill(#"hash_ffdc982b");
    level thread function_4e237f5c();
    util::clear_streamer_hint();
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x0
// namespace_ce9d9fc1<file_0>::function_d5d199aa
// Checksum 0xd909fd9f, Offset: 0x1468
// Size: 0x124
function function_d5d199aa() {
    level waittill(#"hash_15bf2587");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_now_what_0");
    level waittill(#"hash_6039f21b");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_fuck_2");
    level waittill(#"hash_816104fe");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_i_guess_the_rescue_m_0");
    level waittill(#"hash_100456bb");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_you_re_kidding_me_r_0");
    level waittill(#"hash_2971a10c");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_hey_do_you_hear_me_0");
    level waittill(#"hash_cf9e18be");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_accept_it_0");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x0
// namespace_ce9d9fc1<file_0>::function_52dabe42
// Checksum 0x70afde47, Offset: 0x1598
// Size: 0x7c
function function_52dabe42() {
    level waittill(#"hash_e2d6e01a");
    level dialog::function_13b3b16a("plyr_now_we_get_kane_0");
    level waittill(#"hash_d330121");
    level dialog::function_13b3b16a("plyr_find_us_transport_fo_0");
    level waittill(#"hash_882063bf");
    level dialog::function_13b3b16a("plyr_no_there_s_still_a_0");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_8fbe8f97
// Checksum 0x40bbbf56, Offset: 0x1620
// Size: 0x54
function function_8fbe8f97() {
    level waittill(#"hash_8ed78163");
    var_a9009014 = getentarray("safehouse_ext_door", "targetname");
    array::delete_all(var_a9009014);
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_4e237f5c
// Checksum 0xa4291d66, Offset: 0x1680
// Size: 0x164
function function_4e237f5c() {
    var_40ccaf9f = getentarray("safehouse_entry_door_rubble", "targetname");
    foreach (e_item in var_40ccaf9f) {
        e_item movez(128, 0.05);
    }
    exploder::exploder("sh_int_lobby_door_fire_01");
    level thread scene::play("fxanims_safehouse_explodes", "targetname");
    exploder::exploder("sh_int_lobby_door_fire_02");
    var_3c8ec8e = getent("lobby_door_fire_trigger", "targetname");
    var_3c8ec8e triggerenable(1);
}

// Namespace namespace_ce9d9fc1
// Params 2, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_29dad6e8
// Checksum 0x3cb81176, Offset: 0x17f0
// Size: 0x164
function function_29dad6e8(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        callback::on_spawned(&namespace_63b4601c::function_b9785164);
        objectives::set("cp_level_vengeance_rescue_kane");
        level thread function_4e237f5c();
        var_a9009014 = getentarray("safehouse_ext_door", "targetname");
        array::delete_all(var_a9009014);
        level flag::wait_till("all_players_spawned");
    }
    if (isdefined(level.stealth)) {
        level stealth::stop();
    }
    thread namespace_7c587e3e::function_1fc1836b();
    spawner::add_spawn_function_group("sniper", "script_noteworthy", &function_422af9d);
    function_bb642ec0(str_objective, var_74cd64bc);
}

// Namespace namespace_ce9d9fc1
// Params 4, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_6bc33c8e
// Checksum 0xd63a9be3, Offset: 0x1960
// Size: 0x24
function function_6bc33c8e(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_ce9d9fc1
// Params 2, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_bb642ec0
// Checksum 0xa2acb5d2, Offset: 0x1990
// Size: 0x174
function function_bb642ec0(str_objective, var_74cd64bc) {
    objectives::set("cp_level_vengeance_go_to_panic_room");
    level thread function_be8594ba();
    level thread function_33ebc91e();
    level thread function_4f5d8ae9();
    level thread function_c50ccfbd();
    level thread function_7d2a7231();
    level thread function_fb60b7ca();
    level thread namespace_9fd035::function_b83aa9c5();
    wait(3);
    level objectives::breadcrumb("find_kayne_breadcrumb");
    trigger::wait_till("obj_safehouse_int", "targetname");
    if (str_objective == "safehouse_explodes") {
        skipto::function_be8adfb8("safehouse_explodes");
    } else {
        skipto::function_be8adfb8("dev_safehouse_interior");
    }
    objectives::hide("cp_level_vengeance_go_to_panic_room");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_33ebc91e
// Checksum 0x1e79effa, Offset: 0x1b10
// Size: 0x14c
function function_33ebc91e() {
    trigger::wait_till("start_safehouse_vo");
    level namespace_63b4601c::function_ee75acde("xiu0_your_friend_she_s_0");
    level dialog::function_13b3b16a("plyr_what_did_you_do_to_h_0");
    level namespace_63b4601c::function_ee75acde("xiu0_she_won_t_be_talking_0");
    level namespace_63b4601c::function_ee75acde("xiu0_now_she_is_being_q_0");
    level namespace_63b4601c::function_ee75acde("xiu0_you_will_see_0");
    trigger::wait_till("spawn_safehouse_wave_3");
    level namespace_63b4601c::function_ee75acde("hend_you_d_better_pick_up_0");
    trigger::wait_till("spawn_panic_room");
    level namespace_63b4601c::function_ee75acde("hend_dammit_are_you_list_0");
    level dialog::function_13b3b16a("plyr_stay_where_you_are_h_0");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_4f5d8ae9
// Checksum 0x93966a5c, Offset: 0x1c68
// Size: 0x11c
function function_4f5d8ae9() {
    spawner::add_spawn_function_ai_group("sh_robots", &function_c6fb453d);
    trigger::wait_till("spawn_safehouse_wave_1", "targetname");
    spawn_manager::enable("safehouse_wave1");
    trigger::wait_till("spawn_safehouse_wave_1a", "targetname");
    spawn_manager::enable("safehouse_wave1a");
    trigger::wait_till("spawn_safehouse_wave_2", "targetname");
    spawner::simple_spawn("safehouse_robots_wave_2");
    trigger::wait_till("spawn_safehouse_wave_3", "targetname");
    namespace_63b4601c::function_a084a58f();
    spawn_manager::enable("safehouse_robots_wave_3");
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_be8594ba
// Checksum 0x4873ca29, Offset: 0x1d90
// Size: 0x15c
function function_be8594ba() {
    var_ee392d90 = getent("last_stand_agent1", "targetname");
    var_ee392d90 spawner::add_spawn_function(&function_8d0196a7);
    var_60409ccb = getent("last_stand_agent2", "targetname");
    var_60409ccb spawner::add_spawn_function(&function_8d0196a7);
    var_3a3e2262 = getent("panicroom_cia1", "targetname");
    var_3a3e2262 spawner::add_spawn_function(&function_8d0196a7);
    level thread function_2196c10e("cin_ven_08_30_agentlaststand_vign", "safehouse_hall_script_node", undefined, 2, "last_stand_done");
    level thread function_2196c10e("cin_ven_08_60_panicroom_bodies", "panic_room_hall_animnode", "shake_ready_room", undefined);
}

// Namespace namespace_ce9d9fc1
// Params 5, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_2196c10e
// Checksum 0x7877f49a, Offset: 0x1ef8
// Size: 0x118
function function_2196c10e(scriptbundle, var_2d7613bb, trigger, delay, var_199e0d00) {
    assert(isdefined(scriptbundle), "cin_ven_11_safehouse_3rd_sh020");
    if (isdefined(var_2d7613bb)) {
        var_5b01a37b = struct::get(var_2d7613bb, "targetname");
    }
    if (isdefined(trigger)) {
        trigger::wait_till(trigger);
    }
    if (isdefined(delay)) {
        wait(delay);
    }
    if (isdefined(var_5b01a37b)) {
        var_5b01a37b scene::play(scriptbundle);
    } else {
        level scene::play(scriptbundle);
    }
    if (isdefined(var_199e0d00)) {
        level notify(var_199e0d00);
    }
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_8d0196a7
// Checksum 0xb00891eb, Offset: 0x2018
// Size: 0x24
function function_8d0196a7() {
    self setweapon(self.sidearm);
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x0
// namespace_ce9d9fc1<file_0>::function_15d46e2e
// Checksum 0x26c5f7f9, Offset: 0x2048
// Size: 0xcc
function function_15d46e2e() {
    var_f0488808 = getent("sh_lobby_case_frame", "targetname");
    var_8f75db49 = struct::get("sh_case_impact_spot", "targetname");
    level waittill(#"hash_22368350");
    var_f0488808 delete();
    exploder::exploder("sh_lobby_case_glass");
    wait(0.1);
    physicsexplosioncylinder(var_8f75db49.origin, 48, 40, 3);
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_c6fb453d
// Checksum 0xa087d560, Offset: 0x2120
// Size: 0x3c
function function_c6fb453d() {
    if (isdefined(self.script_parameters) && self.script_parameters == "laser") {
        self laseron();
    }
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_422af9d
// Checksum 0x7a7c99c0, Offset: 0x2168
// Size: 0x10
function function_422af9d() {
    self.goalradius = 8;
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_c50ccfbd
// Checksum 0x4bf060ef, Offset: 0x2180
// Size: 0x1bc
function function_c50ccfbd() {
    wait(1);
    level thread function_2d58165a();
    wait(3);
    level thread function_d39f39b7();
    trigger::wait_till("shake_stairwell", "targetname");
    thread namespace_7c587e3e::function_c4ece2ab();
    level util::clientnotify("start_debris_fall");
    level notify(#"hash_9bd485a5");
    level thread function_2d58165a();
    wait(1.5);
    var_136e3a27 = getentarray("sh_stairs_glass_remove", "targetname");
    array::delete_all(var_136e3a27);
    var_f9fdee53 = struct::get("sh_stairwell_glass_damage", "targetname");
    glassradiusdamage(var_f9fdee53.origin, -128, -56, -81);
    wait(1.5);
    level thread function_d39f39b7();
    trigger::wait_till("shake_ready_room", "targetname");
    level notify(#"hash_9bd485a5");
    level thread function_2d58165a();
    wait(3);
    level thread function_d39f39b7();
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_d39f39b7
// Checksum 0x21659cbc, Offset: 0x2348
// Size: 0x18e
function function_d39f39b7() {
    level endon(#"hash_9bd485a5");
    while (true) {
        wait(randomintrange(15, 25));
        var_ab2048f4 = randomfloatrange(2, 3);
        var_68397497 = randomfloatrange(2.5, 4);
        foreach (e_player in level.activeplayers) {
            thread namespace_7c587e3e::function_a34878f1(e_player);
            screenshake(e_player.origin, var_ab2048f4, var_ab2048f4 / 3, var_ab2048f4 / 3, var_68397497, 0, -1, 100, 7, 1, 1, 1, e_player);
            e_player playrumbleonentity("cp_vengeance_rumble_sh_ran_shake");
        }
    }
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_2d58165a
// Checksum 0x57289ea7, Offset: 0x24e0
// Size: 0x13a
function function_2d58165a() {
    var_ab2048f4 = randomfloatrange(4, 5);
    var_68397497 = 4.5;
    foreach (e_player in level.activeplayers) {
        thread namespace_7c587e3e::function_a34878f1(e_player);
        screenshake(e_player.origin, var_ab2048f4, var_ab2048f4 / 3, var_ab2048f4 / 3, var_68397497, 0, -1, 100, 8, 2, 2, 1, e_player);
        e_player playrumbleonentity("cp_vengeance_rumble_sh_big_shake");
    }
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_7d2a7231
// Checksum 0x5aabaced, Offset: 0x2628
// Size: 0x134
function function_7d2a7231() {
    level thread function_f3b31be1("spawn_safehouse_wave_1", 0.5, 1.75, "sh_backdraft_01", "backdraft_01_struct", "backdraft_1_siege");
    level thread function_f3b31be1("start_backdraft_2", 0, 0.25, "sh_backdraft_02", "backdraft_02_struct", "backdraft_2_siege");
    level thread function_f3b31be1("find_kayne_breadcrumb", 0, 0.75, "sh_backdraft_03", "backdraft_03_struct", "backdraft_3_siege");
    level thread function_f3b31be1("start_backdraft_4", 0, 0.5, "sh_backdraft_04");
    level thread function_f3b31be1("shake_ready_room", 0, 0.25, "sh_backdraft_05");
}

// Namespace namespace_ce9d9fc1
// Params 6, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_f3b31be1
// Checksum 0x21a76b24, Offset: 0x2768
// Size: 0x11c
function function_f3b31be1(trigger, var_946cffe7, var_39c72159, exploder, struct, var_d5e92f6a) {
    trigger::wait_till(trigger, "targetname");
    wait(randomfloatrange(var_946cffe7, var_39c72159));
    exploder::exploder(exploder);
    if (isdefined(var_d5e92f6a)) {
        level util::clientnotify(var_d5e92f6a);
    }
    if (isdefined(struct)) {
        s_struct = struct::get(struct, "targetname");
        thread namespace_7c587e3e::function_f3b31be1(s_struct.origin);
        glassradiusdamage(s_struct.origin, 96, -106, 125);
    }
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_fb60b7ca
// Checksum 0xb72adbea, Offset: 0x2890
// Size: 0xdc
function function_fb60b7ca(var_74cd64bc) {
    if (!isdefined(var_74cd64bc) || var_74cd64bc == 0) {
        trigger::wait_till("spawn_panic_room");
    }
    level.var_3d556bcd = spawner::simple_spawn_single("rachel", &function_87298438);
    wait(1);
    var_35a1e4f8 = struct::get("tag_align_panic_room", "targetname");
    var_35a1e4f8 thread scene::init("cin_ven_08_80_enter_panicroom_1st");
    var_35a1e4f8 thread scene::init("cin_ven_12_01_1st_kane_rescue");
}

// Namespace namespace_ce9d9fc1
// Params 2, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_6d9a830c
// Checksum 0xc3d732ff, Offset: 0x2978
// Size: 0x184
function function_6d9a830c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        callback::on_spawned(&namespace_63b4601c::function_b9785164);
        objectives::set("cp_level_vengeance_rescue_kane");
        e_spawner = getent("panicroom_cia1", "targetname");
        e_spawner spawner::add_spawn_function(&function_8d0196a7);
        level thread function_2196c10e("cin_ven_08_60_panicroom_bodies", "panic_room_hall_animnode", "shake_ready_room", undefined);
        level function_fb60b7ca(var_74cd64bc);
        level util::function_d8eaed3d(6);
        load::function_a2995f22();
        trigger::use("shake_ready_room");
    }
    thread namespace_7c587e3e::function_1a02fe3();
    function_d128fa92(str_objective);
}

// Namespace namespace_ce9d9fc1
// Params 4, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_c328b12
// Checksum 0xfa46698a, Offset: 0x2b08
// Size: 0x24
function function_c328b12(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_d128fa92
// Checksum 0x3bd32849, Offset: 0x2b38
// Size: 0x504
function function_d128fa92(str_objective) {
    e_trigger = getent("obj_panic", "targetname");
    var_ca0e9b65 = util::function_14518e76(e_trigger, %cp_prompt_enter_ven_door, %CP_MI_SING_VENGEANCE_HINT_OPEN, &function_69ff4ffa);
    objectives::set("cp_level_vengeance_open_panic_room_menu");
    level waittill(#"hash_9644b953");
    level clientfield::set("gameplay_started", 0);
    level thread namespace_9fd035::function_c8bfdb76();
    level thread audio::unlockfrontendmusic("mus_vengeance_alerted_intro");
    level flag::set("starting_igc_12");
    var_ca0e9b65 gameobjects::disable_object();
    objectives::hide("cp_level_vengeance_open_panic_room_menu");
    objectives::complete("cp_level_vengeance_rescue_kane");
    a_enemies = getaiteamarray("axis");
    if (isdefined(a_enemies)) {
        foreach (e_enemy in a_enemies) {
            if (isdefined(e_enemy)) {
                e_enemy delete();
            }
        }
    }
    scene::add_scene_func("cin_ven_12_01_1st_kane_rescue", &function_63cf4f49);
    scene::add_scene_func("cin_ven_12_01_1st_kane_rescue", &function_965c6db8, "play");
    scene::add_scene_func("cin_ven_12_01_1st_kane_rescue", &function_724dd06d, "skip_started");
    scene::add_scene_func("cin_ven_12_kane_3rd_sh010", &function_724dd06d, "skip_started");
    scene::add_scene_func("cin_ven_12_kane_3rd_sh010_female", &function_724dd06d, "skip_started");
    scene::add_scene_func("cin_ven_12_kane_3rd_sh020", &function_724dd06d, "skip_started");
    scene::add_scene_func("cin_ven_12_kane_3rd_sh030_female", &function_724dd06d, "skip_started");
    scene::add_scene_func("cin_ven_12_kane_3rd_sh040", &function_724dd06d, "skip_started");
    level thread function_58c9be50();
    if (isdefined(level.var_e9d4ea4)) {
        level thread [[ level.var_e9d4ea4 ]]();
    }
    if (!isalive(level.var_3d556bcd)) {
        return;
    }
    level thread util::function_d8eaed3d(6);
    var_35a1e4f8 = struct::get("tag_align_panic_room", "targetname");
    var_35a1e4f8 scene::play("cin_ven_08_80_enter_panicroom_1st", level.var_4c62d05f);
    level waittill(#"hash_30b302a6");
    foreach (e_player in level.activeplayers) {
        e_player disableweapons();
    }
    skipto::function_be8adfb8("panic_room");
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_965c6db8
// Checksum 0x59939e0e, Offset: 0x3048
// Size: 0x11c
function function_965c6db8(a_ents) {
    level endon(#"hash_ec2539d3");
    level waittill(#"start_fade");
    level thread util::screen_fade_out(1, "black");
    level notify(#"hash_2bfbbe4d");
    level waittill(#"fade_in");
    exploder::exploder("sh_ex_igc");
    level thread util::screen_fade_in(2, "black");
    if (isdefined(level.var_69b67781)) {
        level thread [[ level.var_69b67781 ]]();
    }
    level.var_6e1075a2 = 0;
    level waittill(#"fade2black");
    level thread util::screen_fade_out(1.5, "black", "end_level_fade");
    level clientfield::set("sndIGCsnapshot", 4);
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_724dd06d
// Checksum 0xc9710601, Offset: 0x3170
// Size: 0x6c
function function_724dd06d(a_ents) {
    level notify(#"hash_ec2539d3");
    level notify(#"hash_2bfbbe4d");
    if (!isdefined(level.var_6e1075a2) || level.var_6e1075a2) {
        level thread util::screen_fade_out(0.05, "black", "end_level_fade");
    }
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_69ff4ffa
// Checksum 0xce9f6b68, Offset: 0x31e8
// Size: 0x3c
function function_69ff4ffa(e_player) {
    level.var_4c62d05f = e_player;
    level notify(#"hash_9644b953");
    objectives::complete("cp_level_vengeance_open_panic_room");
}

// Namespace namespace_ce9d9fc1
// Params 1, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_63cf4f49
// Checksum 0x4c4a5113, Offset: 0x3230
// Size: 0x20
function function_63cf4f49(a_ents) {
    level.var_bc7418fa = a_ents["goxiulan"];
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_58c9be50
// Checksum 0xb353e4d, Offset: 0x3258
// Size: 0x34
function function_58c9be50() {
    level waittill(#"hash_fcbf624f");
    level.var_bc7418fa clientfield::set("xiulan_face_burn", 1);
}

// Namespace namespace_ce9d9fc1
// Params 0, eflags: 0x1 linked
// namespace_ce9d9fc1<file_0>::function_87298438
// Checksum 0x236ad7bf, Offset: 0x3298
// Size: 0x11c
function function_87298438() {
    level endon(#"hash_2bfbbe4d");
    self waittill(#"death");
    e_trigger = getent("obj_panic", "targetname");
    e_trigger triggerenable(0);
    if (!level flag::get("starting_igc_12")) {
        wait(2.5);
    }
    var_35a1e4f8 = struct::get("tag_align_panic_room", "targetname");
    var_35a1e4f8 thread scene::stop("cin_ven_08_80_enter_panicroom_1st");
    var_35a1e4f8 thread scene::stop("cin_ven_12_01_1st_kane_rescue");
    util::function_207f8667(%CP_MI_SING_VENGEANCE_KANE_KILLED, %CP_MI_SING_VENGEANCE_KANE_KILLED_HINT);
}

