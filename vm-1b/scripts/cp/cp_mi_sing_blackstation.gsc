#using scripts/cp/voice/voice_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cp_mi_sing_blackstation_subway;
#using scripts/cp/cp_mi_sing_blackstation_station;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_port;
#using scripts/cp/cp_mi_sing_blackstation_police_station;
#using scripts/cp/cp_mi_sing_blackstation_fx;
#using scripts/cp/cp_mi_sing_blackstation_cross_debris;
#using scripts/cp/cp_mi_sing_blackstation_comm_relay;
#using scripts/cp/cp_mi_sing_blackstation_qzone;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_load;
#using scripts/cp/_hazard;
#using scripts/cp/_collectibles;
#using scripts/cp/_ammo_cache;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_502339f3;

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x84ac53a5, Offset: 0x1310
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x4d7d3f81, Offset: 0x1350
// Size: 0x292
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(19);
    }
    precache();
    register_clientfields();
    flag_init();
    level_init();
    function_6364bd7d();
    namespace_23567e72::function_4d39a2af();
    namespace_56310eec::main();
    namespace_7a033503::main();
    namespace_d754dd61::main();
    namespace_8b9f718f::main();
    namespace_ec2cabcf::init_voice();
    function_673254cc();
    util::function_286a5010(5);
    savegame::function_8c0c4b3a("blackstation");
    callback::on_spawned(&on_player_spawned);
    callback::on_loadout(&on_player_loadout);
    level.var_1895e0f9 = &namespace_79e1cd97::function_8f7c9f3c;
    load::main();
    setdvar("ui_newHud", 1);
    level thread namespace_79e1cd97::function_33942907();
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh170", &namespace_79e1cd97::function_746a2da4, "done", "objective_warlord");
    level scene::add_scene_func("cin_bla_10_01_kaneintro_3rd_sh190", &namespace_79e1cd97::function_746a2da4, "done", "objective_comm_relay_traverse");
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_landing", &namespace_79e1cd97::function_746a2da4, "done", "objective_subway");
    level thread function_f92d2f1c();
    level thread function_2acd20f4();
    level thread function_b3f6e2cd();
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0xcc71456b, Offset: 0x15f0
// Size: 0x1b2
function function_b3f6e2cd() {
    getent("com_rugged_glitch_1", "targetname") hide();
    getent("com_rugged_glitch_2", "targetname") hide();
    getent("com_rugged_off", "targetname") hide();
    getent("com_curve_glitch_1", "targetname") hide();
    getent("com_curve_glitch_2", "targetname") hide();
    getent("com_curve_off", "targetname") hide();
    getent("barge_monitor_glitch_1", "targetname") hide();
    getent("barge_monitor_glitch_2", "targetname") hide();
    getent("barge_monitor_off", "targetname") hide();
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x4a0cdb35, Offset: 0x17b0
// Size: 0x4a
function function_2acd20f4() {
    hidemiscmodels("lt_wharf_water");
    hidemiscmodels("vista_water");
    hidemiscmodels("collapse_frogger_water");
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0xdeb0a560, Offset: 0x1808
// Size: 0x9b
function function_f92d2f1c() {
    var_7b45393e = getentarray("trigger_hurt", "classname");
    foreach (e_trigger in var_7b45393e) {
        if (e_trigger.var_75dbd7 === "o2") {
            e_trigger util::self_delete();
        }
    }
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x183f39a9, Offset: 0x18b0
// Size: 0xab
function precache() {
    level._effect["blood_headpop"] = "blood/fx_blood_ai_head_explosion";
    level._effect["lightning_strike"] = "weather/fx_lightning_strike_bolt_single_blackstation";
    level._effect["disabled_robot"] = "destruct/fx_dest_robot_head_sparks";
    level._effect["worklight"] = "light/fx_spot_low_factory_zmb";
    level._effect["worklight_rays"] = "light/fx_light_ray_work_light";
    level._effect["wave_pier"] = "water/fx_water_splash_xlg";
    level._effect["bubbles"] = "player/fx_plyr_swim_bubbles_body_blkstn";
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x47b14f4d, Offset: 0x1968
// Size: 0x7b2
function flag_init() {
    level flag::init("obj_goto_docks");
    level flag::init("allow_wind_gust");
    level flag::init("end_gust_warning");
    level flag::init("kill_weather");
    level flag::init("kill_surge");
    level flag::init("end_surge");
    level flag::init("kill_wave");
    level flag::init("surging_inward");
    level flag::init("vtol_jump");
    level flag::init("executed_bodies");
    level flag::init("warlord_approach");
    level flag::init("hendricks_debris_traversal_ready");
    level flag::init("warlord_intro_prep");
    level flag::init("warlord_fight");
    level flag::init("warlord_backup");
    level flag::init("warlord_reinforce");
    level flag::init("warlord_retreat");
    level flag::init("warlord_fight_done");
    level flag::init("qzone_done");
    level flag::init("warning_vo_played");
    level flag::init("wind_gust");
    level flag::init("drone_strike");
    level flag::init("surge_active");
    level flag::init("end_surge_start");
    level flag::init("end_surge_rest");
    level flag::init("wind_done");
    level flag::init("surge_done");
    level flag::init("wave_done");
    level flag::init("cover_switch");
    level flag::init("enter_port");
    level flag::init("start_objective_barge_assault");
    level flag::init("hendricks_on_barge");
    level flag::init("slow_mo_finished");
    level flag::init("breached");
    level flag::init("barge_breach_cleared");
    level flag::init("tanker_smash");
    level flag::init("tanker_go");
    level flag::init("tanker_face");
    level flag::init("tanker_hit");
    level flag::init("tanker_ride");
    level flag::init("tanker_ride_done");
    level flag::init("flag_lobby_engaged");
    level flag::init("flag_kane_intro_complete");
    level flag::init("flag_enter_police_station");
    level flag::init("flag_lobby_ready_to_engage");
    level flag::init("flag_intro_dialog_ended");
    level flag::init("table_flip");
    level flag::init("walkway_collapse");
    level flag::init("hendricks_crossed");
    level flag::init("police_station_engaged");
    level flag::init("approach_ps_entrance");
    level flag::init("comm_relay_pulse");
    level flag::init("comm_relay_engaged");
    level flag::init("comm_relay_started_hack");
    level flag::init("comm_relay_hacked");
    level flag::init("relay_room_clear");
    level flag::init("igc_robot_down");
    level flag::init("blackstation_exterior_engaged");
    level flag::init("exterior_ready_weapons");
    level flag::init("ziplines_ready");
    level flag::init("kane_landed");
    level flag::init("zipline_player_landed");
    level flag::init("lightning_strike");
    level flag::init("lightning_strike_done");
    level flag::init("breach_active");
    level flag::init("hendricks_at_window");
    level flag::init("bridge_start_blocked");
    level flag::init("bridge_collapsed");
    level flag::init("cancel_slow_mo");
    level flag::init("atrium_rubble_dropped");
    level flag::init("path_is_open");
    level flag::init("awakening_begun");
    level flag::init("awakening_end");
    level flag::init("no_awakened_robots");
    level flag::init("truck_in_position");
    level flag::init("give_dni_weapon");
    level flag::init("trig_zipline02");
    level flag::init("trig_zipline01");
    level flag::init("warlord_dead");
    level flag::init("comm_relay_hendricks_ready");
    level flag::init("zipline_done");
    level flag::init("exterior_clear");
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x28519e15, Offset: 0x2128
// Size: 0xf2
function level_init() {
    setdvar("player_swimTime", 5000);
    setdvar("player_swimSpeed", 120);
    createthreatbiasgroup("warlords");
    createthreatbiasgroup("heroes");
    hidemiscmodels("frogger_building_fallen");
    array::run_all(getentarray("frogger_building_fallen", "targetname"), &hide);
    level thread scene::add_scene_func("cin_gen_ground_anchor_player", &namespace_79e1cd97::function_12398a8b, "done");
    level.var_4eef455c = [];
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0xc3d84f05, Offset: 0x2228
// Size: 0x3ed
function on_player_spawned() {
    self thread function_73dee914();
    self thread namespace_79e1cd97::function_913d882();
    self.var_f44af1ef = 0;
    self.var_fca564e8 = 0;
    self.var_4cfe7265 = 0;
    self.var_1cd4d4e6 = 0;
    self.var_f82cc610 = 0;
    self.var_32939eb7 = 0;
    self.var_20aea9e5 = 0;
    self.var_eb7c5a24 = 0;
    self.var_ff9883fd = 0;
    self.var_3f081af5 = 0;
    self.var_116f2fb8 = 0;
    self.var_62269fcc = 0;
    if (!getdvarint("art_review", 0)) {
        if (level.var_31aefea8 == "objective_qzone") {
            self thread namespace_d754dd61::function_ec18f079();
        } else if (level.var_31aefea8 == "objective_warlord_igc") {
            self util::function_16c71b8(1);
        }
    }
    switch (level.var_31aefea8) {
    case 139:
    case 130:
        self thread function_cc28a20d("wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1);
        self thread function_cc28a20d("wind_effects", "trigger_pier_wind", "tanker_smash", 1);
        self.var_2d166751 = 0;
        break;
    case 129:
    case 4:
        self thread function_cc28a20d("wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1);
        self thread function_cc28a20d("wind_effects", "trigger_pier_wind", "tanker_smash", 1);
        wait(0.1);
        self.var_2d166751 = 0.1;
        self clientfield::set_to_player("toggle_rain_sprite", 1);
        break;
    case 136:
        self thread function_cc28a20d("wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1);
        self thread function_cc28a20d("wind_effects", "trigger_pier_wind", "tanker_smash", 1);
        self thread namespace_79e1cd97::function_2c33b48e();
        self thread namespace_79e1cd97::function_f2e7ba4b();
        self thread namespace_79e1cd97::function_55221935();
        self thread namespace_8b9f718f::function_b3d8d3f5();
        wait(0.1);
        self.var_2d166751 = 0.4;
        self clientfield::set_to_player("toggle_rain_sprite", 2);
        break;
    case 141:
        self thread function_cc28a20d("wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1);
        self thread function_cc28a20d("wind_effects", "trigger_pier_wind", "tanker_smash", 1);
        self thread namespace_79e1cd97::function_2c33b48e();
        self thread namespace_79e1cd97::function_f2e7ba4b();
        self thread namespace_79e1cd97::function_55221935();
        self thread namespace_8b9f718f::function_b3d8d3f5();
        break;
    case 137:
    case 142:
        self thread namespace_79e1cd97::function_2c33b48e();
        self thread namespace_79e1cd97::function_55221935();
        self thread namespace_8b9f718f::function_b3d8d3f5();
        break;
    case 138:
    case 140:
        wait(0.1);
        self.var_2d166751 = 0.1;
        self clientfield::set_to_player("toggle_rain_sprite", 1);
        break;
    }
}

// Namespace namespace_502339f3
// Params 4, eflags: 0x0
// Checksum 0x5c7cdd7e, Offset: 0x2620
// Size: 0xf5
function function_cc28a20d(str_fx, str_trigger, str_flag, var_df107013) {
    if (!isdefined(var_df107013)) {
        var_df107013 = 0;
    }
    level endon(str_flag);
    self endon(#"death");
    self thread function_f891013e(str_flag);
    while (true) {
        trigger::wait_till(str_trigger, "targetname", self);
        if (str_fx == "wind_effects") {
            self clientfield::set_to_player("wind_effects", 1);
        } else {
            self clientfield::set_to_player("wind_effects", 2);
        }
        var_cfabce58 = getent(str_trigger, "targetname");
        util::wait_till_not_touching(var_cfabce58, self);
        self clientfield::set_to_player("wind_effects", 0);
    }
}

// Namespace namespace_502339f3
// Params 1, eflags: 0x0
// Checksum 0xbbab6bc4, Offset: 0x2720
// Size: 0x52
function function_f891013e(str_flag) {
    self endon(#"death");
    level flag::wait_till(str_flag);
    self clientfield::set_to_player("wind_blur", 0);
    self clientfield::set_to_player("wind_effects", 0);
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x3be1d0dd, Offset: 0x2780
// Size: 0x3a
function on_player_loadout() {
    var_91c59c31 = getweapon("micromissile_launcher");
    self giveweapon(var_91c59c31);
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x3f467886, Offset: 0x27c8
// Size: 0x48a
function register_clientfields() {
    clientfield::register("actor", "kill_target_keyline", 1, 4, "int");
    clientfield::register("allplayers", "zipline_sound_loop", 1, 1, "int");
    clientfield::register("scriptmover", "water_disturbance", 1, 1, "int");
    clientfield::register("scriptmover", "water_splash_lrg", 1, 1, "counter");
    clientfield::register("toplayer", "player_rain", 1, 3, "int");
    clientfield::register("toplayer", "rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "sndWindSystem", 1, 2, "int");
    clientfield::register("toplayer", "zipline_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "player_water_swept", 1, 1, "int");
    clientfield::register("toplayer", "toggle_ukko", 1, 2, "int");
    clientfield::register("toplayer", "toggle_rain_sprite", 1, 2, "int");
    clientfield::register("toplayer", "wind_blur", 1, 1, "int");
    clientfield::register("toplayer", "wind_effects", 1, 2, "int");
    clientfield::register("toplayer", "subway_water", 1, 1, "int");
    clientfield::register("toplayer", "play_bubbles", 1, 1, "int");
    clientfield::register("toplayer", "toggle_water_fx", 1, 1, "int");
    clientfield::register("toplayer", "wave_hit", 1, 1, "int");
    clientfield::register("world", "subway_entrance_crash", 1, 1, "int");
    clientfield::register("world", "water_level", 1, 3, "int");
    clientfield::register("world", "roof_panels_init", 1, 1, "int");
    clientfield::register("world", "roof_panels_play", 1, 1, "int");
    clientfield::register("world", "subway_tiles", 1, 1, "int");
    clientfield::register("world", "warlord_exposure", 1, 1, "int");
    clientfield::register("world", "outro_exposure", 1, 1, "int");
    clientfield::register("world", "sndDrillWalla", 1, 2, "int");
    clientfield::register("world", "sndBlackStationSounds", 1, 1, "int");
    clientfield::register("world", "flotsam", 1, 1, "int");
    clientfield::register("world", "sndStationWalla", 1, 1, "int");
    clientfield::register("world", "qzone_debris", 1, 1, "counter");
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x8976a341, Offset: 0x2c60
// Size: 0x3ba
function function_673254cc() {
    skipto::add("objective_igc", &namespace_d754dd61::function_6ec9ed4d, undefined, &namespace_d754dd61::function_25dc0657);
    skipto::add("objective_qzone", &namespace_d754dd61::function_a19cdfad, undefined, &namespace_d754dd61::function_58aef8b7);
    skipto::function_d68e678e("objective_warlord_igc", &namespace_d754dd61::function_b457621f, undefined, &namespace_d754dd61::function_487563c5);
    skipto::add("objective_warlord", &namespace_d754dd61::function_f1376b81, undefined, &namespace_d754dd61::function_68cbd90b);
    skipto::function_d68e678e("objective_anchor_intro", &namespace_8b9f718f::function_bd209495, undefined, &namespace_8b9f718f::function_88ddfb38);
    skipto::function_d68e678e("objective_port_assault", &namespace_8b9f718f::function_7a0b2bc4, undefined, &namespace_8b9f718f::function_93433fef);
    skipto::function_d68e678e("objective_barge_assault", &namespace_8b9f718f::function_43296c4c, undefined, &namespace_8b9f718f::function_c57c7177);
    skipto::function_d68e678e("objective_storm_surge", &namespace_8b9f718f::function_f93ea5f3, undefined, &namespace_8b9f718f::function_7cde31a6);
    skipto::function_d68e678e("objective_subway", &function_e4a0bb, undefined, &function_b501c2d1);
    skipto::function_d68e678e("objective_police_station", &namespace_933eb669::function_23a0cc93, undefined, &namespace_933eb669::function_88d892b9);
    skipto::function_d68e678e("objective_kane_intro", &namespace_933eb669::function_1629236a, undefined, &namespace_933eb669::function_5d496554);
    skipto::function_d68e678e("objective_comm_relay_traverse", &namespace_641b22d4::function_c9040e7d, undefined, &namespace_641b22d4::function_311be427);
    skipto::function_d68e678e("objective_comm_relay", &namespace_641b22d4::function_a2073f94, undefined, &namespace_641b22d4::function_7e7b796a);
    skipto::function_d68e678e("objective_cross_debris", &namespace_e785bfa0::function_e9acb08, undefined, &namespace_e785bfa0::function_508330ae);
    skipto::function_d68e678e("objective_blackstation_exterior", &namespace_4040b6c2::function_3450aa78, undefined, &namespace_4040b6c2::function_b5e9c2fe);
    skipto::function_d68e678e("objective_blackstation_interior", &namespace_4040b6c2::function_a870c9be, undefined, &namespace_4040b6c2::function_2846e098);
    skipto::function_d68e678e("objective_end_igc", &namespace_4040b6c2::function_2783ca83, undefined, &namespace_4040b6c2::function_392085c9);
}

// Namespace namespace_502339f3
// Params 2, eflags: 0x0
// Checksum 0x8ef60967, Offset: 0x3028
// Size: 0xca
function function_e4a0bb(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_subway");
        objectives::complete("cp_level_blackstation_intercept");
        load::function_a2995f22();
        array::thread_all(level.activeplayers, &namespace_3dc5b645::function_99f304f0);
        level thread namespace_4297372::function_37f7c98d();
    }
    level thread namespace_79e1cd97::function_6778ea09("none");
    namespace_3dc5b645::function_822cae8a();
}

// Namespace namespace_502339f3
// Params 4, eflags: 0x0
// Checksum 0x253716e9, Offset: 0x3100
// Size: 0x9a
function function_b501c2d1(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::play("p7_fxanim_cp_blackstation_streetlight01_4on_s4_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_streetlight01_2on_s4_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_streetlight01_4on_flicker_s4_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_streetlight_01_s4_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_streetlight01_1on_s4_bundle");
}

// Namespace namespace_502339f3
// Params 2, eflags: 0x0
// Checksum 0xf13daf8f, Offset: 0x31a8
// Size: 0x2a
function givecustomloadout(takeallweapons, alreadyspawned) {
    self takeweapon(self.grenadetypesecondary);
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0xe0e14244, Offset: 0x31e0
// Size: 0x11d
function function_73dee914() {
    self endon(#"death");
    switch (level.var_31aefea8) {
    case 180:
    case 181:
    case 182:
    case 178:
    case 9:
        self thread namespace_79e1cd97::function_6778ea09("none");
        break;
    case 129:
    case 4:
    case 130:
        self thread namespace_79e1cd97::function_6778ea09("light_se");
        break;
    case 136:
    case 141:
        self thread namespace_79e1cd97::function_6778ea09("med_se");
        break;
    case 137:
    case 142:
        self thread namespace_79e1cd97::function_6778ea09("drench_se");
        break;
    case 179:
    case 7:
    case 138:
    case 140:
        self thread namespace_79e1cd97::function_6778ea09("light_ne");
        break;
    }
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x43264a10, Offset: 0x3308
// Size: 0x8b
function function_6364bd7d() {
    var_917cd731 = getentarray("trig_rain_indoor", "targetname");
    foreach (e_trig in var_917cd731) {
        e_trig thread function_3187983c();
    }
}

// Namespace namespace_502339f3
// Params 0, eflags: 0x0
// Checksum 0x6c4972ae, Offset: 0x33a0
// Size: 0xe5
function function_3187983c() {
    self endon(#"death");
    while (true) {
        e_who = self waittill(#"trigger");
        if (isdefined(e_who.var_1b3b1022) && isplayer(e_who) && e_who.var_1b3b1022) {
            e_who thread function_c0861aa3(self);
            continue;
        }
        if (isdefined(e_who.var_1b3b1022) && isai(e_who) && e_who.var_1b3b1022) {
            if (e_who ai::has_behavior_attribute("useAnimationOverride") && e_who ai::get_behavior_attribute("useAnimationOverride")) {
                e_who thread function_8a1a53f(self);
            }
        }
    }
}

// Namespace namespace_502339f3
// Params 1, eflags: 0x0
// Checksum 0x85e9cf3e, Offset: 0x3490
// Size: 0xa2
function function_c0861aa3(e_trig) {
    self endon(#"disconnect");
    e_trig endon(#"death");
    self.var_1b3b1022 = 0;
    self clientfield::set_to_player("toggle_rain_sprite", 0);
    util::wait_till_not_touching(e_trig, self);
    self.var_1b3b1022 = 1;
    if (!self isplayinganimscripted()) {
        if (level.var_31aefea8 != "objective_port_assault" && level.var_31aefea8 != "objective_blackstation_exterior") {
            self clientfield::set_to_player("toggle_rain_sprite", 1);
        }
    }
}

// Namespace namespace_502339f3
// Params 1, eflags: 0x0
// Checksum 0xef85854b, Offset: 0x3540
// Size: 0x6a
function function_8a1a53f(e_trig) {
    self endon(#"death");
    e_trig endon(#"death");
    self.var_1b3b1022 = 0;
    self ai::set_behavior_attribute("useAnimationOverride", 0);
    util::wait_till_not_touching(e_trig, self);
    self.var_1b3b1022 = 1;
    self ai::set_behavior_attribute("useAnimationOverride", 1);
}

