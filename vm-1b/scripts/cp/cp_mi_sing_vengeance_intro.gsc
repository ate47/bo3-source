#using scripts/cp/cp_mi_sing_vengeance_killing_streets;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/shared/stealth;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/turret_shared;
#using scripts/shared/math_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/animation_shared;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/cp/_load;
#using scripts/cp/_debug;
#using scripts/cp/gametypes/_save;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/cp/_dialog;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_8776ed6e;

// Namespace namespace_8776ed6e
// Params 2, eflags: 0x0
// Checksum 0xc734e65b, Offset: 0x1ec8
// Size: 0x132
function function_62616b71(str_objective, var_74cd64bc) {
    namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
    load::function_73adcefc();
    namespace_63b4601c::function_66773296("hendricks", str_objective);
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_2fd26037 ai::set_ignoreme(1);
    level.var_2fd26037.goalradius = 32;
    namespace_63b4601c::function_4e8207e9("intro");
    intro_screen(str_objective);
    videostop("cp_vengeance_env_sign_dancer01");
    wait 0.05;
    level thread namespace_63b4601c::function_ab876b5a("cp_vengeance_env_sign_dancer01", "strip_video_start", "strip_video_end");
    wait 0.05;
    level notify(#"strip_video_start");
    level.var_2fd26037 battlechatter::function_d9f49fba(0);
    intro_main(str_objective);
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x8d58aeee, Offset: 0x2008
// Size: 0x11a
function intro_main(str_objective) {
    foreach (e_player in level.players) {
        e_player thread apartment_light_fire_fx();
    }
    level thread function_21e6e30e();
    level flag::set("intro_wall_done");
    level thread function_6c1c9aad();
    level thread function_858195d5();
    level thread namespace_9fd035::function_d4c52995();
    savegame::checkpoint_save();
    thread cp_mi_sing_vengeance_sound::function_eb9cdcd9();
    level flag::wait_till("player_near_apartment_stairs");
    savegame::checkpoint_save();
    apartment_main();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x8900965d, Offset: 0x2130
// Size: 0xed
function apartment_light_fire_fx() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"start_takedown_igc");
    trigger = getent("apartment_light_fire_trigger", "targetname");
    while (true) {
        e_other = trigger waittill(#"trigger");
        if (e_other == self && isplayer(self)) {
            while (isdefined(self) && self istouching(trigger)) {
                if (!isdefined(self.apartment_light_fire)) {
                    self.apartment_light_fire = 1;
                    self clientfield::set_to_player("apartment_light_fire_fx", 1);
                }
                wait 0.05;
            }
            self.apartment_light_fire = undefined;
            self clientfield::set_to_player("apartment_light_fire_fx", 0);
        }
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x41cf2c9, Offset: 0x2228
// Size: 0x26a
function function_38736bb4() {
    level thread namespace_63b4601c::function_e3420328("intro_ambient_anims", "start_takedown_igc");
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "dead_civ1";
    var_6a07eb6c[1] = "dead_civ2";
    var_6a07eb6c[2] = "dead_civ3";
    var_6a07eb6c[3] = "dead_civ4";
    scene::add_scene_func("cin_ven_01_20_introstreet_bodies_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    var_4254e946 = [];
    var_4254e946[0] = "outside_dead_body_01";
    var_4254e946[1] = "outside_dead_body_02";
    var_4254e946[2] = "outside_dead_body_03";
    var_4254e946[3] = "outside_dead_body_04";
    var_4254e946[4] = "outside_dead_body_05";
    var_4254e946[5] = "outside_dead_body_06";
    var_4254e946[6] = "outside_dead_body_07";
    var_4254e946[7] = "outside_dead_body_08";
    var_4254e946[8] = "outside_dead_body_09";
    var_4254e946[9] = "outside_dead_body_10";
    scene::add_scene_func("cin_ven_01_25_outside_apt_bodies_vign", &namespace_63b4601c::function_65a61b78, "play", var_4254e946);
    var_685763af = [];
    var_685763af[0] = "inside_dead_body_01";
    var_685763af[1] = "inside_dead_body_02";
    var_685763af[2] = "inside_dead_body_03";
    scene::add_scene_func("cin_ven_02_05_inside_apt_bodies_vign", &namespace_63b4601c::function_65a61b78, "play", var_685763af);
    level thread scene::play("cin_ven_01_20_introstreet_bodies_vign");
    level thread scene::play("cin_ven_01_25_outside_apt_bodies_vign");
    level thread scene::play("cin_ven_02_05_inside_apt_bodies_vign");
    level flag::wait_till("start_takedown_igc");
    level thread scene::stop("cin_ven_01_20_introstreet_bodies_vign");
    level thread scene::stop("cin_ven_01_25_outside_apt_bodies_vign");
    level thread scene::stop("cin_ven_02_05_inside_apt_bodies_vign");
    namespace_63b4601c::function_4e8207e9("intro", 0);
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x3aefe386, Offset: 0x24a0
// Size: 0x162
function intro_screen(str_objective) {
    var_d3b2290d = struct::get("tag_align_intro", "targetname");
    namespace_63b4601c::function_ac2b4535("cin_ven_01_intro_3rd_sh070", "intro_igc_teleport");
    var_d3b2290d scene::init("cin_ven_01_intro_3rd_sh010");
    util::function_d8eaed3d(1);
    level thread function_38736bb4();
    level thread function_1c58a370();
    load::function_a2995f22();
    util::function_46d3a558(%CP_MI_SING_VENGEANCE_INTRO_LINE_1_FULL, %CP_MI_SING_VENGEANCE_INTRO_LINE_1_SHORT, %CP_MI_SING_VENGEANCE_INTRO_LINE_2_FULL, %CP_MI_SING_VENGEANCE_INTRO_LINE_2_SHORT, %CP_MI_SING_VENGEANCE_INTRO_LINE_3_FULL, %CP_MI_SING_VENGEANCE_INTRO_LINE_3_SHORT, %CP_MI_SING_VENGEANCE_INTRO_LINE_4_FULL, %CP_MI_SING_VENGEANCE_INTRO_LINE_4_SHORT);
    thread cp_mi_sing_vengeance_sound::function_4368969a();
    if (isdefined(level.var_42ed4e79)) {
        level thread [[ level.var_42ed4e79 ]]();
    }
    level thread namespace_9fd035::function_7dc66faa();
    var_d3b2290d scene::play("cin_ven_01_intro_3rd_sh010");
    level waittill(#"intro_igc_done");
    util::clear_streamer_hint();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x46fd9fa0, Offset: 0x2610
// Size: 0x1aa
function function_21e6e30e() {
    objectives::set("cp_level_vengeance_rescue_kane");
    objectives::set("cp_level_vengeance_go_to_safehouse");
    level flag::wait_till("send_hendricks_to_apartment_entrance");
    objectives::set("cp_waypoint_breadcrumb", struct::get("waypoint_intro1"));
    level flag::wait_till("apartment_entrance_door_open");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("waypoint_intro1"));
    level thread function_a1d4e729("breadcrumb_apartment1_triggered", "set_breadcrumb_apartment1", "breadcrumb_apartment1");
    level flag::wait_till("breadcrumb_apartment1_triggered");
    if (!level flag::get("breadcrumb_apartment1")) {
        level notify(#"hash_9f640c4a");
    }
    level thread function_a1d4e729("breadcrumb_apartment2_triggered", "set_breadcrumb_apartment2", "breadcrumb_apartment2");
    level flag::wait_till("breadcrumb_apartment2_triggered");
    if (!level flag::get("breadcrumb_apartment2")) {
        level notify(#"hash_9f640c4a");
    }
    level thread function_a1d4e729("breadcrumb_apartment3_triggered", "set_breadcrumb_apartment3", "breadcrumb_apartment3");
}

// Namespace namespace_8776ed6e
// Params 3, eflags: 0x0
// Checksum 0xb0615a5e, Offset: 0x27c8
// Size: 0x52
function function_a1d4e729(var_6fbdf20, wait_flag, breadcrumb) {
    level endon(var_6fbdf20);
    level flag::wait_till(wait_flag);
    level objectives::breadcrumb(breadcrumb);
    level flag::set(breadcrumb);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xf8b29222, Offset: 0x2828
// Size: 0xea
function function_1c58a370() {
    level endon(#"takedown_begin");
    vehicle::add_spawn_function("intro_street_technical", &function_52f443ca);
    vehicle::add_spawn_function("intro_street_technical2", &function_52f443ca);
    level flag::wait_till("send_hendricks_to_apartment_entrance");
    level thread cp_mi_sing_vengeance_sound::function_6dcacaf4();
    wait 1;
    intro_street_technical = vehicle::simple_spawn_single_and_drive("intro_street_technical");
    intro_street_technical2 = vehicle::simple_spawn_single_and_drive("intro_street_technical2");
    wait 0.25;
    intro_street_technical thread function_b36ddcbc();
    intro_street_technical2 thread function_b36ddcbc();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x6b93236a, Offset: 0x2920
// Size: 0x11d
function function_3b2e29a() {
    level endon(#"takedown_begin");
    count = 0;
    vehicle::add_spawn_function("intro_street_technical", &function_52f443ca);
    vehicle::add_spawn_function("intro_street_technical2", &function_52f443ca);
    while (count <= 75) {
        if (math::cointoss()) {
            intro_street_technical = vehicle::simple_spawn_single_and_drive("intro_street_technical");
        } else {
            intro_street_technical = vehicle::simple_spawn_single_and_drive("intro_street_technical");
            intro_street_technical2 = vehicle::simple_spawn_single_and_drive("intro_street_technical2");
        }
        count++;
        wait 0.25;
        intro_street_technical thread function_b36ddcbc();
        if (isdefined(intro_street_technical2)) {
            intro_street_technical2 thread function_b36ddcbc();
        }
        wait randomfloatrange(15, 20);
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xfce7fad7, Offset: 0x2a48
// Size: 0xb1
function function_52f443ca() {
    var_ae407c5 = [];
    var_5ee71f72 = array("driver", "gunner1");
    for (i = 0; i < var_5ee71f72.size; i++) {
        var_ae407c5[i] = spawner::simple_spawn_single("intro_street_technical_enemy1");
        if (isdefined(var_ae407c5[i])) {
            var_ae407c5[i] ai::set_ignoreall(1);
            var_ae407c5[i] vehicle::get_in(self, var_5ee71f72[i], 1);
        }
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x42cacde7, Offset: 0x2b08
// Size: 0x197
function function_b36ddcbc() {
    self endon(#"death");
    level endon(#"takedown_begin");
    self turret::set_burst_parameters(1, 2, 0.25, 0.75, 1);
    var_dfb53de7 = self vehicle::function_ad4ec07a("gunner1");
    if (isdefined(var_dfb53de7)) {
        var_153dcea0 = struct::get_array("intro_street_technical_fake_target", "targetname");
        fake_target = array::random(var_153dcea0);
        if (!isdefined(fake_target.ent)) {
            fake_target.ent = spawn("script_model", fake_target.origin);
            fake_target.ent setmodel("tag_origin");
            fake_target.ent.health = 1;
            fake_target.ent thread function_352b4f2e();
        }
        self thread turret::shoot_at_target(fake_target.ent, -1, undefined, 1, 0);
        var_dfb53de7 waittill(#"death");
        self notify(#"hash_c7d626");
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x1ecfde67, Offset: 0x2ca8
// Size: 0x32
function function_352b4f2e() {
    level flag::wait_till("takedown_begin");
    wait 1;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x7e133e10, Offset: 0x2ce8
// Size: 0x222
function function_6c1c9aad() {
    apt_door_l = getent("apt_door_l", "targetname");
    apt_door_l_clip = getent("apt_door_l_clip", "targetname");
    apt_door_l_clip linkto(apt_door_l);
    apt_door_r = getent("apt_door_r", "targetname");
    apt_door_r_clip = getent("apt_door_r_clip", "targetname");
    apt_door_r_clip linkto(apt_door_r);
    level.hendricks_apartment_anim_struct = struct::get("hendricks_apartment_anim_struct", "targetname");
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "dead_door_civilian";
    scene::add_scene_func("cin_ven_02_10_apthorror_enterbldg_vign", &namespace_63b4601c::function_65a61b78, "init", var_6a07eb6c);
    level.hendricks_apartment_anim_struct scene::init("cin_ven_02_10_apthorror_enterbldg_vign");
    level.var_af857373 = struct::get("hendricks_street_anim_struct", "targetname");
    level.hendricks_apartment_anim_struct scene::play("cin_ven_01_15_introstreet_walk_vign");
    if (!level flag::get("hendricks_move_to_apartment_building")) {
        level flag::wait_till("hendricks_move_to_apartment_building");
    }
    level thread function_8fc34056();
    wait 3.5;
    level thread cp_mi_sing_vengeance_sound::function_677a24e2();
    wait 1.5;
    level flag::set("apartment_entrance_door_open");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xe52fbcdf, Offset: 0x2f18
// Size: 0x19a
function function_8fc34056() {
    level endon(#"apartment_enemies_alerted");
    level endon(#"apartment_enemies_dead");
    level endon(#"synckill_scene_complete");
    level thread function_d5df9cca("breadcrumb_apartment1_triggered", "set_breadcrumb_apartment1");
    level thread function_d5df9cca("breadcrumb_apartment2_triggered", "set_breadcrumb_apartment2");
    level thread function_d5df9cca("breadcrumb_apartment3_triggered", "set_breadcrumb_apartment3");
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "dead_door_civilian";
    scene::add_scene_func("cin_ven_02_10_apthorror_enterbldg_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    level.hendricks_apartment_anim_struct scene::play("cin_ven_02_10_apthorror_enterbldg_vign");
    if (!level flag::get("breadcrumb_apartment1_triggered")) {
        level flag::wait_till("breadcrumb_apartment1_triggered");
    }
    level.hendricks_apartment_anim_struct scene::play("cin_ven_02_10_apthorror_firstfloorapt_vign");
    if (isdefined(level.var_46bdf616)) {
        level thread [[ level.var_46bdf616 ]]();
    }
    if (!level flag::get("player_near_apartment_stairs")) {
        level flag::wait_till("player_near_apartment_stairs");
    }
    level.hendricks_apartment_anim_struct scene::play("cin_ven_02_10_apthorror_secondfloorapt_vign");
}

// Namespace namespace_8776ed6e
// Params 2, eflags: 0x0
// Checksum 0x90ccd5d2, Offset: 0x30c0
// Size: 0x32
function function_d5df9cca(var_6fbdf20, var_1e583720) {
    level endon(var_6fbdf20);
    level.var_2fd26037 waittill(var_1e583720);
    level flag::set(var_1e583720);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xae8e149c, Offset: 0x3100
// Size: 0x122
function function_858195d5() {
    wait 2;
    level thread function_d259704f();
    level flag::wait_till("send_hendricks_to_apartment_entrance");
    wait 3;
    level thread dialog::function_13b3b16a("plyr_let_s_get_out_of_the_0");
    level flag::set("hendricks_move_to_apartment_building");
    wait 4.5;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_agreed_we_ll_cut_th_1");
    level flag::wait_till("hendricks_apartment_vo");
    level thread function_c55b72a5();
    level endon(#"apartment_enemies_alerted");
    level.var_2fd26037 util::waittill_either("noise_upstairs", "player_near_apartment_stairs");
    thread cp_mi_sing_vengeance_sound::function_afc6fda4();
    wait 1;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_contact_upstairs_ta_1");
    level dialog::function_13b3b16a("plyr_i_hear_it_0");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x88741438, Offset: 0x3230
// Size: 0x52
function function_d259704f() {
    level endon(#"send_hendricks_to_apartment_entrance");
    wait 1;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_it_s_a_god_damn_warz_0");
    wait 1;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_they_slaughtered_em_0");
    wait 0.5;
}

// Namespace namespace_8776ed6e
// Params 4, eflags: 0x0
// Checksum 0x3acad950, Offset: 0x3290
// Size: 0x122
function function_19a68bdb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh010");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh020");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh030");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh040");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh050");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh060");
    level struct::function_368120a1("scene", "cin_ven_01_intro_3rd_sh070");
    level struct::function_368120a1("scene", "cin_ven_01_15_introstreet_walk_vign");
}

// Namespace namespace_8776ed6e
// Params 2, eflags: 0x0
// Checksum 0xfddf5b4d, Offset: 0x33c0
// Size: 0x292
function function_5cb54255(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        util::function_ab12ef82("start_level");
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level thread function_38736bb4();
        level.hendricks_apartment_anim_struct = struct::get("hendricks_apartment_anim_struct", "targetname");
        level.hendricks_apartment_anim_struct thread scene::play("cin_ven_02_10_apthorror_secondfloorapt_vign");
        level thread function_d5df9cca("breadcrumb_apartment3_triggered", "set_breadcrumb_apartment3");
        level thread function_a1d4e729("breadcrumb_apartment3_triggered", "set_breadcrumb_apartment3", "breadcrumb_apartment3");
        level flag::wait_till("all_players_spawned");
        level flag::set("start_level");
        videostop("cp_vengeance_env_sign_dancer01");
        wait 0.05;
        level thread namespace_63b4601c::function_ab876b5a("cp_vengeance_env_sign_dancer01", "strip_video_start", "strip_video_end");
        wait 0.05;
        level notify(#"strip_video_start");
        foreach (e_player in level.players) {
            e_player thread apartment_light_fire_fx();
        }
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
    }
    apartment_main();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x8f914c39, Offset: 0x3660
// Size: 0xd2
function apartment_main() {
    thread cp_mi_sing_vengeance_sound::apartment_init();
    level flag::set("apartment_begin");
    level.bedroom_anim_struct = struct::get("bedroom_anim_struct", "targetname");
    level thread function_99eb6152();
    level thread function_5274de79();
    level thread function_5ef7fdc2();
    level thread function_b3c6efd1();
    level thread function_7acb5fc4();
    level flag::wait_till("apartment_complete");
    skipto::function_be8adfb8("intro");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x1dca17f0, Offset: 0x3740
// Size: 0x7a
function function_99eb6152() {
    level flag::wait_till("breadcrumb_apartment3_triggered");
    if (!level flag::get("breadcrumb_apartment3")) {
        level notify(#"hash_9f640c4a");
    }
    level waittill(#"hash_cf441b58");
    objectives::set("cp_waypoint_breadcrumb", struct::get("waypoint_intro5"));
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x2ea0b903, Offset: 0x37c8
// Size: 0x562
function function_5274de79() {
    level.var_2fd26037 ai::set_ignoreme(1);
    level flag::wait_till_any(array("apartment_enemies_alerted", "synckill_scene_complete", "apartment_enemies_dead"));
    level.var_2fd26037 ai::set_ignoreme(0);
    wait 0.05;
    if (level.hendricks_apartment_anim_struct scene::is_playing("cin_ven_02_10_apthorror_enterbldg_vign")) {
        level.hendricks_apartment_anim_struct scene::stop("cin_ven_02_10_apthorror_enterbldg_vign");
    }
    if (level.hendricks_apartment_anim_struct scene::is_playing("cin_ven_02_10_apthorror_firstfloorapt_vign")) {
        level.hendricks_apartment_anim_struct scene::stop("cin_ven_02_10_apthorror_firstfloorapt_vign");
    }
    if (level.hendricks_apartment_anim_struct scene::is_playing("cin_ven_02_10_apthorror_secondfloorapt_vign")) {
        level.hendricks_apartment_anim_struct scene::stop("cin_ven_02_10_apthorror_secondfloorapt_vign");
    }
    level.hendricks_apartment_anim_struct scene::stop();
    level.var_2fd26037 stopanimscripted();
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    if (!level flag::get("apartment_enemies_dead")) {
        level.var_2fd26037.goalradius = 16;
        node = getnode("hendricks_syncshot_node", "targetname");
        level.var_2fd26037 setgoalnode(node);
        level.var_2fd26037 ai::set_ignoreall(0);
        level.var_2fd26037 ai::set_ignoreme(0);
        level.var_2fd26037.var_df53bc6 = level.var_2fd26037.script_accuracy;
        level.var_2fd26037.script_accuracy = 0.1;
        level flag::wait_till_timeout(8, "apartment_enemies_dead");
        if (!level flag::get("apartment_enemies_dead")) {
            if (isdefined(level.var_2fd26037.var_df53bc6)) {
                level.var_2fd26037.script_accuracy = level.var_2fd26037.var_df53bc6;
            }
            level flag::wait_till("apartment_enemies_dead");
        }
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        if (isdefined(level.var_2fd26037.var_df53bc6)) {
            level.var_2fd26037.script_accuracy = level.var_2fd26037.var_df53bc6;
        }
    }
    level thread function_dcf3d41b();
    node = getnode("hendricks_bedroom_door_node", "targetname");
    level.var_2fd26037 setgoal(node);
    level.var_2fd26037 waittill(#"goal");
    level thread util::function_d8eaed3d(2);
    level thread function_ee2ef2f3();
    level.bedroom_anim_struct thread scene::play("cin_ven_02_30_masterbedroom_vign");
    wait 11;
    node = getnode("hendricks_takedown_rooftop_node", "targetname");
    level.var_2fd26037 setgoal(node);
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    clip = getent("chair_a_clip_top", "targetname");
    if (isdefined(clip)) {
        clip delete();
    }
    wait 2;
    level thread function_caf96976();
    level.bedroom_anim_struct waittill(#"scene_done");
    level notify(#"hash_cf441b58");
    level flag::set("bedroom_scene_complete");
    level flag::wait_till("player_on_takedown_rooftop");
    gunfire_behind_window = getentarray("gunfire_behind_window", "targetname");
    foreach (card in gunfire_behind_window) {
        card hide();
    }
    level flag::set("apartment_complete");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xe5365afa, Offset: 0x3d38
// Size: 0x52
function function_dcf3d41b() {
    if (!level flag::get("hendricks_on_second_floor_apartment")) {
        level flag::wait_till("hendricks_on_second_floor_apartment");
    }
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x83da53b2, Offset: 0x3d98
// Size: 0x34a
function function_5ef7fdc2() {
    level.var_1dca7888 = [];
    var_71e5f989 = getentarray("apartment_enemy", "script_noteworthy");
    apartment_enemy = spawner::simple_spawn(var_71e5f989, &function_1f707d1e);
    var_12d51ad2 = getentarray("apartment_civilian", "script_noteworthy");
    apartment_civilian = spawner::simple_spawn(var_12d51ad2, &function_a645cfd9);
    bedroom_door_right = getent("bedroom_door_right", "targetname");
    bedroom_door_right_clip = getent("bedroom_door_right_clip", "targetname");
    bedroom_door_right_clip linkto(bedroom_door_right);
    bedroom_door_left = getent("bedroom_door_left", "targetname");
    bedroom_door_left_clip = getent("bedroom_door_left_clip", "targetname");
    bedroom_door_left_clip linkto(bedroom_door_left);
    level.bedroom_anim_struct thread scene::init("cin_ven_02_20_synckill_vign");
    level.var_7819b21b = level.var_1dca7888.size;
    namespace_523da15d::function_dab879d0();
    trigger = getent("syncshot_lookat_trigger", "targetname");
    foreach (player in level.players) {
        player thread function_4e050c10(trigger, "syncshot_lookat_failsafe");
    }
    trigger = getent("syncshot_stair_lookat_trigger", "targetname");
    foreach (player in level.players) {
        player thread function_4e050c10(trigger, "syncshot_lookat_failsafe");
    }
    level flag::wait_till_any(array("player_looking", "syncshot_lookat_failsafe"));
    level notify(#"hash_5262905a");
    level thread function_7f6de599();
    level flag::wait_till_any(array("apartment_enemies_alerted", "synckill_scene_complete", "apartment_enemies_dead"));
}

// Namespace namespace_8776ed6e
// Params 2, eflags: 0x0
// Checksum 0x67d0325b, Offset: 0x40f0
// Size: 0xb9
function function_4e050c10(trigger, var_6fbdf20) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"player_looking");
    if (isdefined(var_6fbdf20)) {
        level endon(var_6fbdf20);
    }
    trigger_target = struct::get(trigger.target, "targetname");
    while (true) {
        if (self istouching(trigger)) {
            if (util::is_player_looking_at(trigger_target.origin, 0.6, 1)) {
                level flag::set("player_looking");
                break;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x6bd90303, Offset: 0x41b8
// Size: 0x6a
function function_7f6de599() {
    level endon(#"apartment_enemies_alerted");
    level.bedroom_anim_struct thread scene::play("cin_ven_02_20_synckill_vign");
    thread cp_mi_sing_vengeance_sound::function_57ec1ad7();
    wait 0.25;
    level.bedroom_anim_struct waittill(#"scene_done");
    level flag::set("synckill_scene_complete");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x2aa8f1fb, Offset: 0x4230
// Size: 0x122
function function_1f707d1e() {
    self endon(#"death");
    array::add(level.var_1dca7888, self);
    self.goalradius = 32;
    if (isdefined(self.targetname)) {
        if (self.targetname == "synckill_enemy1_ai") {
            level.var_657f947a = self;
        }
        if (self.targetname == "synckill_enemy2_ai") {
            level.var_3f7d1a11 = self;
        }
        if (self.targetname == "synckill_enemy3_ai") {
            level.var_197a9fa8 = self;
        }
    }
    level flag::wait_till_any(array("player_looking", "syncshot_lookat_failsafe"));
    self thread function_fb5e09cf();
    if (self.targetname == "synckill_enemy2_ai") {
        self thread function_3a005b50();
        self waittill(#"killable_now");
        self.allowdeath = 1;
    }
    self thread apartment_enemies_alerted();
    self thread function_5a4b0113();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xb60a2a13, Offset: 0x4360
// Size: 0x52
function function_3a005b50() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self util::waittill_any("damage", "alert", "killable_now");
    self ai::set_ignoreme(0);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xa473ff0, Offset: 0x43c0
// Size: 0x2a
function function_a645cfd9() {
    self.ignoreme = 1;
    self.team = "allies";
    self disableaimassist();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x5749798e, Offset: 0x43f8
// Size: 0x7a
function function_fb5e09cf() {
    self waittill(#"death");
    if (!level flag::get("apartment_enemy_dead")) {
        level flag::set("apartment_enemy_dead");
    }
    level.var_1dca7888 = array::remove_dead(level.var_1dca7888);
    if (level.var_1dca7888.size == 0) {
        level flag::set("apartment_enemies_dead");
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x2fff7e8a, Offset: 0x4480
// Size: 0x52
function function_5a4b0113() {
    self endon(#"death");
    level endon(#"synckill_scene_complete");
    state = self waittill(#"alert");
    if (!level flag::get("apartment_enemies_alerted")) {
        level flag::set("apartment_enemies_alerted");
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x2c3418a5, Offset: 0x44e0
// Size: 0xf2
function apartment_enemies_alerted() {
    self endon(#"death");
    level flag::wait_till_any(array("apartment_enemies_alerted", "synckill_scene_complete", "syncshot_lookat_failsafe"));
    if (level flag::get("syncshot_lookat_failsafe")) {
        wait 0.25;
    }
    self notify(#"alert");
    if (level flag::get("apartment_enemies_alerted") || level flag::get("syncshot_lookat_failsafe")) {
        self stopanimscripted();
        wait 0.05;
    }
    node = getnode(self.target, "targetname");
    self setgoal(node, 1, 8);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x150d3262, Offset: 0x45e0
// Size: 0x6a
function function_b3c6efd1() {
    level flag::wait_till("player_near_apartment_stairs");
    wait 0.5;
    level.var_2fd26037 notify(#"player_near_apartment_stairs");
    level thread function_cce1e811();
    level.var_2fd26037 waittill(#"plyr_once_we_find_her_n_0");
    level dialog::function_13b3b16a("plyr_once_we_find_her_n_0");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x728f28b3, Offset: 0x4658
// Size: 0x9a
function function_cce1e811() {
    level endon(#"apartment_enemies_alerted");
    level endon(#"apartment_enemies_dead");
    if (!level flag::get("hendricks_on_second_floor_apartment")) {
        level flag::wait_till("hendricks_on_second_floor_apartment");
    }
    if (!level flag::get("player_is_upstairs")) {
        level flag::wait_till("player_is_upstairs");
    }
    wait 2;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_take_them_out_1");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xc04cfd11, Offset: 0x4700
// Size: 0x8c
function function_c55b72a5() {
    level endon(#"hash_a2cf5f81");
    bedroom_audio_origin = getent("bedroom_audio_origin", "targetname");
    level thread function_a5bf9c17(bedroom_audio_origin);
    level flag::wait_till_any(array("apartment_enemies_alerted", "syncshot_lookat_failsafe"));
    level notify(#"hash_3962ec94");
    bedroom_audio_origin notify(#"hash_3962ec94");
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0xb9073df1, Offset: 0x4798
// Size: 0x1ba
function function_a5bf9c17(bedroom_audio_origin) {
    level endon(#"apartment_enemies_alerted");
    level endon(#"apartment_enemy_dead");
    bedroom_audio_origin = getent("bedroom_audio_origin", "targetname");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim1_what_are_you_going_t_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("mciv_leave_us_alone_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim2_no_no_he_s_mine_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim2_death_will_be_quick_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("mciv_what_s_wrong_with_yo_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim1_you_did_plenty_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim1_all_of_you_have_liv_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim2_tell_her_goodbye_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("mciv_no_0");
    wait 2;
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim3_now_it_s_your_turn_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim1_no_one_s_left_to_sav_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim3_i_want_a_piece_of_he_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim3_you_ll_get_them_one_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim2_the_last_one_died_to_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim1_is_that_your_daughte_0");
    bedroom_audio_origin namespace_63b4601c::function_5fbec645("ffim2_i_bet_she_s_soft_0");
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0xf18c5d1, Offset: 0x4960
// Size: 0xbd
function function_4bd6211(bedroom_audio_origin) {
    level endon(#"hash_5262905a");
    var_2ab10bee = [];
    var_2ab10bee[0] = "fciv_crying_hysterically_0";
    var_2ab10bee[1] = "fciv_crying_hysterically_1";
    var_2ab10bee[2] = "fciv_crying_hysterically_2";
    var_2ab10bee[3] = "fciv_crying_hysterically_3";
    var_2ab10bee[4] = "fciv_crying_hysterically_4";
    var_2ab10bee[5] = "fciv_crying_hysterically_5";
    while (true) {
        var_616d3e3e = array::random(var_2ab10bee);
        bedroom_audio_origin namespace_63b4601c::function_5fbec645(var_616d3e3e);
        wait randomfloatrange(0.5, 2);
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x3e34a390, Offset: 0x4a28
// Size: 0x30b
function function_7acb5fc4() {
    level.bedroom_anim_struct scene::init("cin_ven_02_30_masterbedroom_vign");
    wait 0.5;
    var_dad63b6d = [];
    chair_a = getent("chair_a", "targetname");
    array::add(var_dad63b6d, chair_a);
    chair_a_clip = getent("chair_a_clip", "targetname");
    array::add(var_dad63b6d, chair_a_clip);
    chair_a_clip linkto(chair_a);
    door_exit = getent("door_exit", "targetname");
    array::add(var_dad63b6d, door_exit);
    door_exit_clip = getent("door_exit_clip", "targetname");
    array::add(var_dad63b6d, door_exit_clip);
    door_exit_clip linkto(door_exit);
    var_7f0731c6 = door_exit.origin;
    var_c815eaa0 = door_exit.angles;
    civilians = [];
    civilians[civilians.size] = getent("synckill_dead_civilian_ai", "targetname");
    civilians[civilians.size] = getent("synckill_husband_ai", "targetname");
    civilians[civilians.size] = getent("synckill_wife_ai", "targetname");
    foreach (civ in civilians) {
        civ.ignoreme = 1;
    }
    level flag::wait_till("start_takedown_igc");
    door_exit stopanimscripted();
    door_exit.origin = var_7f0731c6;
    door_exit.angles = var_c815eaa0;
    level flag::wait_till("start_dogleg_1_intro");
    foreach (prop in var_dad63b6d) {
        if (isdefined(prop)) {
            prop delete();
        }
    }
}

// Namespace namespace_8776ed6e
// Params 4, eflags: 0x0
// Checksum 0xf1bceb7e, Offset: 0x4d40
// Size: 0x22
function function_4762cf8f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_8776ed6e
// Params 2, eflags: 0x0
// Checksum 0x9a67b5d2, Offset: 0x4d70
// Size: 0x2da
function function_20681e14(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        function_ee2ef2f3();
        while (!level scene::is_ready("cin_ven_03_10_takedown_intro_1st")) {
            wait 0.05;
        }
        while (!level scene::is_ready("cin_ven_03_10_takedown_intro_1st_props")) {
            wait 0.05;
        }
        while (!level scene::is_ready("cin_ven_01_02_rooftop_1st_overlook")) {
            wait 0.05;
        }
        videostop("cp_vengeance_env_sign_dancer01");
        wait 0.05;
        level thread namespace_63b4601c::function_ab876b5a("cp_vengeance_env_sign_dancer01", "strip_video_start", "strip_video_end");
        wait 0.05;
        level notify(#"strip_video_start");
        objectives::set("cp_waypoint_breadcrumb", struct::get("waypoint_intro5"));
        level thread function_caf96976();
        gunfire_behind_window = getentarray("gunfire_behind_window", "targetname");
        foreach (card in gunfire_behind_window) {
            card hide();
        }
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        level util::function_d8eaed3d(2);
        load::function_a2995f22();
    }
    thread cp_mi_sing_vengeance_sound::function_7be69db9();
    level flag::set("takedown_begin");
    takedown_main(var_74cd64bc);
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x699f946f, Offset: 0x5058
// Size: 0x8a
function takedown_main(var_74cd64bc) {
    level thread function_e522974a(var_74cd64bc);
    level thread function_e670b187();
    level thread function_f3b5323a();
    level thread function_4ac99079();
    level thread start_killing_streets_ambient_anims();
    level flag::wait_till("takedown_complete");
    skipto::function_be8adfb8("takedown");
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x74ff7f0, Offset: 0x50f0
// Size: 0xf3
function function_e522974a(var_74cd64bc) {
    gunfire_behind_window = getentarray("gunfire_behind_window", "targetname");
    foreach (card in gunfire_behind_window) {
        card hide();
    }
    function_fb3f26d6(var_74cd64bc);
    foreach (card in gunfire_behind_window) {
        card hide();
    }
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x6acef7a0, Offset: 0x51f0
// Size: 0x463
function function_fb3f26d6(var_74cd64bc) {
    level endon(#"start_takedown_igc");
    if (isdefined(var_74cd64bc) && var_74cd64bc) {
        wait 1;
    }
    level flag::clear("player_looking");
    trigger = getent("takedown_window_gunfire_trigger", "targetname");
    foreach (player in level.players) {
        player thread function_4e050c10(trigger, "start_takedown_igc");
    }
    level flag::wait_till("player_looking");
    gunfire_behind_window = getentarray("gunfire_behind_window", "targetname");
    start = struct::get("takedown_window_gunfire_magicbullet_start", "targetname");
    end = struct::get("takedown_window_gunfire_magicbullet_end", "targetname");
    wait 1;
    foreach (card in gunfire_behind_window) {
        card show();
    }
    magicbullet(level.var_2fd26037.weapon, start.origin, end.origin);
    playsoundatposition("evt_apt_win_gunfire_1", (20497, -4382, 492));
    wait 0.15;
    foreach (card in gunfire_behind_window) {
        card hide();
    }
    wait 0.1;
    foreach (card in gunfire_behind_window) {
        card show();
    }
    magicbullet(level.var_2fd26037.weapon, start.origin, end.origin);
    playsoundatposition("evt_apt_win_gunfire_2", (20497, -4382, 492));
    wait 0.15;
    foreach (card in gunfire_behind_window) {
        card hide();
    }
    wait 0.5;
    foreach (card in gunfire_behind_window) {
        card show();
    }
    magicbullet(level.var_2fd26037.weapon, start.origin, end.origin);
    playsoundatposition("evt_apt_win_gunfire_3", (20497, -4382, 492));
    wait 0.15;
    foreach (card in gunfire_behind_window) {
        card hide();
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x930804f5, Offset: 0x5660
// Size: 0x3a
function start_killing_streets_ambient_anims() {
    level flag::wait_till("start_killing_streets_ambient_anims");
    level thread namespace_63b4601c::function_e3420328("killing_streets_ambient_anims", "dogleg_1_begin");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x2876cac, Offset: 0x56a8
// Size: 0xba
function function_e670b187() {
    level flag::wait_till("start_takedown_igc");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("waypoint_intro5"));
    level waittill(#"takedown_backup_enemies_dead");
    objectives::set("cp_waypoint_breadcrumb", struct::get("waypoint_intro6"));
    level waittill(#"hash_bfaac156");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("waypoint_intro6"));
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x69b94397, Offset: 0x5770
// Size: 0xab
function function_f3b5323a() {
    level flag::wait_till("start_takedown_igc");
    wait 1.5;
    level thread function_d07dfdc1();
    level waittill(#"hash_d1668ed6");
    level thread namespace_9fd035::function_e18f629a();
    level.var_2fd26037 waittill(#"plyr_this_is_what_happens_0");
    level dialog::function_13b3b16a("plyr_this_is_what_happens_0");
    level dialog::function_13b3b16a("plyr_we_get_kane_then_w_0");
    level dialog::function_13b3b16a("plyr_we_don_t_leave_one_o_0");
    level notify(#"hash_c791440b");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x73ce432c, Offset: 0x5828
// Size: 0x3c
function function_d07dfdc1() {
    level endon(#"takedown_backup_enemies_dead");
    level waittill(#"hash_9c3eb25d");
    wait 2;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_more_enemies_inboun_0");
    level waittill(#"hash_c1a33016");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x59855d11, Offset: 0x5870
// Size: 0x122
function function_caf96976() {
    level endon(#"start_takedown_igc");
    takedown_enemy_leader_audio_origin = getent("takedown_enemy_leader_audio_origin", "targetname");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_today_we_rise_agains_0");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_these_things_do_not_0");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_do_not_make_it_quick_0");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_they_are_the_oppress_0");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_every_drop_of_their_0");
    takedown_enemy_leader_audio_origin namespace_63b4601c::function_5fbec645("ffim1_today_the_immortals_0");
    takedown_enemy_leader_audio_origin thread namespace_63b4601c::function_5fbec645("ffim2_yeaaaaahhh_an_0");
    takedown_enemy_leader_audio_origin thread namespace_63b4601c::function_5fbec645("ffim3_death_to_the_oppress_0");
    takedown_enemy_leader_audio_origin thread namespace_63b4601c::function_5fbec645("ffif0_aaaahhhhhh_0");
    takedown_enemy_leader_audio_origin thread namespace_63b4601c::function_5fbec645("ffim2_immorrrtaalllls_0");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x52e8a3a6, Offset: 0x59a0
// Size: 0x4d
function function_c6be5e1d() {
    var_e022aef3 = getent("takedown_igc_trigger", "targetname");
    var_e022aef3 endon(#"death");
    var_e022aef3 trigger::wait_till();
    return var_e022aef3.who;
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xafdfba06, Offset: 0x59f8
// Size: 0x7fa
function function_4ac99079() {
    level.var_3d63f698 thread scene::init("cin_ven_03_11_gate_convo_vign");
    takedown_gate_right = getent("takedown_gate_right", "targetname");
    takedown_gate_right thread takedown_cleanup();
    takedown_gate_right_clip = getent("takedown_gate_right_clip", "targetname");
    takedown_gate_right_clip thread takedown_cleanup();
    takedown_gate_right_clip linkto(takedown_gate_right, "tag_animate");
    takedown_gate_left = getent("takedown_gate_left", "targetname");
    takedown_gate_left thread takedown_cleanup();
    takedown_gate_left_clip = getent("takedown_gate_left_clip", "targetname");
    takedown_gate_left_clip thread takedown_cleanup();
    takedown_gate_left_clip linkto(takedown_gate_left, "tag_animate");
    var_fde961b5 = function_c6be5e1d();
    level flag::wait_till("start_takedown_igc");
    level function_a2b65bd2(var_fde961b5);
    level thread cp_mi_sing_vengeance_sound::function_4ac99079();
    if (isdefined(level.var_48158b2b)) {
        level thread function_497db06c();
    } else {
        if (isdefined(level.var_72ec1fc6)) {
            level thread [[ level.var_72ec1fc6 ]]();
        }
        level.var_3d63f698 thread scene::play("cin_ven_03_10_takedown_intro_1st");
        level.var_3d63f698 thread scene::play("cin_ven_03_10_takedown_intro_1st_props");
        level.var_3d63f698 thread scene::play("cin_ven_01_02_rooftop_1st_overlook");
        level thread function_ca15fd13();
        level.var_2fd26037 waittill(#"takedown_start");
        level.var_2fd26037 cybercom::function_f8669cbf(1);
    }
    util::clear_streamer_hint();
    level thread function_94b3c083();
    level thread function_64be6dbe();
    foreach (enemy in level.var_138e6961) {
        if (isalive(enemy)) {
            enemy.goalradius = 32;
            enemy setgoalpos(enemy.origin, 1);
            enemy.health = 40;
            enemy ai::set_ignoreall(0);
            enemy ai::set_ignoreme(0);
        }
    }
    level.var_2fd26037 waittill(#"hash_955d6809");
    level.var_6e0b32d8 = level.var_d9f6d6.size;
    namespace_523da15d::function_b510823b();
    setslowmotion(1, 0.3, 0.3);
    foreach (player in level.activeplayers) {
        player setmovespeedscale(0.3);
    }
    level.var_2fd26037 waittill(#"stop_slowmo");
    thread cp_mi_sing_vengeance_sound::function_69fc18eb();
    setslowmotion(0.3, 1);
    foreach (player in level.activeplayers) {
        player setmovespeedscale(1);
    }
    level.var_2fd26037 setgoalpos(level.var_2fd26037.origin, 1);
    level.var_2fd26037 battlechatter::function_d9f49fba(1);
    level thread function_9c3eb25d();
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    level.var_138e6961 = array::remove_dead(level.var_138e6961);
    if (level.var_138e6961.size > 0) {
        foreach (enemy in level.var_138e6961) {
            if (isalive(enemy)) {
                magicbullet(level.var_2fd26037.weapon, level.var_2fd26037 gettagorigin("tag_flash"), enemy gettagorigin("j_head"), level.var_2fd26037, enemy);
                level.var_2fd26037 thread ai::shoot_at_target("kill_within_time", enemy, "j_head", 0.1);
                enemy waittill(#"death");
            }
        }
    }
    if (isdefined(level.var_e7c1ffa) && level.var_e7c1ffa.size > 0) {
        node = getnode("hendricks_takedown_backup_node", "targetname");
        level.var_2fd26037 setgoalnode(node);
        level.var_2fd26037 ai::disable_pain();
        level.var_2fd26037 thread function_44b7b533();
        while (level.var_e7c1ffa.size > 0) {
            level.var_e7c1ffa = array::remove_dead(level.var_e7c1ffa);
            wait 1;
        }
        level.var_2fd26037 ai::enable_pain();
        level notify(#"takedown_backup_enemies_dead");
    }
    level thread namespace_62b73aed::function_9736d8c9();
    level thread namespace_62b73aed::function_8704e5f();
    level.var_3d63f698 thread scene::play("cin_ven_03_11_gate_convo_vign");
    level notify(#"hash_d1668ed6");
    if (isdefined(level.var_df45f1f3)) {
        level thread [[ level.var_df45f1f3 ]]();
    }
    level.var_2fd26037 setgoalpos(level.var_2fd26037.origin, 1);
    node = getnode("killing_streets_hendricks_node_03", "targetname");
    level.var_2fd26037 setgoal(node, 1, 16);
    wait 15;
    level notify(#"hash_bfaac156");
    level.var_3d63f698 waittill(#"scene_done");
    level flag::set("takedown_complete");
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0x26bf0291, Offset: 0x6200
// Size: 0xcb
function function_a2b65bd2(var_fde961b5) {
    var_687222b4 = 2;
    foreach (player in level.activeplayers) {
        if (player === var_fde961b5) {
            player.var_efe0572d = "cin_ven_03_10_takedown_intro_1st_p1";
            player.var_ac3f2f23 = "cin_ven_03_10_takedown_1st_p1";
            continue;
        }
        player.var_efe0572d = "cin_ven_03_10_takedown_intro_1st_p" + var_687222b4;
        player.var_ac3f2f23 = "cin_ven_03_10_takedown_1st_p" + var_687222b4;
        var_687222b4++;
        player.play_scene_transition_effect = 1;
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x21da9155, Offset: 0x62d8
// Size: 0x63
function function_ca15fd13() {
    foreach (player in level.activeplayers) {
        player thread function_b5ab443b();
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x82ef8ed2, Offset: 0x6348
// Size: 0x4a
function function_b5ab443b() {
    self endon(#"death");
    level.var_3d63f698 scene::play(self.var_efe0572d, self);
    level.var_3d63f698 scene::play(self.var_ac3f2f23, self);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xea2f1ef9, Offset: 0x63a0
// Size: 0xc2
function function_497db06c() {
    level.var_3d63f698 thread scene::play("cin_ven_01_02_rooftop_1st_overlook", level.var_48158b2b);
    level.var_3d63f698 thread scene::play("cin_ven_03_10_takedown_intro_1st_props");
    level.var_3d63f698 scene::play("cin_ven_03_10_takedown_intro_1st_test", level.var_d60e1bf0);
    level.var_3d63f698 thread scene::play("cin_ven_03_10_takedown_1st_hendricks", level.var_2fd26037);
    level.var_3d63f698 thread scene::play("cin_ven_03_10_takedown_1st", level.var_fc109659);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xe12fe0bb, Offset: 0x6470
// Size: 0x22
function function_94b3c083() {
    level.var_2fd26037 waittill(#"stop_slowmo");
    level namespace_63b4601c::function_a084a58f();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x63732611, Offset: 0x64a0
// Size: 0x4a
function function_44b7b533() {
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.2;
    level util::waittill_notify_or_timeout("takedown_backup_enemies_dead", 8);
    self.script_accuracy = self.var_df53bc6;
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x8cfd8fb5, Offset: 0x64f8
// Size: 0x3cb
function function_9c3eb25d() {
    vehicle::add_spawn_function("takedown_backup_truck", &function_296cfddf);
    takedown_backup_truck = vehicle::simple_spawn_single_and_drive("takedown_backup_truck");
    takedown_backup_truck vehicle::lights_off();
    level.var_e7c1ffa = [];
    var_6d37ea3 = 5;
    for (i = 0; i < var_6d37ea3; i++) {
        spawner = spawner::simple_spawn_single("takedown_backup_right_ai");
        spawner.script_noteworthy = "takedown_backup_right_" + i;
        spawner thread function_4d5e399c();
    }
    level notify(#"hash_9c3eb25d");
    wait 0.25;
    level.var_e7c1ffa = array::remove_dead(level.var_e7c1ffa);
    ai::waittill_dead(level.var_e7c1ffa, 3);
    volume = getent("takedown_backup_volume", "targetname");
    foreach (ai in level.var_e7c1ffa) {
        if (isdefined(ai) && isalive(ai)) {
            ai setgoalvolume(volume);
            wait randomfloatrange(0.3, 0.75);
        }
    }
    if (level.activeplayers.size == 1) {
        var_67bf54e = 2;
    }
    if (level.activeplayers.size == 2) {
        var_67bf54e = 2;
    }
    if (level.activeplayers.size == 3) {
        var_67bf54e = 3;
    }
    if (level.activeplayers.size == 4) {
        var_67bf54e = 3;
    }
    if (isdefined(var_67bf54e)) {
        for (i = 0; i < var_67bf54e; i++) {
            spawner = spawner::simple_spawn_single("takedown_backup_right_ai");
            spawner.script_noteworthy = "takedown_backup_right_extra_" + i;
            spawner thread function_4d5e399c();
        }
    }
    wait 0.25;
    level.var_e7c1ffa = array::remove_dead(level.var_e7c1ffa);
    ai::waittill_dead(level.var_e7c1ffa, 3);
    level notify(#"hash_c1a33016");
    while (level.var_e7c1ffa.size > 3) {
        level.var_e7c1ffa = array::remove_dead(level.var_e7c1ffa);
        wait 0.05;
    }
    volume = getent("takedown_backup_front_volume", "targetname");
    foreach (ai in level.var_e7c1ffa) {
        if (isdefined(ai) && isalive(ai)) {
            ai setgoalvolume(volume);
            wait randomfloatrange(0.3, 0.75);
        }
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x9142bfc4, Offset: 0x68d0
// Size: 0x2a
function function_52c5929b() {
    self waittill(#"goal");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x652c5b50, Offset: 0x6908
// Size: 0x11a
function function_296cfddf() {
    self endon(#"death");
    self thread takedown_cleanup();
    var_ae407c5 = [];
    var_5ee71f72 = array("driver", "passenger1", "gunner1");
    for (i = 0; i < var_5ee71f72.size; i++) {
        var_ae407c5[i] = spawner::simple_spawn_single("takedown_backup_truck_ai");
        var_ae407c5[i] thread function_4d5e399c();
        if (isdefined(var_ae407c5[i])) {
            var_ae407c5[i].script_noteworthy = var_5ee71f72[i];
            var_ae407c5[i] vehicle::get_in(self, var_5ee71f72[i], 1);
        }
    }
    self thread function_8fb2d768();
    level waittill(#"hash_ea1f086f");
    level flag::set("takedown_backup_truck_stopped_flag");
    self disconnectpaths();
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x80f52fa9, Offset: 0x6a30
// Size: 0x112
function function_8fb2d768() {
    self endon(#"death");
    self flag::init("gunner_position_occupied");
    self turret::set_burst_parameters(1, 2, 0.25, 0.75, 1);
    var_dfb53de7 = self vehicle::function_ad4ec07a("gunner1");
    if (isdefined(var_dfb53de7)) {
        self turret::enable(1, 1);
        self flag::set("gunner_position_occupied");
        var_dfb53de7 waittill(#"death");
    }
    self turret::disable(1);
    self flag::clear("gunner_position_occupied");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xeca51b28, Offset: 0x6b50
// Size: 0x492
function function_4d5e399c() {
    self endon(#"death");
    array::add(level.var_e7c1ffa, self);
    if (isdefined(self.targetname) && self.targetname == "takedown_backup_right_ai_ai") {
        self setgoalpos(self.origin, 1);
        self ai::set_ignoreall(1);
        self ai::set_ignoreme(1);
        if (!level flag::get("takedown_backup_truck_stopped_flag")) {
            level flag::wait_till("takedown_backup_truck_stopped_flag");
        }
        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "takedown_backup_right_3" || self.script_noteworthy == "takedown_backup_right_4" || self.script_noteworthy == "takedown_backup_right_extra_2") {
            volume = getent("takedown_backup_middle_volume", "targetname");
            wait randomfloatrange(1, 3);
        } else {
            volume = getent("takedown_backup_left_volume", "targetname");
            wait randomfloatrange(0.3, 0.75);
        }
        self setgoalvolume(volume);
        self waittill(#"goal");
        self ai::set_ignoreall(0);
        self ai::set_ignoreme(0);
    }
    if (isdefined(self.targetname) && self.targetname == "takedown_backup_left_ai_ai") {
        self setgoalpos(self.origin, 1);
        self ai::set_ignoreall(1);
        self ai::set_ignoreme(1);
        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "takedown_backup_left_extra_2") {
            volume = getent("takedown_backup_middle_volume", "targetname");
            wait randomfloatrange(0.3, 0.5);
        } else {
            volume = getent("takedown_backup_right_volume", "targetname");
            wait randomfloatrange(0.3, 0.5);
        }
        self setgoalvolume(volume);
        self waittill(#"goal");
        self ai::set_ignoreall(0);
        self ai::set_ignoreme(0);
        if (level.var_e7c1ffa.size > 3) {
            volume = getent("takedown_backup_volume", "targetname");
            self setgoalvolume(volume);
        }
    }
    if (isdefined(self.targetname) && self.targetname == "takedown_backup_truck_ai_ai") {
        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "gunner1") {
            self.var_df53bc6 = self.script_accuracy;
            self.script_accuracy = 0.2;
        }
        level flag::wait_till("takedown_backup_truck_stopped_flag");
        if (isdefined(self.script_noteworthy)) {
            if (self.script_noteworthy == "gunner1") {
                self.var_df53bc6 = self.script_accuracy;
                self.script_accuracy = 0.2;
                wait 5;
                self.script_accuracy = self.var_df53bc6;
            }
            if (self.script_noteworthy == "driver" || self.script_noteworthy == "passenger1") {
                self vehicle::get_out();
            }
        }
        volume = getent("takedown_backup_right_volume", "targetname");
        if (isdefined(self.script_noteworthy) && self.script_noteworthy != "gunner1") {
            self ai::set_ignoreall(0);
            self ai::set_ignoreme(0);
            self setgoalvolume(volume);
        }
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x93808d88, Offset: 0x6ff0
// Size: 0x172
function function_64be6dbe() {
    level.var_2fd26037 waittill(#"hash_ca6b3f19");
    playfxontag(level._effect["fx_exp_emp_siegebot_veng"], level.takedown_siegebot, "tag_eye");
    wait 0.5;
    if (isalive(level.var_63be7c27)) {
        playfxontag(level._effect["fx_elec_enemy_juiced_shotgun"], level.var_63be7c27, "tag_eye");
    }
    if (isalive(level.var_f1b70cec)) {
        playfxontag(level._effect["fx_elec_enemy_juiced_shotgun"], level.var_f1b70cec, "tag_eye");
    }
    wait 0.5;
    if (isalive(level.var_63be7c27)) {
        playfxontag(level._effect["fx_elec_enemy_juiced_shotgun"], level.var_63be7c27, "tag_eye");
    }
    if (isalive(level.var_f1b70cec)) {
        playfxontag(level._effect["fx_elec_enemy_juiced_shotgun"], level.var_f1b70cec, "tag_eye");
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0xd7d85068, Offset: 0x7170
// Size: 0x92
function function_a339da70() {
    setslowmotion(1, 0.3, 0.3);
    level thread function_8b1bdf0e();
    level.var_2fd26037 util::waittill_either("stop_slowmo", "takedown_enemies_dead");
    thread cp_mi_sing_vengeance_sound::function_69fc18eb();
    setslowmotion(0.3, 1);
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x9b50d049, Offset: 0x7210
// Size: 0x46
function function_8b1bdf0e() {
    while (level.var_138e6961.size > 0) {
        level.var_138e6961 = array::remove_dead(level.var_138e6961);
        wait 0.05;
    }
    level.var_2fd26037 notify(#"takedown_enemies_dead");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x47fa31fb, Offset: 0x7260
// Size: 0x562
function function_ee2ef2f3() {
    level.var_3d63f698 = struct::get("tag_align_takedown", "targetname");
    level.var_82f6e6ad = spawner::simple_spawn_single("truck_54i");
    level.var_82f6e6ad.animname = "truck_54i";
    level.var_82f6e6ad disconnectpaths();
    level.var_82f6e6ad thread takedown_cleanup();
    level.var_82f6e6ad vehicle::lights_off();
    level.takedown_siegebot = spawner::simple_spawn_single("takedown_siegebot");
    level.takedown_siegebot.animname = "takedown_siegebot";
    level.takedown_siegebot ai::set_ignoreall(1);
    level.takedown_siegebot ai::set_ignoreme(1);
    level.takedown_siegebot disableaimassist();
    level.takedown_siegebot.nocybercom = 1;
    level.takedown_siegebot vehicle_ai::start_scripted(1);
    level.takedown_siegebot thread takedown_cleanup();
    level.takedown_siegebot thread function_9d478f6a();
    level.outer_door = getent("outer_door", "targetname");
    level.outer_door thread takedown_cleanup();
    level.sign = getent("sign", "targetname");
    level.sign.animname = "sign";
    level.sign thread takedown_cleanup();
    sign_clip = getent("sign_clip", "targetname");
    sign_clip linkto(level.sign);
    sign_clip thread takedown_cleanup();
    level.p1wire = getent("p1wire", "targetname");
    level.p1wire.animname = "p1wire";
    level.p1wire thread takedown_cleanup();
    if (level.players.size == 4) {
        level.p4door_l = getent("takedown_p4door_l", "targetname");
        level.p4door_l.animname = "p4door_l";
        level.p4door_l thread takedown_cleanup();
        level.p4door_r = getent("takedown_p4door_r", "targetname");
        level.p4door_r.animname = "p4door_r";
        level.p4door_r thread takedown_cleanup();
    }
    level.trashcan = getent("takedown_trashcan", "targetname");
    level.trashcan thread takedown_cleanup();
    level.takedown_trashcan_clip = getent("takedown_trashcan_clip", "targetname");
    level.takedown_trashcan_clip linkto(level.trashcan);
    level.takedown_trashcan_clip thread takedown_cleanup();
    level.var_138e6961 = [];
    level.var_d9f6d6 = [];
    level.var_460ada5f = getentarray("takedown_ai", "script_noteworthy");
    foreach (spawner in level.var_460ada5f) {
        spawner spawner::add_spawn_function(&function_f1ace717);
        spawner spawner::spawn();
    }
    level notify(#"hash_ee2ef2f3");
    if (isdefined(level.var_b7e68311)) {
        level waittill(#"hash_63d9e6f4");
    }
    if (isdefined(level.var_48158b2b)) {
        return;
    }
    level.var_3d63f698 thread scene::init("cin_ven_03_10_takedown_intro_1st");
    level.var_3d63f698 thread scene::init("cin_ven_03_10_takedown_intro_1st_props");
    level.var_3d63f698 scene::init("cin_ven_01_02_rooftop_1st_overlook");
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x6d8a466b, Offset: 0x77d0
// Size: 0x72
function function_9d478f6a() {
    self endon(#"death");
    thread cp_mi_sing_vengeance_sound::takedown_siegebot(self);
    self waittill(#"hash_77e3a76");
    takedown_siegebot_death_clip = getent("takedown_siegebot_death_clip", "targetname");
    takedown_siegebot_death_clip delete();
    self.allowdeath = 1;
    self kill();
}

// Namespace namespace_8776ed6e
// Params 1, eflags: 0x0
// Checksum 0xacfe35ef, Offset: 0x7850
// Size: 0xa
function function_b584dbf0(params) {
    
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x380741f7, Offset: 0x7868
// Size: 0x68a
function function_f1ace717() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self cybercom::function_59965309("cybercom_fireflyswarm");
    if (isdefined(self.targetname)) {
        if (self.targetname == "enemy_leader_ai") {
            level.var_56f5377 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy1_ai") {
            level.var_fe8d50fa = self;
            array::add(level.var_138e6961, self);
        }
        if (self.targetname == "takedown_enemy2_ai") {
            level.var_d88ad691 = self;
            array::add(level.var_138e6961, self);
            level.en2_machete = util::spawn_model("p7_54i_gear_knife");
            level.en2_machete.animname = "en2_machete";
            level.en2_machete thread takedown_cleanup();
        }
        if (self.targetname == "takedown_enemy3_ai") {
            level.var_b2885c28 = self;
            array::add(level.var_138e6961, self);
            level.p3knife = util::spawn_model("wpn_t7_knife_combat_world");
            level.p3knife.animname = "p3knife";
            level.p3knife thread takedown_cleanup();
        }
        if (self.targetname == "takedown_enemy4_ai") {
            level.var_bc99b507 = self;
            array::add(level.var_138e6961, self);
            level.p4knife = util::spawn_model("wpn_t7_knife_combat_world");
            level.p4knife.animname = "p4knife";
            level.p4knife thread takedown_cleanup();
        }
        if (self.targetname == "takedown_enemy5_ai") {
            level.var_96973a9e = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
            level.trashcan.animname = "trashcan";
        }
        if (self.targetname == "takedown_enemy6_ai") {
            level.var_7094c035 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy7_ai") {
            level.var_4a9245cc = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy8_ai") {
            level.var_f47bf81b = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy9_ai") {
            level.var_ce797db2 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy10_ai") {
            level.var_129e201e = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy11_ai") {
            level.var_38a09a87 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy12_ai") {
            level.var_c6992b4c = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy13_ai") {
            level.var_ec9ba5b5 = self;
            array::add(level.var_138e6961, self);
        }
        if (self.targetname == "takedown_enemy14_ai") {
            level.var_7a94367a = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy15_ai") {
            level.var_a096b0e3 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
        }
        if (self.targetname == "takedown_enemy16_ai") {
            level.var_2e8f41a8 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
            level.p4door_l.animname = "p4door_l";
            level.p4door_r.animname = "p4door_r";
        }
        if (self.targetname == "takedown_rbot1_ai") {
            level.var_63be7c27 = self;
            array::add(level.var_138e6961, self);
            array::add(level.var_d9f6d6, self);
            self.nocybercom = 1;
            self cybercom::function_59965309("cybercom_ravagecore");
        }
        if (self.targetname == "takedown_rbot2_ai") {
            level.var_f1b70cec = self;
            array::add(level.var_138e6961, self);
            self.nocybercom = 1;
            self cybercom::function_59965309("cybercom_ravagecore");
        }
    }
}

// Namespace namespace_8776ed6e
// Params 0, eflags: 0x0
// Checksum 0x5b388f5, Offset: 0x7f00
// Size: 0x32
function takedown_cleanup() {
    level flag::wait_till("start_dogleg_1_intro");
    wait 1;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_8776ed6e
// Params 4, eflags: 0x0
// Checksum 0x400e0743, Offset: 0x7f40
// Size: 0x162
function function_fcdc57ea(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ02");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ05");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ07");
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ09");
    level struct::function_368120a1("scene", "cin_ven_01_20_introstreet_bodies_vign");
    level struct::function_368120a1("scene", "cin_ven_01_25_outside_apt_bodies_vign");
    level struct::function_368120a1("scene", "cin_ven_02_05_inside_apt_bodies_vign");
    level struct::function_368120a1("scene", "cin_ven_02_10_apthorror_enterbldg_vign");
    level struct::function_368120a1("scene", "cin_ven_02_10_apthorror_firstfloorapt_vign");
    level struct::function_368120a1("scene", "cin_ven_02_10_apthorror_secondfloorapt_vign");
}

/#

    // Namespace namespace_8776ed6e
    // Params 2, eflags: 0x0
    // Checksum 0xcdecf2b6, Offset: 0x80b0
    // Size: 0x133
    function function_81f84c9c(str_objective, var_74cd64bc) {
        level.var_b7e68311 = 1;
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("<dev string:x28>", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level flag::wait_till("<dev string:x32>");
        objectives::set("<dev string:x46>", struct::get("<dev string:x5d>"));
        level flag::set("<dev string:x6d>");
        level thread takedown_main();
        level waittill(#"hash_ee2ef2f3");
        level function_6fa5f384();
        level notify(#"hash_63d9e6f4");
    }

    // Namespace namespace_8776ed6e
    // Params 2, eflags: 0x0
    // Checksum 0xbf348f05, Offset: 0x81f0
    // Size: 0x193
    function function_616e9ab6(str_objective, var_74cd64bc) {
        level.var_b7e68311 = 1;
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("<dev string:x28>", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level flag::wait_till("<dev string:x32>");
        objectives::set("<dev string:x46>", struct::get("<dev string:x5d>"));
        level flag::set("<dev string:x6d>");
        setdvar("<dev string:x7c>", "<dev string:x87>");
        wait 1;
        if (level.activeplayers.size == 1) {
            setdvar("<dev string:x7c>", "<dev string:x92>");
        }
        wait 1;
        level thread takedown_main();
        level waittill(#"hash_ee2ef2f3");
        if (level.activeplayers.size == 2) {
            level function_6fa5f384();
        }
        level notify(#"hash_63d9e6f4");
    }

    // Namespace namespace_8776ed6e
    // Params 2, eflags: 0x0
    // Checksum 0x97bd5b06, Offset: 0x8390
    // Size: 0x19b
    function function_8771151f(str_objective, var_74cd64bc) {
        level.var_b7e68311 = 1;
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("<dev string:x28>", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level flag::wait_till("<dev string:x32>");
        objectives::set("<dev string:x46>", struct::get("<dev string:x5d>"));
        level flag::set("<dev string:x6d>");
        setdvar("<dev string:x7c>", "<dev string:x87>");
        wait 1;
        while (level.activeplayers.size != 3) {
            setdvar("<dev string:x7c>", "<dev string:x92>");
            wait 1;
        }
        level thread takedown_main();
        level waittill(#"hash_ee2ef2f3");
        if (level.activeplayers.size == 3) {
            level function_6fa5f384();
        }
        level notify(#"hash_63d9e6f4");
    }

    // Namespace namespace_8776ed6e
    // Params 2, eflags: 0x0
    // Checksum 0x4224d630, Offset: 0x8538
    // Size: 0x19b
    function function_7d5fbc40(str_objective, var_74cd64bc) {
        level.var_b7e68311 = 1;
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("<dev string:x28>", str_objective);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level flag::wait_till("<dev string:x32>");
        objectives::set("<dev string:x46>", struct::get("<dev string:x5d>"));
        level flag::set("<dev string:x6d>");
        setdvar("<dev string:x7c>", "<dev string:x87>");
        wait 1;
        while (level.activeplayers.size != 4) {
            setdvar("<dev string:x7c>", "<dev string:x92>");
            wait 1;
        }
        level thread takedown_main();
        level waittill(#"hash_ee2ef2f3");
        if (level.activeplayers.size == 4) {
            level function_6fa5f384();
        }
        level notify(#"hash_63d9e6f4");
    }

    // Namespace namespace_8776ed6e
    // Params 0, eflags: 0x0
    // Checksum 0x4b4e6fe9, Offset: 0x86e0
    // Size: 0xe0f
    function function_6fa5f384() {
        level.var_48158b2b = [];
        level.var_7cd6979b = [];
        level.var_7cd6979b = arraycombine(level.var_7cd6979b, level.activeplayers, 0, 0);
        foreach (player in level.var_7cd6979b) {
            if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                level.var_48158b2b[0] = player;
                arrayremovevalue(level.var_7cd6979b, player);
                break;
            }
        }
        level.var_48158b2b[1] = level.var_2fd26037;
        level.var_d60e1bf0 = [];
        level.var_d60e1bf0[0] = level.takedown_siegebot;
        level.var_d60e1bf0[1] = level.var_82f6e6ad;
        level.var_d60e1bf0[2] = level.var_63be7c27;
        level.var_d60e1bf0[3] = level.var_f1b70cec;
        level.var_d60e1bf0[4] = level.p1wire;
        level.var_d60e1bf0[5] = level.var_fe8d50fa;
        level.var_d60e1bf0[6] = level.var_56f5377;
        level.var_d60e1bf0[7] = level.var_f47bf81b;
        level.var_d60e1bf0[8] = level.var_129e201e;
        if (level.activeplayers.size >= 2) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xa3>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_d60e1bf0[9] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_d60e1bf0[9] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_d60e1bf0[10] = level.var_d88ad691;
            level.var_d60e1bf0[11] = level.en2_machete;
            level.var_d60e1bf0[12] = level.var_ec9ba5b5;
            level.var_d60e1bf0[13] = level.var_4a9245cc;
            level.var_d60e1bf0[14] = level.var_38a09a87;
            level.var_d60e1bf0[15] = level.var_c6992b4c;
        }
        if (level.activeplayers.size >= 3) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xb8>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_d60e1bf0[16] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_d60e1bf0[16] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_d60e1bf0[17] = level.p3knife;
            level.var_d60e1bf0[18] = level.var_b2885c28;
            level.var_d60e1bf0[19] = level.var_96973a9e;
            level.var_d60e1bf0[20] = level.var_7094c035;
            level.var_d60e1bf0[21] = level.var_7a94367a;
        }
        if (level.activeplayers.size == 4) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xcd>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_d60e1bf0[22] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_d60e1bf0[22] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_d60e1bf0[23] = level.p4knife;
            level.var_d60e1bf0[24] = level.var_bc99b507;
            level.var_d60e1bf0[25] = level.var_ce797db2;
            level.var_d60e1bf0[26] = level.var_a096b0e3;
            level.var_d60e1bf0[27] = level.var_2e8f41a8;
        }
        level.var_fc109659 = [];
        level.var_fc109659[0] = level.takedown_siegebot;
        level.var_fc109659[1] = level.var_82f6e6ad;
        level.var_fc109659[2] = level.var_63be7c27;
        level.var_fc109659[3] = level.var_f1b70cec;
        level.var_7cd6979b = [];
        level.var_7cd6979b = arraycombine(level.var_7cd6979b, level.activeplayers, 0, 0);
        foreach (player in level.var_7cd6979b) {
            if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                level.var_fc109659[4] = player;
                arrayremovevalue(level.var_7cd6979b, player);
                break;
            }
        }
        level.var_fc109659[5] = level.p1wire;
        level.var_fc109659[6] = level.var_fe8d50fa;
        level.var_fc109659[7] = level.var_56f5377;
        level.var_fc109659[8] = level.var_f47bf81b;
        level.var_fc109659[9] = level.var_129e201e;
        if (level.activeplayers.size >= 2) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xa3>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_fc109659[10] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_fc109659[10] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_fc109659[11] = level.var_d88ad691;
            level.var_fc109659[12] = level.en2_machete;
            level.var_fc109659[13] = level.var_ec9ba5b5;
            level.var_fc109659[14] = level.var_4a9245cc;
            level.var_fc109659[15] = level.var_38a09a87;
            level.var_fc109659[16] = level.var_c6992b4c;
        }
        if (level.activeplayers.size >= 3) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xb8>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_fc109659[17] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_fc109659[17] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_fc109659[18] = level.p3knife;
            level.var_fc109659[19] = level.var_b2885c28;
            level.var_fc109659[20] = level.var_96973a9e;
            level.var_fc109659[21] = level.var_7094c035;
            level.var_fc109659[22] = level.var_7a94367a;
        }
        if (level.activeplayers.size == 4) {
            if (getdvarstring("<dev string:x9c>") === "<dev string:xcd>") {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && (!isdefined(player.pers) || player.pers["<dev string:x96>"] == undefined)) {
                        level.var_fc109659[23] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            } else {
                foreach (player in level.var_7cd6979b) {
                    if (isdefined(player.pers) && isdefined(player.pers["<dev string:x96>"]) && player.pers["<dev string:x96>"] == 1) {
                        level.var_fc109659[23] = player;
                        arrayremovevalue(level.var_7cd6979b, player);
                        break;
                    }
                }
            }
            level.var_fc109659[24] = level.var_d88ad691;
            level.var_fc109659[25] = level.var_bc99b507;
            level.var_fc109659[26] = level.var_ce797db2;
            level.var_fc109659[27] = level.var_a096b0e3;
            level.var_fc109659[28] = level.var_2e8f41a8;
        }
    }

#/
