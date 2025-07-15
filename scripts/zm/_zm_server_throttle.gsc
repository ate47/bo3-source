#using scripts/codescripts/struct;
#using scripts/zm/_zm_utility;

#namespace zm_server_throttle;

// Namespace zm_server_throttle
// Params 2
// Checksum 0x7bc7a003, Offset: 0xb0
// Size: 0x74
function server_choke_init( id, max )
{
    if ( !isdefined( level.zombie_server_choke_ids_max ) )
    {
        level.zombie_server_choke_ids_max = [];
        level.zombie_server_choke_ids_count = [];
    }
    
    level.zombie_server_choke_ids_max[ id ] = max;
    level.zombie_server_choke_ids_count[ id ] = 0;
    level thread server_choke_thread( id );
}

// Namespace zm_server_throttle
// Params 1
// Checksum 0x638ef7d2, Offset: 0x130
// Size: 0x32
function server_choke_thread( id )
{
    while ( true )
    {
        wait 0.05;
        level.zombie_server_choke_ids_count[ id ] = 0;
    }
}

// Namespace zm_server_throttle
// Params 1
// Checksum 0xcef6e541, Offset: 0x170
// Size: 0x26, Type: bool
function server_choke_safe( id )
{
    return level.zombie_server_choke_ids_count[ id ] < level.zombie_server_choke_ids_max[ id ];
}

// Namespace zm_server_throttle
// Params 5
// Checksum 0xc82f66b4, Offset: 0x1a0
// Size: 0xfe
function server_choke_action( id, choke_action, arg1, arg2, arg3 )
{
    assert( isdefined( level.zombie_server_choke_ids_max[ id ] ), "<dev string:x28>" + id + "<dev string:x37>" );
    
    while ( !server_choke_safe( id ) )
    {
        wait 0.05;
    }
    
    level.zombie_server_choke_ids_count[ id ]++;
    
    if ( !isdefined( arg1 ) )
    {
        return [[ choke_action ]]();
    }
    
    if ( !isdefined( arg2 ) )
    {
        return [[ choke_action ]]( arg1 );
    }
    
    if ( !isdefined( arg3 ) )
    {
        return [[ choke_action ]]( arg1, arg2 );
    }
    
    return [[ choke_action ]]( arg1, arg2, arg3 );
}

// Namespace zm_server_throttle
// Params 1
// Checksum 0xd87ba92a, Offset: 0x2a8
// Size: 0x1e, Type: bool
function server_entity_valid( entity )
{
    if ( !isdefined( entity ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_server_throttle
// Params 2
// Checksum 0xb249da33, Offset: 0x2d0
// Size: 0x7c
function server_safe_init( id, max )
{
    if ( !isdefined( level.zombie_server_choke_ids_max ) || !isdefined( level.zombie_server_choke_ids_max[ id ] ) )
    {
        server_choke_init( id, max );
    }
    
    assert( max == level.zombie_server_choke_ids_max[ id ] );
}

// Namespace zm_server_throttle
// Params 1
// Checksum 0xe52c4f7c, Offset: 0x358
// Size: 0x22
function _server_safe_ground_trace( pos )
{
    return zm_utility::groundpos( pos );
}

// Namespace zm_server_throttle
// Params 3
// Checksum 0x7060ee1c, Offset: 0x388
// Size: 0x5a
function server_safe_ground_trace( id, max, origin )
{
    server_safe_init( id, max );
    return server_choke_action( id, &_server_safe_ground_trace, origin );
}

// Namespace zm_server_throttle
// Params 1
// Checksum 0xbea1832, Offset: 0x3f0
// Size: 0x22
function _server_safe_ground_trace_ignore_water( pos )
{
    return zm_utility::groundpos_ignore_water( pos );
}

// Namespace zm_server_throttle
// Params 3
// Checksum 0x924c085a, Offset: 0x420
// Size: 0x5a
function server_safe_ground_trace_ignore_water( id, max, origin )
{
    server_safe_init( id, max );
    return server_choke_action( id, &_server_safe_ground_trace_ignore_water, origin );
}

