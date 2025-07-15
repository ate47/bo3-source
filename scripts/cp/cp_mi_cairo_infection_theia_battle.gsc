#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_siegebot_theia;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace sarah_battle;

// Namespace sarah_battle
// Params 0
// Checksum 0xb7f95371, Offset: 0x1340
// Size: 0x18e
function main()
{
    setup_scenes();
    level flag::init( "player_exiting_downed_vtol" );
    level flag::init( "vtol_intro_complete" );
    level flag::init( "sarah_battle_friendly_spawned" );
    level flag::init( "sarah_defeated" );
    level flag::init( "sarah_interface_started" );
    level flag::init( "sarah_interface_done" );
    level.wrecked_vtol = getentarray( "inf_wrecked_vtol", "targetname" );
    level.sarah_bash2_clip = getent( "sarah_bash2_clip", "targetname" );
    
    if ( isdefined( level.sarah_bash2_clip ) )
    {
        level.sarah_bash2_clip notsolid();
        level.sarah_bash2_clip connectpaths();
    }
    
    init_clientfields();
    level._effect[ "crashed_vtol_exp_fx" ] = "explosions/fx_exp_quadtank_death_sm";
}

// Namespace sarah_battle
// Params 0
// Checksum 0xac6c0ba8, Offset: 0x14d8
// Size: 0xec
function init_clientfields()
{
    n_clientbits = getminbitcountfornum( 8 );
    clientfield::register( "world", "building_destruction_callback", 1, n_clientbits, "int" );
    clientfield::register( "world", "building_end_callback", 1, 1, "int" );
    clientfield::register( "world", "vtol_fog_bank", 1, 1, "int" );
    clientfield::register( "scriptmover", "sarah_tac_mode_disable", 1, 1, "int" );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x7f618689, Offset: 0x15d0
// Size: 0x11c
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_03_01_interface_1st_dni_02", &interface_1st_dni );
    scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_c087a5cf );
    scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_1bb0323c );
    scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_45d8cfab );
    scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_56c9a7f3 );
    scene::add_scene_func( "cin_inf_02_01_vign_interface_siegebot_bash", &function_68861104 );
    scene::add_scene_func( "cin_inf_02_01_vign_interface_siegebot_bash_2", &sarah_truck_bash_2 );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x55883963, Offset: 0x16f8
