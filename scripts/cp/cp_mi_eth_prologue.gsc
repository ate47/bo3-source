#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_turret_sentry;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_patch;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_bridge;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_dark_battle;
#using scripts/cp/cp_prologue_ending;
#using scripts/cp/cp_prologue_enter_base;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_hostage_rescue;
#using scripts/cp/cp_prologue_intro;
#using scripts/cp/cp_prologue_player_sacrifice;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_security_camera;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/gametypes/_save;
#using scripts/cp/voice/voice_prologue;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_eth_prologue;

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x582c97f9, Offset: 0x2480
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x8f3bad68, Offset: 0x24c0
// Size: 0x2bc
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 17 );
    }
    
    init_clientfields();
    util::init_streamer_hints( 7 );
    scene::add_wait_for_streamer_hint_scene( "cin_pro_20_01_rippedapart_murder" );
    savegame::set_mission_name( "prologue" );
    init_flags();
    callback::on_connect( &function_7bf018c5 );
    callback::on_connect( &on_player_connect );
    collectibles::function_93523442( "p7_nc_eth_pro_01", 60, ( 3, -5, 0 ) );
    collectibles::function_93523442( "p7_nc_eth_pro_04", 120, ( -3, -3, 0 ) );
    prologue_accolades::function_4d39a2af();
    precache();
    level_setup();
    setdvar( "bullet_ricochetBaseChance", 0 );
    cp_mi_eth_prologue_fx::main();
    cp_mi_eth_prologue_sound::main();
    voice_prologue::init_voice();
    level.b_tactical_mode_enabled = 0;
    level.b_enhanced_vision_enabled = 0;
    level.var_d086f08f = 1;
    skipto::set_skip_safehouse();
    level thread setup_skiptos();
    callback::on_spawned( &on_player_spawned );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        callback::on_loadout( &on_player_loadout );
    }
    
    load::main();
    setgametypesetting( "trm_maxHeight", 50 );
    cp_mi_eth_prologue_patch::function_7403e82b();
    setdvar( "cg_viewVehicleInfluenceGunner_mode", 2 );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x7b278a24, Offset: 0x2788
