#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/fx_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_30207c6f;

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x5b58921a, Offset: 0x1440
// Size: 0x32
function function_910f2aa() {
    function_54a719d1();
    function_9dad8dce();
    level thread function_a8a110f5();
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x99389db4, Offset: 0x1480
// Size: 0x33
function function_54a719d1() {
    level flag::init("sarah_wall_running");
    level._effect["fx_apc_fire"] = "fire/fx_fire_apc_bridge_prologue";
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x92455cc6, Offset: 0x14c0
// Size: 0x142
function function_9dad8dce() {
    level.var_f58c9f31 ai::set_ignoreall(1);
    level.var_f58c9f31 ai::set_ignoreme(1);
    level.var_f58c9f31.goalradius = 16;
    level.var_f58c9f31.allowpain = 0;
    level.var_f58c9f31 colors::set_force_color("c");
    level.var_9db406db ai::set_ignoreall(0);
    level.var_9db406db ai::set_ignoreme(0);
    level.var_9db406db.goalradius = 16;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreme(1);
    level.var_4d5a4697.goalradius = 16;
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037.allowpain = 0;
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x998d754c, Offset: 0x1610
// Size: 0x28a
function function_a8a110f5() {
    level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_fireloop", &function_cf946de6, "play");
    level thread scene::play("cin_pro_11_01_jeepalley_vign_engage_fireloop");
    level thread function_9855f3c9();
    level.var_2fd26037 thread function_75853acc();
    level thread namespace_21b2c1f2::function_37906040();
    level.var_9db406db battlechatter::function_d9f49fba(1);
    level.var_2fd26037 battlechatter::function_d9f49fba(1);
    level.var_f58c9f31 sethighdetail(1);
    level thread function_1e1e465e();
    if (isdefined(level.var_8a46d9a0)) {
        level thread [[ level.var_8a46d9a0 ]]();
    }
    level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_start", &function_fcc9ed10, "play");
    level scene::play("cin_pro_11_01_jeepalley_vign_engage_start");
    level flag::wait_till("trig_player_exits_vtol");
    level thread function_b830a432();
    level flag::set("sarah_wall_running");
    level flag::init("theia_shoot_plane");
    level flag::init("plane_explodes");
    level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_attack", &function_54cdd83a, "play");
    level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_attack", &function_7af067f4, "done");
    level thread scene::play("cin_pro_11_01_jeepalley_vign_engage_attack");
    level thread function_87513084();
    level thread function_87f18673();
    level flag::wait_till("player_moves_up_alley");
    objectives::hide("cp_level_prologue_get_to_the_surface");
    skipto::function_be8adfb8("skipto_jeep_alley");
}

// Namespace namespace_30207c6f
// Params 1, eflags: 0x0
// Checksum 0x7511d4e5, Offset: 0x18a8
// Size: 0x4a
function function_54cdd83a(a_ents) {
    level waittill(#"hash_25af2e77");
    level flag::set("theia_shoot_plane");
    level waittill(#"hash_878a6dae");
    level flag::set("plane_explodes");
}

// Namespace namespace_30207c6f
// Params 1, eflags: 0x0
// Checksum 0xc2fe831d, Offset: 0x1900
// Size: 0x132
function function_fcc9ed10(a_ents) {
    a_ents["sarah_victim"].var_69dd5d62 = 0;
    a_ents["sarah_victim"] cybercom::function_59965309("cybercom_fireflyswarm");
    mdl_door_left = getent("hall_door_slide_left", "targetname");
    mdl_door_left connectpaths();
    wait(0.05);
    mdl_door_right = getent("hall_door_slide_right", "targetname");
    mdl_door_right connectpaths();
    vec_right = anglestoright(mdl_door_left.angles);
    mdl_door_left moveto(mdl_door_left.origin - vec_right * 48, 0.5);
    mdl_door_right moveto(mdl_door_right.origin + vec_right * 48, 0.5);
    level.var_c644a3e7 = 1;
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0xbf776b2c, Offset: 0x1a40
// Size: 0x1fa
function function_b830a432() {
    level endon(#"hash_800cbac6");
    if (level.var_c644a3e7 === 1) {
        var_7ed6188 = getent("t_all_players_in_vtol_collapse_hangar", "targetname");
        while (level.var_2fd26037 istouching(var_7ed6188) || level.var_9db406db istouching(var_7ed6188) || level.var_4d5a4697 istouching(var_7ed6188)) {
            wait(0.1);
        }
        level flag::wait_till("no_players_in_vtol_collapse_hangar");
        var_ac769486 = getent("clip_player_hall_doors", "targetname");
        var_ac769486 movez(100 * -1, 0.05);
        mdl_door_left = getent("hall_door_slide_left", "targetname");
        mdl_door_right = getent("hall_door_slide_right", "targetname");
        vec_right = anglestoright(mdl_door_left.angles);
        mdl_door_left moveto(mdl_door_left.origin + vec_right * 48, 0.5);
        mdl_door_right moveto(mdl_door_right.origin - vec_right * 48, 0.5);
        wait(0.05);
        var_ac769486 disconnectpaths(0, 0);
        if (isdefined(level.var_7f246cd7)) {
            level.var_7f246cd7 delete();
        }
        level.var_c644a3e7 = 0;
    }
}

// Namespace namespace_30207c6f
// Params 1, eflags: 0x0
// Checksum 0x6f76b616, Offset: 0x1c48
// Size: 0x115
function function_cf946de6(a_ents) {
    level endon(#"hash_86483bce");
    var_edd777e6 = a_ents["jeep_alley"];
    var_edd777e6 hidepart("tag_weapon", "veh_t7_lmg_brm_world", 1);
    level flag::wait_till("trig_player_exits_vtol");
    var_786c2b27 = a_ents["machinegun"];
    var_6c3c4545 = getweapon("turret_bo3_civ_truck_pickup_tech_nrc");
    while (true) {
        var_786c2b27 waittill(#"fire");
        v_start_pos = var_786c2b27 gettagorigin("tag_flash");
        v_end_pos = v_start_pos + anglestoforward(var_786c2b27 gettagangles("tag_flash")) * 120;
        magicbullet(var_6c3c4545, v_start_pos, v_end_pos, var_786c2b27);
    }
}

// Namespace namespace_30207c6f
// Params 1, eflags: 0x0
// Checksum 0x4b8d58b8, Offset: 0x1d68
// Size: 0x42
function function_7af067f4(a_ents) {
    level notify(#"hash_86483bce");
    a_ents["theia"] thread function_467bdccf();
    a_ents["theia"] sethighdetail(0);
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x416bcf26, Offset: 0x1db8
// Size: 0x14a
function function_75853acc() {
    level flag::wait_till("sarah_wall_running");
    self colors::disable();
    self setgoal(getnode("hendricks_kill_jeep_alley", "targetname"), 1);
    self.perfectaim = 1;
    self ai::set_behavior_attribute("useGrenades", 0);
    level waittill(#"hash_ec12613");
    var_af97b78b = spawner::get_ai_group_ai("jeep_alley_enemy");
    for (i = 0; i < var_af97b78b.size; i++) {
        if (isalive(var_af97b78b[i])) {
            self ai::shoot_at_target("shoot_until_target_dead", var_af97b78b[i], "j_head");
        }
    }
    self.perfectaim = 0;
    self colors::enable();
    self ai::set_behavior_attribute("useGrenades", 1);
    trigger::use("jeep_alley_allies_move", "targetname");
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x9ccdd6f5, Offset: 0x1f10
// Size: 0x29a
function function_87513084() {
    spawner::add_spawn_function_group("plane_burn_victims", "targetname", &ai::set_ignoreme, 1);
    var_5aed614f = spawner::simple_spawn("plane_burn_victims");
    level flag::wait_till("theia_shoot_plane");
    level.var_9db406db ai::set_ignoreall(0);
    level flag::wait_till("plane_explodes");
    level util::clientnotify("sndStartFakeBattle");
    foreach (var_3c9a4ab3 in var_5aed614f) {
        if (isalive(var_3c9a4ab3)) {
            var_3c9a4ab3 thread function_d9205aac();
        }
    }
    level thread scene::play("p7_fxanim_cp_prologue_plane_hanger_explode_bundle");
    while (!scene::is_ready("p7_fxanim_cp_prologue_plane_hanger_explode_bundle")) {
        wait(0.05);
    }
    level thread scene::stop("p7_fxanim_cp_prologue_plane_hanger_pristine_bundle", 1);
    var_aab7a6d1 = getent("plane_hanger_explode", "targetname");
    var_aab7a6d1 setmodel("veh_t7_mil_jet_cargo_dest");
    foreach (e_player in level.players) {
        e_player playrumbleonentity("tank_damage_heavy_mp");
        earthquake(1, 1.5, e_player.origin, 128);
    }
    level.var_35c12e63 = struct::get("bridge_obj", "targetname");
    objectives::set("cp_waypoint_breadcrumb", level.var_35c12e63);
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x8f9329c4, Offset: 0x21b8
// Size: 0x42
function function_d9205aac() {
    var_899774be = randomintrange(1, 9);
    var_636cd52c = "cin_gen_vign_plane_burning_0" + var_899774be;
    self thread scene::play(var_636cd52c, self);
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x60eff1a5, Offset: 0x2208
// Size: 0xe2
function function_467bdccf() {
    self setgoal(self.origin, 1);
    var_e71bd5d8 = struct::get("theia_bridge_target", "targetname");
    var_a03ca40a = spawn("script_model", var_e71bd5d8.origin);
    var_a03ca40a setmodel("tag_origin");
    var_a03ca40a.health = 100000;
    self thread ai::shoot_at_target("shoot_until_target_dead", var_a03ca40a);
    level flag::wait_till("player_left_alley");
    var_a03ca40a kill();
    self ai::set_ignoreall(0);
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0xbe234e82, Offset: 0x22f8
// Size: 0x72
function function_9855f3c9() {
    spawner::add_spawn_function_ai_group("jeep_alley_enemy", &function_46e24498);
    spawner::simple_spawn("sp_initial_jeep_enemies");
    level flag::wait_till("trig_player_exits_vtol");
    spawner::simple_spawn("sp_jeep_alley_cqb");
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0x1ef3cf5b, Offset: 0x2378
// Size: 0x9a
function function_46e24498() {
    self endon(#"death");
    self.grenadeammo = 0;
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("disablesprint", 1);
    level flag::wait_till("sarah_wall_running");
    wait(randomfloatrange(0.25, 2));
    self.health = 30;
    self ai::shoot_at_target("shoot_until_target_dead", level.var_f58c9f31);
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0xb9b78acb, Offset: 0x2420
// Size: 0xfa
function function_87f18673() {
    level waittill(#"hash_1e79e193");
    level.var_f58c9f31 thread dialog::say("hall_get_to_the_bridge_i_0");
    level waittill(#"hash_8cc62724");
    level.var_f58c9f31 dialog::say("hall_exfil_ahead_push_fo_0");
    if (!level flag::get("player_left_alley")) {
        level dialog::remote("tayr_better_hustle_picku_0", 0.5);
    }
    if (!level flag::get("player_left_alley")) {
        if (!isdefined(level.var_5d4087a6)) {
            level.var_5d4087a6 = util::function_740f8516("hyperion");
        }
        level.var_5d4087a6 dialog::say("mare_on_me_on_me_0", 0.2);
    }
}

// Namespace namespace_30207c6f
// Params 0, eflags: 0x0
// Checksum 0xac4d0367, Offset: 0x2528
// Size: 0x3a
function function_1e1e465e() {
    level waittill(#"hash_60a343a0");
    level.var_f58c9f31 dialog::say("hall_that_technical_s_min_0");
    level thread namespace_21b2c1f2::function_b83aa9c5();
}

#namespace namespace_dc79b4d3;

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xbebe862f, Offset: 0x2570
// Size: 0x42
function function_b86981e6() {
    function_8e94cc65();
    function_4cabc89a();
    level thread function_57e7a8c9();
    level thread namespace_21b2c1f2::function_b83aa9c5();
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xc67cdc9, Offset: 0x25c0
// Size: 0x32
function function_8e94cc65() {
    level flag::init("play_bridge_nag");
    level flag::init("bridge_intro_chatter_done");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xd8e2b2dc, Offset: 0x2600
// Size: 0x17a
function function_4cabc89a() {
    level.var_5d4087a6 ai::set_ignoreall(1);
    level.var_5d4087a6 ai::set_ignoreme(1);
    level.var_5d4087a6.goalradius = 16;
    level.var_5d4087a6.allowpain = 0;
    level.var_5d4087a6 colors::set_force_color("p");
    level.var_f58c9f31 ai::set_ignoreme(1);
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreme(1);
    level.var_9db406db.goalradius = 16;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreme(1);
    level.var_4d5a4697 ai::set_behavior_attribute("coverIdleOnly", 1);
    level.var_4d5a4697.goalradius = 16;
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037.allowpain = 0;
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x82092de9, Offset: 0x2788
// Size: 0x172
function function_57e7a8c9() {
    objectives::set("cp_level_prologue_cross_bridge");
    callback::on_vehicle_killed(&namespace_61c634f2::function_3d89871d);
    level thread function_401aadf2();
    level thread function_cd931b6e();
    level thread function_86b76a0b();
    level thread function_462ad50a();
    level.var_5d4087a6 thread function_373c3957();
    exploder::exploder("light_exploder_bridge");
    level thread function_19d07c7a();
    function_45506c4a();
    wait(2);
    level thread function_3178e821();
    objectives::hide("cp_level_prologue_cross_bridge");
    savegame::checkpoint_save();
    objectives::set("cp_level_prologue_escort_data_center");
    level thread function_86ce62c8();
    callback::remove_on_vehicle_killed(&namespace_61c634f2::function_3d89871d);
    function_d092ac71();
    skipto::function_be8adfb8("skipto_bridge_battle");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xfd9cf36f, Offset: 0x2908
// Size: 0x192
function function_cd931b6e() {
    spawner::add_spawn_function_group("bridge_wave_1", "script_noteworthy", &function_39c16a4a);
    spawner::add_spawn_function_group("sp_bridge_initial", "targetname", &function_39c16a4a);
    spawner::add_spawn_function_group("sp_bridge_secondary", "targetname", &function_39c16a4a);
    spawner::add_spawn_function_group("bridge_enemies", "script_noteworthy", &namespace_2cb3876f::remove_grenades);
    spawner::simple_spawn("sp_bridge_initial");
    level flag::wait_till("player_left_alley");
    spawner::simple_spawn("sp_bridge_front");
    spawn_manager::enable("CQB_spawner_right");
    spawn_manager::enable("CQB_spawner_left");
    level thread function_57ae876e();
    level thread function_58b194a5();
    level thread function_2fdac05f();
    level thread function_d32d88c();
    wait(10);
    spawner::simple_spawn("sp_bridge_secondary");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xf7fc9646, Offset: 0x2aa8
// Size: 0x142
function function_39c16a4a() {
    self endon(#"death");
    if (!isdefined(self.target)) {
        var_257bbc01 = getent("trig_bridge_goal_vol_1", "targetname");
        self setgoal(var_257bbc01);
    }
    level flag::wait_till("bridge_enemies_fallback_1");
    var_257bbc01 = getent("trig_bridge_goal_vol_2", "targetname");
    self setgoal(var_257bbc01);
    level flag::wait_till("bridge_enemies_fallback_2");
    var_257bbc01 = getent("trig_bridge_goal_vol_3", "targetname");
    self setgoal(var_257bbc01);
    level flag::wait_till("bridge_enemies_fallback_3");
    var_257bbc01 = getent("trig_bridge_goal_vol_4", "targetname");
    self setgoal(var_257bbc01);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x18950bd5, Offset: 0x2bf8
// Size: 0x52
function function_57ae876e() {
    level endon(#"hash_babbfab3");
    level flag::wait_till("bring_in_jeeps");
    spawner::waittill_ai_group_ai_count("aig_bridge_defenders", 8);
    spawn_manager::enable("bridge_reinforcement_spawner", 1);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x8c3c98ee, Offset: 0x2c58
// Size: 0x16a
function function_d32d88c() {
    level thread function_6e72a6d1();
    level flag::wait_till("bring_in_jeeps");
    level thread function_823e535e();
    var_4f41d1d9 = vehicle::simple_spawn_single("bridge_jeep_right");
    var_4f41d1d9 playsound("evt_jeeps_pre_bridge_drive");
    var_a2623c0a = vehicle::simple_spawn_single("bridge_jeep_left");
    var_a2623c0a.var_52c5472d = 1;
    var_4f41d1d9.var_52c5472d = 1;
    level thread function_c4e1973c(var_4f41d1d9);
    level thread function_c4e1973c(var_a2623c0a);
    var_4f41d1d9 thread function_9069a713();
    var_a2623c0a thread function_9069a713();
    objectives::complete("cp_waypoint_breadcrumb", level.var_35c12e63);
    var_a2623c0a thread function_7096928d("cp_level_prologue_destroy_jeep_left");
    var_4f41d1d9 thread function_7096928d("cp_level_prologue_destroy_jeep_left");
    level.var_8c902673 = array(var_a2623c0a, var_4f41d1d9);
    level thread function_5d5b8625();
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xd346c056, Offset: 0x2dd0
// Size: 0x1a
function function_6e72a6d1() {
    wait(30);
    level flag::set("bring_in_jeeps");
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0xb30abd6f, Offset: 0x2df8
// Size: 0xc2
function function_7096928d(var_376507c0) {
    self thread turret::disable_ai_getoff(1, 1);
    self waittill(#"hash_449a82fd");
    ai_rider = self vehicle::function_ad4ec07a("gunner1");
    ai_rider ai::set_ignoreme(1);
    ai_rider thread function_da187c1b(self);
    objectives::set(var_376507c0, self);
    self waittill(#"death");
    if (!isdefined(self.var_ceae8e35)) {
        objectives::complete(var_376507c0, self);
    }
    level flag::set("bridge_destruction_sequence");
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0x17451081, Offset: 0x2ec8
// Size: 0x62
function function_da187c1b(var_edd777e6) {
    self waittill(#"death");
    wait(randomfloatrange(2, 4));
    if (isalive(var_edd777e6)) {
        var_edd777e6 kill();
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x137aca61, Offset: 0x2f38
// Size: 0x3a
function function_5d5b8625() {
    level flag::wait_till("bridge_intro_chatter_done");
    level.var_2fd26037 dialog::say("hend_only_way_across_the_0");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x385f0b81, Offset: 0x2f80
// Size: 0x1a
function function_823e535e() {
    wait(45);
    level flag::set("bridge_destruction_sequence");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x60152b11, Offset: 0x2fa8
// Size: 0x22
function function_9069a713() {
    self waittill(#"start_firing");
    self turret::enable(1, 1);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xc6f8db96, Offset: 0x2fd8
// Size: 0x32
function function_58b194a5() {
    level flag::wait_till("bring_in_sniper_2");
    spawner::simple_spawn("sp_bridge_sniper_right");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x29247689, Offset: 0x3018
// Size: 0x7a
function function_2fdac05f() {
    level flag::wait_till("bring_in_trucks");
    level thread function_ec50ea55("bridge_battle_flatbed_left_1");
    level thread function_ec50ea55("bridge_battle_flatbed_right_1");
    wait(2);
    level thread function_ec50ea55("bridge_battle_flatbed_left_2");
    level thread function_ec50ea55("bridge_battle_flatbed_right_2");
}

// Namespace namespace_dc79b4d3
// Params 2, eflags: 0x0
// Checksum 0x2984b618, Offset: 0x30a0
// Size: 0x52
function function_58377d0(vehiclename, name) {
    ai_rider = vehiclename vehicle::function_ad4ec07a(name);
    if (isdefined(ai_rider)) {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_39c16a4a();
    }
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0x58b031a, Offset: 0x3100
// Size: 0x6a
function function_ec50ea55(str_vehicle) {
    vh_vehicle = vehicle::simple_spawn_single(str_vehicle);
    vh_vehicle thread vehicle::go_path();
    vh_vehicle waittill(#"reached_end_node");
    function_58377d0(vh_vehicle, "driver");
    function_58377d0(vh_vehicle, "passenger1");
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0xb5c7d57a, Offset: 0x3178
// Size: 0x112
function function_c4e1973c(vh_vehicle) {
    vh_vehicle thread vehicle::go_path();
    vh_vehicle waittill(#"reached_end_node");
    ai_rider = vh_vehicle vehicle::function_ad4ec07a("passenger1");
    if (isalive(ai_rider)) {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_39c16a4a();
    }
    var_dfb53de7 = vh_vehicle vehicle::function_ad4ec07a("gunner1");
    if (isalive(var_dfb53de7)) {
        var_dfb53de7 waittill(#"death");
    }
    var_44762fa4 = vh_vehicle vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4 thread vehicle::get_out();
        var_44762fa4 thread function_39c16a4a();
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xa9c94fc7, Offset: 0x3298
// Size: 0x11a
function function_19d07c7a() {
    var_82079741 = spawner::simple_spawn_single("floodlight_left");
    var_8386532c = spawner::simple_spawn_single("floodlight_right");
    var_82079741 vehicle::lights_on();
    var_8386532c vehicle::lights_on();
    level waittill(#"hash_69473677");
    if (isdefined(var_82079741)) {
        var_82079741 vehicle::lights_off();
        var_8386532c vehicle::lights_off();
        var_82079741.delete_on_death = 1;
        var_82079741 notify(#"death");
        if (!isalive(var_82079741)) {
            var_82079741 delete();
        }
        wait(0.05);
        var_8386532c.delete_on_death = 1;
        var_8386532c notify(#"death");
        if (!isalive(var_8386532c)) {
            var_8386532c delete();
        }
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x955f43c2, Offset: 0x33c0
// Size: 0x142
function function_45506c4a() {
    level flag::wait_till("bridge_destruction_sequence");
    level notify(#"hash_91d75f4e");
    level thread function_61ebf180();
    battlechatter::function_d9f49fba(0);
    var_b729b603 = getent("trig_bridge_vehicle_delete", "targetname");
    level thread trigger::trigger_delete_on_touch(var_b729b603);
    wait(2);
    level.var_3e3bb66f = [];
    level thread function_bb86e135("bridge_macv_convoy1", 3, 2);
    wait(1);
    level thread function_bb86e135("bridge_macv_convoy2", 3, 2);
    wait(1.5);
    level.var_2fd26037 dialog::say("hend_reinforcements_comin_0");
    wait(0.25);
    level.var_2fd26037 dialog::say("hend_we_re_not_getting_ac_0");
    wait(0.4);
    level.var_5d4087a6 dialog::say("mare_fuck_it_plan_b_0");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x2d106792, Offset: 0x3510
// Size: 0x21b
function function_61ebf180() {
    level waittill(#"hash_2cc5e83");
    level thread function_b61c8c58();
    level scene::add_scene_func("p7_fxanim_cp_prologue_bridge_bundle", &function_cefcd22a);
    level scene::add_scene_func("p7_fxanim_cp_prologue_bridge_bundle", &function_27bfa6a0, "done");
    level thread scene::play("p7_fxanim_cp_prologue_bridge_bundle");
    exploder::stop_exploder("light_exploder_bridge");
    array::run_all(level.var_3e3bb66f, &function_908069e9);
    level notify(#"hash_babbfab3");
    trigger::use("trig_kill_cqb_spawner_right", "targetname", undefined, 0);
    trigger::use("trig_kill_cqb_spawner_left", "targetname", undefined, 0);
    trigger::use("trig_kill_bridge_reinforcement_spawner", "targetname", undefined, 0);
    level thread function_a34a09b4();
    wait(0.5);
    level thread namespace_21b2c1f2::function_3c37ec50();
    foreach (var_edd777e6 in level.var_8c902673) {
        if (isalive(var_edd777e6)) {
            var_edd777e6.var_ceae8e35 = 1;
            objectives::complete("cp_level_prologue_destroy_jeep_left", var_edd777e6);
            radiusdamage(var_edd777e6.origin, 96, 1000, 500, level.var_2fd26037, "MOD_GRENADE");
            wait(0.75);
        }
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x3c3c8e70, Offset: 0x3738
// Size: 0xbb
function function_a34a09b4() {
    var_c1470355 = getaiteamarray("axis");
    foreach (ai in var_c1470355) {
        if (isalive(ai)) {
            ai ai::bloody_death();
            wait(randomfloatrange(0.1, 0.3));
        }
    }
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0x98f1846a, Offset: 0x3800
// Size: 0x42
function function_cefcd22a(a_ents) {
    level thread namespace_2cb3876f::function_2a0bc326(level.var_2fd26037.origin, 0.5, 1.5, 5000, 5, "damage_heavy");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x4e4b305d, Offset: 0x3850
// Size: 0x412
function function_b61c8c58() {
    var_a02e914a = getent("bridge_section_top", "targetname");
    var_a02e914a delete();
    var_725be530 = getent("bridge_section_bottom", "targetname");
    var_725be530 delete();
    level thread scene::play("bridge_tent_01");
    var_59ff07ee = getent("bridge_section_1", "targetname");
    var_59ff07ee delete();
    var_57376852 = getent("bridge_damage_origin_1", "targetname");
    radiusdamage(var_57376852.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE");
    level thread function_71e578b6();
    level waittill(#"hash_85385801");
    level thread scene::play("bridge_tent_02");
    var_33fc8d85 = getent("bridge_section_2", "targetname");
    var_33fc8d85 delete();
    var_3134ede9 = getent("bridge_damage_origin_2", "targetname");
    radiusdamage(var_3134ede9.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE");
    level thread function_71e578b6();
    level waittill(#"hash_5f35dd98");
    var_dfa131c = getent("bridge_section_3", "targetname");
    var_dfa131c delete();
    var_b327380 = getent("bridge_damage_origin_3", "targetname");
    radiusdamage(var_b327380.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE");
    level thread function_71e578b6();
    level waittill(#"hash_69473677");
    level thread scene::play("bridge_tent_03");
    var_e7f798b3 = getentarray("bridge_section_4", "targetname");
    array::run_all(var_e7f798b3, &delete);
    var_1543cc5f = getent("bridge_damage_origin_4", "targetname");
    radiusdamage(var_1543cc5f.origin, 800, 3000, 3000, undefined, "MOD_EXPLOSIVE");
    level thread function_71e578b6();
    var_2bb8ffb8 = getentarray("bridge_macv_convoy1_vh", "targetname");
    var_bd827604 = struct::get("struct_macv_fx", "targetname");
    var_85d8db71 = arraygetclosest(var_bd827604.origin, var_2bb8ffb8);
    var_85d8db71 thread fx::play("fx_apc_fire", var_85d8db71.origin, var_85d8db71.angles, undefined, 1, "tag_origin");
}

// Namespace namespace_dc79b4d3
// Params 1, eflags: 0x0
// Checksum 0x272ca8a6, Offset: 0x3c70
// Size: 0x8b
function function_27bfa6a0(a_ents) {
    showmiscmodels("fxanim_bridge_static2");
    util::wait_network_frame();
    foreach (ent in a_ents) {
        ent delete();
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x31c8734b, Offset: 0x3d08
// Size: 0x31
function function_908069e9() {
    for (i = 1; i < 5; i++) {
        self turret::stop(i);
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x6dd5a4d9, Offset: 0x3d48
// Size: 0x93
function function_71e578b6() {
    foreach (e_player in level.players) {
        e_player playrumbleonentity("tank_damage_heavy_mp");
        earthquake(0.3, 1, e_player.origin, 128);
    }
}

// Namespace namespace_dc79b4d3
// Params 2, eflags: 0x0
// Checksum 0x7a730a5a, Offset: 0x3de8
// Size: 0x6a
function function_1aacc8e6(truck, spawner) {
    var_b337b3dc = vehicle::simple_spawn_single(truck);
    var_b337b3dc thread vehicle::go_path();
    var_b337b3dc waittill(#"reached_end_node");
    var_b337b3dc disconnectpaths();
    spawn_manager::enable(spawner);
}

// Namespace namespace_dc79b4d3
// Params 3, eflags: 0x0
// Checksum 0xefa03d39, Offset: 0x3e60
// Size: 0x93
function function_bb86e135(var_2c566fb1, n_amount, n_delay) {
    for (i = 0; i < n_amount; i++) {
        var_86cf1a8 = vehicle::simple_spawn_single_and_drive(var_2c566fb1);
        level.var_3e3bb66f[level.var_3e3bb66f.size] = var_86cf1a8;
        if (i == 0) {
            var_86cf1a8 playsound("evt_apc_bridge_drive");
        }
        var_86cf1a8 thread function_9a998f4c();
        wait(n_delay);
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x7729c6ba, Offset: 0x3f00
// Size: 0xd1
function function_9a998f4c() {
    self endon(#"death");
    self waittill(#"activate_turret");
    for (i = 1; i < 5; i++) {
        if (level.players.size > 1) {
            var_e248524d = array::get_all_closest(self.origin, level.activeplayers, undefined, 3);
            n_index = randomintrange(1, level.activeplayers.size);
            e_target = var_e248524d[n_index - 1];
        } else {
            e_target = level.players[0];
        }
        self thread turret::shoot_at_target(e_target, 20, (0, 0, 0), i, 0);
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x4acd12a9, Offset: 0x3fe0
// Size: 0x42
function function_86b76a0b() {
    var_415b1e24 = getnode("node_hendricks_bridge", "targetname");
    level.var_2fd26037 setgoal(var_415b1e24);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xf5cd23dd, Offset: 0x4030
// Size: 0xf2
function function_373c3957() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    var_948fd036 = getent("hyperion_teleport_point", "targetname");
    self forceteleport(var_948fd036.origin, var_948fd036.angles, 1);
    level flag::wait_till("hyperion_move_up");
    n_node = getnode("hyperion_bridge_start", "targetname");
    self setgoal(n_node, 1);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xbb57ad73, Offset: 0x4130
// Size: 0xf2
function function_462ad50a() {
    var_49b32118 = getent("pa_dialog_bridge", "targetname");
    var_49b32118 dialog::say("nrcp_satellite_stations_m_0", 0, 1);
    level flag::wait_till("player_left_alley");
    level.var_5d4087a6 dialog::say("mare_exfil_is_across_the_0");
    level.var_2fd26037 dialog::say("hend_they_ll_still_be_rig_0", 0.5);
    level.var_5d4087a6 dialog::say("mare_we_ve_set_charges_al_0", 0.3);
    wait(1);
    level flag::set("bridge_intro_chatter_done");
    level function_ce74e624();
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x225b0721, Offset: 0x4230
// Size: 0x122
function function_ce74e624() {
    level endon(#"hash_91d75f4e");
    level thread function_ccb258c2();
    level thread function_ff7f8d6c();
    level flag::wait_till("play_bridge_nag");
    level.var_5d4087a6 dialog::say("mare_bridge_s_just_ahead_0");
    level flag::clear("play_bridge_nag");
    level thread function_ccb258c2();
    level flag::wait_till("play_bridge_nag");
    level.var_5d4087a6 dialog::say("mare_keep_on_mark_we_re_0");
    level flag::clear("play_bridge_nag");
    level thread function_ccb258c2();
    level flag::wait_till("play_bridge_nag");
    level.var_5d4087a6 dialog::say("mare_move_up_move_up_0");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xcd1d5fc9, Offset: 0x4360
// Size: 0x61
function function_ccb258c2() {
    level endon(#"hash_91d75f4e");
    level.var_1d513eb4 = 0;
    n_starttime = gettime();
    while (true) {
        wait(0.5);
        level.var_1d513eb4 = (gettime() - n_starttime) / 1000;
        if (level.var_1d513eb4 >= 20) {
            level flag::set("play_bridge_nag");
            break;
        }
    }
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x997c8e5e, Offset: 0x43d0
// Size: 0x62
function function_ff7f8d6c() {
    level flag::wait_till("bridge_enemies_fallback_1");
    level.var_1d513eb4 = 0;
    level flag::wait_till("bridge_enemies_fallback_3");
    level.var_1d513eb4 = 0;
    level flag::wait_till("bring_in_jeeps");
    level.var_1d513eb4 = 0;
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xc34142fc, Offset: 0x4440
// Size: 0x1b2
function function_d092ac71() {
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_5d4087a6 ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_behavior_attribute("coverIdleOnly", 0);
    level thread function_43d4df76();
    trigger::use("move_friendlies_to_darkroom_door");
    level thread scene::play("cin_pro_12_01_darkbattle_vign_doorhack_theia_hack");
    level thread function_d94fdf85();
    level thread objectives::breadcrumb("dark_battle_breadcrumb_start");
    level waittill(#"hash_3b176c27");
    function_40039059();
    trigger::use("move_friendlies_to_darkroom");
    level waittill(#"hash_2ea5aaf1");
    level flag::set("activate_db_bc_2");
    n_node = getnode("pallas_stairs_goal", "targetname");
    level.var_5d4087a6 setgoal(n_node);
    level thread function_8798d583();
    level.var_5d4087a6 waittill(#"goal");
    objectives::complete("cp_waypoint_breadcrumb");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x15bd2bc9, Offset: 0x4600
// Size: 0x15d
function function_40039059() {
    level.var_212db960 = getent("intelligence_building_entrance_blocker", "targetname");
    level.var_212db960.movedist = 300;
    level.var_212db960 movez(-1 * level.var_212db960.movedist, 0.05);
    var_181a23a4 = getent("intelstation_entry_door_l", "targetname");
    var_5c50a8aa = getent("intelstation_entry_door_r", "targetname");
    playsoundatposition("evt_doorhack_dooropen", var_5c50a8aa.origin);
    var_96ba651b = (54, 0, 0);
    var_ebf82f1 = var_181a23a4.origin + var_96ba651b;
    var_181a23a4 moveto(var_ebf82f1, 0.5);
    var_ebf82f1 = var_5c50a8aa.origin - var_96ba651b;
    var_5c50a8aa moveto(var_ebf82f1, 0.5);
    var_181a23a4 waittill(#"movedone");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xe623b3d1, Offset: 0x4768
// Size: 0x1ca
function function_43d4df76() {
    t_door = getent("t_intelligence_entrance_doors", "targetname");
    var_634d0729 = array(level.var_4d5a4697, level.var_2fd26037, level.var_9db406db, level.var_5d4087a6);
    level thread namespace_2cb3876f::function_21f52196("intelligence_doors", t_door);
    level thread namespace_2cb3876f::function_2e61b3e8("intelligence_doors", t_door, var_634d0729);
    while (!namespace_2cb3876f::function_cdd726fb("intelligence_doors")) {
        wait(0.1);
    }
    level.var_212db960 movez(level.var_212db960.movedist, 0.05);
    var_181a23a4 = getent("intelstation_entry_door_l", "targetname");
    var_5c50a8aa = getent("intelstation_entry_door_r", "targetname");
    var_5c50a8aa playsound("evt_doorhack_doorclose");
    var_96ba651b = (54, 0, 0);
    var_ebf82f1 = var_181a23a4.origin - var_96ba651b;
    var_181a23a4 moveto(var_ebf82f1, 0.5);
    var_ebf82f1 = var_5c50a8aa.origin + var_96ba651b;
    var_5c50a8aa moveto(var_ebf82f1, 0.5);
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x87b953f3, Offset: 0x4940
// Size: 0x82
function function_d94fdf85() {
    ent = spawn("script_origin", (13413, 2917, 442));
    ent playloopsound("evt_darkbattle_walla_pre_loop", 5);
    level waittill(#"hash_400d768d");
    ent stoploopsound(3);
    wait(0.5);
    ent playsound("evt_darkbattle_walla_surprise_oneshot");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x49518cb6, Offset: 0x49d0
// Size: 0x34a
function function_3178e821() {
    wait(18);
    var_edc6e0e1 = vehicle::simple_spawn_single("vtol_bridge_flyby");
    var_edc6e0e1 util::magic_bullet_shield();
    var_edc6e0e1 thread vehicle::go_path();
    var_edc6e0e1 thread namespace_2cb3876f::vehicle_rumble("buzz_high", "vtol_attack_end", 0.1, 0.1, 2000, 60);
    var_edc6e0e1 thread namespace_2cb3876f::function_c56034b7();
    var_edc6e0e1 vehicle::toggle_lights_group(4, 1);
    var_bd827604 = struct::get("vtol_spotlight_closest", "targetname");
    e_closest_player = arraygetclosest(var_bd827604.origin, level.players);
    var_edc6e0e1 function_9af49228(e_closest_player, (0, 0, 0), 2);
    var_edc6e0e1 waittill(#"hash_808f9bca");
    var_c9a712ab = getent("trig_all_players_in_int_builing", "targetname");
    var_edc6e0e1 vehicle::detach_path();
    var_11357cb8 = struct::get_array("vtol_db_pos");
    var_3a018a9 = 0;
    while (!namespace_2cb3876f::function_cdd726fb("intelligence_doors")) {
        foreach (e_player in level.activeplayers) {
            var_edc6e0e1 setlookatent(e_player);
            var_edc6e0e1 function_9af49228(e_player, (0, 0, 0), 2);
            while (isdefined(e_player) && !e_player istouching(var_c9a712ab)) {
                e_player function_62f55bbc(var_edc6e0e1, 0);
                var_3a018a9++;
                if (var_3a018a9 % 2 == 0) {
                    var_edc6e0e1 setvehgoalpos(array::random(var_11357cb8).origin, 1);
                }
            }
        }
        wait(0.5);
    }
    var_edc6e0e1 clearvehgoalpos();
    var_edc6e0e1.drivepath = 1;
    var_618ce087 = getvehiclenode("vtol_bridge_leave_nd", "targetname");
    var_edc6e0e1 thread vehicle::get_on_and_go_path(var_618ce087);
    var_edc6e0e1 waittill(#"reached_end_node");
    var_edc6e0e1 util::stop_magic_bullet_shield();
    var_edc6e0e1 notify(#"hash_e9b8a433");
    var_edc6e0e1.delete_on_death = 1;
    var_edc6e0e1 notify(#"death");
    if (!isalive(var_edc6e0e1)) {
        var_edc6e0e1 delete();
    }
}

// Namespace namespace_dc79b4d3
// Params 2, eflags: 0x0
// Checksum 0xb700811c, Offset: 0x4d28
// Size: 0x111
function function_62f55bbc(var_6d8dbcae, var_bb290d08) {
    if (!isdefined(var_bb290d08)) {
        var_bb290d08 = 0;
    }
    level endon(#"hash_7097d501");
    self endon(#"death");
    n_timer = randomfloatrange(2, 3) * 20;
    for (i = 0; i < n_timer; i++) {
        if (!var_bb290d08) {
            var_30299a05 = (randomintrange(-150, -106), randomintrange(-150, -106), randomintrange(-150, -106));
        } else {
            var_30299a05 = (0, 0, 0);
        }
        magicbullet(getweapon("turret_bo3_mil_vtol_nrc"), var_6d8dbcae gettagorigin("tag_gunner_barrel3") + (0, -40, 0), self.origin + var_30299a05);
        wait(0.05);
    }
}

// Namespace namespace_dc79b4d3
// Params 13, eflags: 0x0
// Checksum 0xb69591e6, Offset: 0x4e48
// Size: 0x6f
function function_3d8309dc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal) {
    return idamage * 5;
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x8956952f, Offset: 0x4ec0
// Size: 0x42
function function_86ce62c8() {
    level.var_5d4087a6 dialog::say("mare_taylor_primary_exfi_0");
    level dialog::remote("tayr_copy_that_rendezvou_0", undefined, "normal");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xa2aa323e, Offset: 0x4f10
// Size: 0x7a
function function_8798d583() {
    level endon(#"hash_18d7e7c0");
    level thread function_951308f0();
    wait(10);
    level.var_5d4087a6 dialog::say("mare_gotta_move_on_second_0");
    wait(5);
    level.var_5d4087a6 dialog::say("mare_move_your_ass_get_i_0");
    wait(5);
    level.var_5d4087a6 dialog::say("mare_that_drone_s_less_th_0");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0x765c3e95, Offset: 0x4f98
// Size: 0x23
function function_951308f0() {
    level trigger::wait_till("trig_all_players_in_int_builing");
    level notify(#"hash_18d7e7c0");
}

// Namespace namespace_dc79b4d3
// Params 0, eflags: 0x0
// Checksum 0xc07ff009, Offset: 0x4fc8
// Size: 0xfa
function function_401aadf2() {
    var_950ed8c6 = getnode("bridge_link_1", "targetname");
    linktraversal(var_950ed8c6);
    var_950ed8c6 = getnode("bridge_link_2", "targetname");
    linktraversal(var_950ed8c6);
    var_950ed8c6 = getnode("bridge_link_3", "targetname");
    linktraversal(var_950ed8c6);
    var_950ed8c6 = getnode("bridge_link_4", "targetname");
    linktraversal(var_950ed8c6);
    var_950ed8c6 = getnode("bridge_link_5", "targetname");
    linktraversal(var_950ed8c6);
}

