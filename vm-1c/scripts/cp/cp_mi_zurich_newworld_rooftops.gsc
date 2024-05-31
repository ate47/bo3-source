#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/cp_mi_zurich_newworld_accolades;
#using scripts/cp/cp_mi_zurich_newworld;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_36358f9c;

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c862f707
// Checksum 0x1879fce8, Offset: 0x33d0
// Size: 0x1cc
function function_c862f707(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        level thread namespace_ce0e5f06::function_30ec5bf7(1);
    } else {
        foreach (player in level.players) {
            player namespace_ce0e5f06::on_player_loadout();
        }
    }
    namespace_ce0e5f06::function_3383b379();
    battlechatter::function_d9f49fba(0);
    level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
    util::delay(2, undefined, &function_62976d31);
    var_b2afdf94 = getent("nw_apt_breach_decals", "targetname");
    var_b2afdf94 hide();
    function_520a8e67();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8aa535bd
// Checksum 0x3eb9a979, Offset: 0x35a8
// Size: 0x94
function function_8aa535bd(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (!level flag::exists("chase_done")) {
        level flag::init("chase_done");
    }
    level thread namespace_37a1dc33::function_cd261d0b();
    level thread namespace_37a1dc33::function_323baa37();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_520a8e67
// Checksum 0xa4800ff1, Offset: 0x3648
// Size: 0x2f0
function function_520a8e67() {
    level scene::init("cin_new_05_01_apartmentbreach_1st_sh010");
    namespace_ce0e5f06::function_83a7d040();
    if (isdefined(level.durango) && level.durango) {
        util::streamer_wait(undefined, undefined, 7);
    } else {
        util::streamer_wait();
    }
    level thread scene::init("p7_fxanim_cp_newworld_chase_door_breach_bundle");
    level thread scene::init("p7_fxanim_cp_newworld_chase_window_break_bundle");
    level thread function_d8ddf1d9();
    level thread function_b444c7bc();
    scene::add_scene_func("cin_new_05_01_apartmentbreach_1st_sh010", &function_985304c3);
    scene::add_scene_func("cin_new_05_01_apartmentbreach_1st_sh010", &function_34fb5ce3, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh020", &function_241c1e7a, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh070", &function_397c0ec9, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh080", &function_8cdb5361, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh100", &rusherdefending, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh110", &function_617b7548, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_3rd_sh130", &function_98ec301e, "play");
    scene::add_scene_func("cin_new_05_01_apartmentbreach_1st_sh140", &function_6d1ffabf, "done");
    if (isdefined(level.var_2a8a13fb)) {
        level thread [[ level.var_2a8a13fb ]]();
    }
    level scene::play("cin_new_05_01_apartmentbreach_1st_sh010");
    namespace_ce0e5f06::function_c07e7f7d(0);
    level waittill(#"hash_6d1ffabf");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_985304c3
// Checksum 0xd23b29dc, Offset: 0x3940
// Size: 0x64
function function_985304c3(a_ents) {
    level flag::clear("infinite_white_transition");
    array::thread_all(level.activeplayers, &namespace_ce0e5f06::function_737d2864, %CP_MI_ZURICH_NEWWORLD_LOCATION_ROOFTOPS, %CP_MI_ZURICH_NEWWORLD_TIME_ROOFTOPS);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d8ddf1d9
// Checksum 0x2f028e5, Offset: 0x39b0
// Size: 0x4c
function function_d8ddf1d9() {
    level.var_88590003 clientfield::set("chase_suspect_fx", 0);
    level waittill(#"hash_fc2a0798");
    level thread scene::play("p7_fxanim_cp_newworld_chase_door_breach_bundle");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b444c7bc
// Checksum 0x5ffb4420, Offset: 0x3a08
// Size: 0x2c
function function_b444c7bc() {
    level waittill(#"hash_d2bb9806");
    level thread scene::play("p7_fxanim_cp_newworld_chase_window_break_bundle");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_34fb5ce3
// Checksum 0xe1fbbffa, Offset: 0x3a40
// Size: 0xa4
function function_34fb5ce3(a_ents) {
    var_c4ba82be = getweapon("ar_fastburst");
    a_ents["gunfire01"] thread function_b81a9fbb(var_c4ba82be);
    a_ents["gunfire02"] thread function_b81a9fbb(var_c4ba82be);
    a_ents["gunfire03"] thread function_b81a9fbb(var_c4ba82be);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b81a9fbb
// Checksum 0x65d6855f, Offset: 0x3af0
// Size: 0x88
function function_b81a9fbb(var_26fbc878) {
    level endon(#"hash_d2197033");
    while (true) {
        self waittill(#"fire");
        v_end = self.origin + anglestoforward(self.angles) * 1000;
        magicbullet(var_26fbc878, self.origin, v_end);
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_241c1e7a
// Checksum 0xf7f5ef2, Offset: 0x3b80
// Size: 0x1e4
function function_241c1e7a(a_ents) {
    level notify(#"hash_d2197033");
    a_ents["apartment_igc_robot01"] ai::set_ignoreall(1);
    a_ents["apartment_igc_robot01"] ai::set_ignoreme(1);
    a_ents["apartment_igc_robot02"] ai::set_ignoreall(1);
    a_ents["apartment_igc_robot02"] ai::set_ignoreme(1);
    a_ents["apartment_igc_robot02"] setignorepauseworld(1);
    a_ents["apartment_igc_robot03"] ai::set_ignoreall(1);
    a_ents["apartment_igc_robot03"] ai::set_ignoreme(1);
    a_ents["apartment_igc_robot04"] ai::set_ignoreall(1);
    a_ents["apartment_igc_robot04"] ai::set_ignoreme(1);
    a_ents["apartment_igc_robot04"] setignorepauseworld(1);
    var_b2afdf94 = getent("nw_apt_breach_decals", "targetname");
    var_b2afdf94 show();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_397c0ec9
// Checksum 0x77d6bb35, Offset: 0x3d70
// Size: 0x14c
function function_397c0ec9(a_ents) {
    a_ents["chase_bomber_ai"] setignorepauseworld(1);
    a_ents["chase_bomber_ai"] waittill(#"freeze");
    var_71a9a72e = spawn("script_origin", (0, 0, 0));
    var_71a9a72e playloopsound("evt_time_freeze_loop", 0.5);
    setpauseworld(1);
    namespace_ce0e5f06::function_85d8906c();
    level waittill(#"hash_e58361f7");
    var_71a9a72e stoploopsound(0.5);
    var_71a9a72e delete();
    setpauseworld(0);
    namespace_ce0e5f06::function_3383b379();
    level thread scene::play("p7_fxanim_cp_newworld_chase_air_traffic_hunters_01_bundle");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8cdb5361
// Checksum 0x10eb5e26, Offset: 0x3ec8
// Size: 0x84
function function_8cdb5361(a_ents) {
    var_1c26230b = a_ents["taylor"];
    var_1c26230b setignorepauseworld(1);
    var_1c26230b ghost();
    var_1c26230b waittill(#"hash_f855e936");
    var_1c26230b thread namespace_ce0e5f06::function_c949a8ed(1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f28939ed
// Checksum 0xe8a95219, Offset: 0x3f58
// Size: 0x84
function rusherdefending(a_ents) {
    var_2dca8767 = a_ents["hall"];
    var_2dca8767 setignorepauseworld(1);
    var_2dca8767 ghost();
    var_2dca8767 waittill(#"hash_f855e936");
    var_2dca8767 show();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_617b7548
// Checksum 0x5460db6b, Offset: 0x3fe8
// Size: 0x7c
function function_617b7548(a_ents) {
    a_ents["apartment_igc_book"] setforcenocull();
    a_ents["apartment_igc_book"] sethighdetail(1);
    a_ents["apartment_igc_book"] setignorepauseworld(1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_98ec301e
// Checksum 0x242bc6f4, Offset: 0x4070
// Size: 0x4c
function function_98ec301e(a_ents) {
    var_1c26230b = a_ents["taylor"];
    var_1c26230b waittill(#"hash_32fc12d3");
    var_1c26230b thread namespace_ce0e5f06::function_4943984c();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6d1ffabf
// Checksum 0x5e8ff492, Offset: 0x40c8
// Size: 0x1a
function function_6d1ffabf(a_ents) {
    level notify(#"hash_6d1ffabf");
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_35d96059
// Checksum 0xab235569, Offset: 0x40f0
// Size: 0x464
function function_35d96059(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        function_62976d31();
        level thread scene::skipto_end("p7_fxanim_cp_newworld_chase_door_breach_bundle");
        level thread scene::skipto_end("p7_fxanim_cp_newworld_chase_window_break_bundle");
        level scene::init("cin_new_06_01_chase_vign_takedown");
        battlechatter::function_d9f49fba(0);
        load::function_a2995f22();
    }
    level thread function_92fdb1da();
    level.var_67e1f60e[0] = &function_3936e284;
    foreach (player in level.players) {
        player savegame::set_player_data("b_nw_accolade_11_failed", 0);
        player savegame::set_player_data("b_nw_accolade_12_failed", 0);
        player savegame::set_player_data("b_has_done_chase", 0);
    }
    util::delay(0.6, undefined, &namespace_ce0e5f06::function_3e37f48b, 0);
    callback::on_disconnect(&function_25e57b80);
    function_f423f05a(str_objective);
    trigger::use("chase_hall_start_color", undefined, undefined, 0);
    util::function_93831e79(str_objective);
    level thread function_fb28b377("chase_street_traffic_location3");
    level thread function_fb28b377("chase_street_traffic_location4");
    level thread namespace_e38c3c58::function_606b7b8();
    level.var_2dca8767 ai::set_ignoreall(1);
    level.var_2dca8767 ai::set_ignoreme(1);
    level thread function_6a59765b();
    level thread function_59e96bfa(var_74cd64bc);
    level thread function_11eee9db(str_objective);
    level thread function_ef62a489();
    level thread function_9c1b6d95();
    level thread function_28aaa11a(30);
    level flag::wait_till("apartment_jump_down");
    level thread function_cd5444f4();
    level flag::wait_till("bridge_collapse_start");
    level thread scene::play("p7_fxanim_cp_newworld_chase_air_traffic_hunters_03_bundle");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_62976d31
// Checksum 0x8afdc589, Offset: 0x4560
// Size: 0x24
function function_62976d31() {
    function_2a977ed8();
    function_22fba3d2();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9c1b6d95
// Checksum 0x306ef137, Offset: 0x4590
// Size: 0x54
function function_9c1b6d95() {
    trigger::wait_till("start_fxanim_hunter2");
    exploder::exploder_stop("cin_new_05_01_sun_on");
    level thread scene::play("p7_fxanim_cp_newworld_chase_air_traffic_hunters_02_bundle");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d29dd4ef
// Checksum 0xb5b9bb41, Offset: 0x45f0
// Size: 0xe4
function function_d29dd4ef() {
    self disableaimassist();
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::disable_pain();
    self ai::set_behavior_attribute("sprint", 1);
    self.overrideactordamage = &function_2204603a;
    self.goalradius = 16;
    self.script_objective = "chase_glass_ceiling_igc";
    self.var_69dd5d62 = 0;
    self.nocybercom = 1;
    self thread function_cf7f00d();
}

// Namespace namespace_36358f9c
// Params 13, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2204603a
// Checksum 0x1ab70624, Offset: 0x46e0
// Size: 0xd4
function function_2204603a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (isplayer(eattacker)) {
        eattacker thread function_9c291f73();
    } else {
        idamage = 0;
        return idamage;
    }
    idamage = int(idamage * 0.25);
    return idamage;
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cf7f00d
// Checksum 0xe1f5fc11, Offset: 0x47c0
// Size: 0x4c
function function_cf7f00d() {
    level endon(#"hash_c1a074c7");
    self waittill(#"death");
    level notify(#"hash_f584427c");
    util::function_207f8667(%CP_MI_ZURICH_NEWWORLD_SUSPECT_KILLED, %CP_MI_ZURICH_NEWWORLD_SUSPECT_KILLED_HINT);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_22fba3d2
// Checksum 0xc1e0d729, Offset: 0x4818
// Size: 0x34
function function_22fba3d2() {
    level scene::init("p7_fxanim_cp_newworld_bridge_collapse_bundle_init");
    util::wait_network_frame();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_67d7546
// Checksum 0x345ac39c, Offset: 0x4858
// Size: 0x6c
function function_67d7546() {
    self util::magic_bullet_shield();
    self setteam("allies");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_112af5d1
// Checksum 0x1a6907a3, Offset: 0x48d0
// Size: 0x64
function function_112af5d1() {
    level.var_79ddcc8b = spawner::simple_spawn_single("chase_hunter", &function_67d7546);
    level scene::init("p7_fxanim_cp_newworld_bridge_collapse_hunter_bundle", array(level.var_79ddcc8b));
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cd5444f4
// Checksum 0xdd171b8e, Offset: 0x4940
// Size: 0x1b4
function function_cd5444f4() {
    spawner::add_spawn_function_group("patio_robot", "script_noteworthy", &function_cdb6a55c);
    level thread function_480f8035();
    spawn_manager::enable("sm_patio_robots");
    spawn_manager::wait_till_complete("sm_patio_robots");
    var_f49fea10 = spawner::get_ai_group_ai("bar_2nd_floor_robot");
    foreach (ai in var_f49fea10) {
        level.var_2dca8767 setignoreent(ai, 1);
    }
    trigger::wait_till("bar_hall_uses_cybercore");
    var_64e85e6d = spawner::get_ai_group_ai("bar_1st_floor_robot");
    ai = array::random(var_64e85e6d);
    function_e1109a4f(array(ai));
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cdb6a55c
// Checksum 0xf63c43bb, Offset: 0x4b00
// Size: 0x44
function function_cdb6a55c() {
    self.script_accuracy = 0.1;
    self.health = int(self.health * 0.5);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x0
// namespace_36358f9c<file_0>::function_188e9064
// Checksum 0x71b88473, Offset: 0x4b50
// Size: 0x74
function function_188e9064() {
    level flag::wait_till("apartment_jump_down");
    var_7125f45d = struct::get_array("patio_glass_break", "targetname");
    array::thread_all(var_7125f45d, &function_8efffbca);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_92fdb1da
// Checksum 0x5f11746a, Offset: 0x4bd0
// Size: 0x10c
function function_92fdb1da() {
    var_edc6e0e1 = vehicle::simple_spawn_single("chase_air_traffic_start");
    var_edc6e0e1 thread vehicle::get_on_and_go_path(getvehiclenode(var_edc6e0e1.target, "targetname"));
    var_c49819b1 = vehicle::simple_spawn_single("chase_air_traffic_start2");
    var_c49819b1 thread vehicle::get_on_and_go_path(getvehiclenode(var_c49819b1.target, "targetname"));
    var_9e959f48 = vehicle::simple_spawn_single("chase_air_traffic_start3");
    var_9e959f48 thread vehicle::get_on_and_go_path(getvehiclenode(var_9e959f48.target, "targetname"));
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1c5d5613
// Checksum 0x3cb35b85, Offset: 0x4ce8
// Size: 0x24
function function_1c5d5613(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9a9ab34a
// Checksum 0x5786501a, Offset: 0x4d18
// Size: 0x168
function function_9a9ab34a() {
    self endon(#"death");
    self endon(#"hash_34427886");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self flag::init("sprint_tutorial");
    self thread function_778a3080();
    while (!self flag::get("sprint_tutorial")) {
        self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_SPRINT_TUTORIAL, 0, undefined, 4);
        self flag::wait_till_timeout(4, "sprint_tutorial");
        self thread util::hide_hint_text(1);
        if (!self flag::get("sprint_tutorial")) {
            self flag::wait_till_timeout(3, "sprint_tutorial");
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_778a3080
// Checksum 0x8048ec8d, Offset: 0x4e88
// Size: 0xb4
function function_778a3080() {
    self endon(#"death");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (true) {
        if (self issprinting()) {
            break;
        }
        wait(0.1);
    }
    self flag::set("sprint_tutorial");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x0
// namespace_36358f9c<file_0>::function_144ffd5
// Checksum 0x886c13ea, Offset: 0x4f48
// Size: 0x168
function function_144ffd5() {
    self endon(#"death");
    self endon(#"hash_34427886");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self flag::init("slide_tutorial");
    self thread function_5bef9ce1();
    while (!self flag::get("slide_tutorial")) {
        self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_SLIDE_TUTORIAL, 0, undefined, 4);
        self flag::wait_till_timeout(4, "slide_tutorial");
        self thread util::hide_hint_text(1);
        if (!self flag::get("slide_tutorial")) {
            self flag::wait_till_timeout(3, "slide_tutorial");
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_5bef9ce1
// Checksum 0x6a293273, Offset: 0x50b8
// Size: 0xb4
function function_5bef9ce1() {
    self endon(#"death");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (true) {
        if (self issliding()) {
            break;
        }
        wait(0.1);
    }
    self flag::set("slide_tutorial");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2a977ed8
// Checksum 0xcd18b3e7, Offset: 0x5178
// Size: 0x184
function function_2a977ed8() {
    function_18a473c0();
    scene::add_scene_func("cin_new_06_01_chase_vign_railing_civs_var01", &function_1efc629f, "done");
    scene::add_scene_func("cin_new_06_01_chase_vign_train_civs_var2", &function_1efc629f, "done");
    util::wait_network_frame();
    function_b497a9d3();
    util::wait_network_frame();
    function_42903a98();
    util::wait_network_frame();
    function_6892b501();
    util::wait_network_frame();
    function_8926ae16();
    util::wait_network_frame();
    function_ad5b66cd();
    util::wait_network_frame();
    function_1e8b5e92();
    util::wait_network_frame();
    function_14c4a966();
    util::wait_network_frame();
    function_6a341ec9();
    util::wait_network_frame();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_18a473c0
// Checksum 0x589a6462, Offset: 0x5308
// Size: 0x1ac
function function_18a473c0() {
    var_e8942d17 = spawner::simple_spawn_single("chase_bartender_civilian");
    var_e8942d17.var_a0f70d54 = level.var_88590003;
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_civ_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_bar_civ_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_bar_civ_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3);
    scene::add_scene_func("cin_new_06_01_chase_vign_bar_civs", &function_e2b3f312, "done");
    level thread scene::init("cin_new_06_01_chase_vign_cower", array(var_e8942d17));
    level thread scene::init("cin_new_06_01_chase_vign_bar_civs", a_ai);
    level thread function_5f1afc64();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_5f1afc64
// Checksum 0xc4223c4e, Offset: 0x54c0
// Size: 0x64
function function_5f1afc64() {
    trigger::wait_for_either("bartender_look_trigger", "bartender_touch_trigger");
    level thread scene::play("cin_new_06_01_chase_vign_cower");
    level thread scene::play("cin_new_06_01_chase_vign_bar_civs");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e2b3f312
// Checksum 0x11b84360, Offset: 0x5530
// Size: 0xe2
function function_e2b3f312(a_ents) {
    wait(0.05);
    var_368248f2 = getnode("chase_bar_upper_exit_near", "script_noteworthy");
    foreach (var_14c918e8 in a_ents) {
        if (isalive(var_14c918e8)) {
            var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b497a9d3
// Checksum 0xd4d17c9e, Offset: 0x5620
// Size: 0xfc
function function_b497a9d3() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_railing_civ_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_bar_railing_civ_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a);
    s_scene = struct::get("bar_railing_01", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_d66e3365();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d66e3365
// Checksum 0xb7d4e859, Offset: 0x5728
// Size: 0x24
function function_d66e3365() {
    level waittill(#"hash_991e4316");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_42903a98
// Checksum 0x8b23f338, Offset: 0x5758
// Size: 0xdc
function function_42903a98() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_railing_civ_3");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_railing_civ_4");
    a_ai = array(var_a61dbbf1, var_cc20365a);
    s_scene = struct::get("bar_railing_02", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_d0a73a33(a_ai);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d0a73a33
// Checksum 0x5f176543, Offset: 0x5840
// Size: 0xfe
function function_d0a73a33(a_ai) {
    level waittill(#"hash_287cc85e");
    self scene::play();
    foreach (ai in a_ai) {
        wait(randomfloatrange(1, 2));
        if (isalive(ai)) {
            ai dodamage(1, ai.origin);
            break;
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6892b501
// Checksum 0x1ff84146, Offset: 0x5948
// Size: 0xdc
function function_6892b501() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_railing_civ_5");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_railing_civ_6");
    a_ai = array(var_a61dbbf1, var_cc20365a);
    s_scene = struct::get("bar_railing_03", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_aaa4bfca(a_ai);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_aaa4bfca
// Checksum 0x79d86256, Offset: 0x5a30
// Size: 0x106
function function_aaa4bfca(a_ai) {
    level waittill(#"hash_287cc85e");
    wait(0.1);
    self scene::play();
    foreach (ai in a_ai) {
        wait(randomfloatrange(0.5, 1));
        if (isalive(ai)) {
            ai dodamage(1, ai.origin);
            break;
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1efc629f
// Checksum 0x305070a6, Offset: 0x5b40
// Size: 0xd2
function function_1efc629f(a_ents) {
    wait(0.05);
    var_368248f2 = getnode(self.target, "targetname");
    foreach (var_14c918e8 in a_ents) {
        if (isdefined(var_14c918e8)) {
            var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8926ae16
// Checksum 0xbf0be794, Offset: 0x5c20
// Size: 0x134
function function_8926ae16() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_group_civ_1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_group_civ_2");
    var_f222b0c3 = spawner::simple_spawn_single("chase_bar_group_civ_3");
    var_18252b2c = spawner::simple_spawn_single("chase_bar_group_civ_4");
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    s_scene = struct::get("chase_bar_group_civs_1", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_3fc15555();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3fc15555
// Checksum 0x82ccf966, Offset: 0x5d60
// Size: 0x24
function function_3fc15555() {
    level waittill(#"hash_991e4316");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ad5b66cd
// Checksum 0x4b8a0953, Offset: 0x5d90
// Size: 0x204
function function_ad5b66cd() {
    scene::add_scene_func("cin_new_06_01_chase_vign_bar_stand_civs_var1", &function_d8cfb628, "done");
    scene::add_scene_func("cin_new_06_01_chase_vign_bar_stand_civs_var2", &function_4ad72563, "done");
    var_a61dbbf1 = spawner::simple_spawn_single("chase_mid_bar_1");
    var_cc20365a = spawner::simple_spawn_single("chase_mid_bar_2");
    var_2c5d8c08 = array(var_a61dbbf1, var_cc20365a);
    var_6396997e = struct::get("mid_bar_scene_1", "targetname");
    var_6396997e thread scene::init(var_2c5d8c08);
    var_f222b0c3 = spawner::simple_spawn_single("chase_mid_bar_3");
    var_18252b2c = spawner::simple_spawn_single("chase_mid_bar_4");
    var_9e64fb43 = array(var_f222b0c3, var_18252b2c);
    var_3d941f15 = struct::get("mid_bar_scene_2", "targetname");
    var_3d941f15 thread scene::init(var_9e64fb43);
    level thread function_ffd8ef40(var_6396997e, var_3d941f15);
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ffd8ef40
// Checksum 0xbd33e7fe, Offset: 0x5fa0
// Size: 0x54
function function_ffd8ef40(var_6396997e, var_3d941f15) {
    level waittill(#"hash_66de346");
    var_6396997e thread scene::play();
    wait(0.1);
    var_3d941f15 thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1e8b5e92
// Checksum 0xe74c91a1, Offset: 0x6000
// Size: 0x1a4
function function_1e8b5e92() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_mid_bar_sitting01_civ1");
    var_cc20365a = spawner::simple_spawn_single("chase_mid_bar_sitting01_civ2");
    var_2c5d8c08 = array(var_a61dbbf1, var_cc20365a);
    var_6396997e = struct::get("chase_mid_bar_sitting01", "targetname");
    var_6396997e thread scene::init(var_2c5d8c08);
    var_f222b0c3 = spawner::simple_spawn_single("chase_mid_bar_sitting02_civ1");
    var_18252b2c = spawner::simple_spawn_single("chase_mid_bar_sitting02_civ2");
    var_9e64fb43 = array(var_f222b0c3, var_18252b2c);
    var_3d941f15 = struct::get("chase_mid_bar_sitting02", "targetname");
    var_3d941f15 thread scene::init(var_9e64fb43);
    level thread function_dc8a6a3(var_6396997e, var_3d941f15);
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_dc8a6a3
// Checksum 0x691b78b2, Offset: 0x61b0
// Size: 0x5c
function function_dc8a6a3(var_6396997e, var_3d941f15) {
    level waittill(#"hash_66de346");
    wait(0.25);
    var_6396997e thread scene::play();
    wait(0.1);
    var_3d941f15 thread scene::play();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d8cfb628
// Checksum 0x6bea4214, Offset: 0x6218
// Size: 0xd2
function function_d8cfb628(a_ents) {
    wait(0.05);
    var_368248f2 = getnode(self.target, "targetname");
    foreach (var_14c918e8 in a_ents) {
        if (isdefined(var_14c918e8)) {
            var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4ad72563
// Checksum 0xa2081b46, Offset: 0x62f8
// Size: 0x14a
function function_4ad72563(a_ents) {
    wait(0.05);
    var_792430f = getnode("chase_bar_near_exit", "script_noteworthy");
    var_958ad3d4 = getnode("mid_bar_exit_point", "script_noteworthy");
    foreach (var_14c918e8 in a_ents) {
        if (isdefined(var_14c918e8)) {
            if (issubstr(var_14c918e8.classname, "female")) {
                var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_792430f);
                continue;
            }
            var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_958ad3d4);
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_14c4a966
// Checksum 0xb301a190, Offset: 0x6450
// Size: 0x1b4
function function_14c4a966() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar__end_group_civ_1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar__end_group_civ_2");
    var_f222b0c3 = spawner::simple_spawn_single("chase_bar__end_group_civ_3");
    var_18252b2c = spawner::simple_spawn_single("chase_bar__end_group_civ_4");
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    foreach (ai in a_ai) {
        ai thread function_6bc2fd9b();
    }
    s_scene = struct::get("chase_bar_end_group_civs", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_ce90e373();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ce90e373
// Checksum 0x17080dd0, Offset: 0x6610
// Size: 0x44
function function_ce90e373() {
    level util::waittill_any("bridge_collapse_start", "bar_end_civs_alerted");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6a341ec9
// Checksum 0x1b12e190, Offset: 0x6660
// Size: 0x55c
function function_6a341ec9() {
    scene::add_scene_func("cin_new_06_01_chase_vign_sitting_civs_right", &function_1efc629f, "done");
    scene::add_scene_func("cin_new_06_01_chase_vign_sitting_civs_left", &function_1efc629f, "done");
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_sitting01_civ1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_sitting01_civ2");
    var_2c5d8c08 = array(var_a61dbbf1, var_cc20365a);
    foreach (ai in var_2c5d8c08) {
        ai thread function_6bc2fd9b();
    }
    var_6396997e = struct::get("chase_bar_sitting01", "targetname");
    var_6396997e thread scene::init(var_2c5d8c08);
    wait(0.1);
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_sitting02_civ1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_sitting02_civ2");
    var_9e64fb43 = array(var_a61dbbf1, var_cc20365a);
    foreach (ai in var_9e64fb43) {
        ai thread function_6bc2fd9b();
    }
    var_3d941f15 = struct::get("chase_bar_sitting02", "targetname");
    var_3d941f15 thread scene::init(var_9e64fb43);
    wait(0.1);
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_sitting03_civ1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_sitting03_civ2");
    var_786280da = array(var_a61dbbf1, var_cc20365a);
    foreach (ai in var_786280da) {
        ai thread function_6bc2fd9b();
    }
    var_1791a4ac = struct::get("chase_bar_sitting03", "targetname");
    var_1791a4ac thread scene::init(var_786280da);
    wait(0.1);
    var_a61dbbf1 = spawner::simple_spawn_single("chase_bar_sitting04_civ1");
    var_cc20365a = spawner::simple_spawn_single("chase_bar_sitting04_civ2");
    var_ea69f015 = array(var_a61dbbf1, var_cc20365a);
    foreach (ai in var_ea69f015) {
        ai thread function_6bc2fd9b();
    }
    var_f18f2a43 = struct::get("chase_bar_sitting04", "targetname");
    var_f18f2a43 thread scene::init(var_ea69f015);
    level thread function_790d18d8(var_6396997e, var_3d941f15, var_1791a4ac, var_f18f2a43);
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_790d18d8
// Checksum 0xa2a3d8f, Offset: 0x6bc8
// Size: 0xc4
function function_790d18d8(var_6396997e, var_3d941f15, var_1791a4ac, var_f18f2a43) {
    level util::waittill_any("bridge_collapse_start", "bar_end_civs_alerted");
    var_6396997e thread scene::play();
    wait(0.1);
    var_3d941f15 thread scene::play();
    wait(0.1);
    var_1791a4ac thread scene::play();
    wait(0.1);
    var_f18f2a43 thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6bc2fd9b
// Checksum 0x4c27dbac, Offset: 0x6c98
// Size: 0x52
function function_6bc2fd9b() {
    level endon(#"hash_9f036d3d");
    level endon(#"hash_9988f9e0");
    self util::waittill_any("bulletwhizby", "damage", "death");
    level notify(#"hash_9988f9e0");
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ec6ea2d4
// Checksum 0x886e8cf7, Offset: 0x6cf8
// Size: 0x1f4
function function_ec6ea2d4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        exploder::exploder_stop("cin_new_05_01_sun_on");
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        level.var_79ddcc8b = spawner::simple_spawn_single("chase_hunter", &function_67d7546);
        level thread scene::init("p7_fxanim_cp_newworld_bridge_collapse_bundle_init");
        level thread scene::skipto_end("p7_fxanim_cp_newworld_bridge_collapse_hunter_bundle", array(level.var_79ddcc8b), 0.85);
        load::function_a2995f22();
        namespace_ce0e5f06::function_3e37f48b(0);
        level thread function_11eee9db(str_objective);
        level thread function_ef62a489();
        level thread function_28aaa11a(30);
        callback::on_disconnect(&function_25e57b80);
    }
    level thread function_cd16f88c(0);
    level thread function_82467236();
    level waittill(#"hash_6a29494d");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9ca3cbaa
// Checksum 0x54481d47, Offset: 0x6ef8
// Size: 0x74
function function_9ca3cbaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    e_clip = getent("bridge_collapse_player_clip", "targetname");
    if (isdefined(e_clip)) {
        e_clip delete();
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2c789839
// Checksum 0xbb789dd1, Offset: 0x6f78
// Size: 0xb2
function function_2c789839() {
    scene::add_scene_func("p7_fxanim_cp_newworld_bridge_collapse_bundle", &function_1637aac6, "play");
    scene::add_scene_func("p7_fxanim_cp_newworld_bridge_collapse_bundle", &function_28e6c236, "play");
    level waittill(#"hash_511ddebd");
    level scene::play("p7_fxanim_cp_newworld_bridge_collapse_bundle", array(level.var_79ddcc8b));
    level notify(#"hash_6a29494d");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1637aac6
// Checksum 0x3bcc60ec, Offset: 0x7038
// Size: 0xb2
function function_1637aac6(a_ents) {
    foreach (index, ent in a_ents) {
        if (issubstr(index, "wasp")) {
            ent thread function_cba88b2();
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cba88b2
// Checksum 0x2a0e1f1b, Offset: 0x70f8
// Size: 0x4c
function function_cba88b2() {
    self endon(#"death");
    self waittill(#"hash_1637aac6");
    self ghost();
    wait(1);
    self delete();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_28e6c236
// Checksum 0xa9a40c84, Offset: 0x7150
// Size: 0xac
function function_28e6c236(a_ents) {
    level waittill(#"hash_741a928d");
    radiusdamage(a_ents["newworld_bridge_collapse_hunter"].origin, 850, 300, 20, level.var_88590003, "MOD_EXPLOSIVE");
    e_clip = getent("bridge_collapse_player_clip", "targetname");
    if (isdefined(e_clip)) {
        e_clip delete();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cd16f88c
// Checksum 0xf7a695eb, Offset: 0x7208
// Size: 0xbc
function function_cd16f88c(var_ef8c14b) {
    level endon(#"hash_75fed2c4");
    if (!var_ef8c14b) {
        trigger::wait_till("sarah_bridge_dropdown", undefined, undefined, 0);
    }
    scene::play("cin_new_07_01_bridge_collapse_traverse");
    var_9885044c = getnode("hall_post_bridge_goto", "targetname");
    level.var_2dca8767 setgoal(var_9885044c, 1);
    level thread function_4d159c1c();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4d159c1c
// Checksum 0xfc8d0319, Offset: 0x72d0
// Size: 0x94
function function_4d159c1c() {
    level flag::wait_till("hall_post_bridge_climb_scene");
    if (isdefined(level.var_6b7ee624)) {
        level thread [[ level.var_6b7ee624 ]]();
    }
    scene::play("cin_new_06_01_chase_vign_hall_traversal_bridge");
    if (!level flag::get("chase_post_bridge_climb_up")) {
        trigger::use("hall_post_traversal_bridge_colors");
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a507aa05
// Checksum 0x3cb5a892, Offset: 0x7370
// Size: 0x44
function function_a507aa05(var_64e85e6d) {
    level flag::wait_till("hall_use_systemoverload_post_bridge_collapse");
    function_e1109a4f(var_64e85e6d);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_82467236
// Checksum 0x34076c39, Offset: 0x73c0
// Size: 0x8a
function function_82467236() {
    foreach (player in level.activeplayers) {
        player thread function_10f68f8b();
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_10f68f8b
// Checksum 0x8939dd3b, Offset: 0x7458
// Size: 0x74
function function_10f68f8b() {
    self endon(#"death");
    level endon(#"hash_c1a074c7");
    trigger::wait_till("bridge_collapse_drop_down", "targetname", self);
    self enableinvulnerability();
    wait(2);
    self disableinvulnerability();
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_61decb2d
// Checksum 0x4c9dd50c, Offset: 0x74d8
// Size: 0x38c
function function_61decb2d(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        exploder::exploder_stop("cin_new_05_01_sun_on");
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        array::run_all(getentarray("collapse_bridge", "targetname"), &delete);
        load::function_a2995f22();
        namespace_ce0e5f06::function_3e37f48b(0);
        level thread function_cd16f88c(1);
        level thread function_82467236();
        level thread function_11eee9db(str_objective);
        level thread function_ef62a489();
        level thread function_c2c5155b();
        level thread function_28aaa11a(30);
        callback::on_disconnect(&function_25e57b80);
    } else {
        namespace_ce0e5f06::function_c1c980d8("chase_bar_enemy_culling");
    }
    vehicle::add_spawn_function("chase_wasp_mg", &function_694c9886);
    vehicle::add_spawn_function("chase_wasp_rocket", &function_694c9886);
    function_660e6b31(1);
    level thread function_2ac6fe38();
    level thread function_59153fc0();
    level thread function_34427886();
    level flag::init("train_station_start_gate_closed");
    level flag::init("train_station_end_gate_closed");
    level flag::init("chase_train_move");
    level thread function_4cd03714("trigger_chase_trains", "train_station_train_org", "train_station_train_start", "train_station_stop_train", "chase_trainstation_train_rumble", 0, 1, 1);
    function_77e81fa3();
    function_e8d2d7d8(1);
    function_e8d2d7d8(2);
    function_e8d2d7d8(3);
    function_8c82b44d(1);
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_18f0e437
// Checksum 0x127eb4a, Offset: 0x7870
// Size: 0x24
function function_18f0e437(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_75fed2c4
// Checksum 0x183a6d4f, Offset: 0x78a0
// Size: 0x9c
function function_75fed2c4() {
    trigger::wait_till("hall_train_station_wallrun");
    level.var_2dca8767 namespace_ce0e5f06::function_d0aa2f4f();
    level thread scene::play("cin_new_06_02_chase_vign_wallrun");
    level notify(#"hash_75fed2c4");
    trigger::use("hall_post_train_station_wallrun_color_trigger", "targetname");
    level thread function_33cb6df1();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_59153fc0
// Checksum 0x9955d27f, Offset: 0x7948
// Size: 0x182
function function_59153fc0() {
    level waittill(#"hash_fb8f6850");
    level notify(#"hash_210f1e22");
    namespace_ce0e5f06::function_3e37f48b(1);
    level.var_ebe3b234 = 1;
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player namespace_d00ec32::function_c219b381();
        player namespace_d00ec32::function_a724d44("cybercom_systemoverload", 0);
        player namespace_d00ec32::function_eb512967("cybercom_systemoverload", 1);
        player thread namespace_ce0e5f06::function_6062e90("cybercom_systemoverload", 0, "stop_systemoverload_tutorial", 1, "CP_MI_ZURICH_NEWWORLD_SYSTEM_PARALYSIS_TARGET", "CP_MI_ZURICH_NEWWORLD_SYSTEM_PARALYSIS_RELEASE");
        player thread function_a69280be("cybercom_systemoverload", 0);
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_34427886
// Checksum 0xfbe329ac, Offset: 0x7ad8
// Size: 0xaa
function function_34427886() {
    foreach (player in level.activeplayers) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread function_3a5a4e5e();
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3a5a4e5e
// Checksum 0xa573d8cd, Offset: 0x7b90
// Size: 0x198
function function_3a5a4e5e() {
    self endon(#"death");
    level endon(#"hash_210f1e22");
    trigger::wait_till("high_mantle_tutorial", "targetname", self);
    self notify(#"hash_34427886");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self flag::init("high_mantle_tutorial");
    self thread function_87127ac4();
    while (!self flag::get("high_mantle_tutorial")) {
        self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_MANTLE_TUTORIAL, 0, undefined, 4);
        self flag::wait_till_timeout(4, "high_mantle_tutorial");
        self thread util::hide_hint_text(1);
        if (!self flag::get("high_mantle_tutorial")) {
            self flag::wait_till_timeout(3, "high_mantle_tutorial");
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_87127ac4
// Checksum 0x85d362b3, Offset: 0x7d30
// Size: 0x3c
function function_87127ac4() {
    self endon(#"death");
    self waittill(#"mantle_start");
    self flag::set("high_mantle_tutorial");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_33cb6df1
// Checksum 0xf092d56b, Offset: 0x7d78
// Size: 0x5c
function function_33cb6df1() {
    level endon(#"hash_de039dbd");
    trigger::wait_till("hall_old_zurich_traversal");
    level thread scene::play("cin_new_06_01_chase_vign_hall_traversal_train");
    level thread function_83d6701();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_77e81fa3
// Checksum 0x71270679, Offset: 0x7de0
// Size: 0x74
function function_77e81fa3() {
    spawner::add_spawn_function_group("train_station_cafe_civs", "targetname", &function_97ed9674);
    level thread function_be23c07c();
    level thread function_75fed2c4();
    function_64c3236();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_64c3236
// Checksum 0x17c9f35b, Offset: 0x7e60
// Size: 0x1a4
function function_64c3236() {
    scene::add_scene_func("cin_new_06_01_chase_vign_train_civs", &function_c9f8e2cd, "play");
    scene::remove_scene_func("cin_new_06_01_chase_vign_train_civs_var2", &function_1efc629f, "done");
    scene::add_scene_func("cin_new_06_01_chase_vign_train_civs_var2", &function_c9f8e2cd, "play");
    scene::add_scene_func("cin_new_06_01_chase_vign_ticket_civ_group_left", &function_c9f8e2cd, "play");
    function_a22441fa();
    util::wait_network_frame();
    function_2c90def0();
    util::wait_network_frame();
    function_1626a1fa();
    util::wait_network_frame();
    function_e246b288();
    util::wait_network_frame();
    function_1a503ca4();
    util::wait_network_frame();
    function_d0faa80();
    util::wait_network_frame();
    function_8a7ecd4d();
    util::wait_network_frame();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e246b288
// Checksum 0x2923e2fe, Offset: 0x8010
// Size: 0x17c
function function_e246b288() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_trainstation_civ_scene_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_trainstation_civ_scene_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_trainstation_civ_scene_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_trainstation_civ_scene_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    scene::add_scene_func("cin_new_06_01_chase_vign_train_civs", &function_c9f8e2cd, "play");
    level thread scene::init("cin_new_06_01_chase_vign_train_civs", a_ai);
    level thread function_df331f0b();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_df331f0b
// Checksum 0xd76c99c, Offset: 0x8198
// Size: 0x2c
function function_df331f0b() {
    level waittill(#"hash_5367d5ab");
    level thread scene::play("cin_new_06_01_chase_vign_train_civs");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1626a1fa
// Checksum 0x7e2cc354, Offset: 0x81d0
// Size: 0x174
function function_1626a1fa() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_trainstation_civ_ped_walkway_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_trainstation_civ_ped_walkway_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_trainstation_civ_ped_walkway_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_trainstation_civ_ped_walkway_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    s_scene = struct::get("train_civs_pedestrian_bridge", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_67c85dcf();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_67c85dcf
// Checksum 0xa9ff8c57, Offset: 0x8350
// Size: 0x24
function function_67c85dcf() {
    level waittill(#"hash_a6d0e6f3");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1a503ca4
// Checksum 0x15345178, Offset: 0x8380
// Size: 0x174
function function_1a503ca4() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_trainstation_civ_near_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_trainstation_civ_near_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_trainstation_civ_near_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_trainstation_civ_near_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    s_scene = struct::get("train_civs_near_group", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_79da4b91();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_79da4b91
// Checksum 0x4aefe2f6, Offset: 0x8500
// Size: 0x24
function function_79da4b91() {
    level waittill(#"hash_64ab138");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d0faa80
// Checksum 0x5450824d, Offset: 0x8530
// Size: 0x174
function function_d0faa80() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_trainstation_civ_wallrun_end_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_trainstation_civ_wallrun_end_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_trainstation_civ_wallrun_end_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_trainstation_civ_wallrun_end_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    s_scene = struct::get("train_civs_wallrun_end", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_cde8399();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cde8399
// Checksum 0x56f980c6, Offset: 0x86b0
// Size: 0x24
function function_cde8399() {
    level waittill(#"hash_796ee858");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c9f8e2cd
// Checksum 0x634d9356, Offset: 0x86e0
// Size: 0xca
function function_c9f8e2cd(a_ents) {
    var_368248f2 = getnode(self.target, "targetname");
    foreach (var_14c918e8 in a_ents) {
        if (isdefined(var_14c918e8)) {
            var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a22441fa
// Checksum 0x27d12c5c, Offset: 0x87b8
// Size: 0x33a
function function_a22441fa() {
    scene::add_scene_func("cin_new_06_01_chase_vign_ticket_civ_female", &function_bff4697e, "done");
    scene::add_scene_func("cin_new_06_01_chase_vign_ticket_civ_male", &function_bff4697e, "done");
    a_s_scene = struct::get_array("ticket_civ_male", "targetname");
    foreach (s_scene in a_s_scene) {
        ai = spawner::simple_spawn_single("ticket_civ_male");
        ai.var_a0f70d54 = level.var_88590003;
        s_scene scene::init(array(ai));
        if (s_scene.script_noteworthy === "ticket_civs_01") {
            s_scene thread function_76abdc5e(ai);
            continue;
        }
        if (s_scene.script_noteworthy === "ticket_civs_02") {
            s_scene thread function_50a961f5(ai);
        }
    }
    util::wait_network_frame();
    a_s_scene = struct::get_array("ticket_civ_female", "targetname");
    foreach (s_scene in a_s_scene) {
        ai = spawner::simple_spawn_single("ticket_civ_female");
        ai.var_a0f70d54 = level.var_88590003;
        s_scene scene::init(array(ai));
        if (s_scene.script_noteworthy === "ticket_civs_01") {
            s_scene thread function_76abdc5e(ai);
            continue;
        }
        if (s_scene.script_noteworthy === "ticket_civs_02") {
            s_scene thread function_50a961f5(ai);
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_76abdc5e
// Checksum 0x76c49547, Offset: 0x8b00
// Size: 0x6c
function function_76abdc5e(ai) {
    level waittill(#"hash_1fae4afe");
    wait(randomfloatrange(0.1, 0.5));
    if (isalive(ai)) {
        self thread scene::play();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_50a961f5
// Checksum 0xecfe0cdd, Offset: 0x8b78
// Size: 0x6c
function function_50a961f5(ai) {
    level waittill(#"hash_c589911");
    wait(randomfloatrange(0.1, 0.5));
    if (isalive(ai)) {
        self thread scene::play();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_bff4697e
// Checksum 0x7cf73fa8, Offset: 0x8bf0
// Size: 0xf2
function function_bff4697e(a_ents) {
    wait(0.05);
    foreach (var_14c918e8 in a_ents) {
        if (isalive(var_14c918e8)) {
            if (isdefined(self.target)) {
                var_368248f2 = getnode(self.target, "targetname");
                var_14c918e8 thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
            }
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8a7ecd4d
// Checksum 0xea82b306, Offset: 0x8cf0
// Size: 0x134
function function_8a7ecd4d() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_trainstation_civ_ticket_line_1");
    var_cc20365a = spawner::simple_spawn_single("chase_trainstation_civ_ticket_line_2");
    var_f222b0c3 = spawner::simple_spawn_single("chase_trainstation_civ_ticket_line_3");
    var_18252b2c = spawner::simple_spawn_single("chase_trainstation_civ_ticket_line_4");
    a_ai = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    s_scene = struct::get("chase_trainstation_ticket_line", "targetname");
    s_scene thread scene::init(a_ai);
    s_scene thread function_437b4c76();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_437b4c76
// Checksum 0x410ee19b, Offset: 0x8e30
// Size: 0x24
function function_437b4c76() {
    level waittill(#"hash_d4e3672a");
    self thread scene::play();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_97ed9674
// Checksum 0x8d6632d9, Offset: 0x8e60
// Size: 0xd4
function function_97ed9674() {
    self endon(#"death");
    self ai::set_behavior_attribute("panic", 1);
    for (var_9de10fe3 = getnode(self.target, "targetname"); isdefined(var_9de10fe3); var_9de10fe3 = undefined) {
        self waittill(#"goal");
        if (isdefined(var_9de10fe3.target)) {
            var_9de10fe3 = getnode(var_9de10fe3.target, "targetname");
            continue;
        }
    }
    namespace_ce0e5f06::function_523cdc93(0);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2c90def0
// Checksum 0x11a8669a, Offset: 0x8f40
// Size: 0x34
function function_2c90def0() {
    function_205aeba5();
    util::wait_network_frame();
    function_465d660e();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_205aeba5
// Checksum 0xa571ad6d, Offset: 0x8f80
// Size: 0x28c
function function_205aeba5() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_civilian_elevator1_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_civilian_elevator1_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_civilian_elevator1_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_civilian_elevator1_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    var_7545bc63 = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    e_elevator = getent("station_elevator_01", "targetname");
    e_elevator.origin += (0, 0, 274);
    e_elevator setmovingplatformenabled(1);
    var_8c7e827f = getent("station_elevator_door_top_left", "targetname");
    var_5548791a = getent("station_elevator_door_top_right", "targetname");
    var_8c7e827f movey(38, 0.25);
    var_5548791a movey(-38, 0.25);
    s_scene = struct::get("chase_train_elevator1", "targetname");
    s_scene thread scene::init(var_7545bc63);
    level thread function_e235be84(var_7545bc63, s_scene);
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e235be84
// Checksum 0x9d458fc4, Offset: 0x9218
// Size: 0x114
function function_e235be84(var_7545bc63, s_scene) {
    trigger::wait_till("chase_elevator_trigger");
    var_368248f2 = getnode("train_station_securtiy_checkpoint", "script_noteworthy");
    foreach (ai in var_7545bc63) {
        if (isalive(ai)) {
            ai thread function_37c7fee2(var_368248f2);
        }
    }
    s_scene scene::play(var_7545bc63);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_465d660e
// Checksum 0x395d3589, Offset: 0x9338
// Size: 0x1ec
function function_465d660e() {
    var_a61dbbf1 = spawner::simple_spawn_single("chase_civilian_elevator2_1");
    var_a61dbbf1.var_a0f70d54 = level.var_88590003;
    var_cc20365a = spawner::simple_spawn_single("chase_civilian_elevator2_2");
    var_cc20365a.var_a0f70d54 = level.var_88590003;
    var_f222b0c3 = spawner::simple_spawn_single("chase_civilian_elevator2_3");
    var_f222b0c3.var_a0f70d54 = level.var_88590003;
    var_18252b2c = spawner::simple_spawn_single("chase_civilian_elevator2_4");
    var_18252b2c.var_a0f70d54 = level.var_88590003;
    var_7545bc63 = array(var_a61dbbf1, var_cc20365a, var_f222b0c3, var_18252b2c);
    e_elevator = getent("station_elevator_02", "targetname");
    e_elevator.origin += (0, 0, 224);
    e_elevator setmovingplatformenabled(1);
    s_scene = struct::get("chase_train_elevator2", "targetname");
    s_scene thread scene::init(var_7545bc63);
    level thread function_543d2dbf(e_elevator, var_7545bc63, s_scene);
}

// Namespace namespace_36358f9c
// Params 3, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_543d2dbf
// Checksum 0x8784a550, Offset: 0x9530
// Size: 0x1f4
function function_543d2dbf(e_elevator, var_7545bc63, s_scene) {
    level waittill(#"hash_b112b97b");
    e_elevator movez(70, 2);
    e_elevator waittill(#"movedone");
    var_8c7e827f = getent("chase_elevator_2_door_upper_left", "targetname");
    var_5548791a = getent("chase_elevator_2_door_upper_right", "targetname");
    var_8c7e827f movex(38, 0.25);
    var_5548791a movex(-38, 0.25);
    var_5548791a waittill(#"movedone");
    var_368248f2 = getnode("train_station_right_side_exit", "script_noteworthy");
    foreach (ai in var_7545bc63) {
        if (isalive(ai)) {
            ai thread function_37c7fee2(var_368248f2);
        }
    }
    s_scene scene::play(var_7545bc63);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_37c7fee2
// Checksum 0x145919f7, Offset: 0x9730
// Size: 0xc4
function function_37c7fee2(var_368248f2) {
    self endon(#"death");
    self waittill(#"hash_7003d0a");
    if (isalive(self)) {
        if (self.targetname == "chase_civilian_elevator2_3_ai" || self.targetname == "chase_civilian_elevator1_3_ai") {
            self setgoal(self.origin);
            self ai::set_behavior_attribute("panic", 1);
            return;
        }
        self thread namespace_b78a5cd7::function_3840d81a(var_368248f2);
    }
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a7ce33a6
// Checksum 0xda746078, Offset: 0x9800
// Size: 0x3ac
function function_a7ce33a6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_ebe3b234 = 1;
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        e_clip = getent("train_ped_blocker_clip", "targetname");
        e_clip delete();
        exploder::exploder_stop("cin_new_05_01_sun_on");
        level flag::init("chase_train_move");
        spawner::add_spawn_function_group("train_station_cafe_civs", "targetname", &function_97ed9674);
        array::run_all(getentarray("collapse_bridge", "targetname"), &delete);
        vehicle::add_spawn_function("chase_wasp_mg", &function_694c9886);
        vehicle::add_spawn_function("chase_wasp_rocket", &function_694c9886);
        function_93cf0e75(1);
        function_e8d2d7d8(2);
        function_e8d2d7d8(3);
        level thread function_8c82b44d(2);
        scene::skipto_end("p7_fxanim_cp_newworld_chase_wasp_billboard_bundle");
        trigger::use("hall_colors_train_station_end");
        load::function_a2995f22();
        level thread function_660e6b31(1);
        level thread function_33cb6df1();
        level thread function_cd5f4644(var_74cd64bc);
        level thread function_11eee9db(str_objective);
        level thread function_ef62a489();
        level thread function_28aaa11a(30);
        callback::on_disconnect(&function_25e57b80);
        level thread function_b453eaab();
        level.var_67e1f60e[0] = &function_3936e284;
    }
    level thread function_699bfff1(1);
    level thread function_3960c46e();
    level thread function_fb28b377("chase_street_traffic_location1");
    level thread function_fb28b377("chase_street_traffic_location2");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_83d6701
// Checksum 0xa94bd19a, Offset: 0x9bb8
// Size: 0x44
function function_83d6701() {
    level endon(#"hash_de039dbd");
    trigger::wait_till("hall_pre_slide_color_trigger");
    level thread scene::play("cin_new_06_01_chase_vign_hall_traversal_rooftops");
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4d063e30
// Checksum 0x7e07e7ac, Offset: 0x9c08
// Size: 0x24
function function_4d063e30(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_af48bb3e
// Checksum 0x155a569a, Offset: 0x9c38
// Size: 0x2f4
function function_af48bb3e(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_ebe3b234 = 1;
        exploder::exploder_stop("cin_new_05_01_sun_on");
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        level flag::init("chase_train_move");
        level thread function_699bfff1(1);
        level thread function_660e6b31(1);
        array::run_all(getentarray("collapse_bridge", "targetname"), &delete);
        array::run_all(getentarray("chase_train_b", "targetname"), &delete);
        function_93cf0e75(1);
        function_93cf0e75(2);
        function_93cf0e75(3);
        load::function_a2995f22();
        level thread function_b453eaab();
        level thread function_3960c46e();
        level thread function_11eee9db(str_objective);
        level thread function_ef62a489();
        level thread function_28aaa11a(30);
        callback::on_disconnect(&function_25e57b80);
        trigger::use("hall_pre_slide_color_trigger");
    } else {
        namespace_ce0e5f06::function_c1c980d8("chase_old_zurich_enemy_culling");
    }
    spawner::add_spawn_function_group("chase_construction_site_robots", "script_noteworthy", &function_9d580310);
    level thread scene::init("p7_fxanim_cp_newworld_chase_glass_roof_bundle");
    function_2dccd8();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9d580310
// Checksum 0x64b55ca, Offset: 0x9f38
// Size: 0x4c
function function_9d580310() {
    self endon(#"death");
    self.health = int(self.health * 0.5);
    self.script_accuracy = 0.25;
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2dccd8
// Checksum 0xf2cfc415, Offset: 0x9f90
// Size: 0x54
function function_2dccd8() {
    level thread function_6a5889b8();
    level thread function_40a5f97b();
    function_d1512fd8();
    function_f2f82114();
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2f1ed218
// Checksum 0xe858da75, Offset: 0x9ff0
// Size: 0x4c
function function_2f1ed218(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"hash_97eba3fd");
    objectives::complete("cp_level_newworld_rooftop_chase");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3960c46e
// Checksum 0xb462ad5b, Offset: 0xa048
// Size: 0x74
function function_3960c46e() {
    scene::add_scene_func("cin_new_06_01_chase_vign_construction_civs", &function_aec9f1d7, "init");
    scene::init("cin_new_06_01_chase_vign_construction_civs");
    level waittill(#"hash_b1604833");
    scene::play("cin_new_06_01_chase_vign_construction_civs");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_aec9f1d7
// Checksum 0x4027da05, Offset: 0xa0c8
// Size: 0x6c
function function_aec9f1d7(a_ents) {
    a_ents["chase_construction_scene_civ_1"] thread function_6d6e8e77(a_ents["construction_civs_clipboard"]);
    a_ents["chase_construction_scene_civ_3"] thread function_6d6e8e77(a_ents["construction_civs_mug"]);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6d6e8e77
// Checksum 0x56ebb98b, Offset: 0xa140
// Size: 0x2c
function function_6d6e8e77(e_prop) {
    self waittill(#"death");
    e_prop delete();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d1512fd8
// Checksum 0x319ee17f, Offset: 0xa178
// Size: 0x21c
function function_d1512fd8() {
    level endon(#"hash_ad84c994");
    level thread function_68490836();
    level flag::wait_till("teleport_hall_at_slide");
    var_13a78b8b = getnode("teleport_hall_at_slide_node", "targetname");
    level.var_2dca8767 namespace_ce0e5f06::function_d0aa2f4f();
    level notify(#"hash_de039dbd");
    level.var_2dca8767 stopanimscripted();
    level scene::stop("cin_new_06_01_chase_vign_hall_traversal_train");
    level scene::stop("cin_new_06_01_chase_vign_hall_traversal_rooftops");
    level.var_2dca8767 forceteleport(var_13a78b8b.origin, var_13a78b8b.angles, 0, 1);
    level.var_2dca8767 setgoal(var_13a78b8b, 1);
    util::wait_network_frame();
    level.var_2dca8767 namespace_ce0e5f06::function_c949a8ed();
    level.var_2dca8767.goalradius = 32;
    var_fab95496 = getnode("hall_post_slide", "targetname");
    level.var_2dca8767 setgoal(var_fab95496, 1);
    level.var_2dca8767 util::waittill_either("goal", "near_goal");
    trigger::use("hall_construction_site_color_trigger");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_68490836
// Checksum 0xacce809, Offset: 0xa3a0
// Size: 0x24a
function function_68490836() {
    trigger::wait_till("spawn_construction_site_enemies");
    util::wait_network_frame();
    a_ai = spawner::get_ai_group_ai("construction_site_upper_level");
    foreach (ai in a_ai) {
        level.var_2dca8767 setignoreent(ai, 1);
    }
    a_ai = spawner::get_ai_group_ai("construction_site_initial_left");
    foreach (ai in a_ai) {
        ai thread function_7b0aac1e();
    }
    trigger::wait_till("spawn_construction_site_enemies_2");
    util::wait_network_frame();
    a_ai = spawner::get_ai_group_ai("construction_site_upper_level");
    foreach (ai in a_ai) {
        level.var_2dca8767 setignoreent(ai, 1);
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_7b0aac1e
// Checksum 0x246e0bb7, Offset: 0xa5f8
// Size: 0x4c
function function_7b0aac1e() {
    self endon(#"death");
    trigger::wait_till("construction_site_left_wallrun");
    function_e1109a4f(array(self));
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f2f82114
// Checksum 0xc3605629, Offset: 0xa650
// Size: 0x3c
function function_f2f82114() {
    trigger::wait_till("hall_construction_site_beckon");
    level thread scene::play("cin_new_08_01_rooftops_vign_beckon");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6a5889b8
// Checksum 0x9c915584, Offset: 0xa698
// Size: 0x54
function function_6a5889b8() {
    var_7125f45d = struct::get_array("construction_glass_break", "targetname");
    array::thread_all(var_7125f45d, &function_8efffbca);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_40a5f97b
// Checksum 0x5b8be3cd, Offset: 0xa6f8
// Size: 0x44
function function_40a5f97b() {
    level thread function_4cd03714("start_construction_site_train", "construction_train_org", "construction_train_start", "stop_construction_site_train", "chase_construction_train_rumble", 1);
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9262d885
// Checksum 0xa6952c6b, Offset: 0xa748
// Size: 0x254
function function_9262d885(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        exploder::exploder_stop("cin_new_05_01_sun_on");
        level.var_ebe3b234 = 1;
        level.var_88590003 = spawner::simple_spawn_single("chase_bomber", &function_d29dd4ef);
        function_f423f05a(str_objective);
        level thread function_ef62a489();
        level thread function_699bfff1(1);
        level thread function_660e6b31(1);
        level thread scene::play("cin_new_08_01_rooftops_vign_beckon");
        scene::init("p7_fxanim_cp_newworld_chase_glass_roof_bundle");
        load::function_a2995f22();
        level thread function_28aaa11a(30);
        callback::on_disconnect(&function_25e57b80);
        level thread function_ea7bace5(1);
    } else {
        namespace_ce0e5f06::function_c1c980d8("chase_construction_site_enemy_culling");
    }
    level.var_67e1f60e[0] = undefined;
    level thread namespace_ce0e5f06::function_30ec5bf7();
    level notify(#"hash_29e8e5f2");
    level notify(#"hash_ad84c994");
    battlechatter::function_d9f49fba(0);
    level thread function_fa7f41e5();
    level waittill(#"hash_46308f6f");
    level notify(#"hash_bdb23e9d");
    skipto::function_be8adfb8(str_objective);
    level clientfield::set("set_fog_bank", 0);
}

// Namespace namespace_36358f9c
// Params 4, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_500cd65f
// Checksum 0x76b89129, Offset: 0xa9a8
// Size: 0x30c
function function_500cd65f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    foreach (player in level.players) {
        player savegame::set_player_data("b_has_done_chase", 1);
    }
    level flag::set("chase_done");
    level notify(#"hash_3d00ae0c");
    callback::remove_on_disconnect(&function_25e57b80);
    function_b83ef318();
    e_door = getent("chase_door_breach", "targetname");
    if (isdefined(e_door)) {
        e_door delete();
    }
    var_378eee5b = getent("newworld_chase_window_break_", "targetname");
    if (isdefined(var_378eee5b)) {
        var_378eee5b delete();
    }
    scene::stop("p7_fxanim_gp_wasp_tower_flaps_bundle", 1);
    scene::stop("p7_fxanim_gp_wasp_tower_arms_01_bundle", 1);
    scene::stop("p7_fxanim_gp_wasp_tower_arms_02_bundle", 1);
    scene::stop("p7_fxanim_gp_wasp_tower_arms_03_bundle", 1);
    scene::stop("p7_fxanim_gp_wasp_tower_arms_04_bundle", 1);
    scene::stop("p7_fxanim_cp_newworld_chase_wasp_billboard_bundle", 1);
    e_clip = getent("chase_wasp_billboard_clip", "targetname");
    e_clip delete();
    var_b2afdf94 = getent("nw_apt_breach_decals", "targetname");
    var_b2afdf94 delete();
    objectives::set("cp_level_newworld_underground_locate_terrorist");
    function_776190fe();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_776190fe
// Checksum 0x485c29bd, Offset: 0xacc0
// Size: 0x5dc
function function_776190fe() {
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_door_breach_bundle");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_1st_sh010");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh020");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh030");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh040");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh050");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh060");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh070");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh080");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh090");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh100");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh110");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh120");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_3rd_sh130");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_05_01_apartmentbreach_1st_sh140");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_window_break_bundle");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_cower");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_bar_civs");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_railing_civs_var01");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_train_civs_var2");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_bar_stand_civs_var1");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_bar_stand_civs_var2");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_sitting_civs_right");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_sitting_civs_left");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_bridge_collapse_bundle");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_07_01_bridge_collapse_traverse");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_hall_traversal_bridge");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_02_chase_vign_wallrun");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_hall_traversal_train");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_train_civs");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_ticket_civ_female");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_ticket_civ_male");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_ticket_civ_group_left");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_elevator_civs");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_hall_traversal_rooftops");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_beckon");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_flee");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_encounter020");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_device");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter050");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter070");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter070_end");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter080");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter090");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter100");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter110");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_08_01_rooftops_vign_encounter120");
    namespace_ce0e5f06::function_bbd12ed2("cin_gen_melee_robot_hits_civ");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_06_01_chase_vign_takedown");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_gp_wasp_tower_flaps_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_gp_wasp_tower_arms_01_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_gp_wasp_tower_arms_02_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_gp_wasp_tower_arms_03_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_gp_wasp_tower_arms_04_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_wasp_billboard_bundle");
    wait(3);
    namespace_ce0e5f06::function_bbd12ed2("cin_new_09_01_glassceiling_1st_tackle_part01");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_09_01_glassceiling_1st_tackle_part01a");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_09_01_glassceiling_1st_tackle_part02");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_glass_roof_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_air_traffic_hunters_01_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_air_traffic_hunters_02_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_chase_air_traffic_hunters_03_bundle");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_fa7f41e5
// Checksum 0x37e0b821, Offset: 0xb2a8
// Size: 0x39c
function function_fa7f41e5() {
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part01", &function_8f838402, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part01", &function_92556ff1, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part01", &function_7ad5702a, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part01a", &function_3b3a0120, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part01a", &namespace_ce0e5f06::function_43dfaf16, "skip_started");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part02", &function_4c248a91, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part02", &function_d081fcc5, "play");
    scene::add_scene_func("cin_new_09_01_glassceiling_1st_tackle_part02", &function_47edd0a5);
    scene::add_scene_func("p7_fxanim_cp_newworld_chase_glass_roof_bundle", &function_920e3893, "play");
    level thread function_bc6c3aa5();
    var_5b5cfed1 = getent("start_glass_ceiling_igc", "targetname");
    level.var_f2a5cb1e = var_5b5cfed1;
    while (true) {
        ent = var_5b5cfed1 waittill(#"trigger");
        if (isplayer(ent)) {
            level thread function_3174cbb();
            level notify(#"hash_a70b0538");
            break;
        }
    }
    level thread function_bc6c3aa5();
    if (isdefined(ent)) {
        ent player::take_weapons();
    }
    wait(0.625);
    if (scene::is_playing("cin_new_08_01_rooftops_vign_encounter120")) {
        scene::stop("cin_new_08_01_rooftops_vign_encounter120");
    }
    if (isdefined(ent)) {
        ent player::give_back_weapons();
    }
    level notify(#"hash_c1a074c7");
    level thread function_382f4206();
    if (isdefined(level.var_c6980f01)) {
        level thread [[ level.var_c6980f01 ]]();
    }
    level thread namespace_e38c3c58::function_f4a6634b();
    level.var_88590003 clientfield::set("chase_suspect_fx", 0);
    level thread scene::play("p7_fxanim_cp_newworld_chase_glass_roof_bundle");
    level scene::play("cin_new_09_01_glassceiling_1st_tackle_part01", ent);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_47edd0a5
// Checksum 0x4d937604, Offset: 0xb650
// Size: 0x5c
function function_47edd0a5(a_ents) {
    a_ents["player 1"] waittill(#"fade_out");
    level flag::set("infinite_white_transition");
    namespace_ce0e5f06::function_2eded728(0);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_bc6c3aa5
// Checksum 0xa39fc68e, Offset: 0xb6b8
// Size: 0x64
function function_bc6c3aa5() {
    if (scene::is_playing("cin_new_08_01_rooftops_vign_encounter120")) {
        level waittill(#"hash_7f4315eb");
    }
    level.var_88590003 show();
    level scene::init("cin_new_09_01_glassceiling_1st_tackle_part01");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8f838402
// Checksum 0x275e7eb8, Offset: 0xb728
// Size: 0x8c
function function_8f838402(a_ents) {
    a_ents["chase_bomber_ai"] show();
    a_ents["hall"] ghost();
    a_ents["hall"] waittill(#"hash_f855e936");
    a_ents["hall"] thread namespace_ce0e5f06::function_c949a8ed(1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_92556ff1
// Checksum 0xc732d223, Offset: 0xb7c0
// Size: 0xbc
function function_92556ff1(a_ents) {
    a_ents["hall"] setignorepauseworld(1);
    a_ents["chase_bomber_ai"] setignorepauseworld(1);
    a_ents["player 1"] waittill(#"freeze");
    setpauseworld(1);
    a_ents["player 1"] waittill(#"unfreeze");
    setpauseworld(0);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_7ad5702a
// Checksum 0x3db443a6, Offset: 0xb888
// Size: 0x3c
function function_7ad5702a(a_ents) {
    level waittill(#"hash_6b9e8dcb");
    level clientfield::set("set_fog_bank", 2);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3b3a0120
// Checksum 0xc16315f0, Offset: 0xb8d0
// Size: 0x74
function function_3b3a0120(a_ents) {
    a_ents["player 1"] waittill(#"start_hack");
    if (!scene::function_b1f75ee9()) {
        namespace_ce0e5f06::function_2eded728(1);
        level thread namespace_ce0e5f06::function_eaf9c027("cp_newworld_fs_dni", "fullscreen_additive");
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4c248a91
// Checksum 0xa9e79ca4, Offset: 0xb950
// Size: 0xa4
function function_4c248a91(a_ents) {
    a_ents["taylor"] ghost();
    a_ents["taylor"] waittill(#"hash_8b7880e2");
    a_ents["taylor"] thread namespace_ce0e5f06::function_c949a8ed(1);
    a_ents["taylor"] waittill(#"hash_76000c11");
    a_ents["taylor"] thread namespace_ce0e5f06::function_4943984c();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d081fcc5
// Checksum 0x4d0775b1, Offset: 0xba00
// Size: 0x4c
function function_d081fcc5(a_ents) {
    a_ents["hall"] waittill(#"hash_76000c11");
    a_ents["hall"] thread namespace_ce0e5f06::function_4943984c(1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_920e3893
// Checksum 0xa47403b1, Offset: 0xba58
// Size: 0x34
function function_920e3893(a_ents) {
    a_ents["newworld_chase_glass_roof"] setignorepauseworld(1);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b83ef318
// Checksum 0x5d85dd41, Offset: 0xba98
// Size: 0x64
function function_b83ef318() {
    array::run_all(getaiarray(), &delete);
    level thread function_699bfff1(0);
    level thread function_660e6b31(0);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9c291f73
// Checksum 0xc96a5d88, Offset: 0xbb08
// Size: 0x12c
function function_9c291f73() {
    self endon(#"death");
    if (isdefined(self.var_fc7f3f21) && self.var_fc7f3f21) {
        return;
    }
    if (!isdefined(self.var_bf827f00)) {
        self.var_bf827f00 = 0;
    }
    switch (self.var_bf827f00) {
    case 0:
        level.var_2dca8767 dialog::say("hall_don_t_take_him_out_0", undefined, 0, self);
        break;
    case 1:
        level.var_2dca8767 dialog::say("hall_didn_t_you_hear_me_0", undefined, 0, self);
        break;
    case 2:
        level.var_2dca8767 dialog::say("hall_this_part_isn_t_abou_0", undefined, 0, self);
        break;
    case 3:
        level.var_2dca8767 dialog::say("hall_i_m_getting_tired_of_0", undefined, 0, self);
        break;
    }
    self thread function_df9bd811();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_df9bd811
// Checksum 0x7bda0e75, Offset: 0xbc40
// Size: 0x28
function function_df9bd811() {
    self.var_bf827f00++;
    self.var_fc7f3f21 = 1;
    wait(15);
    self.var_fc7f3f21 = 0;
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6a59765b
// Checksum 0xa9b9f55e, Offset: 0xbc70
// Size: 0xc2
function function_6a59765b() {
    level thread function_e54bdd35();
    foreach (player in level.activeplayers) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread function_9a9ab34a();
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e54bdd35
// Checksum 0x2fe51276, Offset: 0xbd40
// Size: 0x3c
function function_e54bdd35() {
    level endon(#"hash_a70b0538");
    wait(30);
    level.var_2dca8767 dialog::say("hall_jump_down_we_can_t_0");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3775434b
// Checksum 0xada10ab1, Offset: 0xbd88
// Size: 0x74
function function_3775434b() {
    level endon(#"hash_bdb23e9d");
    trigger::wait_till("bar_2nd_floor_enemy_VO");
    n_count = spawner::get_ai_group_sentient_count("bar_2nd_floor_robot");
    if (n_count > 0) {
        level.var_2dca8767 dialog::say("hall_heads_up_hostiles_s_0");
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6a13c1d0
// Checksum 0xd965a22e, Offset: 0xbe08
// Size: 0x2c
function function_6a13c1d0() {
    level.var_2dca8767 dialog::say("hall_sending_his_location_0", 0.5);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f4fcddfb
// Checksum 0x5018c309, Offset: 0xbe40
// Size: 0x3c
function function_f4fcddfb() {
    trigger::wait_till("chase_mid_bar_VO");
    level.var_2dca8767 dialog::say("hall_i_still_have_line_of_0");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a00b4c50
// Checksum 0x6125ab10, Offset: 0xbe88
// Size: 0xac
function function_a00b4c50(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    level flag::init("bridge_collapse_vo_complete");
    level flag::init("bridge_collapse_vo_started");
    if (!var_74cd64bc) {
        level.var_79ddcc8b dialog::say("zsfh_surrender_this_is_0", undefined, 1);
    }
    level waittill(#"hash_6a29494d");
    level thread function_c2c5155b();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c2c5155b
// Checksum 0xccae8e12, Offset: 0xbf40
// Size: 0x184
function function_c2c5155b() {
    if (!level flag::exists("bridge_collapse_vo_complete")) {
        level flag::init("bridge_collapse_vo_complete");
    }
    if (!level flag::exists("bridge_collapse_vo_started")) {
        level flag::init("bridge_collapse_vo_started");
    }
    level flag::set("bridge_collapse_vo_started");
    level.var_2dca8767 dialog::say("hall_our_boy_s_hacking_th_0", 0.5);
    playsoundatposition("amb_train_horn_distant", (-10536, -23636, 10075));
    level dialog::function_13b3b16a("plyr_he_s_running_scared_0", 0.5);
    level.var_2dca8767 dialog::say("hall_you_re_a_smart_one_n_0", 0.25);
    level flag::set("bridge_collapse_vo_complete");
    level flag::clear("bridge_collapse_vo_started");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_105db04
// Checksum 0x944e40e0, Offset: 0xc0d0
// Size: 0x6c
function function_105db04() {
    level flag::wait_till("bridge_collapse_vo_complete");
    level flag::wait_till("players_climb_up_post_bridge_collapse");
    level.var_2dca8767 dialog::say("hall_son_of_a_bitch_is_st_0", 0.5);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_be23c07c
// Checksum 0xe01e39e8, Offset: 0xc148
// Size: 0xea
function function_be23c07c() {
    trigger::wait_till("chase_trains");
    level.var_2dca8767 dialog::say("hall_use_that_billboard_t_0");
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_WALLRUN_TUTORIAL, 0, undefined, 4);
    }
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a69280be
// Checksum 0x2de0066f, Offset: 0xc240
// Size: 0xdc
function function_a69280be(var_81a32895, var_2380d5c) {
    self endon(#"death");
    level.var_2dca8767 dialog::say("hall_alright_activating_0", undefined, 0, self);
    weapon = namespace_ce0e5f06::function_71840183(var_81a32895, var_2380d5c);
    var_12b288c7 = weapon.name + "_fired";
    var_a2cc98e = var_81a32895 + "_use_ability_tutorial";
    self thread function_47c78606(var_a2cc98e);
    self thread function_57ffa633(var_12b288c7);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_47c78606
// Checksum 0x6559da12, Offset: 0xc328
// Size: 0x1fe
function function_47c78606(var_a2cc98e) {
    level endon(#"hash_29e8e5f2");
    self endon(var_a2cc98e);
    self endon(#"death");
    if (!self flag::exists(var_a2cc98e)) {
        return;
    }
    if (self flag::get(var_a2cc98e)) {
        return;
    }
    wait(10);
    a_ai = getaiteamarray("axis");
    foreach (ai in a_ai) {
        if (isalive(ai) && ai.classname === "script_vehicle") {
            break;
        }
    }
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_2dca8767 dialog::say("hall_remember_your_cyber_1", undefined, 0, self);
        break;
    case 1:
        level.var_2dca8767 dialog::say("hall_use_system_paralysis_0", undefined, 0, self);
        break;
    case 2:
        level.var_2dca8767 dialog::say("hall_why_you_doing_this_o_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_57ffa633
// Checksum 0xf9792ce0, Offset: 0xc530
// Size: 0x12c
function function_57ffa633(var_12b288c7) {
    self endon(#"death");
    level endon(#"hash_29e8e5f2");
    self waittill(var_12b288c7);
    wait(0.5);
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_2dca8767 dialog::say("hall_piece_of_cake_0", undefined, 0, self);
        break;
    case 1:
        level.var_2dca8767 dialog::say("hall_you_re_getting_the_h_0", undefined, 0, self);
        break;
    case 2:
        level.var_2dca8767 dialog::say("hall_nice_going_newblood_0", undefined, 0, self);
        break;
    }
    level.var_2dca8767 dialog::say("hall_your_cyber_abilities_0", 0.5, 0, self);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cd5f4644
// Checksum 0x79140f82, Offset: 0xc668
// Size: 0x64
function function_cd5f4644(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    if (!var_74cd64bc) {
        level waittill(#"hash_f29a6266");
    } else {
        wait(0.5);
    }
    level.var_2dca8767 dialog::say("hall_he_s_heading_into_ol_0");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x0
// namespace_36358f9c<file_0>::function_209e2a03
// Checksum 0x4cf8e2ce, Offset: 0xc6d8
// Size: 0x44
function function_209e2a03() {
    trigger::wait_till("player_enters_old_rooftops_vo");
    level.var_2dca8767 dialog::say("hall_he_s_getting_distanc_0", 0.25);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x0
// namespace_36358f9c<file_0>::function_cc7848ea
// Checksum 0xfd5ff1d6, Offset: 0xc728
// Size: 0x64
function function_cc7848ea() {
    wait(3);
    var_b3b33e02 = getentarray("chase_wasp_tower_2", "targetname");
    if (var_b3b33e02.size > 0) {
        level.var_2dca8767 dialog::say("hall_taking_fire_from_the_0");
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_da0e703d
// Checksum 0xea2c01ce, Offset: 0xc798
// Size: 0x64
function function_da0e703d() {
    wait(3);
    var_b3b33e02 = getentarray("chase_wasp_tower_3", "targetname");
    if (var_b3b33e02.size > 0) {
        level.var_2dca8767 dialog::say("hall_take_them_down_0");
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b453eaab
// Checksum 0xc9b7bb82, Offset: 0xc808
// Size: 0x3c
function function_b453eaab() {
    trigger::wait_till("chase_slide_vo");
    level.var_2dca8767 dialog::say("hall_don_t_let_up_slide_0");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8aea2545
// Checksum 0x5c277666, Offset: 0xc850
// Size: 0x4c
function function_8aea2545() {
    level waittill(#"hash_ce19dcf7");
    level.var_2dca8767 dialog::say("hall_don_t_lose_him_now_0");
    level thread function_ea7bace5();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ea7bace5
// Checksum 0x398b7a57, Offset: 0xc8a8
// Size: 0x5c
function function_ea7bace5(var_6e2f783e) {
    if (!isdefined(var_6e2f783e)) {
        var_6e2f783e = 0;
    }
    if (!var_6e2f783e) {
        trigger::wait_till("chase_construction_end_vo");
    }
    level.var_2dca8767 dialog::say("hall_grab_him_newblood_0");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3174cbb
// Checksum 0x29b83df0, Offset: 0xc910
// Size: 0x24
function function_3174cbb() {
    level.var_2dca8767 dialog::say("hall_now_s_your_chance_t_0");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_befa9b05
// Checksum 0x8b09fa40, Offset: 0xc940
// Size: 0x104
function function_befa9b05() {
    self endon(#"death");
    if (isdefined(self.var_9d7cd87) && self.var_9d7cd87) {
        return;
    }
    if (!isdefined(self.var_4891f22b)) {
        self.var_4891f22b = array("hall_mind_your_footing_t_0", "hall_watch_the_ledges_yo_0", "hall_you_re_better_than_t_0");
    }
    wait(0.5);
    str_line = array::pop(self.var_4891f22b, randomintrange(0, self.var_4891f22b.size), 0);
    if (self.var_4891f22b.size == 0) {
        self.var_4891f22b = undefined;
    }
    level.var_2dca8767 dialog::say(str_line, undefined, 0, self);
    self thread function_187d1fab();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_187d1fab
// Checksum 0xd86513e0, Offset: 0xca50
// Size: 0x2c
function function_187d1fab() {
    self endon(#"death");
    self.var_9d7cd87 = 1;
    wait(30);
    self.var_9d7cd87 = 0;
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f752dce5
// Checksum 0x3ebd2f4e, Offset: 0xca88
// Size: 0x246
function function_f752dce5(n_wait, str_endon) {
    level endon(str_endon);
    wait(n_wait / 2);
    if (level flag::exists("bridge_collapse_vo_started")) {
        level flag::wait_till_clear("bridge_collapse_vo_started");
    }
    if (level.var_c0e97bd == "chase_glass_ceiling_igc") {
        level.var_2dca8767 dialog::say("hall_you_ain_t_gonna_get_0");
        return;
    }
    n_index = randomintrange(0, 5);
    switch (n_index) {
    case 0:
        level.var_2dca8767 dialog::say("hall_move_it_we_can_t_lo_0");
        break;
    case 1:
        level.var_2dca8767 dialog::say("hall_pick_up_the_pace_le_0");
        break;
    case 2:
        level.var_2dca8767 dialog::say("hall_we_lose_him_it_s_yo_0");
        break;
    case 3:
        level.var_2dca8767 dialog::say("hall_you_re_losing_him_0");
        break;
    case 4:
        var_7f882062 = struct::get("chase_taylor_vo", "targetname");
        var_fc1953ce = spawn("script_origin", var_7f882062.origin);
        var_fc1953ce dialog::say("tayr_keep_up_you_got_no_0", undefined, 1);
        var_fc1953ce delete();
    default:
        break;
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9e93135c
// Checksum 0xef136d5c, Offset: 0xccd8
// Size: 0xd2
function function_9e93135c() {
    n_index = randomintrange(0, 3);
    switch (n_index) {
    case 0:
        level.var_2dca8767 dialog::say("hall_suspect_s_escaped_l_0");
        break;
    case 1:
        level.var_2dca8767 dialog::say("hall_you_re_gonna_have_to_0");
        break;
    case 2:
        level.var_2dca8767 dialog::say("hall_you_wanna_run_with_u_0");
        break;
    default:
        break;
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8e9219f
// Checksum 0x64dae2ce, Offset: 0xcdb8
// Size: 0x5c
function function_8e9219f() {
    if (isdefined(self.var_46b969f4) && self.var_46b969f4) {
        return;
    }
    level.var_2dca8767 dialog::say("hall_check_your_fire_civ_0", undefined, 0, self);
    self thread function_999e5485();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_999e5485
// Checksum 0x38dda5a6, Offset: 0xce20
// Size: 0x2c
function function_999e5485() {
    self endon(#"death");
    self.var_46b969f4 = 1;
    wait(30);
    self.var_46b969f4 = 0;
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_11eee9db
// Checksum 0xf3dde20e, Offset: 0xce58
// Size: 0x122c
function function_11eee9db(str_objective) {
    level flag::init("chase_suspect_train_stationstation_1st_half_done");
    level.var_ceb0eec3 = getnode("chase_bomber_teleport", "targetname");
    scene::add_scene_func("cin_new_06_01_chase_vign_flee", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter050", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter050", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter070", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter070", &function_90332e7d, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter070", &function_e7e11a61, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter070_end", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter080", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter080", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter080", &function_3e091d9e, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter090", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter090", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter100", &function_dae77e96, "init");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter100", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter100", &function_6a406930, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter100", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter110", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter110", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter120", &function_5a6a9794, "play");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter120", &function_c2f8c75f, "done");
    scene::add_scene_func("cin_new_08_01_rooftops_vign_encounter120", &function_7f4315eb, "done");
    var_2db6f578 = [];
    var_e20fd93b = getnode("chase_post_apartment", "targetname");
    var_209448e1 = getnode("chase_pre_bridge_wait", "targetname");
    var_5aa4ca38 = getnode("chase_post_explosion", "targetname");
    var_d4ebb668 = getnode("chase_post_bridge", "targetname");
    var_14b1e2ed = getnode("chase_pre_train_traversals01", "targetname");
    var_72dbb39e = getnode("chase_old_rooftop_start_cheat04", "targetname");
    var_d8079fca = getnode("chase_post_slide", "targetname");
    level.var_88590003.goalradius = 8;
    if (str_objective === "chase_chase_start") {
        level.var_88590003 forceteleport(var_e20fd93b.origin, var_e20fd93b.angles);
        level flag::wait_till("apartment_jump_down");
        level.var_f2a5cb1e = getentarray("chase_pre_bridge", "targetname");
        level thread function_28aaa11a(60);
        level thread function_112af5d1();
        level scene::play("cin_new_06_01_chase_vign_flee");
        level thread function_3775434b();
        level thread function_f4fcddfb();
        level waittill(#"hash_13934b0");
        level scene::init("cin_new_06_01_chase_vign_device");
        level flag::wait_till("bridge_collapse_start");
    } else {
        level.var_88590003 ghost();
        level.var_88590003 forceteleport(var_209448e1.origin, var_209448e1.angles);
    }
    if (str_objective === "chase_chase_start" || str_objective === "chase_bridge_collapse") {
        wait(0.05);
        function_5a6a9794();
        level thread function_28aaa11a(30);
        level.var_f2a5cb1e = getentarray("bomber_post_bridge_traversals", "targetname");
        level.var_88590003 util::magic_bullet_shield();
        level thread function_a00b4c50();
        level thread function_2c789839();
        level scene::play("cin_new_06_01_chase_vign_device");
        level.var_88590003 util::stop_magic_bullet_shield();
        level.var_88590003 setgoal(var_5aa4ca38);
    } else {
        level.var_88590003 ghost();
        level.var_88590003 forceteleport(var_5aa4ca38.origin, var_5aa4ca38.angles);
    }
    if (str_objective === "chase_chase_start" || str_objective === "chase_bridge_collapse" || str_objective === "chase_rooftops") {
        wait(0.05);
        function_5a6a9794();
        level.var_f2a5cb1e = getentarray("chase_post_bridge", "targetname");
        level flag::wait_till("bomber_post_bridge_traversals");
        level thread function_28aaa11a(30);
        level thread function_105db04();
        level thread function_1c67a977();
        var_2db6f578 = [];
        array::add(var_2db6f578, var_d4ebb668);
        array::add(var_2db6f578, var_14b1e2ed);
        function_f6ce84d6(var_2db6f578, "chase_post_bridge");
        flag::wait_till("chase_post_bridge_mantle_up");
        level.var_f2a5cb1e = getentarray("chase_train_station_glass_ceiling", "targetname");
        level thread function_28aaa11a(30);
        level.var_88590003 clientfield::set("chase_suspect_fx", 0);
        util::wait_network_frame();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter050");
        flag::wait_till("chase_train_station_glass_ceiling");
        level thread function_28aaa11a(60);
        level thread function_b6418460();
        scene::stop("cin_new_08_01_rooftops_vign_encounter050");
        level.var_88590003 show();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter070");
        level notify(#"hash_64ab138");
        level.var_f2a5cb1e = getentarray("chase_train_station_midpoint", "targetname");
        level flag::wait_till("chase_train_station_midpoint");
        level flag::wait_till("chase_suspect_train_stationstation_1st_half_done");
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter070_end");
        level thread function_cd5f4644();
        trigger::use("spawn_train_station_cafe_civs");
    } else {
        level.var_88590003 ghost();
        level.var_88590003 forceteleport(var_72dbb39e.origin, var_72dbb39e.angles);
    }
    if (str_objective === "chase_chase_start" || str_objective === "chase_bridge_collapse" || str_objective === "chase_rooftops" || str_objective === "chase_old_zurich") {
        level.var_f2a5cb1e = getentarray("start_bomber_old_zurich", "targetname");
        level flag::wait_till("start_suspect_vign_encounter080");
        level thread function_28aaa11a(60);
        level thread scene::stop("cin_new_08_01_rooftops_vign_encounter070");
        level.var_88590003 clientfield::set("chase_suspect_fx", 0);
        util::wait_network_frame();
        level.var_88590003 forceteleport(var_72dbb39e.origin, var_72dbb39e.angles, 0, 1);
        wait(0.05);
        level.var_88590003 show();
        level.var_88590003 clientfield::set("chase_suspect_fx", 1);
        level thread function_c3fb206c();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter080");
        level.var_f2a5cb1e = getentarray("suspect_scenes_old_rooftops_2", "targetname");
        level flag::wait_till("start_suspect_vign_encounter090");
        level thread function_28aaa11a(60);
        level thread scene::stop("cin_new_08_01_rooftops_vign_encounter080");
        level.var_88590003 show();
        level thread function_ca093905();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter090");
    } else {
        level.var_88590003 ghost();
        level.var_88590003 forceteleport(var_d8079fca.origin, var_d8079fca.angles);
    }
    if (str_objective === "chase_chase_start" || str_objective === "chase_bridge_collapse" || str_objective === "chase_rooftops" || str_objective === "chase_old_zurich" || str_objective === "chase_construction_site") {
        wait(0.05);
        function_5a6a9794();
        level thread scene::init("cin_new_08_01_rooftops_vign_encounter100");
        level.var_f2a5cb1e = getentarray("suspect_scenes_construction_1", "targetname");
        level flag::wait_till("start_suspect_vign_encounter100");
        level thread function_28aaa11a(30);
        level thread scene::stop("cin_new_08_01_rooftops_vign_encounter090");
        function_c2f8c75f();
        level.var_88590003 forceteleport(var_d8079fca.origin, var_d8079fca.angles);
        level thread scene::skipto_end("cin_new_08_01_rooftops_vign_encounter100", undefined, undefined, 0.2);
        level thread function_8aea2545();
        level.var_f2a5cb1e = getentarray("suspect_scenes_construction_2", "targetname");
        level flag::wait_till("start_suspect_vign_encounter110");
        level thread function_28aaa11a(30);
        level thread scene::stop("cin_new_08_01_rooftops_vign_encounter100");
        function_c2f8c75f();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter110");
        level.var_f2a5cb1e = getentarray("suspect_scenes_construction_3", "targetname");
        level flag::wait_till("start_suspect_vign_encounter120");
        level thread function_28aaa11a(30);
        level thread scene::stop("cin_new_08_01_rooftops_vign_encounter110");
        function_c2f8c75f();
        level thread scene::play("cin_new_08_01_rooftops_vign_encounter120");
        var_5b5cfed1 = getent("start_glass_ceiling_igc", "targetname");
        level.var_f2a5cb1e = var_5b5cfed1;
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_5a6a9794
// Checksum 0xb741ae, Offset: 0xe090
// Size: 0x84
function function_5a6a9794(a_ents) {
    if (isdefined(a_ents)) {
        var_88590003 = a_ents["chase_bomber_ai"];
    } else {
        var_88590003 = level.var_88590003;
    }
    var_88590003 show();
    wait(0.1);
    var_88590003 clientfield::set("chase_suspect_fx", 1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c2f8c75f
// Checksum 0x11bf2712, Offset: 0xe120
// Size: 0xb4
function function_c2f8c75f(a_ents) {
    if (isdefined(a_ents)) {
        var_88590003 = a_ents["chase_bomber_ai"];
    } else {
        var_88590003 = level.var_88590003;
    }
    var_88590003 ghost();
    var_88590003 clientfield::set("chase_suspect_fx", 0);
    util::wait_network_frame();
    var_88590003 forceteleport(level.var_ceb0eec3.origin);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_dae77e96
// Checksum 0x8a26c712, Offset: 0xe1e0
// Size: 0xca
function function_dae77e96(a_ents) {
    foreach (ent in a_ents) {
        if (isdefined(ent.classname) && issubstr(ent.classname, "civilian")) {
            ent disableaimassist();
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_90332e7d
// Checksum 0x9a49c23c, Offset: 0xe2b8
// Size: 0x6c
function function_90332e7d(a_ents) {
    level waittill(#"hash_6a2e620a");
    level.var_88590003 clientfield::set("chase_suspect_fx", 0);
    level waittill(#"hash_53dda89b");
    level.var_88590003 clientfield::set("chase_suspect_fx", 1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e7e11a61
// Checksum 0x8df224fe, Offset: 0xe330
// Size: 0x2c
function function_e7e11a61(a_ents) {
    level flag::set("chase_suspect_train_stationstation_1st_half_done");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3e091d9e
// Checksum 0xefd9b79e, Offset: 0xe368
// Size: 0x2c
function function_3e091d9e(a_ents) {
    level thread scene::init("cin_new_08_01_rooftops_vign_encounter090");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_7f4315eb
// Checksum 0x783bbd0c, Offset: 0xe3a0
// Size: 0x1a
function function_7f4315eb(a_ents) {
    level notify(#"hash_7f4315eb");
}

// Namespace namespace_36358f9c
// Params 2, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f6ce84d6
// Checksum 0x48471fee, Offset: 0xe3c8
// Size: 0xd4
function function_f6ce84d6(var_6b5e76f, str_endon) {
    level.var_88590003 endon(#"death");
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    foreach (nd_path in var_6b5e76f) {
        level.var_88590003 setgoal(nd_path);
        level.var_88590003 waittill(#"goal");
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1c67a977
// Checksum 0x5fb84f07, Offset: 0xe4a8
// Size: 0x104
function function_1c67a977() {
    var_64e85e6d = spawner::simple_spawn("chase_post_bridge_robots");
    foreach (ai in var_64e85e6d) {
        ai thread function_117951b9();
    }
    level thread function_a507aa05(var_64e85e6d);
    array::wait_till(var_64e85e6d, "post_bridge_colllapse_robots_in_place");
    level flag::set("hall_use_systemoverload_post_bridge_collapse");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_117951b9
// Checksum 0x8b12cf82, Offset: 0xe5b8
// Size: 0xb2
function function_117951b9() {
    self endon(#"death");
    self.health = int(self.health * 0.5);
    self.script_accuracy = 0.25;
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("sprint", 1);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
    self notify(#"hash_1dba7b6f");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_480f8035
// Checksum 0xc5d1dd95, Offset: 0xe678
// Size: 0x17c
function function_480f8035() {
    scene::add_scene_func("cin_gen_melee_robot_hits_civ", &function_d212a60d, "play");
    scene::add_scene_func("cin_gen_melee_robot_hits_civ", &function_65fe4a2f, "done");
    var_f6c5842 = spawner::simple_spawn_single("robot_hits_civ_scene_robot");
    var_14c918e8 = spawner::simple_spawn_single("robot_hits_civ_scene_civ");
    var_14c918e8 disableaimassist();
    var_14c918e8 ai::set_ignoreme(1);
    var_14c918e8 ai::set_ignoreall(1);
    a_ai = array(var_f6c5842, var_14c918e8);
    scene::init("cin_gen_melee_robot_hits_civ", a_ai);
    level flag::wait_till("apartment_jump_down");
    wait(0.5);
    scene::play("cin_gen_melee_robot_hits_civ", a_ai);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_d212a60d
// Checksum 0xc7ca8ea6, Offset: 0xe800
// Size: 0xa4
function function_d212a60d(a_ents) {
    level waittill(#"hash_b1604833");
    var_14c918e8 = getent("robot_hits_civ_scene_civ_ai", "targetname");
    if (isdefined(var_14c918e8)) {
        var_14c918e8 clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    if (isdefined(var_14c918e8)) {
        var_14c918e8 ghost();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_65fe4a2f
// Checksum 0xca36aaac, Offset: 0xe8b0
// Size: 0x11c
function function_65fe4a2f(a_ents) {
    var_f6c5842 = undefined;
    foreach (ent in a_ents) {
        if (ent.team === "axis") {
            var_f6c5842 = ent;
            break;
        }
    }
    if (isdefined(var_f6c5842) && isalive(var_f6c5842)) {
        var_c9ae457a = getent("chase_bar_balcony_goalvolume", "targetname");
        var_f6c5842 setgoal(var_c9ae457a, 1);
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_59e96bfa
// Checksum 0x54be0a8a, Offset: 0xe9d8
// Size: 0x1a4
function function_59e96bfa(var_74cd64bc) {
    if (!var_74cd64bc) {
        level scene::init("cin_new_06_01_chase_vign_takedown");
    }
    level flag::wait_till("apartment_jump_down");
    battlechatter::function_d9f49fba(1);
    level flag::init("hall_takedown_robot");
    level flag::init("hall_takedown_robot_roll_complete");
    scene::add_scene_func("cin_new_06_01_chase_vign_takedown", &function_7c8216c3, "play");
    scene::add_scene_func("cin_new_06_01_chase_vign_takedown", &function_20fcf1cf, "play");
    scene::add_scene_func("cin_new_06_01_chase_vign_takedown", &function_aef2268d, "done");
    level thread function_6a13c1d0();
    level scene::play("cin_new_06_01_chase_vign_takedown");
    level.var_2dca8767 ai::set_ignoreall(0);
    level.var_2dca8767 ai::set_ignoreme(0);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_7c8216c3
// Checksum 0x559777e3, Offset: 0xeb88
// Size: 0x8c
function function_7c8216c3(a_ents) {
    a_ents["hall_takedown_robot"] endon(#"death");
    a_ents["hall_takedown_robot"] thread function_1ac8d6c6();
    level waittill(#"hash_c6292c7f");
    level flag::set("hall_takedown_robot");
    util::magic_bullet_shield(a_ents["hall_takedown_robot"]);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1ac8d6c6
// Checksum 0x4fc29bba, Offset: 0xec20
// Size: 0x6c
function function_1ac8d6c6() {
    self waittill(#"death");
    level flag::wait_till("hall_takedown_robot_roll_complete");
    if (!level flag::get("hall_takedown_robot")) {
        level scene::stop("cin_new_06_01_chase_vign_takedown");
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_20fcf1cf
// Checksum 0xdf167c35, Offset: 0xec98
// Size: 0x34
function function_20fcf1cf(a_ents) {
    level waittill(#"hash_47e55a4e");
    level flag::set("hall_takedown_robot_roll_complete");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_aef2268d
// Checksum 0x5edc07f9, Offset: 0xecd8
// Size: 0x12c
function function_aef2268d(a_ents) {
    if (isalive(a_ents["hall_takedown_robot"])) {
        util::stop_magic_bullet_shield(a_ents["hall_takedown_robot"]);
        a_ents["hall_takedown_robot"] notify(#"hash_70947625");
        a_ents["hall_takedown_robot"] notify(#"hash_70947625");
        a_ents["hall_takedown_robot"] clientfield::set("derez_ai_deaths", 1);
        util::wait_network_frame();
        if (isdefined(a_ents["hall_takedown_robot"])) {
            a_ents["hall_takedown_robot"] playsound("evt_ai_derez");
        }
        wait(0.1);
        if (isdefined(a_ents["hall_takedown_robot"])) {
            a_ents["hall_takedown_robot"] delete();
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b6418460
// Checksum 0xdd917a65, Offset: 0xee10
// Size: 0x5c
function function_b6418460() {
    level waittill(#"hash_c589911");
    level thread function_9d545239(1);
    level thread function_8c82b44d(2);
    level thread function_de250dc9();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c3fb206c
// Checksum 0x99f4d8ac, Offset: 0xee78
// Size: 0x44
function function_c3fb206c() {
    level waittill(#"hash_325b137a");
    level thread function_9d545239(2);
    level thread function_8c82b44d(3);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ca093905
// Checksum 0xf7c2a2b7, Offset: 0xeec8
// Size: 0x44
function function_ca093905() {
    level waittill(#"hash_585d8de3");
    level thread function_9d545239(3);
    level thread function_da0e703d();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_6a406930
// Checksum 0x99f0ebb2, Offset: 0xef18
// Size: 0x10c
function function_6a406930(a_ents) {
    level waittill(#"hash_b1604833");
    foreach (ent in a_ents) {
        if (ent === level.var_88590003) {
            continue;
        }
        var_14c918e8 = ent;
    }
    if (isdefined(var_14c918e8)) {
        var_14c918e8 clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    if (isdefined(var_14c918e8)) {
        var_14c918e8 ghost();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e1109a4f
// Checksum 0x8d0e575b, Offset: 0xf030
// Size: 0xe6
function function_e1109a4f(var_9e31a3a2) {
    level.var_2dca8767 endon(#"death");
    level.var_2dca8767 cybercom::function_d240e350("cybercom_systemoverload", var_9e31a3a2, 0);
    foreach (var_f6c5842 in var_9e31a3a2) {
        wait(0.25);
        if (isalive(var_f6c5842)) {
            var_f6c5842.health = 1;
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ef62a489
// Checksum 0x694d45d9, Offset: 0xf120
// Size: 0xba
function function_ef62a489() {
    level endon(#"hash_c1a074c7");
    var_7b45393e = getentarray("rooftops_bad_area", "targetname");
    foreach (e_trigger in var_7b45393e) {
        e_trigger thread function_9c12e74d();
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9c12e74d
// Checksum 0x9e16360, Offset: 0xf1e8
// Size: 0xd0
function function_9c12e74d() {
    level endon(#"hash_c1a074c7");
    var_f65c3861 = struct::get_array(self.target, "targetname");
    while (true) {
        e_who = self waittill(#"trigger");
        if (isplayer(e_who) && !(isdefined(e_who.var_fc8b8ec) && e_who.var_fc8b8ec)) {
            e_who playsoundtoplayer("evt_plr_derez", e_who);
            e_who thread function_c24ce0f9(var_f65c3861);
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c24ce0f9
// Checksum 0x3d4e5b0c, Offset: 0xf2c0
// Size: 0x20c
function function_c24ce0f9(var_f65c3861) {
    self endon(#"death");
    while (true) {
        s_spot = array::random(var_f65c3861);
        if (!positionwouldtelefrag(s_spot.origin)) {
            self.var_fc8b8ec = 1;
            self.ignoreme = 1;
            self enableinvulnerability();
            self ghost();
            self util::freeze_player_controls(1);
            self setorigin(s_spot.origin);
            self setplayerangles(s_spot.angles);
            self clientfield::increment_to_player("postfx_igc");
            util::wait_network_frame();
            self show();
            self clientfield::set("player_spawn_fx", 1);
            self util::delay(2, "death", &clientfield::set, "player_spawn_fx", 0);
            self thread function_befa9b05();
            wait(2);
            self disableinvulnerability();
            self util::freeze_player_controls(0);
            self.var_fc8b8ec = 0;
            self.ignoreme = 0;
            break;
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_694c9886
// Checksum 0x7a2cd492, Offset: 0xf4d8
// Size: 0x7c
function function_694c9886() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self vehicle_ai::turnoff();
    self.script_objective = "chase_glass_ceiling_igc";
    self ai::set_ignoreme(1);
    self util::function_e218424d(1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_e8d2d7d8
// Checksum 0xa0f26e65, Offset: 0xf560
// Size: 0x1fc
function function_e8d2d7d8(n_id) {
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_01_bundle", &function_9895ffca, "play");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_02_bundle", &function_9895ffca, "play");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_03_bundle", &function_9895ffca, "play");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_04_bundle", &function_9895ffca, "play");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_01_bundle", &function_ce2ec89f, "done");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_02_bundle", &function_ce2ec89f, "done");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_03_bundle", &function_ce2ec89f, "done");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_04_bundle", &function_ce2ec89f, "done");
    scene::add_scene_func("p7_fxanim_gp_wasp_tower_arms_04_bundle", &function_f489203, "done");
    var_8b599504 = struct::get("chase_wasp_tower_" + n_id);
    var_8b599504 scene::init();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8c82b44d
// Checksum 0x249d69c0, Offset: 0xf768
// Size: 0x2fe
function function_8c82b44d(n_id) {
    level flag::wait_till("all_players_spawned");
    switch (level.activeplayers.size) {
    case 1:
        var_bd061860 = 3;
        break;
    case 2:
    case 3:
        var_bd061860 = 6;
        break;
    case 4:
        var_bd061860 = 8;
        break;
    default:
        var_bd061860 = undefined;
        break;
    }
    var_7f20007c = struct::get_array("chase_wasp_tower_" + n_id + "_arms");
    for (i = 1; i < 5; i++) {
        foreach (s_scene in var_7f20007c) {
            if (s_scene.script_int === i) {
                break;
            }
        }
        a_wasps = [];
        while (a_wasps.size < 2) {
            if (n_id == 1 && i == 1 && a_wasps.size == 0) {
                var_aaefedf3 = spawner::simple_spawn_single("chase_wasp_rocket");
                var_aaefedf3.targetname = "billboard_fxanim_rocket_wasp";
                var_aaefedf3.var_69dd5d62 = 0;
                var_aaefedf3.nocybercom = 1;
                a_wasps[a_wasps.size] = var_aaefedf3;
                var_bd061860--;
                continue;
            }
            if (var_bd061860 > 0) {
                var_aaefedf3 = spawner::simple_spawn_single("chase_wasp_mg");
                var_aaefedf3.targetname = "chase_wasp_tower_" + n_id;
                a_wasps[a_wasps.size] = var_aaefedf3;
                var_bd061860--;
                continue;
            }
            a_wasps[a_wasps.size] = util::spawn_model("tag_origin", s_scene.origin);
        }
        s_scene scene::init(a_wasps);
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9d545239
// Checksum 0x156e4efe, Offset: 0xfa70
// Size: 0x112
function function_9d545239(n_id) {
    var_8b599504 = struct::get("chase_wasp_tower_" + n_id);
    var_4c585e4 = struct::get_array("chase_wasp_tower_" + n_id + "_arms");
    array::add(var_4c585e4, var_8b599504);
    foreach (s_scene in var_4c585e4) {
        s_scene thread scene::play();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_93cf0e75
// Checksum 0x2ad38bb5, Offset: 0xfb90
// Size: 0x1fe
function function_93cf0e75(n_id) {
    var_8b599504 = struct::get("chase_wasp_tower_" + n_id);
    var_4c585e4 = struct::get_array("chase_wasp_tower_" + n_id + "_arms");
    array::add(var_4c585e4, var_8b599504);
    foreach (s_scene in var_4c585e4) {
        s_scene scene::skipto_end();
    }
    for (i = 1; i < 5; i++) {
        var_608b08b0 = getent("wasp_tower_arms_0" + i + "_wasp_0" + i + "_a", "targetname");
        var_608b08b0 delete();
        var_d29277eb = getent("wasp_tower_arms_0" + i + "_wasp_0" + i + "_b", "targetname");
        var_d29277eb delete();
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_9895ffca
// Checksum 0xde1e2a43, Offset: 0xfd98
// Size: 0x23e
function function_9895ffca(a_ents) {
    foreach (ent in a_ents) {
        if (ent.classname === "script_vehicle") {
            ent vehicle_ai::turnon();
            ent ai::set_ignoreme(0);
            ent thread function_26d72169();
        }
    }
    switch (self.scriptbundlename) {
    case 270:
        str_notify = "wasp_tower_arms_01_deploy";
        break;
    case 271:
        str_notify = "wasp_tower_arms_02_deploy";
        break;
    case 272:
        str_notify = "wasp_tower_arms_03_deploy";
        break;
    case 273:
        str_notify = "wasp_tower_arms_04_deploy";
        break;
    default:
        str_notify = undefined;
        break;
    }
    level waittill(str_notify);
    foreach (ent in a_ents) {
        if (ent.classname === "script_vehicle" && ent.targetname !== "billboard_fxanim_rocket_wasp") {
            ent util::stop_magic_bullet_shield();
            ent.var_69dd5d62 = 1;
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_26d72169
// Checksum 0xac834997, Offset: 0xffe0
// Size: 0x3c
function function_26d72169() {
    self endon(#"death");
    self waittill(#"hash_cc44fba5");
    self clientfield::set("wasp_hack_fx", 1);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ce2ec89f
// Checksum 0x950f07f4, Offset: 0x10028
// Size: 0x1e2
function function_ce2ec89f(a_ents) {
    level notify(#"hash_fb8f6850");
    switch (self.targetname) {
    case 427:
        var_c9ae457a = getent("wasp_tower_1_goalvolume", "targetname");
        break;
    case 428:
        var_c9ae457a = getent("wasp_tower_2_goalvolume", "targetname");
        break;
    case 429:
        var_c9ae457a = getent("wasp_tower_3_goalvolume", "targetname");
        break;
    default:
        str_notify = undefined;
        break;
    }
    foreach (ent in a_ents) {
        if (ent.model === "tag_origin") {
            ent delete();
            continue;
        }
        if (ent.classname === "script_vehicle") {
            ent setgoal(var_c9ae457a, 1);
            ent clientfield::set("wasp_hack_fx", 0);
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f489203
// Checksum 0x1b2640c0, Offset: 0x10218
// Size: 0x2e
function function_f489203(a_ents) {
    if (self.targetname == "chase_wasp_tower_1_arms") {
        level notify(#"hash_ab14955f");
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_2ac6fe38
// Checksum 0x6c124b22, Offset: 0x10250
// Size: 0x5c
function function_2ac6fe38() {
    scene::init("p7_fxanim_cp_newworld_chase_wasp_billboard_bundle");
    e_clip = getent("chase_wasp_billboard_clip", "targetname");
    e_clip notsolid();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_de250dc9
// Checksum 0x6aaf61ee, Offset: 0x102b8
// Size: 0x1ac
function function_de250dc9() {
    level waittill(#"hash_ab14955f");
    var_aaefedf3 = getent("billboard_fxanim_rocket_wasp", "targetname");
    var_aaefedf3 util::magic_bullet_shield();
    var_aaefedf3.var_69dd5d62 = 0;
    var_aaefedf3.nocybercom = 1;
    s_target = struct::get("chase_billboard_fxanim_org", "targetname");
    e_target = spawn("script_model", s_target.origin);
    e_target.health = 100;
    var_aaefedf3 thread ai::shoot_at_target("shoot_until_target_dead", e_target);
    var_aaefedf3 thread function_f85e3014(e_target);
    t_damage = getent("fxanim_billboard_damage_trigger", "targetname");
    t_damage thread function_797186a5(var_aaefedf3);
    level waittill(#"hash_828a35af");
    level thread function_f4151d2d();
    level scene::play("p7_fxanim_cp_newworld_chase_wasp_billboard_bundle");
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f85e3014
// Checksum 0xc6497114, Offset: 0x10470
// Size: 0x74
function function_f85e3014(e_target) {
    self endon(#"death");
    level waittill(#"hash_828a35af");
    wait(0.1);
    self util::stop_magic_bullet_shield();
    self.var_69dd5d62 = 1;
    self.nocybercom = 0;
    e_target delete();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_797186a5
// Checksum 0x9f886358, Offset: 0x104f0
// Size: 0xc2
function function_797186a5(var_aaefedf3) {
    level endon(#"hash_828a35af");
    while (true) {
        idamage, var_96133235, var_d3ca3e9c, vpoint, type, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        if (var_96133235 == var_aaefedf3) {
            level notify(#"hash_828a35af");
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f4151d2d
// Checksum 0xf8d1a8ca, Offset: 0x105c0
// Size: 0x1de
function function_f4151d2d() {
    level waittill(#"hash_ae133e20");
    e_clip = getent("chase_wasp_billboard_clip", "targetname");
    e_clip solid();
    var_a80eedb1 = getent("chase_billboard_fxanim_damage_trigger", "targetname");
    a_ai = getaiarray();
    var_b857e377 = arraycombine(a_ai, level.players, 1, 0);
    foreach (e_actor in var_b857e377) {
        if (e_actor util::is_hero()) {
            continue;
        }
        if (e_actor istouching(var_a80eedb1)) {
            if (isplayer(e_actor)) {
                e_actor dodamage(e_actor.health, e_actor.origin);
                break;
            }
            e_actor kill();
            break;
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_8efffbca
// Checksum 0x322b25fd, Offset: 0x107a8
// Size: 0x2c
function function_8efffbca() {
    glassradiusdamage(self.origin, 50, 2000, 1500);
}

// Namespace namespace_36358f9c
// Params 8, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4cd03714
// Checksum 0x887a1eb6, Offset: 0x107e0
// Size: 0x79e
function function_4cd03714(str_trigger_name, var_37713607, var_4b204b1c, var_60c1e5f7, var_10057083, b_reverse, b_timeout, var_76f5cbe9) {
    if (!isdefined(b_reverse)) {
        b_reverse = 0;
    }
    if (!isdefined(b_timeout)) {
        b_timeout = 0;
    }
    if (!isdefined(var_76f5cbe9)) {
        var_76f5cbe9 = 0;
    }
    level endon(#"hash_bdb23e9d");
    level flag::init(str_trigger_name);
    t_trigger = getent(str_trigger_name, "targetname");
    if (isdefined(t_trigger)) {
        trigger::wait_till(str_trigger_name);
    } else {
        level waittill(str_trigger_name);
        level thread function_dfd78ed7();
    }
    level flag::set("chase_train_move");
    level thread function_c9af9d76(var_10057083);
    var_7af45315 = [];
    var_95af8b3e = [];
    var_37048efd = struct::get(var_37713607, "targetname");
    var_5ae02fb7 = spawn("script_model", var_37048efd.origin);
    var_5ae02fb7.angles = var_37048efd.angles;
    var_5ae02fb7 setmodel(var_37048efd.model);
    var_5ae02fb7.script_objective = "chase_glass_ceiling_igc";
    var_5ae02fb7.script_noteworthy = "chase_train";
    var_5ae02fb7 playloopsound("amb_train_front_engine");
    if (var_76f5cbe9) {
        var_5ae02fb7 thread function_db738b68();
    }
    var_7af45315[0] = var_5ae02fb7;
    var_934a157 = struct::get(var_4b204b1c, "targetname");
    var_e5a4a905 = getent(var_37048efd.target, "targetname");
    if (var_37713607 == "train_station_train_org") {
        level thread function_69747207();
    }
    if (b_timeout == 1) {
        level thread function_a8f0457b(var_60c1e5f7);
    }
    while (var_7af45315.size > 0) {
        if (!level flag::get(var_60c1e5f7)) {
            var_3ebf068e = spawn("script_model", var_934a157.origin);
            var_3ebf068e setmodel(var_934a157.model);
            var_3ebf068e.script_objective = "chase_glass_ceiling_igc";
            var_3ebf068e.script_noteworthy = "chase_train";
            var_3ebf068e playloopsound("amb_train_car");
            var_7af45315[var_7af45315.size] = var_3ebf068e;
            if (var_76f5cbe9) {
                var_3ebf068e thread function_db738b68();
            }
        } else if (!level flag::get(str_trigger_name)) {
            level flag::set(str_trigger_name);
            s_end = struct::get("train_station_train_end", "targetname");
            var_3ebf068e = spawn("script_model", var_934a157.origin);
            var_3ebf068e.origin = (var_934a157.origin[0], var_934a157.origin[1], s_end.origin[2]);
            var_3ebf068e.angles = s_end.angles;
            var_3ebf068e setmodel(s_end.model);
            var_3ebf068e.script_objective = "chase_glass_ceiling_igc";
            var_3ebf068e.script_noteworthy = "chase_train";
            var_3ebf068e playloopsound("amb_train_engine");
            var_7af45315[var_7af45315.size] = var_3ebf068e;
            playsoundatposition("amb_train_fades_away", (-12413, -25844, 9837));
            if (var_76f5cbe9) {
                var_3ebf068e thread function_db738b68();
            }
        }
        if (b_reverse) {
            array::run_all(var_7af45315, &movex, 640, 0.274);
        } else {
            array::run_all(var_7af45315, &movex, -640, 0.274);
        }
        wait(0.274);
        if (var_37713607 == "train_station_train_org") {
            level function_4332c4dc(var_7af45315);
        }
        var_8edb1dfd = [];
        foreach (var_fcd89369 in var_7af45315) {
            if (var_fcd89369 istouching(var_e5a4a905)) {
                var_8edb1dfd[var_8edb1dfd.size] = var_fcd89369;
            }
        }
        foreach (var_fcd89369 in var_8edb1dfd) {
            arrayremovevalue(var_7af45315, var_fcd89369);
            var_fcd89369 delete();
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_a8f0457b
// Checksum 0x460cb0f1, Offset: 0x10f88
// Size: 0x2c
function function_a8f0457b(var_60c1e5f7) {
    wait(20);
    level flag::set(var_60c1e5f7);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_db738b68
// Checksum 0x7600ca90, Offset: 0x10fc0
// Size: 0x78
function function_db738b68() {
    self endon(#"death");
    while (true) {
        ent = self waittill(#"touch");
        if (isplayer(ent)) {
            ent dodamage(ent.health, ent.origin);
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_69747207
// Checksum 0xd27c1678, Offset: 0x11040
// Size: 0xa4
function function_69747207() {
    var_668efd10 = getent("train_station_gate_old_side", "targetname");
    var_668efd10 movez(-340, 0.5);
    var_d8966c4b = getent("train_station_gate_modern_side", "targetname");
    var_d8966c4b movez(-340, 0.5);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_4332c4dc
// Checksum 0xc63a5c4a, Offset: 0x110f0
// Size: 0x2dc
function function_4332c4dc(var_7af45315) {
    if (!level flag::get("train_station_start_gate_closed")) {
        var_668efd10 = getent("train_station_gate_old_side", "targetname");
        var_8b856a66 = getent("train_station_spawn_closet", "targetname");
        var_6d7bb3d1 = 1;
        foreach (var_fcd89369 in var_7af45315) {
            if (var_fcd89369 istouching(var_8b856a66)) {
                var_6d7bb3d1 = 0;
                break;
            }
        }
        if (var_6d7bb3d1 == 1) {
            level flag::set("train_station_start_gate_closed");
            var_668efd10 movez(340, 0.5);
        }
    }
    if (!level flag::get("train_station_end_gate_closed")) {
        var_d8966c4b = getent("train_station_gate_modern_side", "targetname");
        var_e5a4a905 = getent("train_station_end_closet", "targetname");
        var_fe4ad5ca = 1;
        foreach (var_fcd89369 in var_7af45315) {
            if (var_fcd89369 istouching(var_e5a4a905)) {
                var_fe4ad5ca = 0;
                break;
            }
        }
        if (var_fe4ad5ca == 1) {
            level flag::clear("chase_train_move");
            var_d8966c4b thread function_1b3cb751();
        }
    }
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_1b3cb751
// Checksum 0xdcfb7af8, Offset: 0x113d8
// Size: 0x74
function function_1b3cb751() {
    if (isdefined(self.var_337d1b65) && self.var_337d1b65) {
        return;
    }
    self.var_337d1b65 = 1;
    self movez(340, 0.5);
    self waittill(#"movedone");
    level flag::set("train_station_end_gate_closed");
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_dfd78ed7
// Checksum 0x1bff29eb, Offset: 0x11458
// Size: 0x3c
function function_dfd78ed7() {
    level clientfield::set("chase_pedestrian_blockers", 1);
    level thread function_b02cee6();
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_b02cee6
// Checksum 0x27c601fb, Offset: 0x114a0
// Size: 0x84
function function_b02cee6() {
    level flag::wait_till("train_station_end_gate_closed");
    level clientfield::set("chase_pedestrian_blockers", 0);
    e_clip = getent("train_ped_blocker_clip", "targetname");
    e_clip delete();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_c9af9d76
// Checksum 0x64540a2, Offset: 0x11530
// Size: 0x10c
function function_c9af9d76(var_10057083) {
    level endon(#"hash_c1a074c7");
    t_rumble = getent(var_10057083, "targetname");
    while (level flag::get("chase_train_move")) {
        ent = t_rumble waittill(#"trigger");
        if (isplayer(ent) && !(isdefined(ent.var_c9af9d76) && ent.var_c9af9d76)) {
            ent clientfield::set_to_player("chase_train_rumble", 1);
            ent thread function_cdd68ba3(t_rumble);
        }
    }
    level thread function_382f4206();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_cdd68ba3
// Checksum 0xa8cd8d1, Offset: 0x11648
// Size: 0x90
function function_cdd68ba3(t_rumble) {
    self endon(#"death");
    level endon(#"hash_c1a074c7");
    self.var_c9af9d76 = 1;
    while (true) {
        if (!self istouching(t_rumble)) {
            self clientfield::set_to_player("chase_train_rumble", 0);
            break;
        }
        wait(0.05);
    }
    self.var_c9af9d76 = 0;
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_382f4206
// Checksum 0x333c4838, Offset: 0x116e0
// Size: 0xba
function function_382f4206() {
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_c9af9d76) && player.var_c9af9d76) {
            player clientfield::set_to_player("chase_train_rumble", 0);
        }
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_699bfff1
// Checksum 0x4292cfe4, Offset: 0x117a8
// Size: 0x54
function function_699bfff1(b_play) {
    if (b_play) {
        level clientfield::set("crane_fxanim", 1);
        return;
    }
    level clientfield::set("crane_fxanim", 0);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_660e6b31
// Checksum 0x339cd7a6, Offset: 0x11808
// Size: 0x54
function function_660e6b31(b_play) {
    if (b_play) {
        level clientfield::set("spinning_vent_fxanim", 1);
        return;
    }
    level clientfield::set("spinning_vent_fxanim", 0);
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_fb28b377
// Checksum 0x6a150a0d, Offset: 0x11868
// Size: 0x128
function function_fb28b377(str_script_noteworthy) {
    level endon(#"hash_c1a074c7");
    var_dc7c1178 = getvehiclespawnerarray(str_script_noteworthy, "script_noteworthy");
    nd_start = getvehiclenode(str_script_noteworthy, "targetname");
    wait(randomfloatrange(2, 10));
    while (true) {
        var_2c566fb1 = array::random(var_dc7c1178);
        str_targetname = var_2c566fb1.targetname;
        veh_car = vehicle::simple_spawn_single(str_targetname);
        veh_car thread function_f579b429(nd_start);
        wait(randomfloatrange(10, 20));
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f579b429
// Checksum 0x565609cd, Offset: 0x11998
// Size: 0x3c
function function_f579b429(nd_start) {
    self vehicle::get_on_and_go_path(nd_start);
    self delete();
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_28aaa11a
// Checksum 0x5afd93c1, Offset: 0x119e0
// Size: 0xd4
function function_28aaa11a(n_time) {
    level notify(#"hash_a70b0538");
    level endon(#"hash_a70b0538");
    level thread function_ec83170f();
    level thread function_f752dce5(n_time, "chase_avoid_fail_condition");
    wait(n_time);
    /#
        if (level.players.size == 1 && isgodmode(level.players[0])) {
            return;
        }
    #/
    level thread function_9e93135c();
    util::function_207f8667(%CP_MI_ZURICH_NEWWORLD_SUSPECT_GOT_AWAY, %CP_MI_ZURICH_NEWWORLD_SUSPECT_FAIL_HINT);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_ec83170f
// Checksum 0xee99877d, Offset: 0x11ac0
// Size: 0x2a
function function_ec83170f() {
    level endon(#"hash_a70b0538");
    level.var_c37e4ef3 = 1;
    wait(10);
    level.var_c37e4ef3 = undefined;
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_25e57b80
// Checksum 0xad1d29a5, Offset: 0x11af8
// Size: 0x102
function function_25e57b80(params) {
    if (!isdefined(level.var_f2a5cb1e)) {
        return;
    }
    var_273033a9 = 1;
    foreach (player in level.activeplayers) {
        if (distance(player.origin, level.var_f2a5cb1e[0].origin) < 2500) {
            var_273033a9 = 0;
            break;
        }
    }
    if (var_273033a9 == 1) {
        level notify(#"hash_a70b0538");
    }
}

// Namespace namespace_36358f9c
// Params 1, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_f423f05a
// Checksum 0x539204d2, Offset: 0x11c08
// Size: 0xa4
function function_f423f05a(str_objective) {
    level.var_2dca8767 = util::function_740f8516("hall");
    level.var_2dca8767 ai::set_behavior_attribute("sprint", 1);
    level.var_2dca8767 ai::set_behavior_attribute("useGrenades", 0);
    level.var_2dca8767 thread namespace_ce0e5f06::function_921d7387();
    skipto::teleport_ai(str_objective);
}

// Namespace namespace_36358f9c
// Params 0, eflags: 0x1 linked
// namespace_36358f9c<file_0>::function_3936e284
// Checksum 0x1d55bb95, Offset: 0x11cb8
// Size: 0x18
function function_3936e284() {
    if (isdefined(level.var_c37e4ef3)) {
        return true;
    }
    return false;
}