// Size: 0x24
function function_7bf018c5()
{
    self flag::init( "tutorial_allowed", 1 );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x3cc8b24f, Offset: 0x27b8
// Size: 0x114
function level_setup()
{
    a_t_ob = getentarray( "trigger_ob_defend", "targetname" );
    
    foreach ( t_ob in a_t_ob )
    {
        t_ob triggerenable( 0 );
    }
    
    var_5aebca26 = getent( "rpg_target", "targetname" );
    var_5aebca26 hide();
    hidemiscmodels( "fxanim_bridge_static2" );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x870dbf8c, Offset: 0x28d8
// Size: 0x8e4
function init_flags()
{
    level flag::init( "tower_doors_open" );
    level flag::init( "is_base_alerted" );
    level flag::init( "start_tower_collapse" );
    level flag::init( "hendr_crossed_tarmac" );
    level flag::init( "start_hendr_kill" );
    level flag::init( "stealth_kill_prepare_done" );
    level flag::init( "security_cam_full_house" );
    level flag::init( "face_scanning_complete" );
    level flag::init( "face_scanning_double_pause" );
    level flag::init( "scanning_dialog_done" );
    level flag::init( "player_past_security_room" );
    level flag::init( "hendricks_exit_cam_room" );
    level flag::init( "start_grenade_roll" );
    level flag::init( "player_breached_early" );
    level flag::init( "interrogation_finished" );
    level flag::init( "vtol_destroy_obj" );
    level flag::init( "hendricks_in_lift" );
    level flag::init( "khalil_in_lift" );
    level flag::init( "minister_in_lift" );
    level flag::init( "vtol_has_crashed" );
    level flag::init( "pallas_at_window" );
    level flag::init( "player_trigger_gear_drop" );
    level flag::init( "hangar_5_bc" );
    level flag::init( "2nd_hangar_apc_in_pos" );
    level flag::init( "spawn_plane_hangar_enemies" );
    level flag::init( "ev_enabled" );
    level flag::init( "vtol_guards_alerted" );
    level flag::init( "taylor_direct" );
    level flag::init( "robot_contact" );
    level flag::init( "spawn_robot_horde" );
    level flag::init( "open_fire" );
    level flag::init( "garage_open" );
    level flag::init( "garage_closed" );
    level flag::init( "garage_enter" );
    level flag::init( "players_in_garage" );
    level flag::init( "allies_in_garage" );
    level flag::init( "minister_apc_done" );
    level flag::init( "garage_dent" );
    level flag::init( "garage_breach" );
    level flag::init( "garage_broken" );
    level flag::init( "ai_in_apc" );
    level flag::init( "apc_ready" );
    level flag::init( "apc_unlocked" );
    level flag::init( "apc_rail_fail" );
    level flag::init( "failed_apc_boarding" );
    level flag::init( "players_are_in_apc" );
    level flag::init( "apc_rail_begin" );
    level flag::init( "robot_swarm" );
    level flag::init( "apc_restart" );
    level flag::init( "apc_engine_started" );
    level flag::init( "apc_resume" );
    level flag::init( "obs_collapse" );
    level flag::init( "apc_done" );
    level flag::init( "deleting_havok_object" );
    level flag::init( "apc_crash" );
    level flag::init( "pod_on_ground" );
    level flag::init( "minister_pos" );
    level flag::init( "ready_load" );
    level flag::init( "pod_waypoint" );
    level flag::init( "start_defend_countdown" );
    level flag::init( "shift_defend" );
    level flag::init( "apc_arrive" );
    level flag::init( "goto_pod" );
    level flag::init( "pod_arrive" );
    level flag::init( "pod_loaded" );
    level flag::init( "dropship_return" );
    level flag::init( "pod_go" );
    level flag::init( "pod_gone" );
    level flag::init( "rpg_done" );
    level flag::init( "activate_bc_5" );
    level flag::init( "activate_db_bc_2" );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0xc9ec2ab2, Offset: 0x31c8
// Size: 0x4c
function on_player_connect()
{
    self flag::init( "custom_loadout" );
    
    if ( !self cp_prologue_util::function_72e9bdb8() )
    {
        self.disableclassselection = 1;
    }
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x24b4b40, Offset: 0x3220
// Size: 0x3d4
function on_player_spawned()
{
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self oed::set_player_ev( 0 );
        
        if ( !self cp_prologue_util::function_72e9bdb8() )
        {
            self thread function_95517e0b();
        }
    }
    
    if ( !sessionmodeiscampaignzombiesgame() && !isdefined( self.var_40c94058 ) )
    {
        self accolades::function_42acdca5( "MISSION_PROLOGUE_CHALLENGE5" );
        self accolades::function_42acdca5( "MISSION_PROLOGUE_CHALLENGE6" );
        self accolades::function_42acdca5( "MISSION_PROLOGUE_CHALLENGE10" );
        self accolades::function_42acdca5( "MISSION_PROLOGUE_CHALLENGE11" );
        self accolades::function_42acdca5( "MISSION_PROLOGUE_CHALLENGE16" );
        uploadstats( self );
        self.var_40c94058 = 1;
    }
    
    self.var_5e3ab4ad = 0;
    self.var_d1cabfc = 0;
    
    if ( level flag::exists( "ev_enabled" ) && level flag::get( "ev_enabled" ) )
    {
        self oed::set_player_ev( 1 );
    }
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        if ( !self cp_prologue_util::function_72e9bdb8() )
        {
            self.var_8dcb3948 = 1;
            n_body_id = getcharacterbodystyleindex( 0, "CPUI_OUTFIT_PROLOGUE" );
            self setcharacterbodystyle( n_body_id );
            self setmovespeedscale( 0.9 );
            self clientfield::set_to_player( "unlimited_sprint_off", 1 );
        }
    }
    
    var_7476c97b = 0;
    var_f690a1c1 = array( "skipto_air_traffic_controller", "skipto_nrc_knocking", "skipto_blend_in", "skipto_vtol_tackle", "skipto_robot_horde", "skipto_apc", "skipto_apc_rail", "skipto_apc_rail_stall", "skipto_robot_defend", "skipto_prologue_ending" );
    
    foreach ( str_skipto in var_f690a1c1 )
    {
        if ( level.current_skipto == str_skipto )
        {
            var_7476c97b = 1;
            break;
        }
    }
    
    if ( var_7476c97b )
    {
        level cp_prologue_util::spawn_coop_player_replacement( level.current_skipto, 0 );
    }
    
    if ( level flag::get( "players_are_in_apc" ) )
    {
        self apc::function_fc1b1b72();
    }
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x137459a4, Offset: 0x3600
// Size: 0x4a
function function_95517e0b()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"scene_enable_cybercom" );
        util::wait_network_frame();
        level notify( #"disable_cybercom", self, 1 );
    }
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x1c93e773, Offset: 0x3658
// Size: 0xac
function on_player_loadout()
{
    if ( !self cp_prologue_util::function_72e9bdb8() && !sessionmodeiscampaignzombiesgame() )
    {
        level notify( #"disable_cybercom", self, 1 );
        self cybercom_tacrig::takeallrigabilities();
        self cp_prologue_util::give_player_weapons();
    }
    else
    {
        self flag::set( "custom_loadout" );
    }
    
    self function_3fe38b8a();
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0xc218d1f3, Offset: 0x3710
// Size: 0xd2
function function_3fe38b8a()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    primaries = self getweaponslistprimaries();
    
    if ( isdefined( primaries ) )
    {
        foreach ( primary_weapon in primaries )
        {
            if ( primary_weapon !== self.secondaryloadoutweapon )
            {
                self._current_weapon = primary_weapon;
                break;
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x56c92233, Offset: 0x37f0
// Size: 0x424
function init_clientfields()
{
    clientfield::register( "world", "tunnel_wall_explode", 1, 1, "int" );
    clientfield::register( "toplayer", "unlimited_sprint_off", 1, 1, "int" );
    clientfield::register( "world", "setup_security_cameras", 1, 1, "int" );
    clientfield::register( "toplayer", "set_cam_lookat_object", 1, 4, "int" );
    clientfield::register( "toplayer", "sndCameraScanner", 1, 3, "int" );
    clientfield::register( "scriptmover", "update_camera_position", 1, 4, "int" );
    clientfield::register( "world", "interrogate_physics", 1, 1, "int" );
    clientfield::register( "world", "blend_in_cleanup", 1, 1, "int" );
    clientfield::register( "world", "fuel_depot_truck_explosion", 1, 1, "int" );
    clientfield::register( "world", "apc_rail_tower_collapse", 1, 1, "int" );
    clientfield::register( "world", "vtol_missile_explode_trash_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "turn_on_multicam", 1, 3, "int" );
    clientfield::register( "toplayer", "turn_off_tacmode_vfx", 1, 1, "int" );
    clientfield::register( "toplayer", "dropship_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "apc_speed_blur", 1, 1, "int" );
    clientfield::register( "world", "diaz_break_1", 1, 2, "int" );
    clientfield::register( "world", "diaz_break_2", 1, 2, "int" );
    clientfield::register( "toplayer", "player_tunnel_dust_fx_on_off", 1, 1, "int" );
    clientfield::register( "toplayer", "player_tunnel_dust_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "player_blood_splatter", 1, 1, "int" );
    clientfield::register( "actor", "cyber_soldier_camo", 1, 2, "int" );
    clientfield::register( "world", "toggle_security_camera_pbg_bank", 1, 1, "int" );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x99ec1590, Offset: 0x3c20
// Size: 0x4
function precache()
{
    
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x21aa2ce6, Offset: 0x3c30
// Size: 0x584
function setup_skiptos()
{
    skipto::add( "skipto_air_traffic_controller", &skipto_air_traffic_controller_init, "Air Traffic Controller", &skipto_air_traffic_controller_complete );
    skipto::function_d68e678e( "skipto_nrc_knocking", &skipto_nrc_knocking_init, "NRC Knocking", &skipto_nrc_knocking_complete );
    skipto::add( "skipto_blend_in", &skipto_blend_in_init, "Blend In", &skipto_blend_in_complete );
    skipto::function_d68e678e( "skipto_take_out_guards", &skipto_take_out_guards_init, "Take Out Guards", &skipto_take_out_guards_complete );
    skipto::function_d68e678e( "skipto_security_camera", &skipto_security_camera_init, "Security Camera", &skipto_security_camera_complete );
    skipto::function_d68e678e( "skipto_hostage_1", &skipto_hostage_1_init, "Fuel Depot", &skipto_hostage_1_complete );
    skipto::function_d68e678e( "skipto_prison", &skipto_prison_init, "Prison", &skipto_prison_complete );
    skipto::function_d68e678e( "skipto_security_desk", &skipto_security_desk_init, "Security Desk", &skipto_security_desk_complete );
    skipto::function_d68e678e( "skipto_lift_escape", &skipto_lift_escape_init, "Lift Escape", &skipto_lift_escape_complete );
    skipto::function_d68e678e( "skipto_intro_cyber_soldiers", &skipto_intro_cyber_soldiers_init, "Intro Cyber Soldiers", &skipto_intro_cyber_soldiers_complete );
    skipto::function_d68e678e( "skipto_hangar", &skipto_hangar_init, "Hangar", &skipto_hangar_complete );
    skipto::function_d68e678e( "skipto_vtol_collapse", &skipto_vtol_collapse_init, "VTOL Collapse", &skipto_vtol_collapse_complete );
    skipto::function_d68e678e( "skipto_jeep_alley", &skipto_jeep_alley_init, "Jeep Alley", &skipto_jeep_alley_complete );
    skipto::add( "skipto_bridge_battle", &skipto_bridge_battle_init, "Bridge Battle", &skipto_bridge_battle_complete );
    skipto::function_d68e678e( "skipto_dark_battle", &skipto_dark_battle_init, "Dark Battle", &skipto_dark_battle_complete );
    skipto::function_d68e678e( "skipto_vtol_tackle", &skipto_vtol_tackle_init, "Vtol Tackle", &skipto_vtol_tackle_complete );
    skipto::function_d68e678e( "skipto_robot_horde", &skipto_robot_horde_init, "Robot Horde", &skipto_robot_horde_complete );
    skipto::function_d68e678e( "skipto_apc", &apc::skipto_apc_init, "APC", &apc::skipto_apc_complete );
    skipto::function_d68e678e( "skipto_apc_rail", &apc::skipto_apc_rail_init, "APC Rail", &apc::skipto_apc_rail_complete );
    skipto::add( "skipto_apc_rail_stall", &apc::skipto_apc_rail_stall_init, "APC Rail Stall", &apc::skipto_apc_rail_stall_complete );
    skipto::function_d68e678e( "skipto_robot_defend", &skipto_robot_defend_init, "Robot Defend", &skipto_robot_defend_complete );
    skipto::add( "skipto_prologue_ending", &prologue_ending::skipto_prologue_ending_init, "Player Prologue Ending", &prologue_ending::skipto_prologue_ending_complete );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xdf450ae9, Offset: 0x41c0
// Size: 0x3c
function skipto_air_traffic_controller_init( str_objective, b_starting )
{
    skipto_message( "objective_air_traffic_controller_init" );
    air_traffic_controller::air_traffic_controller_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x58a8d886, Offset: 0x4208
// Size: 0x5c
function skipto_air_traffic_controller_complete( name, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        exploder::exploder( "fx_exploder_disable_fx_start" );
    }
    
    skipto_message( "objective_air_traffic_controller_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x59866b35, Offset: 0x4270
// Size: 0x104
function skipto_nrc_knocking_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        lui::prime_movie( "cp_prologue_env_post_crash" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        load::function_a2995f22();
        level thread scene::skipto_end( "cin_pro_01_02_airtraffic_1st_hack_aftermath", undefined, undefined, 0.7, 1 );
        videostart( "cp_prologue_env_post_crash", 1 );
    }
    
    objectives::set( "cp_level_prologue_locate_the_security_room" );
    skipto_message( "objective_nrc_knocking_init" );
    cp_prologue_enter_base::nrc_knocking_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0xf22d43f9, Offset: 0x4380
// Size: 0x13c
function skipto_nrc_knocking_complete( name, b_starting, b_direct, player )
{
    skipto_message( "objective_nrc_knocking_done" );
    
    if ( level.skipto_point == "skipto_blend_in" || !b_starting || level.skipto_point == "skipto_take_out_guards" )
    {
        level thread scene::play( "p7_fxanim_cp_prologue_vtol_searchlight_bundle" );
    }
    
    callback::on_spawned( &function_4d4f1d4f );
    level.var_83405e54 = 1;
    struct::delete_script_bundle( "scene", "cin_pro_01_02_airtraffic_1st_hack_ai" );
    struct::delete_script_bundle( "scene", "cin_pro_01_02_airtraffic_1st_hack" );
    struct::delete_script_bundle( "scene", "cin_pro_01_02_airtraffic_1st_hack_aftermath_ai" );
    struct::delete_script_bundle( "scene", "cin_pro_01_02_airtraffic_1st_hack_aftermath" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x5e72ff76, Offset: 0x44c8
// Size: 0x1d4
function skipto_blend_in_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::set( "cp_level_prologue_locate_the_security_room" );
        init_hendricks( "skipto_blend_in_hendricks" );
        level.ai_hendricks.pacifist = 1;
        level.ai_hendricks.ignoreme = 1;
        level scene::skipto_end( "landing_gear_anim", "targetname" );
        level scene::skipto_end( "plane_tail_explosion", "targetname" );
        level scene::skipto_end( "plane_cockpit_explosion", "targetname" );
        load::function_a2995f22();
        exploder::exploder( "fx_exploder_plane_exp" );
        array::run_all( level.players, &util::set_low_ready, 1 );
        array::thread_all( level.players, &function_7072c5d8 );
        level thread cp_prologue_enter_base::function_6bad1a34();
    }
    
    videostop( "cp_prologue_env_post_crash" );
    skipto_message( "objective_blend_in_init" );
    cp_prologue_enter_base::blend_in_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0xa01bffd1, Offset: 0x46a8
// Size: 0xba
function skipto_blend_in_complete( name, b_starting, b_direct, player )
{
    if ( !b_starting || level.skipto_point == "skipto_take_out_guards" || level.skipto_point == "skipto_security_camera" )
    {
        level thread scene::init( "cin_pro_05_01_securitycam_1st_stealth_kill" );
        level thread scene::init( "cin_pro_05_01_securitycam_1st_stealth_kill_movetodoor" );
    }
    
    skipto_message( "objective_blend_in_done" );
    level notify( #"objective_blend_in_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x2a9db1e0, Offset: 0x4770
// Size: 0x1f4
function skipto_take_out_guards_init( str_objective, b_starting )
{
    skipto_message( "objective_take_out_guards_init" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::set( "cp_level_prologue_locate_the_security_room" );
        level thread objectives::breadcrumb( "blending_in_breadcrumb_3" );
        level flag::set( "hendr_crossed_tarmac" );
        
        if ( !isdefined( level.ai_hendricks ) )
        {
            level.ai_hendricks = util::get_hero( "hendricks" );
            init_hendricks( "skipto_take_out_guards_hendricks" );
        }
        
        level scene::skipto_end( "landing_gear_anim", "targetname" );
        level scene::skipto_end( "plane_tail_explosion", "targetname" );
        level scene::skipto_end( "plane_cockpit_explosion", "targetname" );
        level scene::skipto_end_noai( "cin_pro_03_02_blendin_vign_tarmac_cross" );
        level thread scene::play( "cin_pro_03_02_blendin_vign_attendfire" );
        level thread scene::play( "p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle" );
        scene::init( "cin_pro_03_02_blendin_vign_tarmac_cross_end_idle" );
        load::function_a2995f22();
    }
    
    cp_prologue_enter_base::take_out_guards_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x2179e19c, Offset: 0x4970
// Size: 0x154
function skipto_take_out_guards_complete( name, b_starting, b_direct, player )
{
    skipto_message( "objective_take_out_guards_done" );
    level notify( #"objective_take_out_guards_done" );
    
    if ( b_starting )
    {
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_prologue_control_tower_tarmac_turbine_bundle" );
        level struct::delete_script_bundle( "scene", "cin_pro_03_02_blendin_vign_destruction_injured" );
        level struct::delete_script_bundle( "scene", "cin_pro_03_02_blendin_vign_attendfire" );
        level struct::delete_script_bundle( "scene", "cin_pro_03_02_blendin_vign_destruction_help" );
        level struct::delete_script_bundle( "scene", "cin_pro_03_02_blendin_vign_destruction_putoutfire" );
    }
    
    level scene::init( "cin_pro_06_03_hostage_1st_khalil_intro_door" );
    level scene::stop( "p7_fxanim_cp_prologue_vtol_searchlight_bundle" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xd42bdae7, Offset: 0x4ad0
// Size: 0x1d4
function skipto_security_camera_init( str_objective, b_starting )
{
    skipto_message( "objective_security_camera_init" );
    
    if ( !isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        init_hendricks();
        skipto::teleport_ai( str_objective );
    }
    
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::complete( "cp_level_prologue_locate_the_security_room" );
        objectives::set( "cp_level_prologue_locate_the_minister" );
        level flag::set( "stealth_kill_prepare_done" );
        level thread scene::skipto_end( "cin_pro_04_01_takeout_vign_truck_prisoners", undefined, undefined, 0.4 );
        level thread scene::skipto_end( "cin_pro_04_02_takeout_vign_truck_unload", undefined, undefined, 0.4 );
        level thread scene::skipto_end( "forkilft_anim", undefined, undefined, 0.5 );
        level thread scene::add_scene_func( "cin_pro_05_01_securitycam_1st_stealth_kill_prepare", &security_camera::function_d6557dc4 );
        level thread scene::play( "cin_pro_05_01_securitycam_1st_stealth_kill_prepare" );
        load::function_a2995f22();
    }
    
    security_camera::security_camera_start( str_objective );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x9f4760c4, Offset: 0x4cb0
// Size: 0x124
function skipto_security_camera_complete( name, b_starting, b_direct, player )
{
    callback::remove_on_spawned( &function_4d4f1d4f );
    array::run_all( level.players, &util::set_low_ready, 0 );
    level notify( #"hash_e1626ff0" );
    scene::add_scene_func( "cin_pro_06_03_hostage_vign_breach_playerbreach", &prison::function_f8d7f50a, "init" );
    scene::init( "cin_pro_06_03_hostage_vign_breach_playerbreach" );
    var_f33f812b = getent( "fuel_truck_faxnim_clip", "targetname" );
    var_f33f812b notsolid();
    level.var_83405e54 = undefined;
    skipto_message( "objective_security_camera_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x63764b93, Offset: 0x4de0
// Size: 0x114
function skipto_hostage_1_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        level flag::set( "hendricks_exit_cam_room" );
        level thread namespace_21b2c1f2::function_baefe66d();
        level thread scene::skipto_end_noai( "cin_pro_05_01_securitycam_1st_stealth_kill" );
        load::function_a2995f22();
    }
    
    skipto_message( "objective_hostage_1_init" );
    level thread objectives::breadcrumb( "rescue_breadcrumb_1" );
    hostage_1::hostage_1_start( str_objective );
    level thread scene::init( "cin_pro_06_03_hostage_vign_breach_hendrickscover" );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x4985dd6e, Offset: 0x4f00
// Size: 0xca
function skipto_hostage_1_complete( name, b_restarting, b_direct, player )
{
    if ( scene::is_active( "cin_pro_05_01_securitycam_1st_stealth_kill" ) )
    {
        level thread scene::stop( "cin_pro_05_01_securitycam_1st_stealth_kill" );
    }
    
    trig_weapon_room_door = getent( "trig_open_weapons_room", "targetname" );
    trig_weapon_room_door triggerenable( 0 );
    skipto_message( "hostage_1_done" );
    level notify( #"hostage_1_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xca6ac9ec, Offset: 0x4fd8
// Size: 0xb4
function skipto_prison_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level scene::init( "cin_pro_06_03_hostage_vign_breach_hendrickscover" );
        cp_prologue_util::function_34acbf2();
        level thread namespace_21b2c1f2::function_d4c52995();
        load::function_a2995f22();
    }
    
    skipto_message( "objective_prison_init" );
    prison::prison_start( str_objective );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x343b0cd, Offset: 0x5098
// Size: 0xca
function skipto_prison_complete( name, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        exploder::exploder( "light_exploder_prison_exit" );
    }
    
    level thread scene::skipto_end_noai( "cin_pro_06_03_hostage_vign_breach_playerbreach" );
    level thread scene::skipto_end_noai( "cin_pro_04_01_takeout_vign_truck_prisoners" );
    level scene::init( "p7_fxanim_cp_prologue_ceiling_underground_crane_bundle" );
    skipto_message( "prison" );
    level notify( #"prison" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x984838e7, Offset: 0x5170
// Size: 0x204
function skipto_security_desk_init( str_objective, b_starting )
{
    security_desk::function_bfe70f02();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level thread objectives::breadcrumb( "post_prison_breadcrumb_start" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        init_hendricks( "skipto_security_desk_hendricks" );
        level.ai_minister = util::get_hero( "minister" );
        init_minister( "skipto_security_desk_minister" );
        level.ai_minister ai::set_ignoreme( 1 );
        level.ai_khalil = util::get_hero( "khalil" );
        init_khalil( "skipto_security_desk_khalil" );
        level.ai_khalil ai::set_ignoreme( 1 );
        level scene::skipto_end( "cin_pro_06_03_hostage_1st_khalil_intro_rescue" );
        load::function_a2995f22();
    }
    
    scene::init( "cin_pro_07_01_securitydesk_vign_weapons" );
    skipto_message( "objective_security_desk_init" );
    security_desk::security_desk_start( str_objective );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x4c48301f, Offset: 0x5380
// Size: 0x5c
function skipto_security_desk_complete( name, b_starting, b_direct, player )
{
    level thread scene::init( "cin_pro_10_01_hanger_vign_sensory_overload_start" );
    skipto_message( "security_desk_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xde9f5bd8, Offset: 0x53e8
// Size: 0xec
function skipto_lift_escape_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level thread namespace_21b2c1f2::function_6c35b4f3();
        level thread objectives::breadcrumb( "post_prison_breadcrumb_1" );
        load::function_a2995f22();
    }
    
    skipto_message( "objective_lift_escape_init" );
    lift_escape::lift_escape_start( str_objective );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0xbfd4469b, Offset: 0x54e0
// Size: 0x224
function skipto_lift_escape_complete( name, b_starting, b_direct, player )
{
    scene::stop( "cin_pro_06_03_hostage_vign_breach_playerbreach", 1 );
    scene::stop( "cin_pro_06_03_hostage_vign_breach_hendrickscover", 1 );
    scene::stop( "cin_pro_06_03_hostage_vign_breach" );
    scene::stop( "cin_pro_05_02_securitycam_pip_pipe", 1 );
    scene::stop( "cin_pro_05_02_securitycam_pip_waterboard", 1 );
    scene::stop( "cin_pro_05_02_securitycam_pip_branding", 1 );
    scene::stop( "p7_fxanim_cp_prologue_ceiling_underground_crane_bundle", 1 );
    var_2e1f1409 = getent( "hangar_gate_02", "targetname" );
    var_2e1f1409 ghost();
    var_2e1f1409 = getent( "hangar_gate_03", "targetname" );
    var_2e1f1409 ghost();
    var_2e1f1409 = getent( "hangar_gate_04", "targetname" );
    var_2e1f1409 ghost();
    umbragate_set( "umbra_gate_hangar_02", 1 );
    umbragate_set( "umbra_gate_hangar_03", 1 );
    umbragate_set( "umbra_gate_hangar_04", 1 );
    skipto_message( "lift_escape_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x5e99002e, Offset: 0x5710
// Size: 0x1fc
function skipto_intro_cyber_soldiers_init( str_objective, b_starting )
{
    skipto_message( "objective_intro_cyber_soldiers_init" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_khalil = util::get_hero( "khalil" );
        skipto::teleport_ai( str_objective, level.heroes );
        lift_escape::function_d4734ff1();
        level.e_lift = getent( "freight_lift", "targetname" );
        
        if ( !isdefined( level.var_3dce3f88 ) )
        {
            level.var_3dce3f88 = spawn( "script_model", level.e_lift.origin );
            level.e_lift linkto( level.var_3dce3f88 );
        }
        
        load::function_a2995f22();
        intro_cyber_soldiers::function_f9753551();
        level thread lift_escape::function_a3dbf6a2();
        level waittill( #"hash_b100689e" );
    }
    
    intro_cyber_soldiers::intro_cyber_soldiers_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x6d9e2a24, Offset: 0x5918
// Size: 0x174
function skipto_intro_cyber_soldiers_complete( name, b_starting, b_direct, player )
{
    level thread scene::init( "p7_fxanim_cp_prologue_hangar_window_rip_bundle" );
    level thread scene::init( "p7_fxanim_cp_prologue_vtol_hangar_bundle" );
    level clientfield::set( "diaz_break_1", 1 );
    level clientfield::set( "diaz_break_2", 1 );
    scene::init( "bridge_tent_01", "targetname" );
    scene::init( "bridge_tent_02", "targetname" );
    scene::init( "bridge_tent_03", "targetname" );
    level thread scene::skipto_end( "p7_fxanim_cp_prologue_hangar_doors_02_bundle" );
    level thread hangar::function_ce858cd3( 0 );
    callback::on_actor_killed( &hangar::function_d3c9b1d1 );
    skipto_message( "intro_cyber_soldiers_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xd651ef09, Offset: 0x5a98
// Size: 0x294
function skipto_hangar_init( str_objective, b_starting )
{
    level.ai_theia = util::get_hero( "theia" );
    level.ai_prometheus = util::get_hero( "prometheus" );
    level.ai_hyperion = util::get_hero( "hyperion" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_theia thread intro_cyber_soldiers::actor_camo( 1, 0 );
        level.ai_prometheus thread intro_cyber_soldiers::actor_camo( 1, 0 );
        level.ai_hyperion thread intro_cyber_soldiers::actor_camo( 1, 0 );
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_pallas = util::get_hero( "pallas" );
        skipto::teleport_ai( str_objective, level.heroes );
        level.e_lift = getent( "freight_lift", "targetname" );
        level.e_lift movez( 100, 0.05 );
        load::function_a2995f22();
    }
    
    level thread objectives::breadcrumb( "hangar_breadcrumb_start" );
    level thread namespace_21b2c1f2::function_46333a8a();
    skipto_message( "objective_hangar_init" );
    hangar::hangar_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x92718687, Offset: 0x5d38
// Size: 0x7c
function skipto_hangar_complete( name, b_starting, b_direct, player )
{
    level thread scene::skipto_end( "p7_fxanim_cp_prologue_hangar_doors_03_bundle" );
    callback::remove_on_actor_killed( &hangar::function_d3c9b1d1 );
    skipto_message( "hangar_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xb6b653d0, Offset: 0x5dc0
// Size: 0x294
function skipto_vtol_collapse_init( str_objective, b_starting )
{
    level.ai_prometheus = util::get_hero( "prometheus" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_pallas = util::get_hero( "pallas" );
        level thread scene::skipto_end( "cin_pro_10_04_hangar_vign_leap_new_wing2window" );
        level flag::set( "pallas_at_window" );
        level.var_fac57550 = vehicle::simple_spawn_single( "vtol_collapse_apc_initial" );
        wait 0.15;
        level.ai_hendricks thread hangar::function_d418516( level.var_fac57550 );
        level.ai_khalil thread hangar::function_d418516( level.var_fac57550 );
        trigger::use( "hangar_end_move_allies", "targetname", undefined, 0 );
        level hangar::function_10ab649();
        level clientfield::set( "diaz_break_1", 2 );
        skipto::teleport_ai( str_objective, level.heroes );
        load::function_a2995f22();
    }
    
    level thread objectives::breadcrumb( "hangar_breadcrumb_4" );
    skipto_message( "objective_vtol_collapse_init" );
    hangar::vtol_collapse_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x29048c6e, Offset: 0x6060
// Size: 0x1ec
function skipto_vtol_collapse_complete( name, b_starting, b_direct, player )
{
    var_280d5f68 = getent( "hangar_gate_l", "targetname" );
    var_3c301126 = getent( "hangar_gate_r", "targetname" );
    var_9c7511b4 = struct::get( "hangar_gate_move_pos_l", "targetname" );
    var_205c499a = struct::get( "hangar_gate_move_pos_r", "targetname" );
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_door_bundle";
    level hangar::hangar_gate_close( 1, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9 );
    exploder::exploder( "light_exploder_darkbattle" );
    exploder::exploder( "light_exploder_defend_radio_tower" );
    umbragate_set( "umbra_gate_hangar_02", 0 );
    umbragate_set( "umbra_gate_hangar_03", 0 );
    umbragate_set( "umbra_gate_hangar_04", 0 );
    
    if ( name == "skipto_jeep_alley" && b_starting )
    {
        jeep_alley::function_fcc9ed10();
    }
    
    level notify( #"hash_73facd66" );
    skipto_message( "vtol_collapse_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x7f995c44, Offset: 0x6258
// Size: 0x384
function skipto_jeep_alley_init( str_objective, b_starting )
{
    level.ai_theia = util::get_hero( "theia" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        level thread scene::skipto_end( "p7_fxanim_cp_prologue_vtol_hangar_bundle" );
        e_vtol = getent( "vtol_hangar_drop", "targetname" );
        e_vtol thread cp_prologue_util::function_d723979e( "swap_vtol_to_destroyed", "veh_t7_mil_vtol_nrc_no_interior_d", "vtol_collapse_done" );
        level notify( #"vtol_collapse_done" );
        level util::delay( 0.5, undefined, &hangar::function_ce858cd3, 1 );
        var_ac769486 = getent( "clip_player_vtol_collapse_backtrack_doorway", "targetname" );
        var_ac769486 movez( 100 * -1, 0.05 );
        mdl_door_left = getent( "vtol_hangar_in_l", "targetname" );
        mdl_door_right = getent( "vtol_hangar_in_r", "targetname" );
        vec_right = anglestoright( mdl_door_left.angles );
        mdl_door_left moveto( mdl_door_left.origin - vec_right * 50, 0.5 );
        mdl_door_right moveto( mdl_door_right.origin + vec_right * 44, 0.5 );
        objectives::set( "cp_level_prologue_get_to_the_surface" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective, level.heroes );
        load::function_a2995f22();
    }
    
    level thread scene::play( "p7_fxanim_cp_prologue_plane_hanger_pristine_bundle" );
    skipto_message( "objective_jeep_alley_init" );
    jeep_alley::jeep_alley_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0xc7723de3, Offset: 0x65e8
// Size: 0x3c
function skipto_jeep_alley_complete( name, b_starting, b_direct, player )
{
    skipto_message( "jeep_alley_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0xba694fc8, Offset: 0x6630
// Size: 0x2e4
function skipto_bridge_battle_init( str_objective, b_starting )
{
    level.ai_hyperion = util::get_hero( "hyperion" );
    level.ai_theia = util::get_hero( "theia" );
    var_61b253a2 = getweapon( "sniper_fastbolt_hero", "extclip", "fastreload" );
    level.ai_hyperion shared::stowweapon( var_61b253a2, ( -8, 4, 14 ), ( 90, 0, 0 ) );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        level.ai_theia = util::get_hero( "theia" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective, level.heroes );
        level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_attack", &jeep_alley::function_cf946de6 );
        level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_attack", &jeep_alley::function_7af067f4, "done" );
        level thread scene::skipto_end( "cin_pro_11_01_jeepalley_vign_engage_attack", undefined, undefined, 0.8 );
        scene::play( "p7_fxanim_cp_prologue_plane_hanger_explode_bundle" );
        level.bridge_marker = struct::get( "bridge_obj", "targetname" );
        objectives::set( "cp_waypoint_breadcrumb", level.bridge_marker );
        load::function_a2995f22();
        trigger::use( "jeep_alley_allies_move", "targetname" );
    }
    
    skipto_message( "objective_bridge_battle_init" );
    bridge_battle::bridge_battle_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x46861e43, Offset: 0x6920
// Size: 0x24c
function skipto_bridge_battle_complete( name, b_starting, b_direct, player )
{
    scene::skipto_end( "bridge_tent_01", "targetname" );
    scene::skipto_end( "bridge_tent_02", "targetname" );
    scene::skipto_end( "bridge_tent_03", "targetname" );
    scene::skipto_end( "p7_fxanim_cp_prologue_plane_hanger_explode_bundle" );
    var_59ff07ee = getent( "bridge_section_1", "targetname" );
    
    if ( isdefined( var_59ff07ee ) )
    {
        var_59ff07ee delete();
        var_33fc8d85 = getent( "bridge_section_2", "targetname" );
        var_33fc8d85 delete();
        var_dfa131c = getent( "bridge_section_3", "targetname" );
        var_dfa131c delete();
        var_e7f798b3 = getentarray( "bridge_section_4", "targetname" );
        array::run_all( var_e7f798b3, &delete );
    }
    
    e_bridge = getent( "prologue_bridge", "targetname" );
    
    if ( isdefined( e_bridge ) )
    {
        e_bridge delete();
    }
    
    showmiscmodels( "fxanim_bridge_static2" );
    level notify( #"bridge_battle_done" );
    skipto_message( "bridge_battle_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x16773e3e, Offset: 0x6b78
// Size: 0x1e4
function skipto_dark_battle_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        level.ai_hyperion = util::get_hero( "hyperion" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        var_61b253a2 = getweapon( "sniper_fastbolt_hero", "extclip", "fastreload" );
        level.ai_hyperion shared::stowweapon( var_61b253a2, ( -8, 4, 14 ), ( 90, 0, 0 ) );
        level thread scene::skipto_end( "cin_pro_11_01_jeepalley_vign_engage_attack", undefined, undefined, 0.98 );
        load::function_a2995f22();
        exploder::exploder( "light_exploder_darkbattle" );
        skipto::teleport_ai( str_objective, level.heroes );
    }
    
    skipto_message( "objective_dark_battle_init" );
    dark_battle::dark_battle_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x34207338, Offset: 0x6d68
// Size: 0x424
function skipto_dark_battle_complete( name, b_starting, b_direct, player )
{
    level thread scene::init( "cin_pro_15_01_opendoor_vign_getinside_new_prometheus_doorhold" );
    skipto_message( "dark_battle_done" );
    
    if ( scene::is_playing( "cin_pro_11_01_jeepalley_vign_engage_attack" ) )
    {
        level thread scene::stop( "cin_pro_11_01_jeepalley_vign_engage_attack" );
    }
    
    var_59ff07ee = getent( "bridge_section_1", "targetname" );
    
    if ( isdefined( var_59ff07ee ) )
    {
        var_59ff07ee delete();
    }
    
    var_33fc8d85 = getent( "bridge_section_2", "targetname" );
    
    if ( isdefined( var_33fc8d85 ) )
    {
        var_33fc8d85 delete();
    }
    
    var_dfa131c = getent( "bridge_section_3", "targetname" );
    
    if ( isdefined( var_dfa131c ) )
    {
        var_dfa131c delete();
    }
    
    a_mdl_bridge = getentarray( "bridge_section_4", "targetname" );
    
    foreach ( var_8f9551fe in a_mdl_bridge )
    {
        var_8f9551fe delete();
    }
    
    exploder::stop_exploder( "light_exploder_darkbattle" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        array::thread_all( level.players, &oed::set_player_ev, 0 );
    }
    
    level thread apc::function_81a9e31c();
    e_collision = getent( "hangar_vtol_crash_clip", "targetname" );
    e_collision connectpaths();
    e_collision delete();
    wait 0.05;
    e_door = getent( "hall_door_slide_right", "targetname" );
    e_door connectpaths();
    e_door delete();
    wait 0.05;
    e_door = getent( "hall_door_slide_left", "targetname" );
    e_door connectpaths();
    e_door delete();
    trigger::use( "t_motorpool_spawns_disable", "targetname" );
    t_robot_horde_oob = getent( "t_robot_horde_oob", "targetname" );
    
    if ( isdefined( t_robot_horde_oob ) )
    {
        t_robot_horde_oob triggerenable( 0 );
    }
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x8cd1dfbb, Offset: 0x7198
// Size: 0x324
function skipto_vtol_tackle_init( str_objective, b_starting )
{
    level.ai_prometheus = util::get_hero( "prometheus" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::complete( "cp_level_prologue_escort_data_center" );
        objectives::set( "cp_level_prologue_find_vehicle" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hyperion = util::get_hero( "hyperion" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        var_61b253a2 = getweapon( "sniper_fastbolt_hero", "extclip", "fastreload" );
        level.ai_hyperion shared::stowweapon( var_61b253a2, ( -8, 4, 14 ), ( 90, 0, 0 ) );
        level thread dark_battle::vtol_guards_handler();
        level scene::init( "p7_fxanim_cp_prologue_vtol_tackle_windows_bundle" );
        load::function_a2995f22();
        array::thread_all( level.players, &clientfield::set_to_player, "turn_off_tacmode_vfx", 1 );
        array::thread_all( level.players, &oed::set_player_ev, 0 );
        array::thread_all( level.players, &oed::tmode_activate_on_player, 0 );
        spawner::add_spawn_function_group( "initial_vtol_guys", "targetname", &cp_prologue_util::ai_idle_then_alert, "vtol_has_crashed" );
        spawn_manager::enable( "vtol_tackle_spwn_mgr2" );
        skipto::teleport_ai( str_objective, level.heroes );
    }
    
    level thread namespace_21b2c1f2::function_63ffe714();
    skipto_message( "objective_vtol_tackle_init" );
    vtol_tackle::vtol_tackle_main( b_starting );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x52963da3, Offset: 0x74c8
// Size: 0xb4
function skipto_vtol_tackle_complete( name, b_starting, b_direct, player )
{
    s_door = level.scriptbundles[ "scene" ][ "cin_pro_15_01_opendoor_vign_getinside_new_hendricks_and_prometheus" ].objects[ 2 ];
    s_door.firstframe = 1;
    s_door.spawnoninit = 1;
    level scene::init( "cin_pro_15_01_opendoor_vign_getinside_new_hendricks_and_prometheus" );
    skipto_message( "vtol_tackle_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x22fee1c8, Offset: 0x7588
// Size: 0x204
function skipto_robot_horde_init( str_objective, b_starting )
{
    level.ai_pallas = util::get_hero( "pallas" );
    level.ai_theia = util::get_hero( "theia" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_prologue_util::function_34acbf2();
        cp_prologue_util::function_df278013();
        cp_prologue_util::function_9d35b20d();
        objectives::complete( "cp_level_prologue_escort_data_center" );
        objectives::set( "cp_level_prologue_find_vehicle" );
        level.ai_theia = util::get_hero( "theia" );
        level.ai_hyperion = util::get_hero( "hyperion" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_prometheus = util::get_hero( "prometheus" );
        skipto::teleport_ai( str_objective, level.heroes );
        level cp_prologue_util::spawn_coop_player_replacement( "skipto_robot_horde_ai" );
        load::function_a2995f22();
    }
    
    skipto_message( "objective_robot_horde_init" );
    robot_horde::robot_horde_start();
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x95fb6890, Offset: 0x7798
// Size: 0x3c
function skipto_robot_horde_complete( name, b_starting, b_direct, player )
{
    skipto_message( "robot_horde_done" );
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x956e725f, Offset: 0x77e0
// Size: 0x33c
function skipto_robot_defend_init( str_objective, b_starting )
{
    skipto_message( "objective_robot_defend_init" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread cp_prologue_util::function_cfabe921();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_minister = util::get_hero( "minister" );
        level.ai_khalil = util::get_hero( "khalil" );
        level.apc = vehicle::simple_spawn_single( "apc" );
        level.apc vehicle::lights_off();
        level thread scene::skipto_end( "cin_pro_17_01_robotdefend_vign_apc_exit_apc" );
        load::function_a2995f22();
        level cp_prologue_util::spawn_coop_player_replacement( "skipto_robot_defend" );
        level flag::set( "apc_done" );
        m_tunnel_vtol_death = getent( "m_tunnel_vtol_death", "targetname" );
        m_tunnel_vtol_death show();
        exploder::exploder( "fx_exploder_vtol_crash_rail" );
        level flag::set( "apc_unlocked" );
        level thread apc::function_599ebca1();
    }
    else
    {
        level.apc turret::disable( 1 );
        level.apc turret::disable( 2 );
        level.apc turret::disable( 3 );
        level.apc turret::disable( 4 );
    }
    
    level thread function_b5502f69();
    playfxontag( level._effect[ "apc_death_fx_cin" ], level.apc, "tag_origin_animate" );
    exploder::exploder( "light_exploder_headlight_flicker_02" );
    init_khalil( "skipto_robot_defend_khalil" );
    init_minister( "skipto_robot_defend_minister" );
    init_hendricks( "skipto_robot_defend_hendricks" );
    robot_defend::robot_defend_main( b_starting );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x7119bfea, Offset: 0x7b28
// Size: 0x160
function function_b5502f69()
{
    var_9b399cbb = array( "p7_fxanim_cp_prologue_bridge_tent_bundle", "p7_fxanim_cp_prologue_bridge_bundle", "cin_pro_12_01_darkbattle_vign_dive_kill_start" );
    
    foreach ( str_bundlename in var_9b399cbb )
    {
        var_9cc495a4 = struct::get_array( str_bundlename, "targetname" );
        
        foreach ( bundle in var_9cc495a4 )
        {
            if ( isdefined( bundle ) )
            {
                bundle delete();
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0x3361883, Offset: 0x7c90
// Size: 0x4a
function skipto_robot_defend_complete( name, b_starting, b_direct, player )
{
    skipto_message( "robot_defend_done" );
    level notify( #"robot_defend_done" );
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x30762fa6, Offset: 0x7ce8
// Size: 0x34
function skipto_message( msg )
{
    println( "<dev string:x28>" + msg );
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x697dde4d, Offset: 0x7d28
// Size: 0xdc
function init_hendricks( str_teleport_struct_targetname )
{
    level.ai_hendricks = util::get_hero( "hendricks" );
    primary_weapon = getweapon( "ar_standard" );
    level.ai_hendricks ai::gun_switchto( primary_weapon, "right" );
    
    if ( isdefined( str_teleport_struct_targetname ) )
    {
        s_struct = struct::get( str_teleport_struct_targetname, "targetname" );
        level.ai_hendricks forceteleport( s_struct.origin, s_struct.angles );
    }
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x5c578839, Offset: 0x7e10
// Size: 0xd8
function init_minister( str_teleport_struct_targetname )
{
    level.ai_minister = util::get_hero( "minister" );
    
    if ( isdefined( str_teleport_struct_targetname ) )
    {
        s_struct = struct::get( str_teleport_struct_targetname, "targetname" );
        level.ai_minister forceteleport( s_struct.origin, s_struct.angles );
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level.ai_minister.script_friendname = "Bishop";
        level.ai_minister.propername = "Bishop";
    }
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0xcf9158b1, Offset: 0x7ef0
// Size: 0x94
function init_khalil( str_teleport_struct_targetname )
{
    level.ai_khalil = util::get_hero( "khalil" );
    
    if ( isdefined( str_teleport_struct_targetname ) )
    {
        s_struct = struct::get( str_teleport_struct_targetname, "targetname" );
        level.ai_khalil forceteleport( s_struct.origin, s_struct.angles );
    }
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x4b4e6356, Offset: 0x7f90
// Size: 0x8e
function deletegroupaddspawners( str_spawner_name )
{
    a_spawners = getentarray( str_spawner_name, "targetname" );
    
    for ( i = 0; i < a_spawners.size ; i++ )
    {
        a_spawners[ i ] spawner::add_spawn_function( &assign_kill_group, str_spawner_name );
    }
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x666b28ec, Offset: 0x8028
// Size: 0x18
function deletegroupadd( str_group )
{
    self.delete_group = str_group;
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0xdf69f56f, Offset: 0x8048
// Size: 0xde
function deletegroupdelete( str_group )
{
    a_ai = getaiarray();
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            e_ent = a_ai[ i ];
            
            if ( isalive( e_ent ) && isdefined( e_ent.delete_group ) && e_ent.delete_group == str_group )
            {
                e_ent.delete_group = undefined;
                e_ent delete();
            }
        }
    }
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0xb2d10b6c, Offset: 0x8130
// Size: 0x24
function assign_kill_group( str_group )
{
    deletegroupadd( str_group );
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0xb2a9f391, Offset: 0x8160
// Size: 0x44
function function_4d4f1d4f()
{
    level notify( #"hash_25ea191a" );
    self util::set_low_ready( 1 );
    self thread function_7072c5d8();
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0xb1122567, Offset: 0x81b0
// Size: 0x68
function function_7072c5d8()
{
    level endon( #"hash_e1626ff0" );
    self notify( #"hash_beba65a6" );
    self endon( #"hash_beba65a6" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"player_revived" );
        self util::set_low_ready( 1 );
    }
}

