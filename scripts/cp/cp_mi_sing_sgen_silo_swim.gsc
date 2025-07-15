#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_silo_swim;

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2
// Checksum 0x254c14b5, Offset: 0xdd8
// Size: 0x284
function skipto_silo_swim_init( tr_objective, b_starting )
{
    if ( b_starting )
    {
        level clientfield::set( "w_underwater_state", 1 );
        spawner::add_global_spawn_function( "axis", &sgen_util::robot_underwater_callback );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::complete( "cp_level_sgen_goto_server_room" );
        objectives::complete( "cp_level_sgen_confront_pallas" );
        objectives::set( "cp_level_sgen_get_to_surface" );
        load::function_a2995f22();
        
        foreach ( player in level.players )
        {
            player clientfield::set_to_player( "water_motes", 1 );
            player thread hazard::function_e9b126ef( 15, 0.25 );
        }
    }
    
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.ai_hendricks colors::set_force_color( "r" );
    setdvar( "player_swimTime", 5000 );
    level thread main();
    sgen_accolades::function_f3915502();
    exploder::exploder( "lights_sgen_swimup" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 4
// Checksum 0xd097a419, Offset: 0x1068
// Size: 0x3c
function skipto_silo_swim_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_sgen_get_to_surface" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x69c04bfe, Offset: 0x10b0
// Size: 0x15c
function main()
{
    level thread function_454f17f5();
    level thread function_adfc879d();
    level thread function_5faf4875();
    level thread handle_hendricks_path();
    level thread function_e5892d8b();
    level thread silo_debris_fx_anim();
    level thread silo_swim_objective();
    level thread silo_swim_vo();
    level thread sgen_end_igc();
    level thread function_13a4841b();
    level thread function_732b54da();
    level thread function_78227c49();
    level flag::wait_till( "player_in_fan_vent" );
    level thread function_1b1cd649();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xda1df5fe, Offset: 0x1218
// Size: 0x1c
function silo_swim_objective()
{
    objectives::breadcrumb( "silo_swim_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x15e2343b, Offset: 0x1240
// Size: 0xa2
function function_732b54da()
{
    wait 3;
    
    foreach ( player in level.activeplayers )
    {
        player util::show_hint_text( &"COOP_SWIM_INSTRUCTIONS", 0, undefined, 2 );
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x9a385379, Offset: 0x12f0
// Size: 0xc0
function function_adfc879d()
{
    v_push = ( 0, 30, 0 );
    var_339ee53e = getent( "trig_water_flow", "targetname" );
    
    while ( true )
    {
        var_339ee53e waittill( #"trigger", e_player );
        v_velocity = e_player getvelocity();
        v_velocity += v_push;
        e_player setvelocity( v_velocity );
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xc179f91, Offset: 0x13b8
// Size: 0x19c
function silo_swim_vo()
{
    level endon( #"silo_complete" );
    level thread function_72e5fd1f();
    level flag::set( "important_vo_playing" );
    level.ai_hendricks dialog::say( "hend_alright_stay_on_my_0" );
    level dialog::remote( "kane_heads_up_spotted_a_0", 0.5 );
    level.ai_hendricks dialog::say( "hend_take_out_those_charg_0", 0.7 );
    level flag::clear( "important_vo_playing" );
    level flag::wait_till( "silo_swim_bridge_collapse" );
    level flag::set( "important_vo_playing" );
    level.ai_hendricks dialog::say( "hend_bridge_coming_down_0" );
    level dialog::remote( "kane_hang_on_something_s_0", 1 );
    level dialog::remote( "kane_futz_we_hav_0", 0.5 );
    level flag::clear( "important_vo_playing" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x2cea2faa, Offset: 0x1560
// Size: 0x1b0
function function_72e5fd1f()
{
    var_c2758464 = 0.2;
    n_lines_played = 0;
    
    while ( !level flag::get( "silo_complete" ) )
    {
        if ( level.activeplayers.size == 0 )
        {
            return;
        }
        
        n_fraction = level.activeplayers[ 0 ] hazard::function_b78a859e( "o2" );
        
        if ( n_fraction > var_c2758464 )
        {
            if ( !level flag::get( "important_vo_playing" ) )
            {
                switch ( n_lines_played )
                {
                    case 0:
                        level.ai_hendricks dialog::say( "hend_we_gotta_get_up_ther_0" );
                        break;
                    case 1:
                        level.ai_hendricks dialog::say( "hend_your_o2_levels_are_d_0" );
                        break;
                    case 2:
                        level.ai_hendricks dialog::say( "hend_your_o2_level_s_crit_0" );
                        break;
                    case 3:
                        level.ai_hendricks dialog::say( "hend_go_go_go_1" );
                        break;
                }
            }
            
            n_lines_played++;
            var_c2758464 += 0.2;
        }
        
        wait 1;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xc192c088, Offset: 0x1718
// Size: 0xfc
function function_e5892d8b()
{
    array::thread_all( getentarray( "drowning_trigger", "targetname" ), &drowning_54i );
    level flag::wait_till_any( array( "ai_drowning", "hendricks_move_up_5" ) );
    util::delay( randomfloatrange( 0.5, 1 ), undefined, &scene::play, "cin_sgen_25_02_siloswim_vign_windowbang_54i02_drowning" );
    util::delay( randomfloatrange( 2, 3 ), undefined, &scene::play, "cin_sgen_25_02_siloswim_vign_windowbang_54i03_drowning" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xf56469bf, Offset: 0x1820
// Size: 0x1b4
function function_5faf4875()
{
    level.e_safe_zone = getent( "silo_swim_safe_area", "targetname" );
    var_94dd2adf = struct::get_array( "static_depth_charge", "targetname" );
    
    foreach ( var_cb85ae7c in var_94dd2adf )
    {
        var_cb85ae7c thread static_depth_charge_setup();
        util::wait_network_frame();
    }
    
    v_carrier = vehicle::simple_spawn_single( "depth_charge_carrier" );
    v_carrier util::magic_bullet_shield();
    v_carrier sethoverparams( 10, 10, 10 );
    v_carrier thread function_267dcc4e();
    level flag::wait_till( "silo_complete" );
    wait 3;
    v_carrier util::stop_magic_bullet_shield();
    v_carrier util::self_delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x11caa9b9, Offset: 0x19e0
// Size: 0x274
function handle_hendricks_path()
{
    level endon( #"silo_complete" );
    var_c568c095 = getent( "hendricks_kill_bot", "script_noteworthy" );
    var_c568c095 spawner::add_spawn_function( &function_9d7c6fb3 );
    spawn_manager::enable( "sm_under_silo_swim_robots" );
    trigger::wait_till( "silo_hendricks_start_trigger", undefined, undefined, 0 );
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_1st_point" );
    a_ai_robots = getaispeciesarray( "axis", "robot" );
    array::wait_till( a_ai_robots, "death" );
    
    if ( !flag::get( "hendricks_move_to_under_fan" ) )
    {
        level thread scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_1st_point_wait" );
        level flag::wait_till( "hendricks_move_to_under_fan" );
    }
    
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_shaft" );
    level flag::wait_till( "player_in_fan_vent" );
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_thru_shaft" );
    level thread scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_upper_tunnel" );
    level flag::wait_till( "hendricks_move_up_4" );
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_balconies" );
    level flag::wait_till( "hendricks_move_up_5" );
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_rocks" );
    level scene::play( "cin_sgen_25_01_siloswim_vign_coverswim_hendricks_surface" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xe16c225b, Offset: 0x1c60
// Size: 0x54
function function_9d7c6fb3()
{
    self endon( #"death" );
    self settargetentity( level.ai_hendricks );
    level.ai_hendricks waittill( #"hash_f4673288" );
    self kill();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xcc030bd7, Offset: 0x1cc0
// Size: 0x106
function function_267dcc4e()
{
    level endon( #"silo_complete" );
    a_moving_charge = struct::get_array( "moving_depth_charge", "targetname" );
    a_moving_charge = array::get_all_closest( self.origin, a_moving_charge );
    spawn_index = 0;
    n_delay = 1 - ( level.players.size - 1 ) * 0.17;
    
    while ( true )
    {
        spawn_index = spawn_index < a_moving_charge.size ? spawn_index + 1 : 0;
        
        if ( isdefined( a_moving_charge[ spawn_index ] ) )
        {
            self thread create_depth_charge( "script_model", a_moving_charge[ spawn_index ] );
        }
        
        wait n_delay;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xa9206e91, Offset: 0x1dd0
// Size: 0x34
function static_depth_charge_setup()
{
    e_depth_charge = self create_depth_charge( "script_model", undefined );
    return e_depth_charge;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 3
// Checksum 0x989fcc29, Offset: 0x1e10
// Size: 0x220
function create_depth_charge( str_type, s_start, should_ignore_player )
{
    if ( !isdefined( str_type ) )
    {
        str_type = "script_model";
    }
    
    if ( !isdefined( should_ignore_player ) )
    {
        should_ignore_player = 0;
    }
    
    self endon( #"death" );
    
    if ( level flag::get( "silo_complete" ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    e_depth_charge = undefined;
    
    if ( str_type === "script_model" )
    {
        e_depth_charge = self create_depth_charge_model();
        
        if ( isdefined( s_start ) )
        {
            e_depth_charge.targetname = "depth_charger_dive";
            e_depth_charge thread handle_movement( s_start, should_ignore_player );
        }
        else
        {
            e_depth_charge.targetname = "depth_charger_static";
            e_depth_charge thread util::delay( randomfloatrange( 0.5, 5 ), undefined, &sway, 5, 8, 18 );
        }
        
        if ( !should_ignore_player )
        {
            e_depth_charge thread detect_nearby_player( 400 );
        }
    }
    else
    {
        e_depth_charge = self create_depth_charge_vehicle();
        e_depth_charge.origin = self.origin;
        e_depth_charge.angles = self.angles;
        e_depth_charge thread track_completion_cleanup();
        e_depth_charge thread handle_movement( s_start, should_ignore_player );
        
        if ( self.classname === "script_model" )
        {
            self util::self_delete();
        }
    }
    
    return e_depth_charge;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0x8634c5b5, Offset: 0x2038
// Size: 0xd8
function create_depth_charge_vehicle( v_origin )
{
    vh_depth_charge = undefined;
    
    while ( !isdefined( vh_depth_charge ) )
    {
        vh_depth_charge = vehicle::simple_spawn_single( "depth_charge_spawner", 1 );
        util::wait_network_frame();
    }
    
    vh_depth_charge thread init_depth_charge();
    vh_depth_charge setneargoalnotifydist( 105 / 2 );
    vh_depth_charge oed::enable_thermal();
    vh_depth_charge clientfield::set( "sm_depth_charge_fx", 2 );
    return vh_depth_charge;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x46872e14, Offset: 0x2118
// Size: 0x138
function create_depth_charge_model()
{
    var_5a16524f = util::spawn_model( "veh_t7_drone_depth_charge", self.origin, ( randomint( 360 ), randomint( 360 ), randomint( 360 ) ) );
    
    if ( isdefined( var_5a16524f ) )
    {
        var_5a16524f.script_noteworthy = "depth_charge_model";
        var_5a16524f setcandamage( 1 );
        var_5a16524f.health = 999999;
        var_5a16524f clientfield::set( "sm_depth_charge_fx", 1 );
        var_5a16524f enableaimassist();
        var_5a16524f thread handle_damage();
        var_5a16524f oed::enable_thermal();
    }
    
    return var_5a16524f;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2
// Checksum 0x2306a7c4, Offset: 0x2258
// Size: 0x35c
function handle_movement( s_target, should_ignore_player )
{
    self endon( #"death" );
    self endon( #"enemy_close" );
    
    if ( !isvehicle( self ) )
    {
        if ( isdefined( should_ignore_player ) && should_ignore_player )
        {
            self thread function_46012050();
        }
    }
    else if ( !isdefined( s_target ) )
    {
        s_target = isdefined( self._activated_player ) ? self._activated_player : array::random( level.players );
    }
    
    if ( isvehicle( self ) )
    {
        n_fuse_time = gettime() + 3000;
    }
    
    while ( isdefined( s_target ) )
    {
        n_distance = distance( self.origin, s_target.origin );
        n_time = n_distance / 200;
        
        if ( isvehicle( self ) )
        {
            if ( self istouching( level.e_safe_zone ) || gettime() >= n_fuse_time )
            {
                break;
            }
            
            if ( isplayer( s_target ) )
            {
                self setvehgoalpos( self getclosestpointonnavvolume( s_target geteye(), 512 ), 1, 1 );
            }
            else
            {
                self setvehgoalpos( s_target.origin, 1, 1 );
            }
            
            wait 0.5;
            
            if ( distancesquared( self.origin, s_target.origin ) <= 30625 )
            {
                break;
            }
        }
        else if ( n_time )
        {
            self moveto( s_target.origin, n_time );
            self waittill( #"movedone" );
        }
        
        if ( isvehicle( self ) )
        {
            if ( !isplayer( s_target ) && ( !isdefined( s_target ) || !( isdefined( should_ignore_player ) && should_ignore_player ) ) )
            {
                s_target = isdefined( self._activated_player ) ? self._activated_player : array::random( level.players );
            }
            
            continue;
        }
        
        s_target = isdefined( s_target.target ) ? struct::get( s_target.target, "targetname" ) : undefined;
    }
    
    self thread detonate_depth_charge();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x97cb6474, Offset: 0x25c0
// Size: 0x94
function handle_damage()
{
    self endon( #"death" );
    self waittill( #"damage", damage, e_attacker );
    
    if ( isplayer( e_attacker ) )
    {
        sgen_accolades::function_e85e2afd( e_attacker );
    }
    
    self thread detonate_depth_charge( isdefined( e_attacker ) && isplayer( e_attacker ) );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x2d6521c0, Offset: 0x2660
// Size: 0x24c
function function_46012050()
{
    self endon( #"death" );
    self endon( #"enemy_close" );
    var_c4ebe9e7 = -10000;
    n_start_time = gettime();
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( player.origin[ 2 ] > var_c4ebe9e7 )
            {
                var_c4ebe9e7 = player.origin[ 2 ];
            }
        }
        
        if ( self.origin[ 2 ] <= var_c4ebe9e7 + 512 )
        {
            break;
        }
        
        wait 1;
    }
    
    var_90462d11 = var_c4ebe9e7;
    
    foreach ( player in level.activeplayers )
    {
        if ( player.origin[ 2 ] < var_90462d11 )
        {
            var_90462d11 = player.origin[ 2 ];
        }
    }
    
    n_distance = self.origin[ 2 ] - var_90462d11 - 128;
    n_time = n_distance / 200;
    
    if ( n_time > 0 )
    {
        wait randomfloat( n_time );
    }
    
    self thread detonate_depth_charge();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0x613ce4c8, Offset: 0x28b8
// Size: 0x170
function detect_nearby_player( n_update_range )
{
    if ( !isdefined( n_update_range ) )
    {
        n_update_range = 400;
    }
    
    level endon( #"silo_complete" );
    self endon( #"enemy_close" );
    self endon( #"death" );
    self thread chase_nearby_player();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player istouching( level.e_safe_zone ) && !player isinmovemode( "ufo", "noclip" ) )
            {
                if ( distancesquared( player.origin, self.origin ) < n_update_range * n_update_range )
                {
                    self._activated_player = player;
                    self notify( #"enemy_close" );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xd03f9294, Offset: 0x2a30
// Size: 0xbc
function chase_nearby_player()
{
    self endon( #"death" );
    self waittill( #"enemy_close" );
    self playsound( "veh_depth_charge_locked" );
    self playloopsound( "veh_depth_charge_chase", 0.5 );
    
    if ( !level flag::get( "silo_complete" ) )
    {
        self thread create_depth_charge( "script_vehicle" );
        return;
    }
    
    self thread detonate_depth_charge();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0xa9bdec3d, Offset: 0x2af8
// Size: 0x2b2
function detonate_depth_charge( should_chain )
{
    if ( !isdefined( should_chain ) )
    {
        should_chain = 0;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    v_origin = self.origin;
    radiusdamage( v_origin, 175, 50, 15, self );
    playrumbleonposition( "grenade_rumble", v_origin );
    earthquake( 0.5, 0.5, v_origin, 150 );
    
    if ( self.classname === "script_model" )
    {
        playfx( level._effect[ "depth_charge_explosion" ], v_origin );
        playsoundatposition( "exp_drone_underwater", v_origin );
        self util::self_delete();
    }
    else
    {
        self dodamage( self.health + 1000, self.origin, undefined, self, "none", "MOD_EXPLOSIVE" );
    }
    
    wait 0.1;
    
    if ( isdefined( should_chain ) && should_chain )
    {
        a_e_depth_charges = arraycombine( getentarray( "depth_charge_model", "script_noteworthy" ), getentarray( "dept_charge_spawner_vh", "targetname" ), 0, 0 );
        a_e_depth_charges = arraysortclosest( a_e_depth_charges, v_origin, 5, 0, 105 );
        
        foreach ( e_depth_charge in a_e_depth_charges )
        {
            if ( isdefined( e_depth_charge ) )
            {
                e_depth_charge thread detonate_depth_charge();
                util::wait_network_frame();
            }
        }
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xa1af1995, Offset: 0x2db8
// Size: 0x234
function function_78227c49()
{
    hidemiscmodels( "silo_bridge_collapse_static" );
    level scene::init( "bridge_collapse", "targetname" );
    level flag::wait_till( "player_in_fan_vent" );
    scene::add_scene_func( "p7_fxanim_cp_sgen_bridge_silo_collapse_bundle", &bridge_scene, "play" );
    a_s_targets = struct::get_array( "bridge_collapse_dp_target", "targetname" );
    
    foreach ( s_target in a_s_targets )
    {
        playfx( level._effect[ "depth_charge_explosion" ], s_target.origin );
        playsoundatposition( "exp_drone_underwater", s_target.origin );
        wait 0.1 + randomint( 3 ) * 0.1;
    }
    
    level flag::wait_till( "silo_swim_take_out" );
    level flag::set( "silo_swim_bridge_collapse" );
    level scene::play( "bridge_collapse", "targetname" );
    showmiscmodels( "silo_bridge_collapse_static" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0xee4cb166, Offset: 0x2ff8
// Size: 0x234
function bridge_scene( a_ents )
{
    t_hurt1 = getent( "bridge_side1", "targetname" );
    t_hurt1 enablelinkto();
    t_hurt1 linkto( a_ents[ "bridge_silo_collapse" ], "bridge_main_fall_01_jnt" );
    t_hurt2 = getent( "bridge_side2", "targetname" );
    t_hurt2 enablelinkto();
    t_hurt2 linkto( a_ents[ "bridge_silo_collapse" ], "bridge_main_fall_02_jnt" );
    
    while ( level scene::is_playing( "p7_fxanim_cp_sgen_bridge_silo_collapse_bundle" ) )
    {
        a_e_depth_charge = getentarray( "depth_charger_static", "targetname" );
        
        foreach ( e_depth_charge in a_e_depth_charge )
        {
            if ( e_depth_charge istouching( t_hurt1 ) || e_depth_charge istouching( t_hurt2 ) )
            {
                e_depth_charge thread detonate_depth_charge();
            }
        }
        
        wait 0.05;
    }
    
    t_hurt1 delete();
    t_hurt2 delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x2110f413, Offset: 0x3238
// Size: 0x204
function function_1b1cd649()
{
    s_start = struct::get( "rock_suicide_drone" );
    var_5a16524f = s_start static_depth_charge_setup();
    level flag::wait_till( "hendricks_move_up_4" );
    t_damage = getent( "rock_slide_trigger", "targetname" );
    t_damage triggerenable( 0 );
    a_ai_bots = spawner::simple_spawn( "rock_fall_bots" );
    
    foreach ( ai_bot in a_ai_bots )
    {
        ai_bot.maxsightdist = 562500;
        ai_bot.script_accuracy = 0.5;
    }
    
    trigger::wait_till( "trig_rock_slide" );
    
    if ( isdefined( var_5a16524f ) )
    {
        var_5a16524f thread detonate_depth_charge();
        level thread scene::play( "p7_fxanim_cp_sgen_boulder_silo_depth_charge_bundle" );
        level waittill( #"rocks_crush_robots" );
        t_damage triggerenable( 1 );
        level waittill( #"rocks_impact_01" );
        t_damage delete();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x97e1d16f, Offset: 0x3448
// Size: 0x1cc
function function_13a4841b()
{
    level flag::set( "silo_swim_take_out" );
    level thread namespace_d40478f6::function_5d6d7c60();
    var_493378a9 = struct::get_array( "under_silo_depth_charge", "targetname" );
    var_8c2654e3 = [];
    
    for ( i = 0; i < var_493378a9.size ; i++ )
    {
        var_456985ba = 0;
        
        if ( var_493378a9[ i ].script_noteworthy === "ignore_player" )
        {
            var_456985ba = 1;
        }
        
        var_8c2654e3[ i ] = var_493378a9[ i ] create_depth_charge( "script_model", undefined, var_456985ba );
        
        if ( isdefined( var_493378a9[ i ].target ) )
        {
            s_target = struct::get( var_493378a9[ i ].target, "targetname" );
            var_8c2654e3[ i ] thread function_dd461d67( s_target );
        }
        
        wait 0.3;
    }
    
    array::wait_till( var_8c2654e3, "death" );
    level flag::set( "hendricks_move_to_under_fan" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0x4e254a13, Offset: 0x3620
// Size: 0x1d4
function function_dd461d67( s_target )
{
    self endon( #"death" );
    trigger::wait_till( "depth_charge_swarm_trigger" );
    n_distance = distance( self.origin, s_target.origin );
    n_time = n_distance / 200;
    self notify( #"hash_34674350" );
    self moveto( s_target.origin, n_time );
    self waittill( #"movedone" );
    
    if ( s_target.script_noteworthy === "detonate" )
    {
        a_ai_axis = getaiteamarray( "axis" );
        
        foreach ( ai in a_ai_axis )
        {
            if ( isalive( ai ) && distance( ai.origin, self.origin ) < 400 )
            {
                ai kill();
            }
        }
        
        self thread detonate_depth_charge();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2
// Checksum 0x79ace14f, Offset: 0x3800
// Size: 0x72
function function_7cf2db52( var_aa2d33b, n_alpha )
{
    if ( !isdefined( var_aa2d33b ) )
    {
        var_aa2d33b = 0.6;
    }
    
    if ( !isdefined( n_alpha ) )
    {
        n_alpha = 1;
    }
    
    level lui::screen_fade( var_aa2d33b, n_alpha, 0, "black", 0 );
    wait var_aa2d33b;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2
// Checksum 0x1078635e, Offset: 0x3880
// Size: 0x72
function function_1e6ee4b9( var_4b1adf24, n_alpha )
{
    if ( !isdefined( var_4b1adf24 ) )
    {
        var_4b1adf24 = 0.4;
    }
    
    if ( !isdefined( n_alpha ) )
    {
        n_alpha = 1;
    }
    
    level lui::screen_fade( var_4b1adf24, 0, n_alpha, "black", 1 );
    wait var_4b1adf24;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x9d546af9, Offset: 0x3900
// Size: 0x2f2
function sgen_end_igc()
{
    flag::wait_till( "silo_complete" );
    level clientfield::set( "gameplay_started", 0 );
    objectives::complete( "cp_level_sgen_get_to_surface" );
    sgen_accolades::function_fde8c3ce();
    array::thread_all( level.players, &function_55b80798 );
    level function_7cf2db52();
    array::thread_all( getaiteamarray( "axis" ), &util::self_delete );
    level util::set_streamer_hint( 5 );
    level thread sgen_end_igc_exploder_swap();
    level thread namespace_d40478f6::function_973b77f9();
    level util::clientnotify( "tuwco" );
    wait 2;
    
    if ( isdefined( level.bzm_sgendialogue9callback ) )
    {
        level thread [[ level.bzm_sgendialogue9callback ]]();
    }
    
    level thread function_1e6ee4b9();
    level util::delay( "fade_out_grab", undefined, &function_7cf2db52 );
    scene::add_scene_func( "cin_sgen_26_01_lobbyexit_1st_escape_grab", &function_bd2c7078, "done" );
    level thread scene::play( "cin_sgen_26_01_lobbyexit_1st_escape_grab" );
    level waittill( #"fade_out_grab" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 0.6 );
    }
    else
    {
        util::screen_fade_out( 0 );
    }
    
    level waittill( #"hash_bffd177e" );
    
    foreach ( player in level.activeplayers )
    {
        player disableusability();
        player disableoffhandweapons();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0x2d5b14f3, Offset: 0x3c00
// Size: 0xa4
function function_bd2c7078( a_ents )
{
    level thread function_1e6ee4b9();
    level util::delay( "final_fade_out", undefined, &escape_outro );
    level thread namespace_d40478f6::play_outro();
    level thread audio::unlockfrontendmusic( "mus_sgen_diaz_theme_intro" );
    level thread scene::play( "p7_fxanim_cp_sgen_end_building_collapse_debris_bundle" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x32d5c529, Offset: 0x3cb0
// Size: 0x9c
function function_55b80798()
{
    self enableinvulnerability();
    self playrumbleonentity( "damage_heavy" );
    self clientfield::set_to_player( "water_motes", 0 );
    self hazard::function_60455f28( "o2" );
    self hazard::function_12231466( "o2" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x1ae5585c, Offset: 0x3d58
// Size: 0x34
function sgen_end_igc_exploder_swap()
{
    exploder::kill_exploder( "lights_sgen_swimup" );
    exploder::exploder( "lights_sgen_afterswim" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1
// Checksum 0xe43b419, Offset: 0x3d98
// Size: 0x74
function escape_outro( a_ents )
{
    level util::screen_fade_out( 0.6 );
    level clientfield::set( "sndIGCsnapshot", 4 );
    util::clear_streamer_hint();
    skipto::objective_completed( "silo_swim" );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x4ab370c1, Offset: 0x3e18
// Size: 0x64
function init_depth_charge()
{
    level endon( #"silo_complete" );
    self waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self ghost();
    wait 1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x83262783, Offset: 0x3e88
// Size: 0x44
function track_completion_cleanup()
{
    self endon( #"death" );
    level flag::wait_till( "silo_complete" );
    self delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xdb0f1186, Offset: 0x3ed8
// Size: 0x18c
function silo_debris_fx_anim()
{
    level thread silo_debris_tunnel_fx_anim();
    trigger::wait_till( "start_silo_fx_debris" );
    level clientfield::set( "silo_debris", 1 );
    util::wait_network_frame();
    trigger::wait_till( "silo_debris" );
    level clientfield::set( "silo_debris", 2 );
    util::wait_network_frame();
    level flag::wait_till( "hendricks_move_up_4" );
    level clientfield::set( "silo_debris", 3 );
    util::wait_network_frame();
    level flag::wait_till( "hendricks_move_up_5" );
    level clientfield::set( "silo_debris", 4 );
    util::wait_network_frame();
    level flag::wait_till( "silo_complete" );
    level clientfield::set( "silo_debris", 6 );
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xb3c0d357, Offset: 0x4070
// Size: 0x54
function silo_debris_tunnel_fx_anim()
{
    level flag::wait_till( "ai_drowning" );
    level clientfield::set( "silo_debris", 5 );
    util::wait_network_frame();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 3
// Checksum 0xbde6ceb9, Offset: 0x40d0
// Size: 0x236
function sway( n_time, n_min, n_max )
{
    if ( !isdefined( n_time ) )
    {
        n_time = 10;
    }
    
    if ( !isdefined( n_min ) )
    {
        n_min = 1;
    }
    
    if ( !isdefined( n_max ) )
    {
        n_max = 3;
    }
    
    level endon( #"silo_complete" );
    self endon( #"death" );
    self endon( #"hash_34674350" );
    v_home_origin = self.origin;
    v_home_angles = self.angles;
    
    while ( true )
    {
        v_movement = ( randomintrange( n_min, n_max ), randomintrange( n_min, n_max ), randomintrange( n_min, n_max ) ) * 0.75;
        v_rotation = ( randomintrange( n_min, n_max ), randomintrange( n_min, n_max ), randomintrange( n_min, n_max ) );
        self moveto( v_home_origin + v_movement, n_time, 0.5, 0.5 );
        self rotateto( v_home_angles + v_rotation, n_time, 0.5, 0.5 );
        wait n_time;
        self moveto( v_home_origin - v_movement, n_time, 0.5, 0.5 );
        self rotateto( v_home_angles - v_rotation, n_time, 0.5, 0.5 );
        wait n_time;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0xda058504, Offset: 0x4310
// Size: 0x10a
function drowning_54i()
{
    a_s_bundles = struct::get_array( self.target );
    array::thread_all( a_s_bundles, &scene::init );
    self trigger::wait_till();
    
    foreach ( n_index, s_bundle in a_s_bundles )
    {
        s_bundle thread util::delay( ( n_index + 1 ) / 5, undefined, &scene::play );
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0
// Checksum 0x3bf00b71, Offset: 0x4428
// Size: 0x1f2
function function_454f17f5()
{
    level flag::wait_till( "player_in_fan_vent" );
    
    foreach ( player in level.activeplayers )
    {
        player thread hazard::function_e9b126ef( 20, 0.6 );
    }
    
    level flag::wait_till( "hendricks_move_up_5" );
    
    foreach ( player in level.activeplayers )
    {
        player thread hazard::function_e9b126ef( 25, 0.9 );
    }
    
    level flag::wait_till( "final_breath" );
    
    foreach ( player in level.activeplayers )
    {
        player thread hazard::function_e9b126ef( 5, 1 );
    }
}

