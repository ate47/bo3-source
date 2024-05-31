#using scripts/cp/voice/voice_prologue;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_ending;
#using scripts/cp/cp_prologue_player_sacrifice;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_bridge;
#using scripts/cp/cp_prologue_dark_battle;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_hostage_rescue;
#using scripts/cp/cp_prologue_security_camera;
#using scripts/cp/cp_prologue_enter_base;
#using scripts/cp/cp_prologue_intro;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_collectibles;
#using scripts/cp/_util;
#using scripts/cp/_turret_sentry;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_accolades;
#using scripts/codescripts/struct;

#namespace cp_mi_eth_prologue;

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x31b3a6e5, Offset: 0x2348
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf5f6feff, Offset: 0x2388
// Size: 0x25a
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(17);
    }
    init_clientfields();
    util::function_286a5010(7);
    savegame::function_8c0c4b3a("prologue");
    init_flags();
    callback::on_connect(&function_7bf018c5);
    callback::on_connect(&on_player_connect);
    collectibles::function_93523442("p7_nc_eth_pro_01", 60, (3, -5, 0));
    collectibles::function_93523442("p7_nc_eth_pro_04", 120, (-3, -3, 0));
    namespace_61c634f2::function_4d39a2af();
    precache();
    function_d446a137();
    setdvar("bullet_ricochetBaseChance", 0);
    namespace_34e37984::main();
    namespace_7685657b::main();
    namespace_feda6b63::init_voice();
    level.var_1e983b11 = 0;
    level.var_d829fe9f = 0;
    level.var_d086f08f = 1;
    setgametypesetting("trm_maxHeight", 50);
    level.disableclassselection = 1;
    skipto::function_f3e035ef();
    level thread function_673254cc();
    callback::on_spawned(&on_player_spawned);
    if (!sessionmodeiscampaignzombiesgame()) {
        callback::on_loadout(&on_player_loadout);
    }
    load::main();
    setdvar("cg_viewVehicleInfluenceGunner_mode", 2);
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xfe1ae157, Offset: 0x25f0
// Size: 0x1a
function function_7bf018c5() {
    self flag::init("tutorial_allowed", 1);
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x479dd4e9, Offset: 0x2618
// Size: 0xda
function function_d446a137() {
    var_27606155 = getentarray("trigger_ob_defend", "targetname");
    foreach (var_a57773f5 in var_27606155) {
        var_a57773f5 triggerenable(0);
    }
    var_5aebca26 = getent("rpg_target", "targetname");
    var_5aebca26 hide();
    hidemiscmodels("fxanim_bridge_static2");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x817bf7fb, Offset: 0x2700
// Size: 0x692
function init_flags() {
    level flag::init("tower_doors_open");
    level flag::init("is_base_alerted");
    level flag::init("start_tower_collapse");
    level flag::init("hendr_crossed_tarmac");
    level flag::init("start_hendr_kill");
    level flag::init("stealth_kill_prepare_done");
    level flag::init("security_cam_full_house");
    level flag::init("face_scanning_complete");
    level flag::init("face_scanning_double_pause");
    level flag::init("scanning_dialog_done");
    level flag::init("player_past_security_room");
    level flag::init("hendricks_exit_cam_room");
    level flag::init("start_grenade_roll");
    level flag::init("player_breached_early");
    level flag::init("interrogation_finished");
    level flag::init("vtol_destroy_obj");
    level flag::init("hendricks_in_lift");
    level flag::init("khalil_in_lift");
    level flag::init("minister_in_lift");
    level flag::init("vtol_has_crashed");
    level flag::init("pallas_at_window");
    level flag::init("player_trigger_gear_drop");
    level flag::init("hangar_5_bc");
    level flag::init("2nd_hangar_apc_in_pos");
    level flag::init("spawn_plane_hangar_enemies");
    level flag::init("ev_enabled");
    level flag::init("vtol_guards_alerted");
    level flag::init("taylor_direct");
    level flag::init("robot_contact");
    level flag::init("spawn_robot_horde");
    level flag::init("open_fire");
    level flag::init("garage_open");
    level flag::init("garage_closed");
    level flag::init("garage_enter");
    level flag::init("players_in_garage");
    level flag::init("allies_in_garage");
    level flag::init("minister_apc_done");
    level flag::init("garage_dent");
    level flag::init("garage_breach");
    level flag::init("garage_broken");
    level flag::init("ai_in_apc");
    level flag::init("apc_ready");
    level flag::init("apc_unlocked");
    level flag::init("apc_rail_fail");
    level flag::init("players_are_in_apc");
    level flag::init("apc_rail_begin");
    level flag::init("robot_swarm");
    level flag::init("apc_restart");
    level flag::init("apc_engine_started");
    level flag::init("apc_resume");
    level flag::init("obs_collapse");
    level flag::init("apc_done");
    level flag::init("deleting_havok_object");
    level flag::init("apc_crash");
    level flag::init("pod_on_ground");
    level flag::init("minister_pos");
    level flag::init("ready_load");
    level flag::init("pod_waypoint");
    level flag::init("start_defend_countdown");
    level flag::init("shift_defend");
    level flag::init("apc_arrive");
    level flag::init("goto_pod");
    level flag::init("pod_arrive");
    level flag::init("pod_loaded");
    level flag::init("dropship_return");
    level flag::init("pod_go");
    level flag::init("pod_gone");
    level flag::init("rpg_done");
    level flag::init("activate_bc_5");
    level flag::init("activate_db_bc_2");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf68a8de9, Offset: 0x2da0
// Size: 0x1a
function on_player_connect() {
    self flag::init("custom_loadout");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xaf347e19, Offset: 0x2dc8
// Size: 0x2da
function on_player_spawned() {
    if (!sessionmodeiscampaignzombiesgame()) {
        self oed::function_35ce409(0);
    }
    if (!sessionmodeiscampaignzombiesgame() && !isdefined(self.var_40c94058)) {
        self accolades::function_42acdca5("MISSION_PROLOGUE_CHALLENGE5");
        self accolades::function_42acdca5("MISSION_PROLOGUE_CHALLENGE6");
        self accolades::function_42acdca5("MISSION_PROLOGUE_CHALLENGE10");
        self accolades::function_42acdca5("MISSION_PROLOGUE_CHALLENGE11");
        self accolades::function_42acdca5("MISSION_PROLOGUE_CHALLENGE16");
        uploadstats(self);
        self.var_40c94058 = 1;
    }
    self.var_5e3ab4ad = 0;
    self.var_d1cabfc = 0;
    if (level flag::exists("ev_enabled") && level flag::get("ev_enabled")) {
        self oed::function_35ce409(1);
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        if (!self namespace_2cb3876f::function_72e9bdb8()) {
            self.var_8dcb3948 = 1;
            var_e1e06c8 = getcharacterbodystyleindex(0, "CPUI_OUTFIT_PROLOGUE");
            self setcharacterbodystyle(var_e1e06c8);
            self setmovespeedscale(0.9);
            self clientfield::set_to_player("unlimited_sprint_off", 1);
        }
    }
    var_7476c97b = 0;
    var_f690a1c1 = array("skipto_air_traffic_controller", "skipto_nrc_knocking", "skipto_blend_in", "skipto_vtol_tackle", "skipto_robot_horde", "skipto_apc", "skipto_apc_rail", "skipto_apc_rail_stall", "skipto_robot_defend", "skipto_prologue_ending");
    foreach (var_6194780b in var_f690a1c1) {
        if (level.var_c0e97bd == var_6194780b) {
            var_7476c97b = 1;
            break;
        }
    }
    if (var_7476c97b) {
        level namespace_2cb3876f::function_6a5f89cb(level.var_c0e97bd, 0);
    }
    if (level flag::get("players_are_in_apc")) {
        self apc::function_fc1b1b72();
    }
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x49c40327, Offset: 0x30b0
// Size: 0x7a
function on_player_loadout() {
    if (!self namespace_2cb3876f::function_72e9bdb8() && !sessionmodeiscampaignzombiesgame()) {
        self namespace_d00ec32::function_c219b381();
        self cybercom_tacrig::function_78908229();
        self namespace_2cb3876f::function_4e6a4d54();
    } else {
        self flag::set("custom_loadout");
    }
    self function_3fe38b8a();
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xc7b7618b, Offset: 0x3138
// Size: 0x9d
function function_3fe38b8a() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    primaries = self getweaponslistprimaries();
    if (isdefined(primaries)) {
        foreach (primary_weapon in primaries) {
            if (primary_weapon !== self.secondaryloadoutweapon) {
                self._current_weapon = primary_weapon;
                break;
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x9dd5c4b2, Offset: 0x31e0
// Size: 0x372
function init_clientfields() {
    clientfield::register("world", "tunnel_wall_explode", 1, 1, "int");
    clientfield::register("toplayer", "unlimited_sprint_off", 1, 1, "int");
    clientfield::register("world", "setup_security_cameras", 1, 1, "int");
    clientfield::register("toplayer", "set_cam_lookat_object", 1, 4, "int");
    clientfield::register("toplayer", "sndCameraScanner", 1, 3, "int");
    clientfield::register("scriptmover", "update_camera_position", 1, 4, "int");
    clientfield::register("world", "interrogate_physics", 1, 1, "int");
    clientfield::register("world", "blend_in_cleanup", 1, 1, "int");
    clientfield::register("world", "fuel_depot_truck_explosion", 1, 1, "int");
    clientfield::register("world", "apc_rail_tower_collapse", 1, 1, "int");
    clientfield::register("world", "vtol_missile_explode_trash_fx", 1, 1, "int");
    clientfield::register("toplayer", "turn_on_multicam", 1, 3, "int");
    clientfield::register("toplayer", "turn_off_tacmode_vfx", 1, 1, "int");
    clientfield::register("toplayer", "dropship_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "apc_speed_blur", 1, 1, "int");
    clientfield::register("world", "diaz_break_1", 1, 2, "int");
    clientfield::register("world", "diaz_break_2", 1, 2, "int");
    clientfield::register("toplayer", "player_tunnel_dust_fx_on_off", 1, 1, "int");
    clientfield::register("toplayer", "player_tunnel_dust_fx", 1, 1, "int");
    clientfield::register("toplayer", "player_blood_splatter", 1, 1, "int");
    clientfield::register("actor", "cyber_soldier_camo", 1, 2, "int");
    clientfield::register("world", "toggle_security_camera_pbg_bank", 1, 1, "int");
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3560
// Size: 0x2
function precache() {
    
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x6968cbb6, Offset: 0x3570
// Size: 0x582
function function_673254cc() {
    skipto::add("skipto_air_traffic_controller", &function_f30178fc, "Air Traffic Controller", &function_f0e11b0f);
    skipto::function_d68e678e("skipto_nrc_knocking", &function_5bf6196d, "NRC Knocking", &function_99e8b2fa);
    skipto::add("skipto_blend_in", &function_9afd1f40, "Blend In", &function_a856a753);
    skipto::function_d68e678e("skipto_take_out_guards", &function_6977d5a4, "Take Out Guards", &function_33e74d97);
    skipto::function_d68e678e("skipto_security_camera", &function_57c4f8a7, "Security Camera", &function_e9c19f80);
    skipto::function_d68e678e("skipto_hostage_1", &function_f70ba4de, "Fuel Depot", &function_b8ac064d);
    skipto::function_d68e678e("skipto_prison", &function_563809d0, "Prison", &function_c5e740c3);
    skipto::function_d68e678e("skipto_security_desk", &function_cb5e9ce9, "Security Desk", &function_9a16286);
    skipto::function_d68e678e("skipto_lift_escape", &function_129dd7aa, "Lift Escape", &function_874e4009);
    skipto::function_d68e678e("skipto_intro_cyber_soldiers", &function_8b6d4df5, "Intro Cyber Soldiers", &function_2cf07fc2);
    skipto::function_d68e678e("skipto_hangar", &function_5eddb104, "Hangar", &function_45eb05f7);
    skipto::function_d68e678e("skipto_vtol_collapse", &function_d797037e, "VTOL Collapse", &function_9af4a8ed);
    skipto::function_d68e678e("skipto_jeep_alley", &function_ddf114c9, "Jeep Alley", &function_fea8bf66);
    skipto::add("skipto_bridge_battle", &function_d714762b, "Bridge Battle", &function_47b85bb4);
    skipto::function_d68e678e("skipto_dark_battle", &function_32dc1c24, "Dark Battle", &function_5ee97c17);
    skipto::function_d68e678e("skipto_vtol_tackle", &function_30f4cc7b, "Vtol Tackle", &function_c16332e4);
    skipto::function_d68e678e("skipto_robot_horde", &function_34495a26, "Robot Horde", &function_b91214d5);
    skipto::function_d68e678e("skipto_apc", &apc::function_61ebdfad, "APC", &apc::function_c92883a);
    skipto::function_d68e678e("skipto_apc_rail", &apc::function_c1b99214, "APC Rail", &apc::function_961480e7);
    skipto::add("skipto_apc_rail_stall", &apc::function_2ac0c49, "APC Rail Stall", &apc::function_fbfbaee6);
    skipto::function_d68e678e("skipto_robot_defend", &function_373c7d0a, "Robot Defend", &function_d287c569);
    skipto::add("skipto_prologue_ending", &namespace_b7c5904::function_48700afe, "Player Prologue Ending", &namespace_b7c5904::function_cc36a86d);
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x23fda9e4, Offset: 0x3b00
// Size: 0x3a
function function_f30178fc(str_objective, var_74cd64bc) {
    function_77d9dff("objective_air_traffic_controller_init");
    namespace_93c87ad0::function_dc04ece5();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x68359e10, Offset: 0x3b48
// Size: 0x52
function function_f0e11b0f(name, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        exploder::exploder("fx_exploder_disable_fx_start");
    }
    function_77d9dff("objective_air_traffic_controller_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xd3d4ea1, Offset: 0x3ba8
// Size: 0xea
function function_5bf6196d(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        lui::prime_movie("cp_prologue_env_post_crash");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        load::function_a2995f22();
        level thread scene::skipto_end("cin_pro_01_02_airtraffic_1st_hack_aftermath", undefined, undefined, 0.7, 1);
        videostart("cp_prologue_env_post_crash", 1);
    }
    objectives::set("cp_level_prologue_locate_the_security_room");
    function_77d9dff("objective_nrc_knocking_init");
    namespace_bd91a0fd::function_1605fd36();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb8708424, Offset: 0x3ca0
// Size: 0x122
function function_99e8b2fa(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("objective_nrc_knocking_done");
    if (level.var_31aefea8 == "skipto_blend_in" || !var_74cd64bc || level.var_31aefea8 == "skipto_take_out_guards") {
        level thread scene::play("p7_fxanim_cp_prologue_vtol_searchlight_bundle");
    }
    callback::on_spawned(&function_4d4f1d4f);
    struct::function_368120a1("scene", "cin_pro_01_02_airtraffic_1st_hack_ai");
    struct::function_368120a1("scene", "cin_pro_01_02_airtraffic_1st_hack");
    struct::function_368120a1("scene", "cin_pro_01_02_airtraffic_1st_hack_aftermath_ai");
    struct::function_368120a1("scene", "cin_pro_01_02_airtraffic_1st_hack_aftermath");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xa995e749, Offset: 0x3dd0
// Size: 0x1a2
function function_9afd1f40(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::set("cp_level_prologue_locate_the_security_room");
        function_bff1a867("skipto_blend_in_hendricks");
        level.var_2fd26037.pacifist = 1;
        level.var_2fd26037.ignoreme = 1;
        level scene::skipto_end("landing_gear_anim", "targetname");
        level scene::skipto_end("plane_tail_explosion", "targetname");
        level scene::skipto_end("plane_cockpit_explosion", "targetname");
        load::function_a2995f22();
        exploder::exploder("fx_exploder_plane_exp");
        array::run_all(level.players, &util::function_16c71b8, 1);
        array::thread_all(level.players, &function_7072c5d8);
        level thread namespace_bd91a0fd::function_6bad1a34();
    }
    videostop("cp_prologue_env_post_crash");
    function_77d9dff("objective_blend_in_init");
    namespace_bd91a0fd::function_568a781d();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xd74ec893, Offset: 0x3f80
// Size: 0xa3
function function_a856a753(name, var_74cd64bc, var_e4cd2b8b, player) {
    if (!var_74cd64bc || level.var_31aefea8 == "skipto_take_out_guards" || level.var_31aefea8 == "skipto_security_camera") {
        level thread scene::init("cin_pro_05_01_securitycam_1st_stealth_kill");
        level thread scene::init("cin_pro_05_01_securitycam_1st_stealth_kill_movetodoor");
    }
    function_77d9dff("objective_blend_in_done");
    level notify(#"hash_beaa69f3");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x2f8a8d98, Offset: 0x4030
// Size: 0x102
function function_6977d5a4(str_objective, var_74cd64bc) {
    function_77d9dff("objective_take_out_guards_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::set("cp_level_prologue_locate_the_security_room");
        level thread objectives::breadcrumb("blending_in_breadcrumb_3");
        level flag::set("hendr_crossed_tarmac");
        if (!isdefined(level.var_2fd26037)) {
            level.var_2fd26037 = util::function_740f8516("hendricks");
            function_bff1a867("skipto_take_out_guards_hendricks");
        }
        scene::init("cin_pro_03_02_blendin_vign_tarmac_cross_end_idle");
        load::function_a2995f22();
    }
    namespace_bd91a0fd::function_e38f7be3();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xe48d9c13, Offset: 0x4140
// Size: 0x11a
function function_33e74d97(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("objective_take_out_guards_done");
    level notify(#"hash_f70290fd");
    if (var_74cd64bc) {
        level struct::function_368120a1("scene", "p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle");
        level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_injured");
        level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_attendfire");
        level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_help");
        level struct::function_368120a1("scene", "cin_pro_03_02_blendin_vign_destruction_putoutfire");
    }
    level scene::init("cin_pro_06_03_hostage_1st_khalil_intro_door");
    level scene::stop("p7_fxanim_cp_prologue_vtol_searchlight_bundle");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xf3c80cf7, Offset: 0x4268
// Size: 0x192
function function_57c4f8a7(str_objective, var_74cd64bc) {
    function_77d9dff("objective_security_camera_init");
    if (!isdefined(level.var_2fd26037)) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        function_bff1a867();
        skipto::teleport_ai(str_objective);
    }
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::complete("cp_level_prologue_locate_the_security_room");
        objectives::set("cp_level_prologue_locate_the_minister");
        level flag::set("stealth_kill_prepare_done");
        level thread scene::skipto_end("cin_pro_04_01_takeout_vign_truck_prisoners", undefined, undefined, 0.4);
        level thread scene::skipto_end("cin_pro_04_02_takeout_vign_truck_unload", undefined, undefined, 0.4);
        level thread scene::skipto_end("forkilft_anim", undefined, undefined, 0.5);
        level thread scene::add_scene_func("cin_pro_05_01_securitycam_1st_stealth_kill_prepare", &namespace_e09822e3::function_d6557dc4);
        level thread scene::play("cin_pro_05_01_securitycam_1st_stealth_kill_prepare");
        load::function_a2995f22();
    }
    namespace_e09822e3::function_d6a885d6(str_objective);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xac54bfa8, Offset: 0x4408
// Size: 0x10a
function function_e9c19f80(name, var_74cd64bc, var_e4cd2b8b, player) {
    callback::remove_on_spawned(&function_4d4f1d4f);
    array::run_all(level.players, &util::function_16c71b8, 0);
    level notify(#"hash_e1626ff0");
    scene::add_scene_func("cin_pro_06_03_hostage_vign_breach_playerbreach", &prison::function_f8d7f50a, "init");
    scene::init("cin_pro_06_03_hostage_vign_breach_playerbreach");
    var_f33f812b = getent("fuel_truck_faxnim_clip", "targetname");
    var_f33f812b notsolid();
    function_77d9dff("objective_security_camera_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x49eb39ec, Offset: 0x4520
// Size: 0xe2
function function_f70ba4de(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        level flag::set("hendricks_exit_cam_room");
        level thread namespace_21b2c1f2::function_baefe66d();
        level thread scene::skipto_end_noai("cin_pro_05_01_securitycam_1st_stealth_kill");
        load::function_a2995f22();
    }
    function_77d9dff("objective_hostage_1_init");
    level thread objectives::breadcrumb("rescue_breadcrumb_1");
    namespace_ab720c84::function_7af85b91(str_objective);
    level thread scene::init("cin_pro_06_03_hostage_vign_breach_hendrickscover");
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb94976e6, Offset: 0x4610
// Size: 0xb3
function function_b8ac064d(name, var_a334437f, var_e4cd2b8b, player) {
    if (scene::is_active("cin_pro_05_01_securitycam_1st_stealth_kill")) {
        level thread scene::stop("cin_pro_05_01_securitycam_1st_stealth_kill");
    }
    var_88e2cef7 = getent("trig_open_weapons_room", "targetname");
    var_88e2cef7 triggerenable(0);
    function_77d9dff("hostage_1_done");
    level notify(#"hash_ba0d25af");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x5d1757b1, Offset: 0x46d0
// Size: 0x9a
function function_563809d0(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level scene::init("cin_pro_06_03_hostage_vign_breach_hendrickscover");
        namespace_2cb3876f::function_34acbf2();
        level thread namespace_21b2c1f2::function_d4c52995();
        load::function_a2995f22();
    }
    function_77d9dff("objective_prison_init");
    prison::function_955cbf0d(str_objective);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xb55bbf1, Offset: 0x4778
// Size: 0xa3
function function_c5e740c3(name, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        exploder::exploder("light_exploder_prison_exit");
    }
    level thread scene::skipto_end_noai("cin_pro_06_03_hostage_vign_breach_playerbreach");
    level thread scene::skipto_end_noai("cin_pro_04_01_takeout_vign_truck_prisoners");
    level scene::init("p7_fxanim_cp_prologue_ceiling_underground_crane_bundle");
    function_77d9dff("prison");
    level notify(#"prison");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x71eceb00, Offset: 0x4828
// Size: 0x1da
function function_cb5e9ce9(str_objective, var_74cd64bc) {
    namespace_52f8de11::function_bfe70f02();
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level thread objectives::breadcrumb("post_prison_breadcrumb_start");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        function_bff1a867("skipto_security_desk_hendricks");
        level.var_4d5a4697 = util::function_740f8516("minister");
        function_211ff3c7("skipto_security_desk_minister");
        level.var_4d5a4697 ai::set_ignoreme(1);
        level.var_9db406db = util::function_740f8516("khalil");
        function_c117302b("skipto_security_desk_khalil");
        level.var_9db406db ai::set_ignoreme(1);
        level scene::skipto_end("cin_pro_06_03_hostage_1st_khalil_intro_rescue");
        load::function_a2995f22();
    }
    scene::init("cin_pro_07_01_securitydesk_vign_weapons");
    function_77d9dff("objective_security_desk_init");
    namespace_52f8de11::function_72514870(str_objective);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xaaa3f907, Offset: 0x4a10
// Size: 0x52
function function_9a16286(name, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::init("cin_pro_10_01_hanger_vign_sensory_overload_start");
    function_77d9dff("security_desk_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xfe24c77d, Offset: 0x4a70
// Size: 0xd2
function function_129dd7aa(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level thread namespace_21b2c1f2::function_6c35b4f3();
        level thread objectives::breadcrumb("post_prison_breadcrumb_1");
        load::function_a2995f22();
    }
    function_77d9dff("objective_lift_escape_init");
    namespace_e80bc418::function_68538fd(str_objective);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x4b983019, Offset: 0x4b50
// Size: 0x1c2
function function_874e4009(name, var_74cd64bc, var_e4cd2b8b, player) {
    scene::stop("cin_pro_06_03_hostage_vign_breach_playerbreach", 1);
    scene::stop("cin_pro_06_03_hostage_vign_breach_hendrickscover", 1);
    scene::stop("cin_pro_06_03_hostage_vign_breach");
    scene::stop("cin_pro_05_02_securitycam_pip_pipe", 1);
    scene::stop("cin_pro_05_02_securitycam_pip_waterboard", 1);
    scene::stop("cin_pro_05_02_securitycam_pip_branding", 1);
    scene::stop("p7_fxanim_cp_prologue_ceiling_underground_crane_bundle", 1);
    var_2e1f1409 = getent("hangar_gate_02", "targetname");
    var_2e1f1409 ghost();
    var_2e1f1409 = getent("hangar_gate_03", "targetname");
    var_2e1f1409 ghost();
    var_2e1f1409 = getent("hangar_gate_04", "targetname");
    var_2e1f1409 ghost();
    umbragate_set("umbra_gate_hangar_02", 1);
    umbragate_set("umbra_gate_hangar_03", 1);
    umbragate_set("umbra_gate_hangar_04", 1);
    function_77d9dff("lift_escape_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x886a9207, Offset: 0x4d20
// Size: 0x1da
function function_8b6d4df5(str_objective, var_74cd64bc) {
    function_77d9dff("objective_intro_cyber_soldiers_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_9db406db = util::function_740f8516("khalil");
        skipto::teleport_ai(str_objective, level.heroes);
        namespace_e80bc418::function_d4734ff1();
        level.var_be31aa9a = getent("freight_lift", "targetname");
        if (!isdefined(level.var_3dce3f88)) {
            level.var_3dce3f88 = spawn("script_model", level.var_be31aa9a.origin);
            level.var_be31aa9a linkto(level.var_3dce3f88);
        }
        load::function_a2995f22();
        namespace_dccf27b3::function_f9753551();
        level thread namespace_e80bc418::function_a3dbf6a2();
        level waittill(#"hash_b100689e");
    }
    namespace_dccf27b3::function_23ed1506();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x9256d17a, Offset: 0x4f08
// Size: 0x15a
function function_2cf07fc2(name, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::init("cin_pro_11_01_jeepalley_vign_engage_start");
    level thread scene::init("p7_fxanim_cp_prologue_hangar_window_rip_bundle");
    level thread scene::init("p7_fxanim_cp_prologue_vtol_hangar_bundle");
    level clientfield::set("diaz_break_1", 1);
    level clientfield::set("diaz_break_2", 1);
    scene::init("bridge_tent_01", "targetname");
    scene::init("bridge_tent_02", "targetname");
    scene::init("bridge_tent_03", "targetname");
    level thread scene::skipto_end("p7_fxanim_cp_prologue_hangar_doors_02_bundle");
    level thread namespace_d51ba4::function_ce858cd3(0);
    callback::on_actor_killed(&namespace_d51ba4::function_d3c9b1d1);
    function_77d9dff("intro_cyber_soldiers_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x43033a60, Offset: 0x5070
// Size: 0x25a
function function_5eddb104(str_objective, var_74cd64bc) {
    level.var_f58c9f31 = util::function_740f8516("theia");
    level.var_92d245e2 = util::function_740f8516("prometheus");
    level.var_5d4087a6 = util::function_740f8516("hyperion");
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_f58c9f31 thread namespace_dccf27b3::function_9110a277(1, 0);
        level.var_92d245e2 thread namespace_dccf27b3::function_9110a277(1, 0);
        level.var_5d4087a6 thread namespace_dccf27b3::function_9110a277(1, 0);
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_7f246cd7 = util::function_740f8516("pallas");
        skipto::teleport_ai(str_objective, level.heroes);
        level.var_be31aa9a = getent("freight_lift", "targetname");
        level.var_be31aa9a movez(100, 0.05);
        load::function_a2995f22();
    }
    level thread objectives::breadcrumb("hangar_breadcrumb_start");
    level thread namespace_21b2c1f2::function_46333a8a();
    function_77d9dff("objective_hangar_init");
    namespace_d51ba4::function_83921c71();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x3bbc8684, Offset: 0x52d8
// Size: 0x72
function function_45eb05f7(name, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::skipto_end("p7_fxanim_cp_prologue_hangar_doors_03_bundle");
    callback::remove_on_actor_killed(&namespace_d51ba4::function_d3c9b1d1);
    function_77d9dff("hangar_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x9d509f4e, Offset: 0x5358
// Size: 0x25a
function function_d797037e(str_objective, var_74cd64bc) {
    level.var_92d245e2 = util::function_740f8516("prometheus");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_7f246cd7 = util::function_740f8516("pallas");
        level thread scene::skipto_end("cin_pro_10_04_hangar_vign_leap_new_wing2window");
        level flag::set("pallas_at_window");
        level.var_fac57550 = vehicle::simple_spawn_single("vtol_collapse_apc_initial");
        wait(0.15);
        level.var_2fd26037 thread namespace_d51ba4::function_d418516(level.var_fac57550);
        level.var_9db406db thread namespace_d51ba4::function_d418516(level.var_fac57550);
        trigger::use("hangar_end_move_allies", "targetname", undefined, 0);
        level namespace_d51ba4::function_10ab649();
        level clientfield::set("diaz_break_1", 2);
        skipto::teleport_ai(str_objective, level.heroes);
        load::function_a2995f22();
    }
    level thread objectives::breadcrumb("hangar_breadcrumb_4");
    function_77d9dff("objective_vtol_collapse_init");
    namespace_d51ba4::function_31427ccd();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x6f5eabc2, Offset: 0x55c0
// Size: 0x1aa
function function_9af4a8ed(name, var_74cd64bc, var_e4cd2b8b, player) {
    var_280d5f68 = getent("hangar_gate_l", "targetname");
    var_3c301126 = getent("hangar_gate_r", "targetname");
    var_9c7511b4 = struct::get("hangar_gate_move_pos_l", "targetname");
    var_205c499a = struct::get("hangar_gate_move_pos_r", "targetname");
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_door_bundle";
    level namespace_d51ba4::function_a8cd091b(1, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9);
    exploder::exploder("light_exploder_darkbattle");
    exploder::exploder("light_exploder_defend_radio_tower");
    umbragate_set("umbra_gate_hangar_02", 0);
    umbragate_set("umbra_gate_hangar_03", 0);
    umbragate_set("umbra_gate_hangar_04", 0);
    if (name == "skipto_jeep_alley" && var_74cd64bc) {
        namespace_30207c6f::function_fcc9ed10();
    }
    level notify(#"hash_73facd66");
    function_77d9dff("vtol_collapse_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x3d7f59b8, Offset: 0x5778
// Size: 0x15a
function function_ddf114c9(str_objective, var_74cd64bc) {
    level.var_f58c9f31 = util::function_740f8516("theia");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::set("cp_level_prologue_get_to_the_surface");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective, level.heroes);
        load::function_a2995f22();
    }
    level thread scene::play("p7_fxanim_cp_prologue_plane_hanger_pristine_bundle");
    function_77d9dff("objective_jeep_alley_init");
    namespace_30207c6f::function_910f2aa();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x1afbaeb2, Offset: 0x58e0
// Size: 0x3a
function function_fea8bf66(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("jeep_alley_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xab8787bf, Offset: 0x5928
// Size: 0x2c2
function function_d714762b(str_objective, var_74cd64bc) {
    level.var_5d4087a6 = util::function_740f8516("hyperion");
    level.var_f58c9f31 = util::function_740f8516("theia");
    var_61b253a2 = getweapon("sniper_fastbolt_hero", "extclip", "fastreload");
    level.var_5d4087a6 shared::stowweapon(var_61b253a2, (-8, 4, 14), (90, 0, 0));
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        level.var_f58c9f31 = util::function_740f8516("theia");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(str_objective, level.heroes);
        level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_attack", &namespace_30207c6f::function_cf946de6);
        level scene::add_scene_func("cin_pro_11_01_jeepalley_vign_engage_attack", &namespace_30207c6f::function_7af067f4, "done");
        level thread scene::skipto_end("cin_pro_11_01_jeepalley_vign_engage_attack", undefined, undefined, 0.8);
        scene::play("p7_fxanim_cp_prologue_plane_hanger_explode_bundle");
        level.var_35c12e63 = struct::get("bridge_obj", "targetname");
        objectives::set("cp_waypoint_breadcrumb", level.var_35c12e63);
        load::function_a2995f22();
        trigger::use("jeep_alley_allies_move", "targetname");
    }
    function_77d9dff("objective_bridge_battle_init");
    namespace_dc79b4d3::function_b86981e6();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x44542c09, Offset: 0x5bf8
// Size: 0x20a
function function_47b85bb4(name, var_74cd64bc, var_e4cd2b8b, player) {
    scene::skipto_end("bridge_tent_01", "targetname");
    scene::skipto_end("bridge_tent_02", "targetname");
    scene::skipto_end("bridge_tent_03", "targetname");
    scene::skipto_end("p7_fxanim_cp_prologue_plane_hanger_explode_bundle");
    var_59ff07ee = getent("bridge_section_1", "targetname");
    if (isdefined(var_59ff07ee)) {
        var_59ff07ee delete();
        var_33fc8d85 = getent("bridge_section_2", "targetname");
        var_33fc8d85 delete();
        var_dfa131c = getent("bridge_section_3", "targetname");
        var_dfa131c delete();
        var_e7f798b3 = getentarray("bridge_section_4", "targetname");
        array::run_all(var_e7f798b3, &delete);
    }
    var_8de6057e = getent("prologue_bridge", "targetname");
    if (isdefined(var_8de6057e)) {
        var_8de6057e delete();
    }
    showmiscmodels("fxanim_bridge_static2");
    level notify(#"hash_800cbac6");
    function_77d9dff("bridge_battle_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x64f0eea4, Offset: 0x5e10
// Size: 0x1c2
function function_32dc1c24(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        level.var_5d4087a6 = util::function_740f8516("hyperion");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        var_61b253a2 = getweapon("sniper_fastbolt_hero", "extclip", "fastreload");
        level.var_5d4087a6 shared::stowweapon(var_61b253a2, (-8, 4, 14), (90, 0, 0));
        level thread scene::skipto_end("cin_pro_11_01_jeepalley_vign_engage_attack", undefined, undefined, 0.98);
        load::function_a2995f22();
        exploder::exploder("light_exploder_darkbattle");
        skipto::teleport_ai(str_objective, level.heroes);
    }
    function_77d9dff("objective_dark_battle_init");
    namespace_36e484c6::function_6feca657();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x5cb08be2, Offset: 0x5fe0
// Size: 0x36a
function function_5ee97c17(name, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::init("cin_pro_15_01_opendoor_vign_getinside_new_prometheus_doorhold");
    function_77d9dff("dark_battle_done");
    if (scene::is_playing("cin_pro_11_01_jeepalley_vign_engage_attack")) {
        level thread scene::stop("cin_pro_11_01_jeepalley_vign_engage_attack");
    }
    var_59ff07ee = getent("bridge_section_1", "targetname");
    if (isdefined(var_59ff07ee)) {
        var_59ff07ee delete();
    }
    var_33fc8d85 = getent("bridge_section_2", "targetname");
    if (isdefined(var_33fc8d85)) {
        var_33fc8d85 delete();
    }
    var_dfa131c = getent("bridge_section_3", "targetname");
    if (isdefined(var_dfa131c)) {
        var_dfa131c delete();
    }
    var_22216bde = getentarray("bridge_section_4", "targetname");
    foreach (var_8f9551fe in var_22216bde) {
        var_8f9551fe delete();
    }
    exploder::stop_exploder("light_exploder_darkbattle");
    if (!sessionmodeiscampaignzombiesgame()) {
        array::thread_all(level.players, &oed::function_35ce409, 0);
    }
    level thread apc::function_81a9e31c();
    e_collision = getent("hangar_vtol_crash_clip", "targetname");
    e_collision connectpaths();
    e_collision delete();
    wait(0.05);
    e_door = getent("hall_door_slide_right", "targetname");
    e_door connectpaths();
    e_door delete();
    wait(0.05);
    e_door = getent("hall_door_slide_left", "targetname");
    e_door connectpaths();
    e_door delete();
    trigger::use("t_motorpool_spawns_disable", "targetname");
    var_9a246ea8 = getent("t_robot_horde_oob", "targetname");
    if (isdefined(var_9a246ea8)) {
        var_9a246ea8 triggerenable(0);
    }
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x6fe962cb, Offset: 0x6358
// Size: 0x2e2
function function_30f4cc7b(str_objective, var_74cd64bc) {
    level.var_92d245e2 = util::function_740f8516("prometheus");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::complete("cp_level_prologue_escort_data_center");
        objectives::set("cp_level_prologue_find_vehicle");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_5d4087a6 = util::function_740f8516("hyperion");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        var_61b253a2 = getweapon("sniper_fastbolt_hero", "extclip", "fastreload");
        level.var_5d4087a6 shared::stowweapon(var_61b253a2, (-8, 4, 14), (90, 0, 0));
        level thread namespace_36e484c6::function_25c6144e();
        level scene::init("p7_fxanim_cp_prologue_vtol_tackle_windows_bundle");
        load::function_a2995f22();
        array::thread_all(level.players, &clientfield::set_to_player, "turn_off_tacmode_vfx", 1);
        array::thread_all(level.players, &oed::function_35ce409, 0);
        array::thread_all(level.players, &oed::function_ffc82115, 0);
        spawner::add_spawn_function_group("initial_vtol_guys", "targetname", &namespace_2cb3876f::function_35be2939, "vtol_has_crashed");
        spawn_manager::enable("vtol_tackle_spwn_mgr2");
        skipto::teleport_ai(str_objective, level.heroes);
    }
    level thread namespace_21b2c1f2::function_63ffe714();
    function_77d9dff("objective_vtol_tackle_init");
    namespace_1c6b20b7::function_e9166d2d(var_74cd64bc);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x8f29a91b, Offset: 0x6648
// Size: 0x3a
function function_c16332e4(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("vtol_tackle_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xaf672c82, Offset: 0x6690
// Size: 0x1f2
function function_34495a26(str_objective, var_74cd64bc) {
    level.var_7f246cd7 = util::function_740f8516("pallas");
    level.var_f58c9f31 = util::function_740f8516("theia");
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_2cb3876f::function_34acbf2();
        namespace_2cb3876f::function_df278013();
        namespace_2cb3876f::function_9d35b20d();
        objectives::complete("cp_level_prologue_escort_data_center");
        objectives::set("cp_level_prologue_find_vehicle");
        level.var_f58c9f31 = util::function_740f8516("theia");
        level.var_5d4087a6 = util::function_740f8516("hyperion");
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_92d245e2 = util::function_740f8516("prometheus");
        skipto::teleport_ai(str_objective, level.heroes);
        level namespace_2cb3876f::function_6a5f89cb("skipto_robot_horde_ai");
        load::function_a2995f22();
    }
    function_77d9dff("objective_robot_horde_init");
    namespace_12501af4::function_78909aa1();
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0xa6494444, Offset: 0x6890
// Size: 0x3a
function function_b91214d5(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("robot_horde_done");
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0xb54c9ba7, Offset: 0x68d8
// Size: 0x2ca
function function_373c7d0a(str_objective, var_74cd64bc) {
    function_77d9dff("objective_robot_defend_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread namespace_2cb3876f::function_cfabe921();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_9db406db = util::function_740f8516("khalil");
        level.apc = vehicle::simple_spawn_single("apc");
        level.apc vehicle::lights_off();
        level thread scene::skipto_end("cin_pro_17_01_robotdefend_vign_apc_exit_apc");
        load::function_a2995f22();
        level namespace_2cb3876f::function_6a5f89cb("skipto_robot_defend");
        level flag::set("apc_done");
        var_c1767e6 = getent("m_tunnel_vtol_death", "targetname");
        var_c1767e6 show();
        exploder::exploder("fx_exploder_vtol_crash_rail");
        level flag::set("apc_unlocked");
        level thread apc::function_599ebca1();
    } else {
        level.apc turret::disable(1);
        level.apc turret::disable(2);
        level.apc turret::disable(3);
        level.apc turret::disable(4);
    }
    level thread function_b5502f69();
    playfxontag(level._effect["apc_death_fx_cin"], level.apc, "tag_origin_animate");
    exploder::exploder("light_exploder_headlight_flicker_02");
    function_c117302b("skipto_robot_defend_khalil");
    function_211ff3c7("skipto_robot_defend_minister");
    function_bff1a867("skipto_robot_defend_hendricks");
    namespace_835fda7e::function_5dcf4c9a(var_74cd64bc);
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xd82e2ca8, Offset: 0x6bb0
// Size: 0xfb
function function_b5502f69() {
    var_9b399cbb = array("p7_fxanim_cp_prologue_bridge_tent_bundle", "p7_fxanim_cp_prologue_bridge_bundle", "cin_pro_12_01_darkbattle_vign_dive_kill_start");
    foreach (str_bundlename in var_9b399cbb) {
        var_9cc495a4 = struct::get_array(str_bundlename, "targetname");
        foreach (bundle in var_9cc495a4) {
            if (isdefined(bundle)) {
                bundle delete();
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x72973546, Offset: 0x6cb8
// Size: 0x43
function function_d287c569(name, var_74cd64bc, var_e4cd2b8b, player) {
    function_77d9dff("robot_defend_done");
    level notify(#"hash_7d7d7481");
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xa499e3c5, Offset: 0x6d08
// Size: 0x2a
function function_77d9dff(msg) {
    println("taylor_direct" + msg);
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x4a97eb28, Offset: 0x6d40
// Size: 0xba
function function_bff1a867(var_a7fcc91d) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    primary_weapon = getweapon("ar_standard");
    level.var_2fd26037 ai::gun_switchto(primary_weapon, "right");
    if (isdefined(var_a7fcc91d)) {
        s_struct = struct::get(var_a7fcc91d, "targetname");
        level.var_2fd26037 forceteleport(s_struct.origin, s_struct.angles);
    }
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xbac41de4, Offset: 0x6e08
// Size: 0xbe
function function_211ff3c7(var_a7fcc91d) {
    level.var_4d5a4697 = util::function_740f8516("minister");
    if (isdefined(var_a7fcc91d)) {
        s_struct = struct::get(var_a7fcc91d, "targetname");
        level.var_4d5a4697 forceteleport(s_struct.origin, s_struct.angles);
    }
    if (sessionmodeiscampaignzombiesgame()) {
        level.var_4d5a4697.script_friendname = "Bishop";
        level.var_4d5a4697.propername = "Bishop";
    }
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x60175324, Offset: 0x6ed0
// Size: 0x7a
function function_c117302b(var_a7fcc91d) {
    level.var_9db406db = util::function_740f8516("khalil");
    if (isdefined(var_a7fcc91d)) {
        s_struct = struct::get(var_a7fcc91d, "targetname");
        level.var_9db406db forceteleport(s_struct.origin, s_struct.angles);
    }
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x14a8ab2c, Offset: 0x6f58
// Size: 0x69
function function_16f6b7f1(var_c335265b) {
    a_spawners = getentarray(var_c335265b, "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        a_spawners[i] spawner::add_spawn_function(&function_899f174d, var_c335265b);
    }
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xbb43831f, Offset: 0x6fd0
// Size: 0x12
function function_b6ef2c4e(str_group) {
    self.var_1f9269c0 = str_group;
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0xec8f7be4, Offset: 0x6ff0
// Size: 0xa1
function function_6a77bdd4(str_group) {
    a_ai = getaiarray();
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            e_ent = a_ai[i];
            if (isalive(e_ent) && isdefined(e_ent.var_1f9269c0) && e_ent.var_1f9269c0 == str_group) {
                e_ent.var_1f9269c0 = undefined;
                e_ent delete();
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x31dfbc16, Offset: 0x70a0
// Size: 0x1a
function function_899f174d(str_group) {
    function_b6ef2c4e(str_group);
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x8fd588f0, Offset: 0x70c8
// Size: 0x2a
function function_4d4f1d4f() {
    level notify(#"hash_25ea191a");
    self util::function_16c71b8(1);
    self thread function_7072c5d8();
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xf1989ff0, Offset: 0x7100
// Size: 0x4d
function function_7072c5d8() {
    level endon(#"hash_e1626ff0");
    self notify(#"hash_beba65a6");
    self endon(#"hash_beba65a6");
    self endon(#"death");
    while (true) {
        self waittill(#"player_revived");
        self util::function_16c71b8(1);
    }
}

