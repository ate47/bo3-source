#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace factory_cleanup;

// Namespace factory_cleanup
// Params 0, eflags: 0x2
// Checksum 0xeb34bd10, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "factory_cleanup", &__init__, &__main__, undefined );
}

// Namespace factory_cleanup
// Params 0
// Checksum 0x44981523, Offset: 0x200
// Size: 0x10
function __init__()
{
    level.n_cleanups_processed_this_frame = 0;
}

// Namespace factory_cleanup
// Params 0
// Checksum 0xeacef5d9, Offset: 0x218
// Size: 0x1c
function __main__()
{
    level thread cleanup_main();
}

// Namespace factory_cleanup
// Params 0
// Checksum 0x1e0b6b8, Offset: 0x240
// Size: 0x12
function force_check_now()
{
    level notify( #"pump_distance_check" );
}

// Namespace factory_cleanup
// Params 0, eflags: 0x4
// Checksum 0xa44aac62, Offset: 0x260
// Size: 0x246
function private cleanup_main()
{
    n_next_eval = 0;
    
    while ( true )
    {
        util::wait_network_frame();
        n_time = gettime();
        
        if ( n_time < n_next_eval )
        {
            continue;
        }
        
        if ( isdefined( level.n_cleanup_manager_restart_time ) )
        {
            n_current_time = gettime() / 1000;
            n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
            
            if ( n_delta_time < 0 )
            {
                continue;
            }
            
            level.n_cleanup_manager_restart_time = undefined;
        }
        
        n_round_time = ( n_time - level.round_start_time ) / 1000;
        
        if ( level.round_number <= 5 && n_round_time < 30 )
        {
            continue;
        }
        else if ( level.round_number > 5 && n_round_time < 20 )
        {
            continue;
        }
        
        n_override_cleanup_dist_sq = undefined;
        
        if ( level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3 )
        {
            n_override_cleanup_dist_sq = 2250000;
        }
        
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray( "axis" );
        
        foreach ( ai_enemy in a_ai_enemies )
        {
            if ( level.n_cleanups_processed_this_frame >= 1 )
            {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            
            ai_enemy do_cleanup_check( n_override_cleanup_dist_sq );
        }
    }
}

// Namespace factory_cleanup
// Params 1
// Checksum 0xcc36d44c, Offset: 0x4b0
// Size: 0x274
function do_cleanup_check( n_override_cleanup_dist )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.archetype === "margwa" )
    {
        return;
    }
    
    if ( self.b_ignore_cleanup === 1 )
    {
        return;
    }
    
    n_time_alive = gettime() - self.spawn_time;
    
    if ( n_time_alive < 5000 )
    {
        return;
    }
    
    if ( self.archetype === "zombie" )
    {
        if ( n_time_alive < 45000 && self.script_string !== "find_flesh" && self.completed_emerging_into_playable_area !== 1 )
        {
            return;
        }
    }
    
    b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
    level.n_cleanups_processed_this_frame++;
    
    if ( !b_in_active_zone )
    {
        n_dist_sq_min = 10000000;
        e_closest_player = level.activeplayers[ 0 ];
        
        foreach ( player in level.activeplayers )
        {
            n_dist_sq = distancesquared( self.origin, player.origin );
            
            if ( n_dist_sq < n_dist_sq_min )
            {
                n_dist_sq_min = n_dist_sq;
                e_closest_player = player;
            }
        }
        
        if ( isdefined( n_override_cleanup_dist ) )
        {
            n_cleanup_dist_sq = n_override_cleanup_dist;
        }
        else if ( isdefined( e_closest_player ) && player_ahead_of_me( e_closest_player ) )
        {
            n_cleanup_dist_sq = 189225;
        }
        else
        {
            n_cleanup_dist_sq = 250000;
        }
        
        if ( n_dist_sq_min >= n_cleanup_dist_sq )
        {
            self thread delete_zombie_noone_looking();
        }
    }
}

// Namespace factory_cleanup
// Params 0, eflags: 0x4
// Checksum 0x25e2f71a, Offset: 0x730
// Size: 0x26c
function private delete_zombie_noone_looking()
{
    if ( isdefined( self.in_the_ground ) && self.in_the_ground )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( self player_can_see_me( player ) )
        {
            return;
        }
    }
    
    if ( !( isdefined( self.exclude_cleanup_adding_to_total ) && self.exclude_cleanup_adding_to_total ) )
    {
        level.zombie_total++;
        level.zombie_respawns++;
        
        if ( self.health < self.maxhealth )
        {
            if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = [];
            }
            
            if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = [];
            }
            else if ( !isarray( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = array( level.a_zombie_respawn_health[ self.archetype ] );
            }
            
            level.a_zombie_respawn_health[ self.archetype ][ level.a_zombie_respawn_health[ self.archetype ].size ] = self.health;
        }
    }
    
    self zombie_utility::reset_attack_spot();
    self kill();
    wait 0.05;
    
    if ( isdefined( self ) )
    {
        /#
            debugstar( self.origin, 1000, ( 1, 1, 1 ) );
        #/
        
        self delete();
    }
}