// Size: 0x28c
function vtol_model_init()
{
    var_2aa82b86 = getent( "vtol_intro", "targetname" );
    var_2aa82b86 showpart( "tag_console_center_screen_animate_d0" );
    var_2aa82b86 showpart( "tag_console_left_screen_animate_d0" );
    var_2aa82b86 showpart( "tag_console_right_screen_animate_d0" );
    var_2aa82b86 attach( "veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate" );
    var_2aa82b86 attach( "veh_t7_mil_vtol_egypt_cabin_details_attch_screenglows", "tag_body_animate" );
    var_b2c5be8 = getent( "vtol_nose", "targetname" );
    var_b2c5be8 enablelinkto();
    var_b2c5be8 linkto( var_2aa82b86 );
    var_b2c5be8 thread function_d147e0e1();
    vtol_lights = getentarray( "light_vtol_flyin", "targetname" );
    
    foreach ( light in vtol_lights )
    {
        light linkto( var_2aa82b86 );
        light thread vtol_light_cleanup();
    }
    
    vtol_spotlight = getent( "light_vtol_flyin_spotlight", "targetname" );
    
    if ( isdefined( vtol_spotlight ) )
    {
        vtol_spotlight linkto( var_2aa82b86, "tag_winch" );
        vtol_spotlight thread vtol_light_cleanup();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x597b6fc8, Offset: 0x1990
// Size: 0x44
function vtol_light_cleanup()
{
    level flag::wait_till( "player_exiting_downed_vtol" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x89ca2f8e, Offset: 0x19e0
// Size: 0x24c
function function_d147e0e1()
{
    num_parts = 5;
    self hidepart( "tag_glass_d1_animate" );
    
    for ( i = 1; i <= num_parts ; i++ )
    {
        self hidepart( "tag_glass" + i + "_d1_animate" );
    }
    
    self hidepart( "tag_glass_d2_animate" );
    
    for ( i = 1; i <= num_parts ; i++ )
    {
        self hidepart( "tag_glass" + i + "_d2_animate" );
    }
    
    self hidepart( "tag_glass4_d3_animate" );
    level waittill( #"sarah_explode_building" );
    self attach( "veh_t7_mil_vtol_egypt_screens_d1", "tag_nose_animate" );
    self hidepart( "tag_glass_animate" );
    
    for ( i = 1; i <= num_parts ; i++ )
    {
        self hidepart( "tag_glass" + i + "_animate" );
    }
    
    self showpart( "tag_glass_d2_animate" );
    
    for ( i = 1; i <= num_parts ; i++ )
    {
        self showpart( "tag_glass" + i + "_d2_animate" );
    }
    
    level flag::wait_till( "player_exiting_downed_vtol" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x8f23112e, Offset: 0x1c38
// Size: 0xa8
function vo_javelin_warning()
{
    while ( true )
    {
        level waittill( #"theia_preparing_javelin_attack" );
        
        if ( randomint( 100 ) > 60 )
        {
            level.ai_hendricks dialog::say( "hend_javelin_missiles_inc_0", 1 );
            continue;
        }
        
        if ( randomint( 100 ) < 40 )
        {
            level.ai_hendricks dialog::say( "hend_javelin_s_inbound_0", 1 );
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xc5c7589d, Offset: 0x1ce8
// Size: 0x34
function vo_spike_launcher()
{
    if ( !level.var_a2488e6f )
    {
        level.ai_hendricks dialog::say( "hend_explosive_spikes_inc_0", 1 );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xc46ddc74, Offset: 0x1d28
// Size: 0x6c
function sarah_battle_state_init()
{
    level.ai_sarah endon( #"death" );
    level waittill( #"intial_battle_vo_done" );
    level.ai_sarah thread vo_sarah_movement_watcher();
    level.ai_sarah thread vo_sarah_health_watcher();
    level thread vo_javelin_warning();
}

// Namespace sarah_battle
// Params 0
// Checksum 0xcace8cbf, Offset: 0x1da0
// Size: 0x1ea
function vo_sarah_movement_watcher()
{
    self endon( #"death" );
    var_2c8bd13b = 0;
    
    while ( true )
    {
        while ( self vehicle_ai::get_current_state() == "groundCombat" )
        {
            wait 2;
        }
        
        while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
        {
            wait 0.1;
        }
        
        level.var_a2488e6f = 1;
        str_state = self vehicle_ai::get_current_state();
        
        if ( str_state == "combat" || str_state == "prepareDeath" )
        {
            var_2c8bd13b++;
            
            if ( var_2c8bd13b == 1 )
            {
                level.ai_hendricks dialog::say( "hend_eyes_up_hall_s_take_0", 2 );
            }
            else if ( var_2c8bd13b == 2 )
            {
            }
            
            while ( self vehicle_ai::get_current_state() == "combat" || self vehicle_ai::get_current_state() == "pain" || self vehicle_ai::get_current_state() == "prepareDeath" )
            {
                wait 2;
            }
        }
        else if ( str_state == "jumpUp" || str_state == "jumpDown" )
        {
            level.ai_hendricks dialog::say( "hend_she_s_on_the_move_0", 1 );
        }
        
        level.var_a2488e6f = 0;
        wait 1;
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x8ce46970, Offset: 0x1f98
// Size: 0x260
function vo_sarah_health_watcher()
{
    self endon( #"death" );
    self thread sarah_death_failsafe();
    n_start_health = self.health;
    self thread wait_for_sarah_death();
    
    while ( self.health > n_start_health * 0.7 )
    {
        wait 0.1;
    }
    
    while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
    {
        wait 0.1;
    }
    
    level.var_a2488e6f = 1;
    level dialog::remote( "kane_siege_bot_operating_0", 1 );
    level.ai_hendricks dialog::say( "hend_we_gotta_get_through_0", 1 );
    level.var_a2488e6f = 0;
    
    while ( self.health > n_start_health * 0.4 )
    {
        wait 0.1;
    }
    
    while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
    {
        wait 0.1;
    }
    
    level.var_a2488e6f = 1;
    level dialog::remote( "kane_siege_bot_now_operat_0", 1 );
    level.ai_hendricks dialog::say( "hend_her_shields_won_t_ho_0", 1 );
    level.var_a2488e6f = 0;
    
    while ( self.health > n_start_health * 0.1 )
    {
        wait 0.1;
    }
    
    while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
    {
        wait 0.1;
    }
    
    level.var_a2488e6f = 1;
    level dialog::remote( "kane_siege_bot_energy_dow_0", 1 );
    level dialog::remote( "kane_she_s_our_only_lead_0", 1 );
    level.var_a2488e6f = 0;
}

// Namespace sarah_battle
// Params 0
// Checksum 0x3d4a0df8, Offset: 0x2200
// Size: 0x20
function sarah_death_failsafe()
{
    self waittill( #"death" );
    wait 3;
    level.var_a2488e6f = 0;
}

// Namespace sarah_battle
// Params 0
// Checksum 0xc14d54bf, Offset: 0x2228
// Size: 0x70
function wait_for_sarah_death()
{
    self waittill( #"death" );
    
    while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
    {
        wait 0.1;
    }
    
    level.var_a2488e6f = 1;
    level dialog::remote( "kane_she_s_down_she_s_do_0", 1 );
    level.var_a2488e6f = 0;
}

// Namespace sarah_battle
// Params 1
// Checksum 0xa9bf52bd, Offset: 0x22a0
// Size: 0x144
function vo_sarah_battle( a_ents )
{
    level.ai_sarah endon( #"death" );
    level flag::wait_till( "sarah_battle_friendly_spawned" );
    battlechatter::function_d9f49fba( 0 );
    level.ai_khalil dialog::say( "khal_mech_suit_hostile_h_0" );
    level dialog::remote( "kane_looks_like_sarah_hal_0", 0.5 );
    level dialog::player_say( "plyr_you_got_a_fix_on_tay_0", 2 );
    level dialog::remote( "kane_negative_0", 0.7 );
    level dialog::player_say( "plyr_then_the_only_way_to_0", 1 );
    level notify( #"intial_battle_vo_done" );
    level.var_9e921465 = 1;
    battlechatter::function_d9f49fba( 1 );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x15330a3b, Offset: 0x23f0
// Size: 0xcc
function vo_sarah_interface_init()
{
    while ( isdefined( level.var_a2488e6f ) && level.var_a2488e6f )
    {
        wait 0.05;
    }
    
    level dialog::remote( "kane_hurry_you_have_to_0", 0.5 );
    function_b38700c3( "kane_we_need_a_full_extra_0", 1 );
    function_b38700c3( "kane_i_know_this_isn_t_ea_0", 7 );
    function_b38700c3( "kane_no_sign_of_taylor_an_0", 8 );
    function_b38700c3( "kane_her_systems_are_fail_0", 5 );
}

// Namespace sarah_battle
// Params 2
// Checksum 0x148515c6, Offset: 0x24c8
// Size: 0x84
function function_b38700c3( str_vo_alias, n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    if ( !level flag::get( "sarah_interface_started" ) )
    {
        wait n_delay;
        
        if ( !level flag::get( "sarah_interface_started" ) )
        {
            level dialog::remote( str_vo_alias );
        }
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xcd9d7d21, Offset: 0x2558
// Size: 0x10c
function interface_1st_dni( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level waittill( #"hash_4ad123af" );
        
        foreach ( player in level.activeplayers )
        {
            player cybercom::cybercom_armpulse( 1 );
            player clientfield::increment_to_player( "hack_dni_fx" );
        }
        
        level.players[ 0 ] waittill( #"start_interface" );
        level thread infection_util::movie_transition( "cp_infection_fs_interface" );
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x291ca292, Offset: 0x2670
// Size: 0x34
function function_45d8cfab( a_ents )
{
    level waittill( #"hash_45d8cfab" );
    level scene::init( "cin_inf_02_01_vign_interface_siegebot_bash" );
}

// Namespace sarah_battle
// Params 1
// Checksum 0x51f52440, Offset: 0x26b0
// Size: 0x6c
function function_56c9a7f3( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level waittill( #"hash_9903f6a6" );
        level util::delay( 1, undefined, &friendly_ai_controller );
        return;
    }
    
    level thread friendly_ai_controller();
}

// Namespace sarah_battle
// Params 2
// Checksum 0x8d1f352c, Offset: 0x2728
// Size: 0x394
function vtol_arrival_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
    
    load::function_73adcefc();
    objectives::set( "cp_level_infection_find_dr" );
    level vtol_model_init();
    spawn_sarah_boss();
    level.ai_hendricks = util::get_hero( "hendricks" );
    level scene::init( "cin_inf_01_01_vtolarrival_1st_encounter_wires" );
    level scene::init( "cin_inf_01_01_vtolarrival_1st_encounter_v2" );
    function_48e3f00e();
    level clientfield::set( "vtol_fog_bank", 1 );
    level thread function_69d9e05d();
    level thread function_4dd97558();
    level thread building_destruction_init();
    level util::set_streamer_hint( 1 );
    load::function_c32ba481();
    util::do_chyron_text( &"CP_MI_CAIRO_INFECTION_INTRO_LINE_1_FULL", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_1_SHORT", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_2_FULL", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_2_SHORT", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_3_FULL", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_3_SHORT", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_4_FULL", &"CP_MI_CAIRO_INFECTION_INTRO_LINE_4_SHORT" );
    
    if ( isdefined( level.bzm_infectiondialogue1callback ) )
    {
        level thread [[ level.bzm_infectiondialogue1callback ]]();
    }
    
    level thread namespace_eccdd5d1::play_intro();
    level scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_8b952c00 );
    level scene::add_scene_func( "cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_3cb73539, "skip_completed" );
    level thread scene::play( "cin_inf_01_01_vtolarrival_1st_encounter_wires" );
    level thread scene::play( "cin_inf_01_01_vtolarrival_1st_encounter_sarah_cockpit_loop" );
    level thread scene::play( "cin_inf_01_01_vtolarrival_1st_encounter_v2" );
    level flag::wait_till( "player_exiting_downed_vtol" );
    level clientfield::set( "gameplay_started", 1 );
    function_99e62b85();
    level scene::stop( "cin_inf_01_01_vtolarrival_1st_encounter_wires" );
    objectives::complete( "cp_level_infection_find_dr" );
    scene::waittill_skip_sequence_completed();
    util::wait_network_frame();
    level thread util::clear_streamer_hint();
    skipto::objective_completed( "vtol_arrival" );
}

// Namespace sarah_battle
// Params 1
// Checksum 0xc214a475, Offset: 0x2ac8
// Size: 0x4c
function function_8b952c00( a_ents )
{
    level waittill( #"teleport_players" );
    level flag::set( "player_exiting_downed_vtol" );
    util::teleport_players_igc( "vtol_arrival_coop_teleport" );
}

// Namespace sarah_battle
// Params 1
// Checksum 0xb2f02b5f, Offset: 0x2b20
// Size: 0x46a
function function_3cb73539( a_ents )
{
    var_cca89d10 = array( "intro_friendly_vtol", "vtol_intro_veh1", "vtol_intro_veh3", "intro_friendly_vtol_vh" );
    
    foreach ( str_vehicle in var_cca89d10 )
    {
        a_vehicles = getentarray( str_vehicle, "targetname" );
        
        foreach ( var_91e835c9 in a_vehicles )
        {
            if ( isdefined( var_91e835c9 ) )
            {
                var_91e835c9.delete_on_death = 1;
                var_91e835c9 notify( #"death" );
                
                if ( !isalive( var_91e835c9 ) )
                {
                    var_91e835c9 delete();
                }
            }
        }
    }
    
    var_8da4fac5 = getentarray( "vtol_intro_veh1", "targetname" );
    var_b3a7752e = getentarray( "vtol_intro_veh2", "targetname" );
    var_d9a9ef97 = getentarray( "vtol_intro_veh3", "targetname" );
    
    foreach ( vh_intro in var_8da4fac5 )
    {
        vh_intro.delete_on_death = 1;
        vh_intro notify( #"death" );
        
        if ( !isalive( vh_intro ) )
        {
            vh_intro delete();
        }
    }
    
    foreach ( vh_intro in var_b3a7752e )
    {
        vh_intro.delete_on_death = 1;
        vh_intro notify( #"death" );
        
        if ( !isalive( vh_intro ) )
        {
            vh_intro delete();
        }
    }
    
    foreach ( vh_intro in var_d9a9ef97 )
    {
        vh_intro.delete_on_death = 1;
        vh_intro notify( #"death" );
        
        if ( !isalive( vh_intro ) )
        {
            vh_intro delete();
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x70e4d20e, Offset: 0x2f98
// Size: 0x382
function function_69d9e05d()
{
    foreach ( e_piece in level.wrecked_vtol )
    {
        e_piece hide();
    }
    
    var_5ff14e42 = getentarray( "sarah_battle_launcher", "targetname" );
    
    foreach ( var_7e2968b3 in var_5ff14e42 )
    {
        var_7e2968b3 ghost();
    }
    
    var_f0770462 = getentarray( "sarah_battle_destructible", "script_noteworthy" );
    
    foreach ( e_destructible in var_f0770462 )
    {
        e_destructible ghost();
    }
    
    var_da5600e3 = getentarray( "sarah_battle_ammo", "targetname" );
    
    foreach ( var_4abed703 in var_da5600e3 )
    {
        if ( isdefined( var_4abed703.gameobject ) )
        {
            var_4abed703.gameobject gameobjects::set_model_visibility( 0 );
        }
    }
    
    level waittill( #"hash_9903f6a6" );
    var_5865e335 = spawner::get_ai_group_ai( "intro_friendly" );
    
    foreach ( var_bba6ddda in var_5865e335 )
    {
        if ( isdefined( var_bba6ddda ) )
        {
            var_bba6ddda delete();
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x6652ad1b, Offset: 0x3328
// Size: 0x324
function function_4dd97558()
{
    level waittill( #"vtol_crashed" );
    
    foreach ( e_piece in level.wrecked_vtol )
    {
        e_piece show();
    }
    
    rocket_launcher_init();
    var_5ff14e42 = getentarray( "sarah_battle_launcher", "targetname" );
    
    foreach ( var_7e2968b3 in var_5ff14e42 )
    {
        var_7e2968b3 show();
        util::wait_network_frame();
    }
    
    var_f0770462 = getentarray( "sarah_battle_destructible", "script_noteworthy" );
    
    foreach ( e_destructible in var_f0770462 )
    {
        e_destructible show();
        util::wait_network_frame();
    }
    
    var_da5600e3 = getentarray( "sarah_battle_ammo", "targetname" );
    
    foreach ( var_4abed703 in var_da5600e3 )
    {
        if ( isdefined( var_4abed703.gameobject ) )
        {
            var_4abed703.gameobject gameobjects::set_model_visibility( 1 );
        }
        
        util::wait_network_frame();
    }
    
    exploder::exploder( "sarah_battle_fire" );
}

// Namespace sarah_battle
// Params 1
// Checksum 0x3f8fab0e, Offset: 0x3658
// Size: 0x8c
function function_1bb0323c( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        if ( level.current_skipto == "vtol_arrival" )
        {
            a_ents[ "sarah_siegebot" ] vehicle::lights_off();
            a_ents[ "sarah_siegebot" ] waittill( #"turn_on_lights" );
            a_ents[ "sarah_siegebot" ] vehicle::lights_on();
        }
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x39d1fa54, Offset: 0x36f0
// Size: 0x74
function function_c087a5cf( a_ents )
{
    vh_vtol = a_ents[ "vtol_intro" ];
    
    if ( level.current_skipto == "vtol_arrival" )
    {
        level waittill( #"hash_9903f6a6" );
    }
    
    vh_vtol hidepart( "tag_wing_left_animate", vh_vtol.model, 1 );
}

// Namespace sarah_battle
// Params 0
// Checksum 0xaa2e82, Offset: 0x3770
// Size: 0x7c
function function_99e62b85()
{
    s_sarah_battle_hendricks_start_pos = struct::get( "s_sarah_battle_hendricks_start_pos" );
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.ai_hendricks forceteleport( s_sarah_battle_hendricks_start_pos.origin, s_sarah_battle_hendricks_start_pos.angles );
}

// Namespace sarah_battle
// Params 2
// Checksum 0x1a6cd674, Offset: 0x37f8
// Size: 0x3fc
function sarah_battle_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x3a>" );
    #/
    
    if ( !b_starting )
    {
        array::thread_all( level.players, &infection_util::player_leave_cinematic );
    }
    
    level.var_9e921465 = 0;
    level.var_a2488e6f = 0;
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.overrideplayerdamage = &player_callback_damage;
    
    if ( b_starting )
    {
        load::function_73adcefc();
        exploder::exploder( "sarah_battle_fire" );
        function_48e3f00e();
        level thread function_8f97d54e( 1 );
        spawn_sarah_boss( b_starting );
        level thread scene::init( "cin_inf_02_01_vign_interface_siegebot_bash" );
        level thread scene::init( "cin_inf_01_01_vtolarrival_1st_encounter_v2" );
        level flag::set( "vtol_intro_complete" );
        level thread building_destruction_init();
        load::function_a2995f22();
        level thread scene::skipto_end( "cin_inf_01_01_vtolarrival_1st_encounter_v2", undefined, undefined, 0.85, 1 );
        level waittill( #"vtol_crashed" );
        level thread friendly_ai_controller();
        level flag::wait_till( "player_exiting_downed_vtol" );
        util::teleport_players_igc( "vtol_arrival_coop_teleport" );
        function_99e62b85();
    }
    
    level thread namespace_eccdd5d1::function_97020766();
    array::thread_all( level.activeplayers, &coop::function_e9f7384d );
    exploder::exploder( "sarah_battle_vtol_crash_fire" );
    level.ai_sarah ai::set_ignoreme( 0 );
    level thread monitor_sarah_battle();
    level thread vo_sarah_battle();
    level thread sarah_battle_state_init();
    level thread crashed_vtol_explosion();
    close_lui_menu();
    objectives::set( "cp_level_infection_defeat_sarah", level.ai_sarah );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] disableinvulnerability();
        level.players[ i ] infection_accolades::function_ad15914d();
    }
    
    level flag::wait_till( "sarah_battle_friendly_spawned" );
    level.ai_hendricks thread hero_check_distance();
    level.ai_khalil thread hero_check_distance();
}

// Namespace sarah_battle
// Params 1
// Checksum 0x3f5772aa, Offset: 0x3c00
// Size: 0x30c
function spawn_sarah_boss( b_skipto )
{
    if ( !isdefined( b_skipto ) )
    {
        b_skipto = 0;
    }
    
    level.ai_sarah = spawner::simple_spawn_single( "sarah_boss" );
    level.ai_sarah ai::set_ignoreall( 1 );
    level.ai_sarah ai::set_ignoreme( 1 );
    level.ai_sarah.targetname = "sarah_siegebot";
    level.ai_sarah vehicle_ai::start_scripted();
    var_729f9335 = level.ai_sarah gettagorigin( "tag_driver" );
    var_febde835 = level.ai_sarah gettagangles( "tag_driver" );
    level.var_156d60f = util::spawn_model( "c_hro_sarah_base", var_729f9335, var_febde835 );
    level.var_156d60f sethighdetail( 0 );
    level.var_156d60f.targetname = "sarah_driver";
    level.var_156d60f clientfield::set( "sarah_tac_mode_disable", 1 );
    
    if ( b_skipto )
    {
        level.var_156d60f function_76887c27();
    }
    
    createthreatbiasgroup( "sarah_battle_seigebot" );
    createthreatbiasgroup( "players" );
    setthreatbias( "players", "sarah_battle_seigebot", 1000 );
    level thread player_hijack_monitor();
    callback::on_spawned( &on_player_spawn );
    level.ai_sarah setthreatbiasgroup( "sarah_battle_seigebot" );
    
    foreach ( player in level.players )
    {
        player setthreatbiasgroup( "players" );
        player._spawn_time = gettime();
    }
    
    update_player_threat_bias();
}

// Namespace sarah_battle
// Params 0
// Checksum 0xba1b36a0, Offset: 0x3f18
// Size: 0x74
function update_player_threat_bias()
{
    if ( level.players.size <= 1 )
    {
        threatbias = 900;
    }
    else
    {
        threatbias = 1000 + 300 * level.players.size - 1;
    }
    
    setthreatbias( "players", "sarah_battle_seigebot", threatbias );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x9dfbc2b, Offset: 0x3f98
// Size: 0x44
function on_player_spawn()
{
    self setthreatbiasgroup( "players" );
    self._spawn_time = gettime();
    update_player_threat_bias();
}

// Namespace sarah_battle
// Params 0
// Checksum 0x5116a90f, Offset: 0x3fe8
// Size: 0x4c
function player_hijack_monitor()
{
    level.ai_sarah endon( #"death" );
    level waittill( #"clonedentity", clone );
    clone setthreatbiasgroup( "players" );
}

// Namespace sarah_battle
// Params 0
// Checksum 0xb2ce1887, Offset: 0x4040
// Size: 0x330
function sarah_spike_launcher_watcher()
{
    level.ai_sarah endon( #"death" );
    hero_array = [];
    array::add( hero_array, level.ai_hendricks, 0 );
    array::add( hero_array, level.ai_khalil, 0 );
    
    while ( true )
    {
        level waittill( #"theia_preparing_spike_attack", target_origin );
        closest_hero = arraygetclosest( target_origin, hero_array );
        
        if ( level.var_9e921465 )
        {
            level thread vo_spike_launcher();
        }
        
        nd_cover = find_good_coverpos( target_origin );
        
        if ( closest_hero == level.ai_hendricks )
        {
            team = "team_hendricks";
        }
        else
        {
            team = "team_khalil";
        }
        
        a_allies = getentarray( team, "script_noteworthy" );
        
        foreach ( ai in a_allies )
        {
            ai.old_radius = ai.goalradius;
            ai.goalradius = 512;
        }
        
        closest_hero ai::set_ignoreall( 1 );
        closest_hero ai::force_goal( nd_cover, 32 );
        closest_hero waittill( #"goal" );
        closest_hero clearforcedgoal();
        closest_hero ai::set_ignoreall( 0 );
        a_allies = getentarray( team, "script_noteworthy" );
        
        foreach ( ai in a_allies )
        {
            if ( isdefined( ai.old_radius ) )
            {
                ai.goalradius = ai.old_radius;
                ai.old_radius = undefined;
            }
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xbc4867b, Offset: 0x4378
// Size: 0x84
function building_destruction_init()
{
    a_building_dest_trigs = getentarray( "building_trigs", "targetname" );
    a_building_dest_trigs array::thread_all( a_building_dest_trigs, &building_destruction_watcher );
    
    if ( level.current_skipto == "vtol_arrival" )
    {
        level thread vtol_arrival_building();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x64a5fc4e, Offset: 0x4408
// Size: 0x180
function building_destruction_watcher()
{
    self.n_destroyed = 0;
    self.scene_num = 1;
    
    if ( isdefined( self.script_int ) )
    {
        self.scene_num = self.script_int;
    }
    
    level.ai_sarah endon( #"death" );
    level flag::wait_till( "vtol_intro_complete" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who == level.ai_sarah )
        {
            if ( self.script_noteworthy === "building_b" && self.n_destroyed == 0 )
            {
                level notify( #"sarah_building_b_init" );
                level.ai_sarah.dontchangestate = 1;
            }
            
            if ( self.scene_num <= 2 )
            {
                level thread function_3c458698( self.scene_num );
            }
            else
            {
                level clientfield::set( "building_destruction_callback", self.scene_num );
            }
            
            self.n_destroyed++;
            self.scene_num++;
            
            if ( self.n_destroyed == 2 )
            {
                return;
            }
            
            while ( who istouching( self ) )
            {
                wait 0.1;
            }
        }
        
        wait 0.1;
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xd2f8526c, Offset: 0x4590
// Size: 0x104
function vtol_arrival_building()
{
    t_sarah_building = getent( "building_a", "script_noteworthy" );
    t_sarah_building.n_destroyed = 0;
    t_sarah_building.scene_num = 1;
    level waittill( #"sarah_explode_building" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level function_3c458698( t_sarah_building.scene_num );
    }
    else
    {
        level thread function_8f97d54e( 1 );
    }
    
    t_sarah_building.n_destroyed++;
    t_sarah_building.scene_num++;
    level waittill( #"sarah_bash_end" );
    level flag::set( "vtol_intro_complete" );
}

// Namespace sarah_battle
// Params 0
// Checksum 0xbb17f1c6, Offset: 0x46a0
// Size: 0xae
function rocket_launcher_init()
{
    launchers = getentarray( "sarah_battle_launcher", "targetname" );
    
    for ( i = 0; i < launchers.size ; i++ )
    {
        if ( isdefined( launchers[ i ].script_int ) && launchers[ i ].script_int > level.players.size )
        {
            launchers[ i ] delete();
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xf183c349, Offset: 0x4758
// Size: 0x198
function magic_bullet_rpg()
{
    level.ai_sarah endon( #"death" );
    a_s_start_points = struct::get_array( "sarah_battle_magic_rpg", "targetname" );
    weapon = getweapon( "launcher_standard" );
    
    while ( true )
    {
        s_start_point = array::random( a_s_start_points );
        v_target = level.ai_sarah.origin;
        v_end_point = ( v_target[ 0 ] + randomfloatrange( 100 * -1, 100 ), v_target[ 1 ] + randomfloatrange( 100 * -1, 100 ), v_target[ 2 ] + randomfloatrange( 100 * -1, 100 ) );
        magicbullet( weapon, s_start_point.origin, v_end_point );
        wait randomfloatrange( 2, 6 );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xe9ecda7, Offset: 0x48f8
// Size: 0x124
function crashed_vtol_explosion()
{
    s_exposion_pos = struct::get( "crashed_vtol_explosion", "targetname" );
    
    if ( !isdefined( s_exposion_pos ) )
    {
        return;
    }
    
    forward = anglestoforward( s_exposion_pos.angles );
    
    for ( player = array::random( level.players ); true ; player = array::random( level.players ) )
    {
        if ( player infection_util::islookingatstruct( s_exposion_pos ) )
        {
            playfx( level._effect[ "crashed_vtol_exp_fx" ], s_exposion_pos.origin, forward );
            return;
        }
        
        wait 0.1;
        
        if ( !isdefined( player ) )
        {
        }
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x7852668a, Offset: 0x4a28
// Size: 0x228
function friendly_ai_controller()
{
    level.ai_sarah endon( #"death" );
    level.ai_khalil = util::get_hero( "khalil" );
    level thread function_acea9315();
    level thread function_cc12870c();
    level thread function_5acf54bf();
    spawner::add_spawn_function_ai_group( "initial_egypt_army", &function_278b6566 );
    spawner::add_spawn_function_ai_group( "reinforce_egypt_army", &function_ed2505ff );
    spawner::simple_spawn( "sp_ally_egypt_army" );
    level flag::set( "sarah_battle_friendly_spawned" );
    spawner::waittill_ai_group_amount_killed( "initial_egypt_army", 4 );
    var_e2f02570 = getentarray( "t_reinforce", "targetname" );
    var_e2f02570 = array::randomize( var_e2f02570 );
    
    foreach ( t_reinforce in var_e2f02570 )
    {
        t_reinforce trigger::use();
        wait randomfloatrange( 7, 12 );
        level notify( #"reinforcements_arrived" );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x8e262280, Offset: 0x4c58
// Size: 0x34
function function_278b6566()
{
    self setgoal( level.ai_khalil, 0, 1024 );
    self.script_noteworthy = "team_khalil";
}

// Namespace sarah_battle
// Params 0
// Checksum 0x6a78b7ec, Offset: 0x4c98
// Size: 0x154
function function_ed2505ff()
{
    self endon( #"death" );
    self.overrideactordamage = &friendly_callback_damage;
    self.accuracy = 0.2;
    self ai::set_ignoreme( 1 );
    self waittill( #"exited_vehicle" );
    e_goal_volume = getent( "goal_volume_" + self.script_string, "targetname" );
    self setgoal( e_goal_volume );
    self waittill( #"goal" );
    self ai::set_ignoreme( 0 );
    wait 10;
    
    if ( math::cointoss() )
    {
        self setgoal( level.ai_khalil, 0, 1024 );
        self.script_noteworthy = "team_khalil";
        return;
    }
    
    self setgoal( level.ai_hendricks, 0, 1024 );
    self.script_noteworthy = "team_hendricks";
}

// Namespace sarah_battle
// Params 13
// Checksum 0xfb768831, Offset: 0x4df8
// Size: 0xa6
function friendly_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( weapon == getweapon( "spike_charge_siegebot_theia" ) )
    {
        idamage = self.health + 100;
    }
    
    return idamage;
}

// Namespace sarah_battle
// Params 0
// Checksum 0xd234a773, Offset: 0x4ea8
// Size: 0xb8
function function_acea9315()
{
    spawner::add_spawn_function_ai_group( "friendly_wasp", &function_6c7a52c3 );
    
    while ( !level flag::get( "sarah_defeated" ) )
    {
        if ( spawner::get_ai_group_sentient_count( "friendly_wasp" ) < 3 )
        {
            spawner::simple_spawn_single( "mg_wasp_ally" );
        }
        
        wait randomfloatrange( 3, 8 );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x4b9f7656, Offset: 0x4f68
// Size: 0xb4
function function_6c7a52c3()
{
    self endon( #"death" );
    self.var_66ff806d = 1;
    self.accuracy_turret = 0.2;
    self.no_group = 1;
    self setteam( "allies" );
    wait randomfloatrange( 15, 25 );
    
    if ( !level flag::get( "sarah_defeated" ) )
    {
        self kill();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x624881e2, Offset: 0x5028
// Size: 0x13a
function function_b3d20adf()
{
    level flag::wait_till( "sarah_defeated" );
    var_6e403395 = getentarray( "amws_ally_intro_ai", "targetname" );
    var_6e403395 = arraycombine( var_6e403395, getentarray( "amws_ally_ai", "targetname" ), 0, 0 );
    
    foreach ( var_69837b75 in var_6e403395 )
    {
        var_69837b75 ai::set_ignoreall( 1 );
        var_69837b75.goalradius = 16;
        var_69837b75 vehicle_ai::start_scripted();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x1f1f1d5, Offset: 0x5170
// Size: 0xf8
function function_cc12870c()
{
    level thread function_b3d20adf();
    
    while ( !level flag::get( "sarah_defeated" ) )
    {
        if ( spawner::get_ai_group_sentient_count( "friendly_amws" ) < 2 )
        {
            ai_amws = spawner::simple_spawn_single( "amws_ally" );
            ai_amws.accuracy_turret = 0.2;
            ai_amws.health = 130;
            ai_amws setteam( "allies" );
        }
        
        wait randomfloatrange( 10, 20 );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x244f543d, Offset: 0x5270
// Size: 0x126
function hero_check_distance()
{
    self endon( #"death" );
    level.ai_sarah endon( #"death" );
    
    while ( true )
    {
        n_dist = distance( self.origin, level.ai_sarah.origin );
        
        if ( n_dist < 256 || n_dist > 1200 )
        {
            self ai::set_ignoreall( 1 );
            nd_cover = find_good_coverpos( level.ai_sarah.origin );
            self ai::force_goal( nd_cover, 32, 1 );
            self waittill( #"goal" );
            self clearforcedgoal();
            self ai::set_ignoreall( 0 );
        }
        
        wait 1;
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x50ec6321, Offset: 0x53a0
// Size: 0x15e
function find_good_coverpos( v_pos )
{
    var_9b71f11e = getnodearray( "hero_cover", "targetname" );
    var_8cc07584 = var_9b71f11e[ 0 ];
    n_dist = 0;
    
    foreach ( node in var_9b71f11e )
    {
        var_c4e1f800 = distance( v_pos, node.origin );
        
        if ( var_c4e1f800 > n_dist && var_c4e1f800 > 256 && var_c4e1f800 < 1200 && !isnodeoccupied( node ) )
        {
            var_8cc07584 = node;
            n_dist = var_c4e1f800;
        }
    }
    
    return var_8cc07584;
}

// Namespace sarah_battle
// Params 0
// Checksum 0x7cfd0313, Offset: 0x5508
// Size: 0x84
function function_5acf54bf()
{
    level.ai_sarah endon( #"death" );
    level waittill( #"sarah_building_b_init" );
    level thread technical_vehicle_spawn( "veh_spawn_technical_1", 1 );
    spawner::waittill_ai_group_ai_count( "initial_egypt_army", 4 );
    level thread technical_vehicle_spawn( "veh_spawn_technical_2" );
}

// Namespace sarah_battle
// Params 2
// Checksum 0x4829c9f6, Offset: 0x5598
// Size: 0x25c
function technical_vehicle_spawn( tech_veh_name, b_scene )
{
    if ( !isdefined( b_scene ) )
    {
        b_scene = 0;
    }
    
    if ( !isdefined( tech_veh_name ) )
    {
        return;
    }
    
    e_spawner = getent( tech_veh_name, "targetname" );
    vh_techical = spawner::simple_spawn_single( e_spawner );
    
    if ( !isdefined( vh_techical ) )
    {
        return;
    }
    
    ai_driver = spawner::simple_spawn_single( "technical_driver" );
    ai_driver thread vehicle::get_in( vh_techical, "driver", 1 );
    ai_gunner = spawner::simple_spawn_single( "technical_gunner" );
    ai_gunner thread vehicle::get_in( vh_techical, "gunner1", 1 );
    vehicle_start = getvehiclenode( tech_veh_name + "_start", "targetname" );
    vh_techical thread vehicle::get_on_and_go_path( vehicle_start );
    vh_techical util::magic_bullet_shield();
    vh_techical waittill( #"reached_end_node" );
    
    if ( isdefined( b_scene ) && b_scene )
    {
        vh_techical.driver = ai_driver;
        vh_techical.gunner = ai_gunner;
        level.ai_sarah thread sarah_bash_technical( vh_techical );
        return;
    }
    
    vh_techical util::stop_magic_bullet_shield();
    
    if ( isalive( ai_driver ) )
    {
        ai_driver thread vehicle::get_out();
    }
    
    if ( isalive( ai_gunner ) )
    {
        ai_gunner thread vehicle::get_out();
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xac61aace, Offset: 0x5800
// Size: 0x124
function sarah_bash_technical( vehicle )
{
    vehicle.gunner.targetname = "truck_gunner";
    level util::waittill_either( "theia_finished_platform_attack", "theia_preparing_javelin_attack" );
    vehicle delete();
    vehicle.driver delete();
    self vehicle_ai::start_scripted();
    self scene::play( "cin_inf_02_01_vign_interface_siegebot_bash_2", self );
    self vehicle_ai::set_state( "groundCombat" );
    self.dontchangestate = 0;
    
    if ( isdefined( level.sarah_bash2_clip ) )
    {
        level.sarah_bash2_clip solid();
        level.sarah_bash2_clip disconnectpaths();
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x57e61823, Offset: 0x5930
// Size: 0x4c
function sarah_truck_bash_2( a_ents )
{
    a_ents[ "sarah_siegebot" ] waittill( #"truck_crash" );
    a_ents[ "truck_bash" ] setmodel( "veh_t7_civ_truck_pickup_tech_egypt_dead" );
}

// Namespace sarah_battle
// Params 11
// Checksum 0x49515ad5, Offset: 0x5988
// Size: 0xcc
function player_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    minspikedamageinterval = 3;
    
    if ( weapon == getweapon( "spike_charge_siegebot_theia" ) )
    {
        if ( isdefined( self._last_spike_damage_time ) && self._last_spike_damage_time + minspikedamageinterval * 1000 > gettime() )
        {
            return 0;
        }
        else
        {
            self._last_spike_damage_time = gettime();
        }
    }
    
    return idamage;
}

// Namespace sarah_battle
// Params 2
// Checksum 0xfb77bfdb, Offset: 0x5a60
// Size: 0x324
function sarah_battle_end_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x4c>" );
    #/
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        hendricks_start_pos = struct::get( "hendricks_start_pos_sarah_battle_end", "targetname" );
        level.ai_hendricks forceteleport( hendricks_start_pos.origin, hendricks_start_pos.angles );
        level.ai_khalil = util::get_hero( "khalil" );
        khalil_start_pos = struct::get( "khalil_start_pos_sarah_battle_end", "targetname" );
        level.ai_khalil forceteleport( khalil_start_pos.origin, khalil_start_pos.angles );
        spawn_sarah_boss( b_starting );
        level.ai_sarah vehicle_ai::set_state( "groundCombat" );
        level.ai_sarah util::stop_magic_bullet_shield();
        level.ai_sarah siegebot_theia::pain_toggle( 0 );
        level.ai_sarah vehicle::lights_off();
        level.ai_sarah dodamage( level.ai_sarah.health + 10000, level.ai_sarah.origin, level.players[ 0 ] );
    }
    
    level thread monitor_seigebot_sarah_end();
    
    if ( b_starting )
    {
        function_48e3f00e();
        exploder::exploder( "sarah_battle_vtol_crash_fire" );
        exploder::exploder( "sarah_battle_fire" );
        level flag::set( "vtol_intro_complete" );
        level clientfield::set( "building_end_callback", 1 );
        level thread function_8f97d54e( 1 );
        level thread function_8f97d54e( 2 );
        level thread send_friendlies_remaining();
        load::function_a2995f22();
    }
    
    battlechatter::function_d9f49fba( 0 );
}

// Namespace sarah_battle
// Params 1
// Checksum 0xc10d79cc, Offset: 0x5d90
// Size: 0xa6
function open_lui_menu( str_menu )
{
    foreach ( e_player in level.players )
    {
        e_player.infection_temp_menu = e_player openluimenu( str_menu );
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x2a3a51e7, Offset: 0x5e40
// Size: 0xb8
function close_lui_menu()
{
    foreach ( e_player in level.players )
    {
        if ( isdefined( e_player.infection_temp_menu ) )
        {
            e_player closeluimenu( e_player.infection_temp_menu );
            e_player.infection_temp_menu = undefined;
        }
    }
}

// Namespace sarah_battle
// Params 4
// Checksum 0x27a62c40, Offset: 0x5f00
// Size: 0x94
function vtol_arrival_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:x62>" );
    #/
    
    level clientfield::set( "vtol_fog_bank", 0 );
    objectives::complete( "cp_level_infection_find_dr" );
    function_cf47c514( 0 );
}

// Namespace sarah_battle
// Params 4
// Checksum 0x9a6ffe0, Offset: 0x5fa0
// Size: 0x74
function sarah_battle_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:x74>" );
    #/
    
    util::delay( 0.1, undefined, &function_cf47c514, 1 );
}

// Namespace sarah_battle
// Params 4
// Checksum 0x8f6092e8, Offset: 0x6020
// Size: 0xae
function sarah_battle_end_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:x86>" );
    #/
    
    allies = getaiteamarray( "allies" );
    
    for ( i = 0; i < allies.size ; i++ )
    {
        allies[ i ] delete();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0xd1c14c54, Offset: 0x60d8
// Size: 0x90
function clean_up()
{
    level.overrideplayerdamage = undefined;
    
    foreach ( player in level.players )
    {
        self._last_spike_damage_time = undefined;
        self._spawn_time = undefined;
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xf7ad56d7, Offset: 0x6170
// Size: 0x7c
function function_cf47c514( b_enable )
{
    var_2a95256 = getent( "sarah_siegebot_death_clip", "targetname" );
    
    if ( isdefined( var_2a95256 ) )
    {
        if ( b_enable )
        {
            var_2a95256 show();
            return;
        }
        
        var_2a95256 hide();
    }
}

// Namespace sarah_battle
// Params 0
// Checksum 0x7af243d8, Offset: 0x61f8
// Size: 0x1bc
function monitor_seigebot_sarah_end()
{
    e_anchor = util::spawn_model( "tag_origin", level.ai_sarah.origin, level.ai_sarah.angles );
    e_anchor.targetname = "tag_align_sarah";
    clean_up();
    scene::add_scene_func( "cin_inf_03_01_interface_1st_dni_02", &function_ed02c344, "init" );
    level scene::init( "cin_inf_03_01_interface_1st_dni_02" );
    level thread vo_sarah_interface_init();
    level flag::wait_till( "sarah_interface_done" );
    level.ai_hendricks util::unmake_hero( "hendricks" );
    level.ai_hendricks util::self_delete();
    level.ai_khalil util::unmake_hero( "khalil" );
    level.ai_khalil util::self_delete();
    
    if ( isdefined( level.var_156d60f ) )
    {
        level.var_156d60f delete();
    }
    
    e_anchor delete();
    skipto::objective_completed( "sarah_battle_end" );
}

// Namespace sarah_battle
// Params 1
// Checksum 0x50111cb4, Offset: 0x63c0
// Size: 0x302
function function_ed02c344( a_ents )
{
    wait 1;
    var_7d116593 = struct::get( "s_sim_reality_lighting_hint", "targetname" );
    level thread infection_util::function_7aca917c( var_7d116593.origin );
    var_b7f41419 = spawn( "trigger_radius_use", a_ents[ "sarah_driver" ].origin + ( 0, 0, 15 ), 0, 125, 144 );
    var_b7f41419 triggerignoreteam();
    var_b7f41419 setvisibletoall();
    var_b7f41419 setteamfortrigger( "none" );
    var_b7f41419 usetriggerrequirelookat();
    
    /#
        debugstar( var_b7f41419.origin, 1000, ( 1, 0, 0 ) );
    #/
    
    var_b7f41419.e_gameobject = util::init_interactive_gameobject( var_b7f41419, &"cp_level_infection_interface_sarah", &"CP_MI_CAIRO_INFECTION_T_DNI", &function_795efef );
    
    while ( true )
    {
        var_b7f41419 waittill( #"hash_6453bafb", player );
        level thread namespace_eccdd5d1::function_a693b757();
        
        if ( isplayer( player ) )
        {
            var_b7f41419.e_gameobject gameobjects::disable_object();
            var_b7f41419 delete();
            objectives::complete( "cp_level_infection_interface_sarah" );
            level flag::set( "sarah_interface_started" );
            
            if ( isdefined( level.bzm_infectiondialogue2callback ) )
            {
                level thread [[ level.bzm_infectiondialogue2callback ]]();
            }
            
            level.var_efa959f1 = 0;
            scene::add_scene_func( "cin_inf_03_01_interface_1st_dni_02", &function_271fa79e, "skip_completed" );
            level thread scene::play( "cin_inf_03_01_interface_1st_dni_02", player );
            level thread sim_reality_starts::function_f6fce5f1();
            function_3b4ccd2e();
            level flag::set( "sarah_interface_done" );
            return;
        }
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x9a2c7470, Offset: 0x66d0
// Size: 0x18
function function_271fa79e( a_ents )
{
    level.var_efa959f1 = 1;
}

// Namespace sarah_battle
// Params 0
// Checksum 0xb59cb62f, Offset: 0x66f0
// Size: 0x4e
function function_3b4ccd2e()
{
    var_85c195bd = 0;
    
    while ( var_85c195bd < 24 && !level.var_efa959f1 )
    {
        wait 0.1;
        var_85c195bd += 0.1;
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xee762a10, Offset: 0x6748
// Size: 0x24
function function_795efef( player )
{
    self.trigger notify( #"hash_6453bafb", player );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x646223ed, Offset: 0x6778
// Size: 0x174
function monitor_sarah_battle()
{
    level scene::play( "cin_inf_02_01_vign_interface_siegebot_bash" );
    level scene::init( "cin_inf_02_01_vign_interface_siegebot_death" );
    level.var_156d60f thread function_76887c27();
    level.ai_sarah ai::set_ignoreall( 0 );
    level.ai_sarah vehicle_ai::stop_scripted( "groundCombat" );
    level thread magic_bullet_rpg();
    level thread sarah_spike_launcher_watcher();
    level.ai_sarah waittill( #"death" );
    level thread namespace_eccdd5d1::function_973b77f9();
    level flag::set( "sarah_defeated" );
    objectives::complete( "cp_level_infection_defeat_sarah" );
    level scene::play( "cin_inf_02_01_vign_interface_siegebot_death" );
    skipto::objective_completed( "sarah_battle" );
    level thread send_friendlies_remaining();
}

// Namespace sarah_battle
// Params 0
// Checksum 0x921e6b1e, Offset: 0x68f8
// Size: 0x24
function function_76887c27()
{
    level.ai_sarah thread scene::play( "cin_inf_01_01_vtolarrival_1st_encounter_sarah_cockpit_loop", self );
}

// Namespace sarah_battle
// Params 1
// Checksum 0xf406617b, Offset: 0x6928
// Size: 0xfc
function function_68861104( a_ents )
{
    var_1e13503b = a_ents[ "sarah_truck_bash" ];
    var_1e13503b.do_scripted_crash = 0;
    var_1e13503b.deathmodel_attached = 1;
    var_1e13503b waittill( #"explode" );
    var_1e13503b notify( #"death" );
    var_1e13503b setmodel( var_1e13503b.deathmodel );
    s_siegebot_bash_explosion = struct::get( "s_siegebot_bash_explosion", "targetname" );
    level.ai_sarah magicgrenadetype( getweapon( "frag_grenade" ), s_siegebot_bash_explosion.origin, ( 0, 0, 1 ), 0 );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x305a1e52, Offset: 0x6a30
// Size: 0x37a
function send_friendlies_remaining()
{
    a_allies = getaispeciesarray( "allies", "human" );
    a_all_cover = getnodearray( "nd_post_sarah", "script_noteworthy" );
    var_51c45f53 = getnodearray( "nd_post_sarah_hendricks", "script_noteworthy" );
    var_a7b9f562 = a_all_cover.size + 1;
    
    for ( i = 0; i < a_allies.size ; i++ )
    {
        if ( isalive( a_allies[ i ] ) && !a_allies[ i ] util::is_hero() )
        {
            b_can_delete = 1;
            
            foreach ( e_player in level.activeplayers )
            {
                if ( e_player util::is_player_looking_at( a_allies[ i ].origin + ( 0, 0, 40 ) ) )
                {
                    b_can_delete = 0;
                }
            }
            
            if ( b_can_delete )
            {
                a_allies[ i ] kill();
            }
        }
    }
    
    var_bc0bb597 = 0;
    
    foreach ( e_ally in a_allies )
    {
        if ( isalive( e_ally ) )
        {
            e_ally.goalradius = 128;
            e_ally clearentitytarget();
            e_ally cleargoalvolume();
            e_ally clearforcedgoal();
            e_ally ai::set_ignoreall( 1 );
            
            if ( e_ally == level.ai_hendricks )
            {
                e_ally setgoal( var_51c45f53[ 0 ], 1 );
                continue;
            }
            
            e_ally setgoal( a_all_cover[ var_bc0bb597 ], 1, 128, 128 );
            var_bc0bb597++;
            
            if ( var_bc0bb597 == a_all_cover.size )
            {
                return;
            }
        }
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xb97747cb, Offset: 0x6db8
// Size: 0xc4
function send_to_sarah( end_pos )
{
    self endon( #"death" );
    self endon( #"goal" );
    level endon( #"sarah_interface_started" );
    n_engage_dist = randomintrange( 128, 256 );
    v_to_sarah = vectornormalize( self.origin - end_pos ) * n_engage_dist;
    v_goal = end_pos + v_to_sarah;
    self setgoalpos( v_goal, 1 );
}

// Namespace sarah_battle
// Params 0
// Checksum 0x1fe9e2a, Offset: 0x6e88
// Size: 0xbe
function function_48e3f00e()
{
    for ( i = 1; i <= 2 ; i++ )
    {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
        s_test = struct::get( str_name, "scriptbundlename" );
        
        if ( isdefined( s_test ) )
        {
            level thread scene::init( str_name );
        }
        
        function_6712dcb2( "m_sarah_building_0" + i, 0 );
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0x33590271, Offset: 0x6f50
// Size: 0xa4
function function_3c458698( var_b6dcd715 )
{
    str_name = "p7_fxanim_cp_infection_sarah_building_0" + var_b6dcd715 + "_bundle";
    s_test = struct::get( str_name, "scriptbundlename" );
    
    if ( isdefined( s_test ) )
    {
        level scene::play( str_name );
        function_6712dcb2( "m_sarah_building_0" + var_b6dcd715, 1 );
    }
}

// Namespace sarah_battle
// Params 1
// Checksum 0xd91448ba, Offset: 0x7000
// Size: 0x7c
function function_8f97d54e( var_b6dcd715 )
{
    str_name = "p7_fxanim_cp_infection_sarah_building_0" + var_b6dcd715 + "_bundle";
    s_test = struct::get( str_name, "scriptbundlename" );
    
    if ( isdefined( s_test ) )
    {
        level thread scene::skipto_end( str_name );
    }
}

// Namespace sarah_battle
// Params 2
// Checksum 0x6cb4bb41, Offset: 0x7088
// Size: 0x15a
function function_6712dcb2( str_targetname, b_show )
{
    if ( !isdefined( b_show ) )
    {
        b_show = 1;
    }
    
    var_5cee1345 = getentarray( str_targetname, "targetname" );
    
    if ( b_show )
    {
        foreach ( model in var_5cee1345 )
        {
            model show();
        }
        
        return;
    }
    
    foreach ( model in var_5cee1345 )
    {
        model ghost();
    }
}

