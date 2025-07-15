#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sim_reality_starts;

// Namespace sim_reality_starts
// Params 0
// Checksum 0xef60bd49, Offset: 0x938
// Size: 0x54
function main()
{
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
    
    init_flags();
    init_client_field_callback_funcs();
    setup_scenes();
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x8c1fcbdc, Offset: 0x998
// Size: 0x24
function init_flags()
{
    level flag::init( "baby_picked_up" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xf76b91a9, Offset: 0x9c8
// Size: 0x2d4
function init_client_field_callback_funcs()
{
    clientfield::register( "toplayer", "sim_out_of_bound", 1, 1, "counter" );
    clientfield::register( "world", "sim_lgt_tree_glow_01", 1, 1, "int" );
    clientfield::register( "world", "sim_lgt_tree_glow_02", 1, 1, "int" );
    clientfield::register( "world", "sim_lgt_tree_glow_03", 1, 1, "int" );
    clientfield::register( "world", "sim_lgt_tree_glow_04", 1, 1, "int" );
    clientfield::register( "world", "sim_lgt_tree_glow_05", 1, 1, "int" );
    clientfield::register( "world", "lgt_tree_glow_05_fade_out", 1, 1, "int" );
    clientfield::register( "world", "sim_lgt_tree_glow_all_off", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_frost_up", 1, 1, "counter" );
    clientfield::register( "toplayer", "pstfx_frost_down", 1, 1, "counter" );
    clientfield::register( "toplayer", "pstfx_frost_up_baby", 1, 1, "counter" );
    clientfield::register( "toplayer", "pstfx_exit_all", 1, 1, "counter" );
    clientfield::register( "scriptmover", "infection_baby_shader", 1, 1, "int" );
    clientfield::register( "world", "toggle_sim_fog_banks", 1, 1, "int" );
    clientfield::register( "world", "break_baby", 1, 1, "int" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x99ec1590, Offset: 0xca8
// Size: 0x4
function setup_scenes()
{
    
}

// Namespace sim_reality_starts
// Params 2
// Checksum 0x89c87a8e, Offset: 0xcb8
// Size: 0x30c
function sim_reality_starts_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x41>" );
    #/
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread scene::init( "cin_inf_04_01_birthai_vign_deathpose" );
    }
    
    infection_util::turn_on_snow_fx_for_all_players();
    clientfield::set( "toggle_sim_fog_banks", 1 );
    level util::set_lighting_state( 0 );
    skipto::teleport_players( str_objective );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    foreach ( e_player in level.activeplayers )
    {
        e_player player::switch_to_primary_weapon( 1 );
    }
    
    clientfield::set( "sim_lgt_tree_glow_01", 1 );
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    level thread function_43e9cbbf();
    
    if ( isdefined( level.bzm_infectiondialogue3callback ) )
    {
        level thread [[ level.bzm_infectiondialogue3callback ]]();
    }
    
    level thread scene::play( "cin_inf_04_01_birthai_1st_crying_init" );
    level thread function_e2a1f622();
    level thread function_3c6bbd12();
    level thread function_12c0aa84();
    level thread function_f2e3184d();
    level thread function_2baf7f93();
    level thread dead_bodies_anim();
    level thread vo_birth_dialog();
    level thread monitor_t_baby_use();
    level thread monitor_t_lgt_tree_glow_03();
    level thread monitor_t_lgt_tree_glow_04();
    level thread monitor_t_lgt_tree_glow_05();
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x2e351a1a, Offset: 0xfd0
// Size: 0x24
function function_f6fce5f1()
{
    level scene::init( "cin_inf_04_01_birthai_vign_deathpose" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x4312b987, Offset: 0x1000
// Size: 0x24
function dead_bodies_anim()
{
    level scene::play( "cin_inf_04_01_birthai_vign_deathpose" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xdab2b0d9, Offset: 0x1030
// Size: 0x92
function tree_light_on_rumble()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x67fc26b2, Offset: 0x10d0
// Size: 0x1f4
function vo_birth_dialog()
{
    level thread function_3b662fed();
    trigger::wait_till( "t_vo_thea_where_am_i_what_s_0" );
    clientfield::set( "sim_lgt_tree_glow_02", 1 );
    level thread namespace_eccdd5d1::function_8e8e5a12();
    tree_light_on_rumble();
    playsoundatposition( "evt_tree_light", ( -24528, -25283, 3712 ) );
    level thread namespace_eccdd5d1::function_14588839();
    trigger::wait_till( "t_plyr_i_hear_a_baby_crying_0" );
    level dialog::player_say( "plyr_i_hear_a_baby_crying_0", 1 );
    level dialog::player_say( "plyr_hello_is_anyone_th_0" );
    trigger::wait_till( "t_lgt_tree_glow_03" );
    trigger::wait_till( "t_plyr_i_don_t_know_if_you_0" );
    level dialog::player_say( "plyr_i_don_t_know_if_you_0" );
    trigger::wait_till( "t_plyr_hall_0" );
    level dialog::player_say( "plyr_hall_0" );
    level dialog::player_say( "hall_what_did_you_do_to_m_0", 0.6 );
    level dialog::player_say( "plyr_i_tried_to_interface_0", 2.3 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xce63c721, Offset: 0x12d0
// Size: 0x4c
function function_3b662fed()
{
    wait 3.5;
    level dialog::player_say( "plyr_kane_hendricks_0", 1 );
    objectives::set( "cp_level_infection_extract_intel" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xc4b72412, Offset: 0x1328
// Size: 0x6c
function function_e2a1f622()
{
    trigger::wait_till( "t_salm_mr_krueger_beat_0" );
    t_salm_mr_krueger_beat_0 = getent( "t_salm_mr_krueger_beat_0", "targetname" );
    t_salm_mr_krueger_beat_0 dialog::say( "salm_mr_krueger_beat_0", 0, 1 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xfeb0a31d, Offset: 0x13a0
// Size: 0x6c
function function_3c6bbd12()
{
    trigger::wait_till( "t_krue_oh_i_understand_do_0" );
    t_salm_mr_krueger_beat_0 = getent( "t_krue_oh_i_understand_do_0", "targetname" );
    t_salm_mr_krueger_beat_0 dialog::say( "krue_oh_i_understand_do_0", 0, 1 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x2a8fe124, Offset: 0x1418
// Size: 0x6c
function function_12c0aa84()
{
    trigger::wait_till( "t_salm_please_listen_to_wh_0" );
    t_salm_mr_krueger_beat_0 = getent( "t_salm_please_listen_to_wh_0", "targetname" );
    t_salm_mr_krueger_beat_0 dialog::say( "salm_please_listen_to_wh_0", 0, 1 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0xb7976a7d, Offset: 0x1490
// Size: 0x6c
function function_f2e3184d()
{
    trigger::wait_till( "t_krue_we_re_standing_on_th_1" );
    t_salm_mr_krueger_beat_0 = getent( "t_krue_we_re_standing_on_th_1", "targetname" );
    t_salm_mr_krueger_beat_0 dialog::say( "krue_we_re_standing_on_th_1", 0, 1 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x26a86301, Offset: 0x1508
// Size: 0x6c
function function_2baf7f93()
{
    trigger::wait_till( "t_krue_zurich_is_where_the_1" );
    t_salm_mr_krueger_beat_0 = getent( "t_krue_zurich_is_where_the_1", "targetname" );
    t_salm_mr_krueger_beat_0 dialog::say( "krue_zurich_is_where_the_1", 0, 1 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x534e1516, Offset: 0x1580
// Size: 0xac
function monitor_t_lgt_tree_glow_03()
{
    trigger::wait_till( "t_lgt_tree_glow_03" );
    level thread namespace_eccdd5d1::function_688bdfa9();
    clientfield::set( "sim_lgt_tree_glow_03", 1 );
    tree_light_on_rumble();
    playsoundatposition( "evt_tree_light", ( -24934, -23881, 3803 ) );
    playsoundatposition( "evt_baby_cry", ( 0, 0, 0 ) );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x4c6f1dfb, Offset: 0x1638
// Size: 0xac
function monitor_t_lgt_tree_glow_04()
{
    trigger::wait_till( "t_lgt_tree_glow_04" );
    level thread namespace_eccdd5d1::function_42896540();
    clientfield::set( "sim_lgt_tree_glow_04", 1 );
    tree_light_on_rumble();
    playsoundatposition( "evt_tree_light", ( -24574, -22663, 4172 ) );
    playsoundatposition( "evt_baby_cry", ( 0, 0, 0 ) );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x4b6e387, Offset: 0x16f0
// Size: 0xac
function monitor_t_lgt_tree_glow_05()
{
    trigger::wait_till( "t_lgt_tree_glow_05" );
    level thread namespace_eccdd5d1::function_4c9abe1f();
    clientfield::set( "sim_lgt_tree_glow_05", 1 );
    tree_light_on_rumble();
    playsoundatposition( "evt_tree_light", ( -23716, -21731, 4429 ) );
    playsoundatposition( "evt_baby_cry", ( 0, 0, 0 ) );
}

// Namespace sim_reality_starts
// Params 4
// Checksum 0xf3447889, Offset: 0x17a8
// Size: 0x84
function sim_reality_starts_done( str_objective, b_starting, b_direct, player )
{
    clientfield::set( "toggle_sim_fog_banks", 0 );
    clientfield::set( "sim_lgt_tree_glow_all_off", 1 );
    infection_util::turn_off_snow_fx_for_all_players();
    objectives::complete( "cp_level_infection_extract_intel" );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x1db37acb, Offset: 0x1838
// Size: 0xcc
function function_43e9cbbf()
{
    level.var_ff59b31e = 0;
    array::thread_all( level.players, &function_ca04578e );
    callback::on_spawned( &function_ca04578e );
    array::thread_all( getentarray( "t_warm", "script_noteworthy" ), &function_cdf731ff );
    level waittill( #"hash_744b1b8e" );
    callback::remove_on_spawned( &function_ca04578e );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x696782aa, Offset: 0x1910
// Size: 0x24
function function_cdf731ff()
{
    self waittill( #"trigger" );
    self.b_activated = 1;
    level.var_ff59b31e++;
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x412149b2, Offset: 0x1940
// Size: 0x28a
function function_ca04578e()
{
    level endon( #"hash_744b1b8e" );
    self endon( #"death" );
    var_803084e1 = getentarray( "t_warm", "script_noteworthy" );
    var_4902d28 = getentarray( "t_cold", "script_noteworthy" );
    
    while ( true )
    {
        wait 1.5;
        str_status = "out_of_bounds";
        
        foreach ( t_warm in var_803084e1 )
        {
            if ( self istouching( t_warm ) && t_warm.b_activated === 1 )
            {
                str_status = "warm";
            }
        }
        
        if ( str_status != "warm" )
        {
            foreach ( t_cold in var_4902d28 )
            {
                if ( self istouching( t_cold ) )
                {
                    str_status = "cold";
                }
            }
        }
        
        switch ( str_status )
        {
            default:
                self clientfield::increment_to_player( "pstfx_frost_down", 1 );
                break;
            case "cold":
                self clientfield::increment_to_player( "pstfx_frost_up", 1 );
                break;
            case "out_of_bounds":
                self function_ed57c386();
                break;
        }
    }
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x37dc7360, Offset: 0x1bd8
// Size: 0x18c
function function_ed57c386()
{
    self freezecontrols( 1 );
    s_sim_out_of_bound_warp = struct::get_array( "s_sim_out_of_bound_warp_" + level.var_ff59b31e );
    self thread hud::fade_to_black_for_x_sec( 0, 1, 0.5, 1, "white" );
    wait 0.5;
    self clientfield::increment_to_player( "sim_out_of_bound" );
    self clientfield::set( "player_spawn_fx", 1 );
    self setorigin( s_sim_out_of_bound_warp[ self getentitynumber() ].origin );
    self setplayerangles( s_sim_out_of_bound_warp[ self getentitynumber() ].angles );
    wait 0.5;
    self clientfield::set( "player_spawn_fx", 0 );
    self freezecontrols( 0 );
}

// Namespace sim_reality_starts
// Params 0
// Checksum 0x680e68ab, Offset: 0x1d70
// Size: 0x24c
function monitor_t_baby_use()
{
    trigger::wait_till( "pod_open_anim_trig" );
    level thread scene::play( "cin_inf_04_01_birthai_1st_crying_init_loop" );
    var_be695670 = struct::get( "pick_up_baby_objective_pos", "targetname" );
    t_baby_use = getent( "t_baby_use", "targetname" );
    t_baby_use.e_gameobject = util::init_interactive_gameobject( t_baby_use, &"cp_level_infection_gather_baby", &"CP_MI_CAIRO_INFECTION_T_BABY_USE", &function_b4750e7c );
    util::wait_network_frame();
    level thread sgen_test_chamber::function_a29f7cbd();
    t_baby_use waittill( #"hash_2d864e11", player );
    objectives::complete( "cp_level_infection_gather_baby" );
    level clientfield::set( "lgt_tree_glow_05_fade_out", 1 );
    level thread namespace_eccdd5d1::function_582799a6();
    
    if ( isdefined( player ) )
    {
        /#
            iprintlnbold( "<dev string:x59>" );
        #/
        
        t_baby_use.e_gameobject gameobjects::disable_object();
        scene::add_scene_func( "cin_inf_04_01_birthai_1st_crying", &scene_baby_skin_shader, "play" );
        level flag::set( "baby_picked_up" );
        level scene::play( "cin_inf_04_01_birthai_1st_crying", player );
        level notify( #"hash_744b1b8e" );
        skipto::objective_completed( "sim_reality_starts" );
    }
}

// Namespace sim_reality_starts
// Params 1
// Checksum 0xe143b707, Offset: 0x1fc8
// Size: 0x24
function function_b4750e7c( player )
{
    self.trigger notify( #"hash_2d864e11", player );
}

// Namespace sim_reality_starts
// Params 1
// Checksum 0x1cb35681, Offset: 0x1ff8
// Size: 0x20c
function scene_baby_skin_shader( a_ents )
{
    /#
        iprintlnbold( "<dev string:x74>" );
    #/
    
    foreach ( player in level.activeplayers )
    {
        player thread clientfield::increment_to_player( "pstfx_exit_all" );
    }
    
    cin_baby = a_ents[ "baby" ];
    level waittill( #"pickup_baby" );
    cin_baby clientfield::set( "infection_baby_shader", 1 );
    level waittill( #"swap_baby" );
    cin_baby ghost();
    level clientfield::set( "break_baby", 1 );
    level waittill( #"baby_frost_up" );
    
    foreach ( player in level.activeplayers )
    {
        player thread clientfield::increment_to_player( "pstfx_frost_up_baby", 1 );
    }
    
    level waittill( #"baby_whiteout" );
    level thread util::screen_fade_out( 1, "white" );
}

