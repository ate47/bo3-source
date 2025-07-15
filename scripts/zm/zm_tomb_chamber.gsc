#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_tomb_utility;

#namespace zm_tomb_chamber;

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x2
// Checksum 0x6822ca56, Offset: 0x270
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_tomb_chamber", &__init__, undefined, undefined );
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0x720f42cf, Offset: 0x2b0
// Size: 0x34
function __init__()
{
    clientfield::register( "scriptmover", "divider_fx", 21000, 1, "counter" );
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0x90f11457, Offset: 0x2f0
// Size: 0x20c
function main()
{
    level thread chamber_wall_change_randomly();
    a_walls = getentarray( "chamber_wall", "script_noteworthy" );
    
    foreach ( e_wall in a_walls )
    {
        e_wall.down_origin = e_wall.origin;
        e_wall.up_origin = ( e_wall.origin[ 0 ], e_wall.origin[ 1 ], e_wall.origin[ 2 ] + 1000 );
    }
    
    level.n_chamber_wall_active = 0;
    level flag::wait_till( "start_zombie_round_logic" );
    wait 3;
    
    foreach ( e_wall in a_walls )
    {
        e_wall moveto( e_wall.up_origin, 0.05 );
        e_wall connectpaths();
    }
    
    /#
        level thread chamber_devgui();
    #/
}

/#

    // Namespace zm_tomb_chamber
    // Params 0
    // Checksum 0x1c921373, Offset: 0x508
    // Size: 0xbc, Type: dev
    function chamber_devgui()
    {
        setdvar( "<dev string:x28>", 5 );
        adddebugcommand( "<dev string:x35>" );
        adddebugcommand( "<dev string:x6b>" );
        adddebugcommand( "<dev string:xa0>" );
        adddebugcommand( "<dev string:xdb>" );
        adddebugcommand( "<dev string:x112>" );
        level thread watch_chamber_wall();
    }

    // Namespace zm_tomb_chamber
    // Params 0
    // Checksum 0xb60e131, Offset: 0x5d0
    // Size: 0x90, Type: dev
    function watch_chamber_wall()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x28>" ) != 5 )
            {
                chamber_change_walls( getdvarint( "<dev string:x28>" ) );
                setdvar( "<dev string:x28>", 5 );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace zm_tomb_chamber
// Params 3
// Checksum 0x6da7302c, Offset: 0x668
// Size: 0x52
function cap_value( val, min, max )
{
    if ( val < min )
    {
        return min;
    }
    
    if ( val > max )
    {
        return max;
    }
    
    return val;
}

// Namespace zm_tomb_chamber
// Params 1
// Checksum 0x8fd2d0fa, Offset: 0x6c8
// Size: 0x170
function chamber_change_walls( n_element )
{
    if ( n_element == level.n_chamber_wall_active )
    {
        return;
    }
    
    e_current_wall = undefined;
    e_new_wall = undefined;
    playsoundatposition( "zmb_chamber_wallchange", ( 10342, -7921, -272 ) );
    a_walls = getentarray( "chamber_wall", "script_noteworthy" );
    
    foreach ( e_wall in a_walls )
    {
        if ( e_wall.script_int == n_element )
        {
            e_wall thread move_wall_down();
            continue;
        }
        
        if ( e_wall.script_int == level.n_chamber_wall_active )
        {
            e_wall thread move_wall_up();
        }
    }
    
    level.n_chamber_wall_active = n_element;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xc111772a, Offset: 0x840
// Size: 0xb4, Type: bool
function is_chamber_occupied()
{
    a_players = getplayers();
    
    foreach ( e_player in a_players )
    {
        if ( is_point_in_chamber( e_player.origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_tomb_chamber
// Params 1
// Checksum 0x863250c1, Offset: 0x900
// Size: 0xac, Type: bool
function is_point_in_chamber( v_origin )
{
    if ( !isdefined( level.s_chamber_center ) )
    {
        level.s_chamber_center = struct::get( "chamber_center", "targetname" );
        level.s_chamber_center.radius_sq = level.s_chamber_center.script_float * level.s_chamber_center.script_float;
    }
    
    return distance2dsquared( level.s_chamber_center.origin, v_origin ) < level.s_chamber_center.radius_sq;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xcfe789cc, Offset: 0x9b8
// Size: 0x1d0
function chamber_wall_change_randomly()
{
    level flag::wait_till( "start_zombie_round_logic" );
    a_element_enums = array( 1, 2, 3, 4 );
    level endon( #"stop_random_chamber_walls" );
    
    for ( n_elem_prev = undefined; true ; n_elem_prev = n_elem )
    {
        while ( !is_chamber_occupied() )
        {
            wait 1;
        }
        
        level flag::wait_till( "any_crystal_picked_up" );
        n_round = cap_value( level.round_number, 10, 30 );
        f_progression_pct = ( n_round - 10 ) / ( 30 - 10 );
        n_change_wall_time = lerpfloat( 15, 5, f_progression_pct );
        n_elem = array::random( a_element_enums );
        arrayremovevalue( a_element_enums, n_elem, 0 );
        
        if ( isdefined( n_elem_prev ) )
        {
            a_element_enums[ a_element_enums.size ] = n_elem_prev;
        }
        
        chamber_change_walls( n_elem );
        wait n_change_wall_time;
    }
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0x68444f8b, Offset: 0xb90
// Size: 0x44
function move_wall_up()
{
    self moveto( self.up_origin, 1 );
    self waittill( #"movedone" );
    self connectpaths();
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0x5b5eb426, Offset: 0xbe0
// Size: 0x84
function move_wall_down()
{
    self moveto( self.down_origin, 1 );
    self waittill( #"movedone" );
    zm_tomb_utility::rumble_players_in_chamber( 2, 0.1 );
    self clientfield::increment( "divider_fx" );
    self disconnectpaths();
}

// Namespace zm_tomb_chamber
// Params 2
// Checksum 0x944aba54, Offset: 0xc70
// Size: 0x9c
function random_shuffle( a_items, item )
{
    b_done_shuffling = undefined;
    
    if ( !isdefined( item ) )
    {
        item = a_items[ a_items.size - 1 ];
    }
    
    while ( !( isdefined( b_done_shuffling ) && b_done_shuffling ) )
    {
        a_items = array::randomize( a_items );
        
        if ( a_items[ 0 ] != item )
        {
            b_done_shuffling = 1;
        }
        
        wait 0.05;
    }
    
    return a_items;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0x2db07a5, Offset: 0xd18
// Size: 0x218
function tomb_chamber_find_exit_point()
{
    self endon( #"death" );
    player = getplayers()[ 0 ];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize( self.origin - player.origin );
    endpos = self.origin + vectorscale( away, 600 );
    locs = array::randomize( level.zm_loc_types[ "wait_location" ] );
    
    for ( i = 0; i < locs.size ; i++ )
    {
        dist_zombie = distancesquared( locs[ i ].origin, endpos );
        dist_player = distancesquared( locs[ i ].origin, player.origin );
        
        if ( dist_zombie < dist_player )
        {
            dest = i;
            break;
        }
    }
    
    self notify( #"stop_find_flesh" );
    self notify( #"zombie_acquire_enemy" );
    
    if ( isdefined( locs[ dest ] ) )
    {
        self setgoalpos( locs[ dest ].origin );
    }
    
    self.b_wandering_in_chamber = 1;
    level flag::wait_till( "player_active_in_chamber" );
    self.b_wandering_in_chamber = 0;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xb5071755, Offset: 0xf38
// Size: 0xc6
function chamber_zombies_find_poi()
{
    zombies = getaiteamarray( level.zombie_team );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( isdefined( zombies[ i ].b_wandering_in_chamber ) && zombies[ i ].b_wandering_in_chamber )
        {
            continue;
        }
        
        if ( !is_point_in_chamber( zombies[ i ].origin ) )
        {
            continue;
        }
        
        zombies[ i ] thread tomb_chamber_find_exit_point();
    }
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xaa700fb9, Offset: 0x1008
// Size: 0x120, Type: bool
function tomb_is_valid_target_in_chamber()
{
    a_players = getplayers();
    
    foreach ( e_player in a_players )
    {
        if ( e_player laststand::player_is_in_laststand() )
        {
            continue;
        }
        
        if ( isdefined( e_player.ignoreme ) && ( isdefined( e_player.b_zombie_blood ) && e_player.b_zombie_blood || e_player.ignoreme ) )
        {
            continue;
        }
        
        if ( !is_point_in_chamber( e_player.origin ) )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xd97ded6c, Offset: 0x1130
// Size: 0x2c
function is_player_in_chamber()
{
    if ( is_point_in_chamber( self.origin ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_tomb_chamber
// Params 0
// Checksum 0xcf2751a9, Offset: 0x1168
// Size: 0xd0
function tomb_watch_chamber_player_activity()
{
    level flag::init( "player_active_in_chamber" );
    level flag::wait_till( "start_zombie_round_logic" );
    
    while ( true )
    {
        wait 1;
        
        if ( is_chamber_occupied() )
        {
            if ( tomb_is_valid_target_in_chamber() )
            {
                level flag::set( "player_active_in_chamber" );
                continue;
            }
            
            level flag::clear( "player_active_in_chamber" );
            chamber_zombies_find_poi();
        }
    }
}

