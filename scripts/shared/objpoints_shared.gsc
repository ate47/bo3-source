#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace objpoints;

// Namespace objpoints
// Params 0, eflags: 0x2
// Checksum 0xd15e79da, Offset: 0xf8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "objpoints", &__init__, undefined, undefined );
}

// Namespace objpoints
// Params 0
// Checksum 0x7831ea7c, Offset: 0x138
// Size: 0x70
function __init__()
{
    level.objpointnames = [];
    level.objpoints = [];
    
    if ( isdefined( level.splitscreen ) && level.splitscreen )
    {
        level.objpointsize = 15;
    }
    else
    {
        level.objpointsize = 8;
    }
    
    level.objpoint_alpha_default = 1;
    level.objpointscale = 1;
}

// Namespace objpoints
// Params 6
// Checksum 0x2fe5353d, Offset: 0x1b0
// Size: 0x2ba
function create( name, origin, team, shader, alpha, scale )
{
    assert( isdefined( level.teams[ team ] ) || team == "<dev string:x28>" );
    objpoint = get_by_name( name );
    
    if ( isdefined( objpoint ) )
    {
        delete( objpoint );
    }
    
    if ( !isdefined( shader ) )
    {
        shader = "objpoint_default";
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    if ( team != "all" )
    {
        objpoint = newteamhudelem( team );
    }
    else
    {
        objpoint = newhudelem();
    }
    
    objpoint.name = name;
    objpoint.x = origin[ 0 ];
    objpoint.y = origin[ 1 ];
    objpoint.z = origin[ 2 ];
    objpoint.team = team;
    objpoint.isflashing = 0;
    objpoint.isshown = 1;
    objpoint.fadewhentargeted = 1;
    objpoint.archived = 0;
    objpoint setshader( shader, level.objpointsize, level.objpointsize );
    objpoint setwaypoint( 1 );
    
    if ( isdefined( alpha ) )
    {
        objpoint.alpha = alpha;
    }
    else
    {
        objpoint.alpha = level.objpoint_alpha_default;
    }
    
    objpoint.basealpha = objpoint.alpha;
    objpoint.index = level.objpointnames.size;
    level.objpoints[ name ] = objpoint;
    level.objpointnames[ level.objpointnames.size ] = name;
    return objpoint;
}

// Namespace objpoints
// Params 1
// Checksum 0xb116f0ad, Offset: 0x478
// Size: 0x1a4
function delete( oldobjpoint )
{
    assert( level.objpoints.size == level.objpointnames.size );
    
    if ( level.objpoints.size == 1 )
    {
        assert( level.objpointnames[ 0 ] == oldobjpoint.name );
        assert( isdefined( level.objpoints[ oldobjpoint.name ] ) );
        level.objpoints = [];
        level.objpointnames = [];
        oldobjpoint destroy();
        return;
    }
    
    newindex = oldobjpoint.index;
    oldindex = level.objpointnames.size - 1;
    objpoint = get_by_index( oldindex );
    level.objpointnames[ newindex ] = objpoint.name;
    objpoint.index = newindex;
    level.objpointnames[ oldindex ] = undefined;
    level.objpoints[ oldobjpoint.name ] = undefined;
    oldobjpoint destroy();
}

// Namespace objpoints
// Params 1
// Checksum 0x6ee1ae52, Offset: 0x628
// Size: 0x80
function update_origin( origin )
{
    if ( self.x != origin[ 0 ] )
    {
        self.x = origin[ 0 ];
    }
    
    if ( self.y != origin[ 1 ] )
    {
        self.y = origin[ 1 ];
    }
    
    if ( self.z != origin[ 2 ] )
    {
        self.z = origin[ 2 ];
    }
}

// Namespace objpoints
// Params 2
// Checksum 0x44dd6a72, Offset: 0x6b0
// Size: 0x54
function set_origin_by_name( name, origin )
{
    objpoint = get_by_name( name );
    objpoint update_origin( origin );
}

// Namespace objpoints
// Params 1
// Checksum 0x67d97810, Offset: 0x710
// Size: 0x36
function get_by_name( name )
{
    if ( isdefined( level.objpoints[ name ] ) )
    {
        return level.objpoints[ name ];
    }
    
    return undefined;
}

// Namespace objpoints
// Params 1
// Checksum 0xf9c082c5, Offset: 0x750
// Size: 0x3e
function get_by_index( index )
{
    if ( isdefined( level.objpointnames[ index ] ) )
    {
        return level.objpoints[ level.objpointnames[ index ] ];
    }
    
    return undefined;
}

// Namespace objpoints
// Params 0
// Checksum 0x8a0fe3d7, Offset: 0x798
// Size: 0xb8
function start_flashing()
{
    self endon( #"stop_flashing_thread" );
    
    if ( self.isflashing )
    {
        return;
    }
    
    self.isflashing = 1;
    
    while ( self.isflashing )
    {
        self fadeovertime( 0.75 );
        self.alpha = 0.35 * self.basealpha;
        wait 0.75;
        self fadeovertime( 0.75 );
        self.alpha = self.basealpha;
        wait 0.75;
    }
    
    self.alpha = self.basealpha;
}

// Namespace objpoints
// Params 0
// Checksum 0xff3d7255, Offset: 0x858
// Size: 0x1c
function stop_flashing()
{
    if ( !self.isflashing )
    {
        return;
    }
    
    self.isflashing = 0;
}

