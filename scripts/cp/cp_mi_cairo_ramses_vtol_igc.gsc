#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_quad_tank_plaza;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_raps;

#namespace vtol_igc;

// Namespace vtol_igc
// Params 1
// Checksum 0x8fafbc82, Offset: 0xc58
// Size: 0xac
function vtol_igc_main( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    precache();
    level flag::init( "vtol_igc_robots_alerted" );
    level flag::init( "vtol_igc_robots_dead" );
    level flag::init( "hendricks_at_vtol_igc" );
    setup_vtol_igc( b_starting );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x99ec1590, Offset: 0xd10
// Size: 0x4
function precache()
{
    
}

// Namespace vtol_igc
// Params 0
// Checksum 0xb3d043bc, Offset: 0xd20
// Size: 0x222
function hide_skipto_items()
{
    a_hide_me = getentarray( "hide_me", "script_noteworthy" );
    
    foreach ( e_hide_me in a_hide_me )
    {
        if ( isdefined( e_hide_me ) )
        {
            e_hide_me hide();
        }
    }
    
    a_hide_me = getentarray( "hide_vtol_robots", "script_noteworthy" );
    
    foreach ( e_hide_me in a_hide_me )
    {
        if ( isdefined( e_hide_me ) )
        {
            e_hide_me hide();
        }
    }
    
    a_alley_bridge_destroyed_pieces = getentarray( "alley_bridge_destroyed", "targetname" );
    
    foreach ( e_pieces in a_alley_bridge_destroyed_pieces )
    {
        e_pieces hide();
    }
}

// Namespace vtol_igc
// Params 1
// Checksum 0x287cb7d5, Offset: 0xf50
// Size: 0x6f4
function setup_vtol_igc( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    level thread vtol_igc_notetracks();
    level thread hide_vtol_wings();
    level notify( #"sndvtolcollapse1" );
    level thread setaudio_snapshot();
    level thread function_3659e172();
    var_e8fa0050 = spawn( "script_origin", ( 8190, -16469, 418 ) );
    var_9cf50b7e = spawn( "script_origin", ( 7934, -15639, 351 ) );
    var_e8fa0050 playloopsound( "evt_outside_battle_l", 0.25 );
    var_9cf50b7e playloopsound( "evt_outside_battle_r", 0.25 );
    array::run_all( getentarray( "lgt_vtol_block", "targetname" ), &hide );
    
    if ( !b_starting )
    {
        level scene::init( "cin_ram_06_05_safiya_1st_friendlydown_init" );
    }
    
    util::wait_network_frame();
    level scene::init( "cin_ram_06_05_safiya_aie_breakin_pilotshoots" );
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &function_e78f7ba0, "play" );
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc_done, "done" );
    t_use_vtol_igc = getent( "trig_use_vtol_igc", "targetname" );
    t_use_vtol_igc setinvisibletoall();
    util::wait_network_frame();
    level thread init_robot_breakin_vignette();
    trigger::wait_till( "trig_spawn_vtol_igc" );
    objectives::complete( "cp_level_ramses_go_to_safiya" );
    level thread vtol_igc_vo();
    quad_tank_plaza::pre_skipto();
    level thread initial_hendricks_scripting();
    level thread breakin_pilotshoots_scene();
    spawner::waittill_ai_group_cleared( "vtol_robots" );
    level flag::set( "vtol_igc_robots_dead" );
    level.ai_hendricks thread hendricks_vtol_igc_start_notetrack();
    level thread util::set_streamer_hint( 3 );
    level scene::init( "cin_ram_06_05_safiya_1st_friendlydown" );
    level flag::wait_till( "hendricks_at_vtol_igc" );
    t_use_vtol_igc setvisibletoall();
    s_use_trigger_gameobject = util::init_interactive_gameobject( t_use_vtol_igc, &"cp_level_ramses_vtol_use", &"CP_MI_CAIRO_RAMSES_VTOL_IGC_TRIG", &callback_gameobject_vtol_igc_trigger_on_use );
    level flag::wait_till( "vtol_igc_trigger_used" );
    
    if ( isdefined( level.bzm_ramsesdialogue7callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue7callback ]]();
    }
    
    objectives::complete( "cp_level_ramses_vtol_use" );
    var_e8fa0050 stoploopsound( 2 );
    var_9cf50b7e stoploopsound( 2 );
    level util::clientnotify( "vtligc" );
    level thread namespace_a6a248fc::function_bb3105cf();
    battlechatter::function_d9f49fba( 0 );
    s_use_trigger_gameobject gameobjects::destroy_object();
    level thread function_6ee65e7a();
    a_alley_egypt_intro_guy = getentarray( "alley_egypt_intro_guy_ai", "targetname" );
    
    foreach ( e_guy in a_alley_egypt_intro_guy )
    {
        e_guy delete();
    }
    
    a_alley_egypt_mid_guy = getentarray( "alley_egypt_mid_guy_ai", "targetname" );
    
    foreach ( e_guy in a_alley_egypt_mid_guy )
    {
        e_guy delete();
    }
    
    level flag::wait_till( "vtol_igc_done" );
    var_e8fa0050 delete();
    var_9cf50b7e delete();
    level util::clientnotify( "pst" );
    skipto::objective_completed( "vtol_igc" );
}

