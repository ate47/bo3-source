#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_comm_relay;
#using scripts/cp/cp_mi_sing_blackstation_cross_debris;
#using scripts/cp/cp_mi_sing_blackstation_fx;
#using scripts/cp/cp_mi_sing_blackstation_patch;
#using scripts/cp/cp_mi_sing_blackstation_police_station;
#using scripts/cp/cp_mi_sing_blackstation_port;
#using scripts/cp/cp_mi_sing_blackstation_qzone;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_station;
#using scripts/cp/cp_mi_sing_blackstation_subway;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/gametypes/_save;
#using scripts/cp/voice/voice_blackstation;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_blackstation;

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x4f659a39, Offset: 0x1398
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xa115ddc3, Offset: 0x13d8
// Size: 0x31c
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 19 );
    }
    
    precache();
    register_clientfields();
    flag_init();
    level_init();
    weather_setup();
    function_aca49f84();
    blackstation_accolades::function_4d39a2af();
    cp_mi_sing_blackstation_fx::main();
    cp_mi_sing_blackstation_sound::main();
    cp_mi_sing_blackstation_qzone::main();
    cp_mi_sing_blackstation_port::main();
    voice_blackstation::init_voice();
    setup_skiptos();
    util::init_streamer_hints( 5 );
    scene::add_wait_for_streamer_hint_scene( "cin_bla_03_warlordintro_3rd_sh010" );
    scene::add_wait_for_streamer_hint_scene( "cin_bla_10_01_kaneintro_3rd_sh010" );
    savegame::set_mission_name( "blackstation" );
    callback::on_spawned( &on_player_spawned );
    callback::on_loadout( &on_player_loadout );
    level.var_1895e0f9 = &blackstation_utility::function_8f7c9f3c;
    load::main();
    cp_mi_sing_blackstation_patch::function_7403e82b();
    setdvar( "ui_newHud", 1 );
    level thread blackstation_utility::function_33942907();
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh170", &blackstation_utility::coop_teleport_on_igc_end, "done", "objective_warlord" );
    level scene::add_scene_func( "cin_bla_10_01_kaneintro_3rd_sh190", &blackstation_utility::coop_teleport_on_igc_end, "done", "objective_comm_relay_traverse" );
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_landing", &blackstation_utility::coop_teleport_on_igc_end, "done", "objective_subway" );
    level thread function_f92d2f1c();
    level thread function_2acd20f4();
    level thread function_b3f6e2cd();
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x9b27784c, Offset: 0x1700
// Size: 0x15a
function function_aca49f84()
{
    var_e260543c = [];
    var_e260543c[ 0 ] = util::spawn_model( "collision_clip_64x64x64", ( -1674, 10107, 65 ), ( 0, 350, 0 ) );
    var_e260543c[ 1 ] = util::spawn_model( "collision_clip_64x64x64", ( -1702, 9950, 65 ), ( 0, 350, 0 ) );
    var_e260543c[ 2 ] = util::spawn_model( "collision_clip_64x64x64", ( -1728, 9806, 65 ), ( 0, 350, 0 ) );
    
    foreach ( mdl_clip in var_e260543c )
    {
        mdl_clip ghost();
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xa90a47a4, Offset: 0x1868
// Size: 0x1b4
function function_b3f6e2cd()
{
    getent( "com_rugged_glitch_1", "targetname" ) hide();
    getent( "com_rugged_glitch_2", "targetname" ) hide();
    getent( "com_rugged_off", "targetname" ) hide();
    getent( "com_curve_glitch_1", "targetname" ) hide();
    getent( "com_curve_glitch_2", "targetname" ) hide();
    getent( "com_curve_off", "targetname" ) hide();
    getent( "barge_monitor_glitch_1", "targetname" ) hide();
    getent( "barge_monitor_glitch_2", "targetname" ) hide();
    getent( "barge_monitor_off", "targetname" ) hide();
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xe71a1984, Offset: 0x1a28
// Size: 0x4c
function function_2acd20f4()
{
    hidemiscmodels( "lt_wharf_water" );
    hidemiscmodels( "vista_water" );
    hidemiscmodels( "collapse_frogger_water" );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xbb016e46, Offset: 0x1a80
// Size: 0xd2
function function_f92d2f1c()
{
    a_e_triggers = getentarray( "trigger_hurt", "classname" );
    
    foreach ( e_trigger in a_e_triggers )
    {
        if ( e_trigger.script_hazard === "o2" )
        {
            e_trigger util::self_delete();
        }
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x248f3770, Offset: 0x1b60
// Size: 0xc6
function precache()
{
    level._effect[ "blood_headpop" ] = "blood/fx_blood_ai_head_explosion";
    level._effect[ "lightning_strike" ] = "weather/fx_lightning_strike_bolt_single_blackstation";
    level._effect[ "disabled_robot" ] = "destruct/fx_dest_robot_head_sparks";
    level._effect[ "worklight" ] = "light/fx_spot_low_factory_zmb";
    level._effect[ "worklight_rays" ] = "light/fx_light_ray_work_light";
    level._effect[ "wave_pier" ] = "water/fx_water_splash_xlg";
    level._effect[ "bubbles" ] = "player/fx_plyr_swim_bubbles_body_blkstn";
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x4f048411, Offset: 0x1c30
// Size: 0xa44
function flag_init()
{
    level flag::init( "obj_goto_docks" );
    level flag::init( "allow_wind_gust" );
    level flag::init( "end_gust_warning" );
    level flag::init( "kill_weather" );
    level flag::init( "kill_surge" );
    level flag::init( "end_surge" );
    level flag::init( "kill_wave" );
    level flag::init( "surging_inward" );
    level flag::init( "vtol_jump" );
    level flag::init( "executed_bodies" );
    level flag::init( "warlord_approach" );
    level flag::init( "hendricks_debris_traversal_ready" );
    level flag::init( "warlord_intro_prep" );
    level flag::init( "warlord_fight" );
    level flag::init( "warlord_backup" );
    level flag::init( "warlord_reinforce" );
    level flag::init( "warlord_retreat" );
    level flag::init( "warlord_fight_done" );
    level flag::init( "qzone_done" );
    level flag::init( "warning_vo_played" );
    level flag::init( "wind_gust" );
    level flag::init( "drone_strike" );
    level flag::init( "surge_active" );
    level flag::init( "end_surge_start" );
    level flag::init( "end_surge_rest" );
    level flag::init( "wind_done" );
    level flag::init( "surge_done" );
    level flag::init( "wave_done" );
    level flag::init( "cover_switch" );
    level flag::init( "enter_port" );
    level flag::init( "start_objective_barge_assault" );
    level flag::init( "hendricks_on_barge" );
    level flag::init( "slow_mo_finished" );
    level flag::init( "breached" );
    level flag::init( "barge_breach_cleared" );
    level flag::init( "tanker_smash" );
    level flag::init( "tanker_go" );
    level flag::init( "tanker_face" );
    level flag::init( "tanker_hit" );
    level flag::init( "tanker_ride" );
    level flag::init( "tanker_ride_done" );
    level flag::init( "flag_lobby_engaged" );
    level flag::init( "flag_kane_intro_complete" );
    level flag::init( "flag_enter_police_station" );
    level flag::init( "flag_lobby_ready_to_engage" );
    level flag::init( "flag_intro_dialog_ended" );
    level flag::init( "table_flip" );
    level flag::init( "walkway_collapse" );
    level flag::init( "hendricks_crossed" );
    level flag::init( "police_station_engaged" );
    level flag::init( "approach_ps_entrance" );
    level flag::init( "comm_relay_pulse" );
    level flag::init( "comm_relay_engaged" );
    level flag::init( "comm_relay_started_hack" );
    level flag::init( "comm_relay_hacked" );
    level flag::init( "relay_room_clear" );
    level flag::init( "igc_robot_down" );
    level flag::init( "blackstation_exterior_engaged" );
    level flag::init( "exterior_ready_weapons" );
    level flag::init( "ziplines_ready" );
    level flag::init( "kane_landed" );
    level flag::init( "zipline_player_landed" );
    level flag::init( "lightning_strike" );
    level flag::init( "lightning_strike_done" );
    level flag::init( "breach_active" );
    level flag::init( "hendricks_at_window" );
    level flag::init( "bridge_start_blocked" );
    level flag::init( "bridge_collapsed" );
    level flag::init( "cancel_slow_mo" );
    level flag::init( "atrium_rubble_dropped" );
    level flag::init( "path_is_open" );
    level flag::init( "awakening_begun" );
    level flag::init( "awakening_end" );
    level flag::init( "no_awakened_robots" );
    level flag::init( "truck_in_position" );
    level flag::init( "give_dni_weapon" );
    level flag::init( "trig_zipline02" );
    level flag::init( "trig_zipline01" );
    level flag::init( "warlord_dead" );
    level flag::init( "comm_relay_hendricks_ready" );
    level flag::init( "zipline_done" );
    level flag::init( "exterior_clear" );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x8410d0b3, Offset: 0x2680
// Size: 0x108
function level_init()
{
    setdvar( "player_swimTime", 5000 );
    setdvar( "player_swimSpeed", 120 );
    createthreatbiasgroup( "warlords" );
    createthreatbiasgroup( "heroes" );
    hidemiscmodels( "frogger_building_fallen" );
    array::run_all( getentarray( "frogger_building_fallen", "targetname" ), &hide );
    level thread scene::add_scene_func( "cin_gen_ground_anchor_player", &blackstation_utility::function_12398a8b, "done" );
    level.a_lobby_ai = [];
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xaa9df145, Offset: 0x2790
// Size: 0x506
function on_player_spawned()
{
    self thread player_rain_fx();
    self thread blackstation_utility::player_underwater();
    self.var_f44af1ef = 0;
    self.b_launcher_hint = 0;
    self.b_safezone = 0;
    self.is_surged = 0;
    self.is_wet = 0;
    self.var_32939eb7 = 0;
    self.var_20aea9e5 = 0;
    self.is_anchored = 0;
    self.is_wind_affected = 0;
    self.is_surge_affected = 0;
    self.var_116f2fb8 = 0;
    self.b_warning = 0;
    
    if ( !getdvarint( "art_review", 0 ) )
    {
        if ( level.skipto_point == "objective_qzone" )
        {
            self thread cp_mi_sing_blackstation_qzone::function_ec18f079();
        }
        else if ( level.skipto_point == "objective_warlord_igc" )
        {
            self util::set_low_ready( 1 );
        }
    }
    
    switch ( level.skipto_point )
    {
        case "objective_igc":
        default:
            self thread function_cc28a20d( "wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1 );
            self thread function_cc28a20d( "wind_effects", "trigger_pier_wind", "tanker_smash", 1 );
            self.var_2d166751 = 0;
            break;
        case "objective_qzone":
        case "objective_warlord":
            self thread function_cc28a20d( "wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1 );
            self thread function_cc28a20d( "wind_effects", "trigger_pier_wind", "tanker_smash", 1 );
            wait 0.1;
            self.var_2d166751 = 0.1;
            self clientfield::set_to_player( "toggle_rain_sprite", 1 );
            break;
        case "objective_anchor_intro":
            self thread function_cc28a20d( "wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1 );
            self thread function_cc28a20d( "wind_effects", "trigger_pier_wind", "tanker_smash", 1 );
            self thread blackstation_utility::player_anchor();
            self thread blackstation_utility::setup_wind_storm();
            self thread blackstation_utility::player_surge_trigger_tracker();
            self thread cp_mi_sing_blackstation_port::function_b3d8d3f5();
            wait 0.1;
            self.var_2d166751 = 0.4;
            self clientfield::set_to_player( "toggle_rain_sprite", 2 );
            break;
        case "objective_port_assault":
            self thread function_cc28a20d( "wind_effects_anchor", "anchor_intro_wind", "tanker_smash", 1 );
            self thread function_cc28a20d( "wind_effects", "trigger_pier_wind", "tanker_smash", 1 );
            self thread blackstation_utility::player_anchor();
            self thread blackstation_utility::setup_wind_storm();
            self thread blackstation_utility::player_surge_trigger_tracker();
            self thread cp_mi_sing_blackstation_port::function_b3d8d3f5();
            break;
        case "objective_barge_assault":
        case "objective_storm_surge":
            self thread blackstation_utility::player_anchor();
            self thread blackstation_utility::player_surge_trigger_tracker();
            self thread cp_mi_sing_blackstation_port::function_b3d8d3f5();
            break;
        case "objective_cross_debris":
        case "objective_police_station":
            wait 0.1;
            self.var_2d166751 = 0.1;
            self clientfield::set_to_player( "toggle_rain_sprite", 1 );
            break;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 4
// Checksum 0x86af4e46, Offset: 0x2ca0
// Size: 0x150
function function_cc28a20d( str_fx, str_trigger, str_flag, var_df107013 )
{
    if ( !isdefined( var_df107013 ) )
    {
        var_df107013 = 0;
    }
    
    level endon( str_flag );
    self endon( #"death" );
    self thread function_f891013e( str_flag );
    
    while ( true )
    {
        trigger::wait_till( str_trigger, "targetname", self );
        
        if ( str_fx == "wind_effects" )
        {
            self clientfield::set_to_player( "wind_effects", 1 );
        }
        else
        {
            self clientfield::set_to_player( "wind_effects", 2 );
        }
        
        t_wind = getent( str_trigger, "targetname" );
        util::wait_till_not_touching( t_wind, self );
        self clientfield::set_to_player( "wind_effects", 0 );
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1
// Checksum 0x69899f4b, Offset: 0x2df8
// Size: 0x6c
function function_f891013e( str_flag )
{
    self endon( #"death" );
    level flag::wait_till( str_flag );
    self clientfield::set_to_player( "wind_blur", 0 );
    self clientfield::set_to_player( "wind_effects", 0 );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x17ac26c3, Offset: 0x2e70
// Size: 0x44
function on_player_loadout()
{
    w_dni_shotgun = getweapon( "micromissile_launcher" );
    self giveweapon( w_dni_shotgun );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x847aa8ef, Offset: 0x2ec0
// Size: 0x574
function register_clientfields()
{
    clientfield::register( "actor", "kill_target_keyline", 1, 4, "int" );
    clientfield::register( "allplayers", "zipline_sound_loop", 1, 1, "int" );
    clientfield::register( "scriptmover", "water_disturbance", 1, 1, "int" );
    clientfield::register( "scriptmover", "water_splash_lrg", 1, 1, "counter" );
    clientfield::register( "toplayer", "player_rain", 1, 3, "int" );
    clientfield::register( "toplayer", "rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "sndWindSystem", 1, 2, "int" );
    clientfield::register( "toplayer", "zipline_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "player_water_swept", 1, 1, "int" );
    clientfield::register( "toplayer", "toggle_ukko", 1, 2, "int" );
    clientfield::register( "toplayer", "toggle_rain_sprite", 1, 2, "int" );
    clientfield::register( "toplayer", "wind_blur", 1, 1, "int" );
    clientfield::register( "toplayer", "wind_effects", 1, 2, "int" );
    clientfield::register( "toplayer", "subway_water", 1, 1, "int" );
    clientfield::register( "toplayer", "play_bubbles", 1, 1, "int" );
    clientfield::register( "toplayer", "toggle_water_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "wave_hit", 1, 1, "int" );
    clientfield::register( "world", "subway_entrance_crash", 1, 1, "int" );
    clientfield::register( "world", "water_level", 1, 3, "int" );
    clientfield::register( "world", "roof_panels_init", 1, 1, "int" );
    clientfield::register( "world", "roof_panels_play", 1, 1, "int" );
    clientfield::register( "world", "subway_tiles", 1, 1, "int" );
    clientfield::register( "world", "warlord_exposure", 1, 1, "int" );
    clientfield::register( "world", "outro_exposure", 1, 1, "int" );
    clientfield::register( "world", "sndDrillWalla", 1, 2, "int" );
    clientfield::register( "world", "sndBlackStationSounds", 1, 1, "int" );
    clientfield::register( "world", "flotsam", 1, 1, "int" );
    clientfield::register( "world", "sndStationWalla", 1, 1, "int" );
    clientfield::register( "world", "qzone_debris", 1, 1, "counter" );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x39ce45a3, Offset: 0x3440
// Size: 0x3bc
function setup_skiptos()
{
    skipto::add( "objective_igc", &cp_mi_sing_blackstation_qzone::objective_igc_init, undefined, &cp_mi_sing_blackstation_qzone::objective_igc_done );
    skipto::add( "objective_qzone", &cp_mi_sing_blackstation_qzone::objective_qzone_init, undefined, &cp_mi_sing_blackstation_qzone::objective_qzone_done );
    skipto::function_d68e678e( "objective_warlord_igc", &cp_mi_sing_blackstation_qzone::objective_warlord_igc_init, undefined, &cp_mi_sing_blackstation_qzone::objective_warlord_igc_done );
    skipto::add( "objective_warlord", &cp_mi_sing_blackstation_qzone::objective_warlord_init, undefined, &cp_mi_sing_blackstation_qzone::objective_warlord_done );
    skipto::function_d68e678e( "objective_anchor_intro", &cp_mi_sing_blackstation_port::anchor_intro, undefined, &cp_mi_sing_blackstation_port::anchor_intro_done );
    skipto::function_d68e678e( "objective_port_assault", &cp_mi_sing_blackstation_port::port_assault, undefined, &cp_mi_sing_blackstation_port::port_assault_done );
    skipto::function_d68e678e( "objective_barge_assault", &cp_mi_sing_blackstation_port::barge_assault, undefined, &cp_mi_sing_blackstation_port::barge_assault_done );
    skipto::function_d68e678e( "objective_storm_surge", &cp_mi_sing_blackstation_port::storm_surge, undefined, &cp_mi_sing_blackstation_port::storm_surge_done );
    skipto::function_d68e678e( "objective_subway", &objective_subway_init, undefined, &objective_subway_done );
    skipto::function_d68e678e( "objective_police_station", &cp_mi_sing_blackstation_police_station::objective_police_station_init, undefined, &cp_mi_sing_blackstation_police_station::objective_police_station_done );
    skipto::function_d68e678e( "objective_kane_intro", &cp_mi_sing_blackstation_police_station::objective_kane_intro_init, undefined, &cp_mi_sing_blackstation_police_station::objective_kane_intro_done );
    skipto::function_d68e678e( "objective_comm_relay_traverse", &cp_mi_sing_blackstation_comm_relay::objective_comm_relay_traverse_init, undefined, &cp_mi_sing_blackstation_comm_relay::objective_comm_relay_traverse_done );
    skipto::function_d68e678e( "objective_comm_relay", &cp_mi_sing_blackstation_comm_relay::objective_comm_relay_init, undefined, &cp_mi_sing_blackstation_comm_relay::objective_comm_relay_done );
    skipto::function_d68e678e( "objective_cross_debris", &cp_mi_sing_blackstation_cross_debris::objective_cross_debris_init, undefined, &cp_mi_sing_blackstation_cross_debris::objective_cross_debris_done );
    skipto::function_d68e678e( "objective_blackstation_exterior", &cp_mi_sing_blackstation_station::objective_blackstation_exterior_init, undefined, &cp_mi_sing_blackstation_station::objective_blackstation_exterior_done );
    skipto::function_d68e678e( "objective_blackstation_interior", &cp_mi_sing_blackstation_station::objective_blackstation_interior_init, undefined, &cp_mi_sing_blackstation_station::objective_blackstation_interior_done );
    skipto::function_d68e678e( "objective_end_igc", &cp_mi_sing_blackstation_station::objective_end_igc_init, undefined, &cp_mi_sing_blackstation_station::objective_end_igc_done );
}

// Namespace cp_mi_sing_blackstation
// Params 2
// Checksum 0x405f2bf7, Offset: 0x3808
// Size: 0xdc
function objective_subway_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_subway" );
        objectives::complete( "cp_level_blackstation_intercept" );
        load::function_a2995f22();
        array::thread_all( level.activeplayers, &cp_mi_sing_blackstation_subway::function_99f304f0 );
        level thread namespace_4297372::function_37f7c98d();
    }
    
    level thread blackstation_utility::player_rain_intensity( "none" );
    cp_mi_sing_blackstation_subway::subway_main();
}

// Namespace cp_mi_sing_blackstation
// Params 4
// Checksum 0x97b808e1, Offset: 0x38f0
// Size: 0xc4
function objective_subway_done( str_objective, b_starting, b_direct, player )
{
    level thread scene::play( "p7_fxanim_cp_blackstation_streetlight01_4on_s4_bundle" );
    level thread scene::play( "p7_fxanim_cp_blackstation_streetlight01_2on_s4_bundle" );
    level thread scene::play( "p7_fxanim_cp_blackstation_streetlight01_4on_flicker_s4_bundle" );
    level thread scene::play( "p7_fxanim_cp_blackstation_streetlight_01_s4_bundle" );
    level thread scene::play( "p7_fxanim_cp_blackstation_streetlight01_1on_s4_bundle" );
}

// Namespace cp_mi_sing_blackstation
// Params 2
// Checksum 0xbc2376a5, Offset: 0x39c0
// Size: 0x34
function givecustomloadout( takeallweapons, alreadyspawned )
{
    self takeweapon( self.grenadetypesecondary );
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xe06b8251, Offset: 0x3a00
// Size: 0x146
function player_rain_fx()
{
    self endon( #"death" );
    
    switch ( level.skipto_point )
    {
        case "objective_blackstation_exterior":
        case "objective_blackstation_interior":
        case "objective_end_igc":
        case "objective_kane_intro":
        case "objective_subway":
            self thread blackstation_utility::player_rain_intensity( "none" );
            break;
        case "objective_qzone":
        case "objective_warlord":
        default:
            self thread blackstation_utility::player_rain_intensity( "light_se" );
            break;
        case "objective_anchor_intro":
        case "objective_port_assault":
            self thread blackstation_utility::player_rain_intensity( "med_se" );
            break;
        case "objective_barge_assault":
        case "objective_storm_surge":
            self thread blackstation_utility::player_rain_intensity( "drench_se" );
            break;
        case "objective_comm_relay":
        case "objective_comm_relay_traverse":
        case "objective_cross_debris":
        case "objective_police_station":
            self thread blackstation_utility::player_rain_intensity( "light_ne" );
            break;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0xdeef934e, Offset: 0x3b50
// Size: 0xb2
function weather_setup()
{
    a_trig_rain_outdoor = getentarray( "trig_rain_indoor", "targetname" );
    
    foreach ( e_trig in a_trig_rain_outdoor )
    {
        e_trig thread monitor_outdoor_rain_doorways();
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0
// Checksum 0x13d6d8d8, Offset: 0x3c10
// Size: 0x118
function monitor_outdoor_rain_doorways()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", e_who );
        
        if ( isdefined( e_who.b_rain_on ) && isplayer( e_who ) && e_who.b_rain_on )
        {
            e_who thread pause_rain_overlay( self );
            continue;
        }
        
        if ( isdefined( e_who.b_rain_on ) && isai( e_who ) && e_who.b_rain_on )
        {
            if ( e_who ai::has_behavior_attribute( "useAnimationOverride" ) && e_who ai::get_behavior_attribute( "useAnimationOverride" ) )
            {
                e_who thread function_8a1a53f( self );
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1
// Checksum 0xefbeaac4, Offset: 0x3d30
// Size: 0xd4
function pause_rain_overlay( e_trig )
{
    self endon( #"disconnect" );
    e_trig endon( #"death" );
    self.b_rain_on = 0;
    self clientfield::set_to_player( "toggle_rain_sprite", 0 );
    util::wait_till_not_touching( e_trig, self );
    self.b_rain_on = 1;
    
    if ( !self isplayinganimscripted() )
    {
        if ( level.skipto_point != "objective_port_assault" && level.skipto_point != "objective_blackstation_exterior" )
        {
            self clientfield::set_to_player( "toggle_rain_sprite", 1 );
        }
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1
// Checksum 0x294a11ed, Offset: 0x3e10
// Size: 0x94
function function_8a1a53f( e_trig )
{
    self endon( #"death" );
    e_trig endon( #"death" );
    self.b_rain_on = 0;
    self ai::set_behavior_attribute( "useAnimationOverride", 0 );
    util::wait_till_not_touching( e_trig, self );
    self.b_rain_on = 1;
    self ai::set_behavior_attribute( "useAnimationOverride", 1 );
}