// Namespace factory_cleanup
// Params 1, eflags: 0x4
// Checksum 0xad211ae3, Offset: 0x9a8
// Size: 0xd8, Type: bool
function private player_can_see_me( player )
{
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward( v_player_angles );
    v_player_to_self = self.origin - player getorigin();
    v_player_to_self = vectornormalize( v_player_to_self );
    n_dot = vectordot( v_player_forward, v_player_to_self );
    
    if ( n_dot < 0.766 )
    {
        return false;
    }
    
    return true;
}

// Namespace factory_cleanup
// Params 1, eflags: 0x4
// Checksum 0xa793ceb9, Offset: 0xa88
// Size: 0xb4, Type: bool
function private player_ahead_of_me( player )
{
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward( v_player_angles );
    v_dir = player getorigin() - self.origin;
    n_dot = vectordot( v_player_forward, v_dir );
    
    if ( n_dot < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace factory_cleanup
// Params 0
// Checksum 0xba0bf5e6, Offset: 0xb48
// Size: 0xb4
function get_escape_position()
{
    self endon( #"death" );
    str_zone = self.zone_name;
    
    if ( !isdefined( str_zone ) )
    {
        str_zone = self.zone_name;
    }
    
    if ( isdefined( str_zone ) )
    {
        a_zones = get_adjacencies_to_zone( str_zone );
        a_wait_locations = get_wait_locations_in_zones( a_zones );
        s_farthest = self get_farthest_wait_location( a_wait_locations );
    }
    
    return s_farthest;
}

// Namespace factory_cleanup
// Params 1
// Checksum 0x16b22c75, Offset: 0xc08
// Size: 0x11e
function get_adjacencies_to_zone( str_zone )
{
    a_adjacencies = [];
    a_adjacencies[ 0 ] = str_zone;
    a_adjacent_zones = getarraykeys( level.zones[ str_zone ].adjacent_zones );
    
    for ( i = 0; i < a_adjacent_zones.size ; i++ )
    {
        if ( level.zones[ str_zone ].adjacent_zones[ a_adjacent_zones[ i ] ].is_connected )
        {
            if ( !isdefined( a_adjacencies ) )
            {
                a_adjacencies = [];
            }
            else if ( !isarray( a_adjacencies ) )
            {
                a_adjacencies = array( a_adjacencies );
            }
            
            a_adjacencies[ a_adjacencies.size ] = a_adjacent_zones[ i ];
        }
    }
    
    return a_adjacencies;
}

// Namespace factory_cleanup
// Params 1, eflags: 0x4
// Checksum 0x2758909, Offset: 0xd30
// Size: 0xd2
function private get_wait_locations_in_zones( a_zones )
{
    a_wait_locations = [];
    
    foreach ( zone in a_zones )
    {
        a_wait_locations = arraycombine( a_wait_locations, level.zones[ zone ].a_loc_types[ "dog_location" ], 0, 0 );
    }
    
    return a_wait_locations;
}

// Namespace factory_cleanup
// Params 1, eflags: 0x4
// Checksum 0x7dbc0887, Offset: 0xe10
// Size: 0xd6
function private get_farthest_wait_location( a_wait_locations )
{
    if ( !isdefined( a_wait_locations ) || a_wait_locations.size == 0 )
    {
        return undefined;
    }
    
    n_farthest_index = 0;
    n_distance_farthest = 0;
    
    for ( i = 0; i < a_wait_locations.size ; i++ )
    {
        n_distance_sq = distancesquared( self.origin, a_wait_locations[ i ].origin );
        
        if ( n_distance_sq > n_distance_farthest )
        {
            n_distance_farthest = n_distance_sq;
            n_farthest_index = i;
        }
    }
    
    return a_wait_locations[ n_farthest_index ];
}

// Namespace factory_cleanup
// Params 1, eflags: 0x4
// Checksum 0xf87ba1b4, Offset: 0xef0
// Size: 0x88
function private get_wait_locations_in_zone( zone )
{
    if ( isdefined( level.zones[ zone ].a_loc_types[ "dog_location" ] ) )
    {
        a_wait_locations = [];
        a_wait_locations = arraycombine( a_wait_locations, level.zones[ zone ].a_loc_types[ "dog_location" ], 0, 0 );
        return a_wait_locations;
    }
    
    return undefined;
}

// Namespace factory_cleanup
// Params 0
// Checksum 0xf9b1529e, Offset: 0xf80
// Size: 0x9c
function get_escape_position_in_current_zone()
{
    self endon( #"death" );
    str_zone = self.zone_name;
    
    if ( !isdefined( str_zone ) )
    {
        str_zone = self.zone_name;
    }
    
    if ( isdefined( str_zone ) )
    {
        a_wait_locations = get_wait_locations_in_zone( str_zone );
        
        if ( isdefined( a_wait_locations ) )
        {
            s_farthest = self get_farthest_wait_location( a_wait_locations );
        }
    }
    
    return s_farthest;
}

