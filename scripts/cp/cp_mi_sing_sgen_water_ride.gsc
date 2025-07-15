#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_water_ride;

// Namespace cp_mi_sing_sgen_water_ride
// Params 2
// Checksum 0x690b9846, Offset: 0x710
// Size: 0x484
function skipto_underwater_rail_init( str_objective, b_starting )
{
    spawner::add_spawn_function_group( "underwater_rail_bot", "script_noteworthy", &init_rail_bot );
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.ai_hendricks colors::set_force_color( "r" );
    t_explosion = getent( "water_ride_explosion_damage", "targetname" );
    t_explosion triggerenable( 0 );
    
    if ( b_starting )
    {
        level clientfield::set( "w_underwater_state", 1 );
        spawner::add_global_spawn_function( "axis", &sgen_util::robot_underwater_callback );
        level scene::init( "p7_fxanim_cp_sgen_door_hendricks_explosion_bundle" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::complete( "cp_level_sgen_goto_server_room" );
        objectives::complete( "cp_level_sgen_confront_pallas" );
        objectives::set( "cp_level_sgen_get_to_surface" );
        t_trigger = getent( "uw_rail_sequence_start", "targetname" );
        level scene::skipto_end( "cin_sgen_23_01_underwater_battle_vign_swim_hendricks_traverse_room", level.ai_hendricks );
        load::function_a2995f22();
        
        foreach ( player in level.players )
        {
            player clientfield::set_to_player( "water_motes", 1 );
            player thread hazard::function_e9b126ef();
        }
    }
    
    setdvar( "player_swimTime", 5000 );
    level thread vo();
    objective_trigger = getent( "uw_rail_sequence_start", "targetname" );
    hendricks_blow_wall();
    spawn_manager::kill( "uw_battle_spawnmanager", 1 );
    a_trigger_debris = getentarray( "water_ride_debris_trigger", "targetname" );
    array::thread_all( a_trigger_debris, &setup_debris );
    a_trigger_split = getentarray( "uw_rail_split_trigger", "targetname" );
    array::thread_all( a_trigger_split, &handle_split_off );
    a_t_static_hurt = getentarray( "water_ride_static_hurt_trigger", "targetname" );
    array::thread_all( a_t_static_hurt, &static_hurt );
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 4
// Checksum 0xc14ad3d4, Offset: 0xba0
// Size: 0x24
function skipto_underwater_rail_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0xa483068b, Offset: 0xbd0
// Size: 0x26a
function hendricks_blow_wall()
{
    level flag::wait_till( "all_players_spawned" );
    t_trigger = getent( "uw_rail_sequence_start", "targetname" );
    level thread objectives::breadcrumb( "uw_rail_sequence_start" );
    t_trigger sgen_util::gather_point_wait();
    level notify( #"gather_completed" );
    level scene::play( "cin_sgen_23_02_blow_door_vign_start", level.ai_hendricks );
    level thread objectives::breadcrumb( "uw_rail_sequence_start" );
    t_trigger waittill( #"trigger" );
    e_charge = getent( "blow_wall_charge", "targetname" );
    playfx( level._effect[ "depth_charge_explosion" ], e_charge.origin );
    t_explosion = getent( "water_ride_explosion_damage", "targetname" );
    t_explosion triggerenable( 1 );
    level thread scene::play( "p7_fxanim_cp_sgen_door_hendricks_explosion_bundle" );
    level thread scene::play( "cin_sgen_23_02_blow_door_vign_end", level.ai_hendricks );
    wait 0.1;
    
    foreach ( n_index, player in level.players )
    {
        player thread player_rail_sequence_init( n_index );
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0x69686709, Offset: 0xe48
// Size: 0x84
function vo()
{
    level endon( #"gather_completed" );
    wait randomfloatrange( 8, 13 );
    level.ai_hendricks dialog::say( "hend_regroup_on_me_our_o_0" );
    wait randomfloatrange( 8, 13 );
    level.ai_hendricks dialog::say( "hend_alright_stay_on_my_0" );
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1
// Checksum 0xcc02534e, Offset: 0xed8
// Size: 0x24c
function player_rail_sequence_init( n_index )
{
    self hazard::function_60455f28( "o2" );
    self.animviewunlock = 0;
    self.animinputunlock = 1;
    self.n_ride_position = n_index;
    a_v_spawner = getentarray( "player_rail_vehicle", "targetname" );
    v_spawner = a_v_spawner[ n_index ];
    nd_path_start = getvehiclenode( v_spawner.target, "targetname" );
    self.v_rail_vehicle = spawner::simple_spawn_single( v_spawner );
    self.v_rail_vehicle setacceleration( 1000 );
    self.v_rail_vehicle.origin = self.origin;
    self setplayerangles( self.v_rail_vehicle.angles );
    self playerlinktodelta( self.v_rail_vehicle, undefined, 0.5, 30, 30, 30, 30 );
    var_658763e6 = n_index * 0.5;
    n_time = 0;
    self playrumbleonentity( "cp_sgen_c4_explode" );
    
    while ( n_time < var_658763e6 )
    {
        n_time += 0.5;
        wait 0.5;
        self playrumbleonentity( "cp_sgen_c4_explode" );
    }
    
    self.v_rail_vehicle vehicle::get_on_path( nd_path_start );
    self thread player_rail_sequence_start( n_index );
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1
// Checksum 0x30cd35b4, Offset: 0x1130
// Size: 0x12c
function player_rail_sequence_start( n_index )
{
    sndent = spawn( "script_origin", ( 0, 0, 0 ) );
    sndent playloopsound( "evt_sgen_waterrail_loop", 1.5 );
    self thread player_rail_sequence( n_index );
    self util::magic_bullet_shield();
    self.v_rail_vehicle waittill( #"rail_over" );
    self util::stop_magic_bullet_shield();
    self clientfield::set_to_player( "tp_water_sheeting", 0 );
    self thread scene::stop( "cin_sgen_24_01_ride_vign_body_player_flail_" + self.n_ride_position );
    skipto::objective_completed( "underwater_rail" );
    sndent delete();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0xca4be3cc, Offset: 0x1268
// Size: 0x264
function setup_debris()
{
    t_hurt_trigger = getent( self.target, "targetname" );
    m_debris_model = getent( t_hurt_trigger.target, "targetname" );
    s_destination = struct::get( m_debris_model.target, "targetname" );
    t_hurt_trigger enablelinkto();
    t_hurt_trigger linkto( m_debris_model );
    t_hurt_trigger thread debris_impact();
    self waittill( #"trigger" );
    m_debris_model rotateto( ( 180, 180, 180 ), 5 );
    
    if ( isdefined( s_destination.script_int ) )
    {
        m_debris_model moveto( s_destination.origin, s_destination.script_int );
    }
    else
    {
        m_debris_model moveto( s_destination.origin, 5 );
    }
    
    m_debris_model waittill( #"movedone" );
    
    if ( isdefined( s_destination.target ) )
    {
        e_next_dest = struct::get( s_destination.target, "targetname" );
        
        if ( isdefined( e_next_dest.script_int ) )
        {
            m_debris_model moveto( e_next_dest.origin, e_next_dest.script_int );
        }
        else
        {
            m_debris_model moveto( e_next_dest.origin, 5 );
        }
    }
    
    m_debris_model waittill( #"movedone" );
    t_hurt_trigger notify( #"stop" );
    m_debris_model delete();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0xd1fd6421, Offset: 0x14d8
// Size: 0xf8
function debris_impact()
{
    self endon( #"stop" );
    a_players_hit = [];
    
    while ( true )
    {
        self waittill( #"trigger", e_player );
        
        if ( !isinarray( a_players_hit, e_player ) && isplayer( e_player ) )
        {
            if ( !isdefined( a_players_hit ) )
            {
                a_players_hit = [];
            }
            else if ( !isarray( a_players_hit ) )
            {
                a_players_hit = array( a_players_hit );
            }
            
            a_players_hit[ a_players_hit.size ] = e_player;
            e_player thread handle_impact( 0.5, 1 );
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0x588bb071, Offset: 0x15d8
// Size: 0xb0
function static_hurt()
{
    level endon( #"underwater_rail_terminate" );
    
    while ( true )
    {
        self waittill( #"trigger", e_player );
        
        if ( !isdefined( e_player.n_uw_static_hurt_time ) || isplayer( e_player ) && gettime() - e_player.n_uw_static_hurt_time > 2000 )
        {
            e_player.n_uw_static_hurt_time = gettime();
            e_player thread handle_impact( 1, 0.75 );
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0x7dc2ff2f, Offset: 0x1690
// Size: 0x50
function play_current_fx()
{
    self endon( #"rail_over" );
    
    while ( true )
    {
        playfxontag( level._effect[ "current_effect" ], self, "tag_origin" );
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0xeb5788f6, Offset: 0x16e8
// Size: 0x154
function handle_split_off()
{
    path_start = getvehiclenode( self.target, "targetname" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !( isdefined( player.v_rail_vehicle.locked_offset ) && player.v_rail_vehicle.locked_offset ) )
        {
            player notify( #"switch_rail" );
            player.v_rail_vehicle vehicle::get_on_and_go_path( path_start );
            player.v_rail_vehicle function_4f28280b( player );
            player.v_rail_vehicle notify( #"rail_over" );
            player thread scene::stop( "cin_sgen_24_01_ride_vign_body_player_flail_" + player.n_ride_position );
            player unlink();
            skipto::objective_completed( "underwater_rail" );
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1
// Checksum 0xdb28849, Offset: 0x1848
// Size: 0x10c
function player_rail_sequence( n_index )
{
    self endon( #"disconnect" );
    self endon( #"switch_rail" );
    self.v_rail_vehicle thread player_rail_control( self );
    self.v_rail_vehicle thread play_current_fx();
    wait 0.8;
    self thread scene::play( "cin_sgen_24_01_ride_vign_body_player_flail_" + self.n_ride_position, self );
    self.v_rail_vehicle vehicle::go_path();
    self.v_rail_vehicle function_4f28280b( self );
    self.v_rail_vehicle notify( #"rail_over" );
    self.animviewunlock = 1;
    self.animinputunlock = 0;
    self unlink();
    self sgen_util::refill_ammo();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1
// Checksum 0x4863097c, Offset: 0x1960
// Size: 0xd6
function function_4f28280b( player )
{
    var_ad88c72f = getvehiclenodearray( "swim_rail_end", "targetname" );
    
    foreach ( index, player_check in level.players )
    {
        if ( player == player_check )
        {
            self vehicle::get_on_and_go_path( var_ad88c72f[ index ] );
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1
// Checksum 0x10d51d72, Offset: 0x1a40
// Size: 0x260
function player_rail_control( player )
{
    player endon( #"disconnect" );
    self endon( #"rail_over" );
    self.y_offset = 0;
    self.z_offset = 0;
    
    while ( true )
    {
        v_stick = player getnormalizedmovement();
        n_left = v_stick[ 1 ];
        n_up = v_stick[ 0 ];
        
        if ( !( isdefined( self.locked_offset ) && self.locked_offset ) )
        {
            if ( n_left < -0.5 )
            {
                if ( self.y_offset > -50 )
                {
                    self.y_offset -= 10;
                }
            }
            else if ( n_left > 0.5 )
            {
                if ( self.y_offset < 50 )
                {
                    self.y_offset += 10;
                }
            }
            else if ( self.y_offset != 0 )
            {
                self.y_offset += self.y_offset > 0 ? -5 : 5;
            }
            
            if ( n_up < -0.5 )
            {
                if ( self.z_offset > -10 )
                {
                    self.z_offset -= 10;
                }
            }
            else if ( n_up > 0.5 )
            {
                if ( self.z_offset < 10 )
                {
                    self.z_offset += 10;
                }
            }
            else if ( self.z_offset != 0 )
            {
                self.z_offset += self.z_offset > 0 ? -5 : 5;
            }
        }
        
        println( self.y_offset );
        self pathfixedoffset( ( 0, self.y_offset, self.z_offset ) );
        wait 0.05;
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 2
// Checksum 0xe3d86440, Offset: 0x1ca8
// Size: 0x104
function handle_impact( n_intensity, n_time )
{
    self endon( #"disconnect" );
    self.v_rail_vehicle.locked_offset = 1;
    self.v_rail_vehicle.y_offset *= -1;
    self.v_rail_vehicle.z_offset *= -1;
    earthquake( n_intensity, n_time, self.origin, 256 );
    self playrumbleonentity( "damage_heavy" );
    self playlocalsound( "evt_waterride_impact" );
    wait n_time * 0.25;
    self.v_rail_vehicle.locked_offset = 0;
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0
// Checksum 0x2d7343b4, Offset: 0x1db8
// Size: 0x14
function init_rail_bot()
{
    self.script_accuracy = 0.1;
}