// Namespace vtol_igc
// Params 1
// Checksum 0x2526f047, Offset: 0x1650
// Size: 0x6c
function function_6ee65e7a( a_ents )
{
    level waittill( #"hash_8456258f" );
    nd_hendricks = getnode( "qtp_hendricks_start_node", "targetname" );
    level.ai_hendricks setgoal( nd_hendricks, 0, 32 );
}

// Namespace vtol_igc
// Params 1
// Checksum 0x7922ba71, Offset: 0x16c8
// Size: 0x16c
function function_2e3a3b68( a_ents )
{
    var_2aa82b86 = a_ents[ "cin_ram_06_05_safiya_1st_friendlydown_vtol01" ];
    str_model = "veh_t7_mil_vtol_egypt_nose_glass_d1";
    var_2aa82b86 function_1e5c6903( 1, "" );
    var_2aa82b86 function_1e5c6903( 0, "_d1" );
    var_2aa82b86 function_1e5c6903( 1, "_d2" );
    var_2aa82b86 hidepart( "tag_glass4_d3_animate", str_model, 1 );
    level waittill( #"hash_495be65c" );
    var_2aa82b86 function_1e5c6903( 1, "_d1" );
    var_2aa82b86 function_1e5c6903( 0, "_d2" );
    level waittill( #"hash_6f5e60c5" );
    var_2aa82b86 hidepart( "tag_glass4_d2_animate", str_model, 1 );
    var_2aa82b86 showpart( "tag_glass4_d3_animate", str_model, 1 );
}

// Namespace vtol_igc
// Params 2
// Checksum 0xba89d409, Offset: 0x1840
// Size: 0x2a4
function function_1e5c6903( b_hide, str_state )
{
    if ( !isdefined( b_hide ) )
    {
        b_hide = 1;
    }
    
    if ( !isdefined( str_state ) )
    {
        str_state = "";
    }
    
    str_model = "veh_t7_mil_vtol_egypt_nose_glass_d1";
    
    if ( b_hide )
    {
        self hidepart( "tag_glass" + str_state + "_animate", str_model, 1 );
        self hidepart( "tag_glass1" + str_state + "_animate", str_model, 1 );
        self hidepart( "tag_glass2" + str_state + "_animate", str_model, 1 );
        self hidepart( "tag_glass3" + str_state + "_animate", str_model, 1 );
        self hidepart( "tag_glass4" + str_state + "_animate", str_model, 1 );
        self hidepart( "tag_glass5" + str_state + "_animate", str_model, 1 );
        return;
    }
    
    self showpart( "tag_glass" + str_state + "_animate", str_model, 1 );
    self showpart( "tag_glass1" + str_state + "_animate", str_model, 1 );
    self showpart( "tag_glass2" + str_state + "_animate", str_model, 1 );
    self showpart( "tag_glass3" + str_state + "_animate", str_model, 1 );
    self showpart( "tag_glass4" + str_state + "_animate", str_model, 1 );
    self showpart( "tag_glass5" + str_state + "_animate", str_model, 1 );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x385609ba, Offset: 0x1af0
// Size: 0x280
function function_3659e172()
{
    s_vtol = struct::get( "vtol_objective" );
    objectives::set( "cp_waypoint_breadcrumb", s_vtol );
    level waittill( #"hash_ca2d8f8" );
    objectives::hide( "cp_waypoint_breadcrumb" );
    
    while ( !level flag::get( "vtol_igc_robots_dead" ) )
    {
        wait 0.5;
        
        foreach ( player in level.activeplayers )
        {
            if ( !isdefined( player.var_fbf99626 ) )
            {
                player.var_fbf99626 = 0;
            }
            
            if ( distance( s_vtol.origin, player.origin ) > 1000 )
            {
                if ( player.var_fbf99626 == 0 )
                {
                    objectives::show( "cp_waypoint_breadcrumb", player );
                    player.var_fbf99626 = 1;
                }
                
                continue;
            }
            
            if ( player.var_fbf99626 == 1 )
            {
                objectives::hide( "cp_waypoint_breadcrumb", player );
                player.var_fbf99626 = 0;
            }
        }
    }
    
    objectives::complete( "cp_waypoint_breadcrumb", s_vtol );
    
    foreach ( player in level.players )
    {
        player.var_fbf99626 = undefined;
    }
}

// Namespace vtol_igc
// Params 1
// Checksum 0xdd3bfed6, Offset: 0x1d78
// Size: 0x94
function callback_gameobject_vtol_igc_trigger_on_use( e_player )
{
    level flag::set( "vtol_igc_trigger_used" );
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &function_2e3a3b68, "play" );
    level thread scene::play( "cin_ram_06_05_safiya_1st_friendlydown", e_player );
    self gameobjects::disable_object();
}

// Namespace vtol_igc
// Params 1
// Checksum 0x8e4b8832, Offset: 0x1e18
// Size: 0x13c
function vtol_igc_notetracks( b_vtol_igc_skipto )
{
    if ( !isdefined( b_vtol_igc_skipto ) )
    {
        b_vtol_igc_skipto = 0;
    }
    
    level flag::init( "vtol_igc_started" );
    ramses_util::co_op_teleport_on_igc_end( "cin_ram_06_05_safiya_1st_friendlydown", "vtol_igc_teleport" );
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc_started, "play" );
    level thread through_fire_notetrack();
    exploder::exploder( "fx_expl_vtol_int" );
    
    if ( !b_vtol_igc_skipto )
    {
        level thread stop_exploder_vtol_int();
        exploder::exploder( "fx_expl_igc_vtol_ext_smoke" );
        level thread stop_exploder_ext_smoke();
    }
    
    level thread function_c887803();
    level thread truck_hit_notetrack();
}

// Namespace vtol_igc
// Params 1
// Checksum 0x6eb84db5, Offset: 0x1f60
// Size: 0x6c
function vtol_igc_started( a_ents )
{
    level flag::set( "vtol_igc_started" );
    array::run_all( getentarray( "lgt_vtol_block", "targetname" ), &show );
}

// Namespace vtol_igc
// Params 1
// Checksum 0xd0394e3c, Offset: 0x1fd8
// Size: 0x13c
function function_e78f7ba0( a_ents )
{
    level waittill( #"hash_1560247e" );
    showmiscmodels( "qtp_vtol_nose" );
    e_vtol = a_ents[ "cin_ram_06_05_safiya_1st_friendlydown_vtol01" ];
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_igc_nose", 1 );
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_cockpit_d0", 1 );
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_d1", 1 );
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_glass_d1", 1 );
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_d0", 1 );
    e_vtol hidepart( "tag_nose_animate", "veh_t7_mil_vtol_egypt_screens_d1", 1 );
}

// Namespace vtol_igc
// Params 1
// Checksum 0xf0239e60, Offset: 0x2120
// Size: 0x94
function vtol_igc_done( a_ents )
{
    level flag::set( "vtol_igc_done" );
    exploder::exploder_stop( "fx_expl_qtplaza_hotel" );
    array::run_all( getentarray( "lgt_vtol_block", "targetname" ), &hide );
    util::clear_streamer_hint();
}

// Namespace vtol_igc
// Params 0
// Checksum 0x4ff78203, Offset: 0x21c0
// Size: 0x54
function init_robot_breakin_vignette()
{
    scene::add_scene_func( "cin_ram_06_05_safiya_aie_breakin_02", &robot_breakin_init_scene_func, "init" );
    level thread scene::init( "cin_ram_06_05_safiya_aie_breakin_02" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x970c0ae3, Offset: 0x2220
// Size: 0xa4
function breakin_pilotshoots_scene()
{
    scene::add_scene_func( "cin_ram_06_05_safiya_aie_breakin_pilotshoots", &breakin_pilotshoots_done, "done" );
    a_flags = [];
    a_flags[ 0 ] = "player_looking_at_vtol_igc";
    a_flags[ 1 ] = "vtol_igc_robots_alerted";
    level flag::wait_till_any( a_flags );
    level notify( #"hash_ca2d8f8" );
    level scene::play( "cin_ram_06_05_safiya_aie_breakin_pilotshoots" );
}

// Namespace vtol_igc
// Params 1
// Checksum 0x85e3dda4, Offset: 0x22d0
// Size: 0x102
function breakin_pilotshoots_done( a_ents )
{
    a_keys = getarraykeys( a_ents );
    
    foreach ( str_key in a_keys )
    {
        if ( issubstr( str_key, "robot" ) )
        {
            ai_robot = a_ents[ str_key ];
            
            if ( isalive( ai_robot ) )
            {
                ai_robot kill();
            }
        }
    }
}

// Namespace vtol_igc
// Params 0
// Checksum 0xb9dde961, Offset: 0x23e0
// Size: 0xac
function initial_hendricks_scripting()
{
    level.ai_hendricks ai::set_ignoreall( 1 );
    nd_start = getnode( "vtol_igc_hendricks_start", "targetname" );
    wait 1;
    level.ai_hendricks ai::force_goal( nd_start );
    level flag::wait_till( "vtol_igc_robots_alerted" );
    level.ai_hendricks ai::set_ignoreall( 0 );
}

// Namespace vtol_igc
// Params 1
// Checksum 0xd1a4dd8c, Offset: 0x2498
// Size: 0xda
function robot_breakin_init_scene_func( a_ents )
{
    a_keys = getarraykeys( a_ents );
    
    foreach ( str_key in a_keys )
    {
        if ( issubstr( str_key, "robot" ) )
        {
            a_ents[ str_key ] thread robot_break_out_of_scene();
        }
    }
}

// Namespace vtol_igc
// Params 0
// Checksum 0x8782ec9f, Offset: 0x2580
// Size: 0xea
function robot_break_out_of_scene()
{
    self endon( #"death" );
    level endon( #"stop_robot_breakout_logic" );
    self thread player_near_robot();
    self util::waittill_any( "damage", "bulletwhizby", "pain", "proximity", "player_near_vtol_igc" );
    level flag::set( "vtol_igc_robots_alerted" );
    level thread scene::play( "cin_ram_06_05_safiya_aie_breakin_02" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    trigger::use( "trig_spawn_vtol_igc" );
    level notify( #"stop_robot_breakout_logic" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0xc1b0808d, Offset: 0x2678
// Size: 0x3a
function player_near_robot()
{
    self endon( #"death" );
    trigger::wait_till( "vtol_igc_near_robots", "targetname" );
    self notify( #"player_near_vtol_igc" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x69d8f8c3, Offset: 0x26c0
// Size: 0x2c
function hendricks_vtol_igc_start_notetrack()
{
    self waittill( #"headlook_on" );
    level flag::set( "hendricks_at_vtol_igc" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x64c31482, Offset: 0x26f8
// Size: 0x24
function through_fire_notetrack()
{
    level waittill( #"vtol_igc_player_through_fire" );
    level thread quad_tank_plaza::ignore_players();
}

// Namespace vtol_igc
// Params 0
// Checksum 0xf40948de, Offset: 0x2728
// Size: 0xd4
function truck_hit_notetrack()
{
    level flag::wait_till( "vtol_igc_started" );
    s_scene = struct::get( "truck_flip_vtol", "targetname" );
    s_scene thread scene::init();
    level waittill( #"truck_hit" );
    s_scene thread scene::play();
    level waittill( #"delete_guy_that_gets_crushed_by_truck" );
    e_guy = getent( "cin_ram_06_05_safiya_1st_friendlydown_guy06", "targetname" );
    e_guy delete();
}

// Namespace vtol_igc
// Params 0
// Checksum 0x5abca539, Offset: 0x2808
// Size: 0x24
function function_c887803()
{
    level waittill( #"vtol_igc_hunter_fxanim" );
    quad_tank_plaza::vtol_igc_hunter_fx_anim();
}

// Namespace vtol_igc
// Params 0
// Checksum 0xc0211a40, Offset: 0x2838
// Size: 0x2c
function stop_exploder_ext_smoke()
{
    level waittill( #"stop_exploder_ext_smoke" );
    exploder::exploder_stop( "fx_expl_igc_vtol_ext_smoke" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x2a0a5a6d, Offset: 0x2870
// Size: 0x2c
function stop_exploder_vtol_int()
{
    level waittill( #"stop_exploder_vtol_int" );
    exploder::exploder_stop( "fx_expl_vtol_int" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x3544cdc2, Offset: 0x28a8
// Size: 0x31c
function hide_vtol_wings()
{
    e_vtol = undefined;
    
    while ( !isdefined( e_vtol ) )
    {
        e_vtol = getent( "cin_ram_06_05_safiya_1st_friendlydown_vtol01", "targetname" );
        wait 1;
    }
    
    var_633b96c9 = array( "veh_t7_mil_vtol_egypt_igc_nose", "veh_t7_mil_vtol_egypt_int_slice" );
    
    foreach ( str_part in var_633b96c9 )
    {
        e_vtol hidepart( "tag_wing_left_animate", str_part, 1 );
        e_vtol hidepart( "tag_wing_right_animate", str_part, 1 );
        e_vtol hidepart( "tag_wing_l_midbreak_animate", str_part, 1 );
        e_vtol hidepart( "tag_wing_r_midbreak_animate", str_part, 1 );
    }
    
    a_e_probes = getentarray( "vtol_cockpit_probe", "script_noteworthy" );
    
    foreach ( e_probe in a_e_probes )
    {
        e_probe linkto( e_vtol, "tag_cockpit_lgt" );
    }
    
    e_vtol hidepart( "tag_console_center_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0" );
    e_vtol hidepart( "tag_console_left_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0" );
    e_vtol hidepart( "tag_console_right_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0" );
    e_vtol attach( "veh_t7_mil_vtol_egypt_screens_d1", "tag_nose_animate" );
    e_vtol attach( "veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate" );
    e_vtol notsolid();
}

// Namespace vtol_igc
// Params 0
// Checksum 0x96590079, Offset: 0x2bd0
// Size: 0x44
function setaudio_snapshot()
{
    level flag::wait_till( "all_players_spawned" );
    wait 1;
    level util::clientnotify( "pres" );
}

// Namespace vtol_igc
// Params 0
// Checksum 0x996447c2, Offset: 0x2c20
// Size: 0x13c
function vtol_igc_vo()
{
    var_a7d1013f = getent( "trig_hendricks_sees_vtol", "targetname" );
    
    while ( true )
    {
        var_a7d1013f trigger::wait_till();
        
        if ( var_a7d1013f.who === level.ai_hendricks || isplayer( var_a7d1013f.who ) )
        {
            break;
        }
    }
    
    level.ai_hendricks dialog::say( "hend_kane_we_got_a_frie_0", 0.5 );
    level dialog::remote( "kane_scanning_for_lifesig_0" );
    ai_pilot = getent( "cin_ram_06_05_safiya_1st_friendlydown_guy01", "targetname" );
    ai_pilot dialog::say( "plyr_screams_from_inside_0" );
    level dialog::player_say( "plyr_that_s_lifesign_enou_0" );
}

