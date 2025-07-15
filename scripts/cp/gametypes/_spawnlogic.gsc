#using scripts/codescripts/struct;
#using scripts/cp/_callbacks;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;

#namespace spawnlogic;

// Namespace spawnlogic
// Params 0, eflags: 0x2
// Checksum 0x8a8088d7, Offset: 0x348
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "spawnlogic", &__init__, undefined, undefined );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x9fa329bb, Offset: 0x388
// Size: 0x24c
function __init__()
{
    function_4489f2c9();
    
    foreach ( spawn_point in get_all_spawn_points() )
    {
        if ( isdefined( spawn_point.scriptgroup_playerspawns_enable ) )
        {
            foreach ( trig in getentarray( spawn_point.scriptgroup_playerspawns_enable, "scriptgroup_playerspawns_enable" ) )
            {
                spawn_point thread _spawn_point_enable( trig );
            }
        }
        
        if ( isdefined( spawn_point.scriptgroup_playerspawns_disable ) )
        {
            foreach ( trig in getentarray( spawn_point.scriptgroup_playerspawns_disable, "scriptgroup_playerspawns_disable" ) )
            {
                spawn_point thread _spawn_point_disable( trig );
            }
        }
    }
    
    level thread update_spawn_points();
    callback::on_start_gametype( &init );
    
    /#
        level thread debug_spawn_points();
    #/
}

// Namespace spawnlogic
// Params 0
// Checksum 0x3ef5ff22, Offset: 0x5e0
// Size: 0x13a
function function_4489f2c9()
{
    foreach ( spawn_point in get_all_spawn_points() )
    {
        if ( isdefined( spawn_point.linkto ) )
        {
            e_linkto = getent( spawn_point.linkto, "linkname" );
            spawn_point function_98b48204( e_linkto );
            continue;
        }
        
        if ( isdefined( spawn_point.script_linkto ) )
        {
            e_linkto = getent( spawn_point.script_linkto, "targetname" );
            spawn_point function_98b48204( e_linkto );
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xebffd5e7, Offset: 0x728
// Size: 0xdc
function function_98b48204( e_linkto )
{
    var_14497229 = spawn( "script_origin", self.origin );
    var_14497229.angles = self.angles;
    var_14497229.targetname = self.targetname;
    var_14497229.script_objective = self.script_objective;
    var_14497229.scriptgroup_playerspawns_disable = self.scriptgroup_playerspawns_disable;
    var_14497229.scriptgroup_playerspawns_enable = self.scriptgroup_playerspawns_enable;
    
    if ( isdefined( e_linkto ) )
    {
        var_14497229 linkto( e_linkto );
    }
    
    self struct::delete();
}

// Namespace spawnlogic
// Params 1
// Checksum 0xb29b001b, Offset: 0x810
// Size: 0x50
function _spawn_point_enable( trig )
{
    trig endon( #"death" );
    self.disabled = 1;
    
    while ( true )
    {
        trig waittill( #"trigger" );
        function_82c857e9( 0 );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd515bd34, Offset: 0x868
// Size: 0x48
function _spawn_point_disable( trig )
{
    trig endon( #"death" );
    
    while ( true )
    {
        trig waittill( #"trigger" );
        function_82c857e9( 1 );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xe637a5d0, Offset: 0x8b8
// Size: 0x70
function function_82c857e9( b_enabled )
{
    var_1b30c0b0 = isdefined( b_enabled ) && b_enabled ? 1 : undefined;
    
    if ( self.disabled !== var_1b30c0b0 )
    {
        level flagsys::set( "spawnpoints_dirty" );
        self.disabled = var_1b30c0b0;
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xff193c80, Offset: 0x930
// Size: 0x100
function update_spawn_points()
{
    while ( true )
    {
        if ( level flagsys::get( "spawnpoints_dirty" ) )
        {
            foreach ( team in level.teams )
            {
                rebuild_spawn_points( team );
            }
            
            level.unified_spawn_points = undefined;
            spawning::updateallspawnpoints();
            level flagsys::clear( "spawnpoints_dirty" );
        }
        
        wait 0.05;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x6331c46b, Offset: 0xa38
// Size: 0x64
function get_all_spawn_points( b_include_disabled )
{
    a_spawn_points = arraycombine( get_spawnpoint_array( "cp_coop_spawn", b_include_disabled ), get_spawnpoint_array( "cp_coop_respawn", b_include_disabled ), 0, 0 );
    return a_spawn_points;
}

/#

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x300af62a, Offset: 0xaa8
    // Size: 0x2b0, Type: dev
    function debug_spawn_points()
    {
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x28>", 0 );
            setdvar( "<dev string:x38>", 0 );
        }
        
        while ( true )
        {
            b_debug = getdvarint( "<dev string:x28>", 0 );
            
            if ( b_debug )
            {
                foreach ( spawn_point in get_all_spawn_points( 1 ) )
                {
                    color = ( 1, 0, 1 );
                    
                    if ( spawn_point.targetname === "<dev string:x4c>" )
                    {
                        color = ( 0, 0, 1 );
                    }
                    
                    if ( isdefined( spawn_point.different_skipto ) && ( isdefined( spawn_point.disabled ) && spawn_point.disabled || spawn_point.different_skipto ) )
                    {
                        color = ( 1, 0, 0 );
                    }
                    
                    print3d( spawn_point.origin + ( 0, 0, -35 ), spawn_point.targetname, color, 1, 0.3, 1 );
                    print3d( spawn_point.origin + ( 0, 0, -43 ), isdefined( spawn_point.script_objective ) ? spawn_point.script_objective : "<dev string:x5a>", color, 1, 0.3, 1 );
                    box( spawn_point.origin, ( -16, -16, -36 ), ( 16, 16, 36 ), 0, color, 0, 1 );
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 0
// Checksum 0x3091c87f, Offset: 0xd60
// Size: 0x3bc
function init()
{
    /#
        if ( getdvarstring( "<dev string:x64>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x64>", 0 );
        }
        
        level.storespawndata = getdvarint( "<dev string:x64>" );
        
        if ( getdvarstring( "<dev string:x78>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x78>", 0 );
        }
        
        if ( getdvarstring( "<dev string:x85>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x85>", 0.25 );
        }
        
        thread loop_bot_spawns();
    #/
    
    level.spawnlogic_deaths = [];
    level.spawnlogic_spawnkills = [];
    level.players = [];
    level.grenades = [];
    level.pipebombs = [];
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.spawnminsmaxsprimed = 0;
    
    if ( isdefined( level.safespawns ) )
    {
        for ( i = 0; i < level.safespawns.size ; i++ )
        {
            level.safespawns[ i ] spawnpoint_init();
        }
    }
    
    if ( getdvarstring( "scr_spawn_enemyavoiddist" ) == "" )
    {
        setdvar( "scr_spawn_enemyavoiddist", "800" );
    }
    
    if ( getdvarstring( "scr_spawn_enemyavoidweight" ) == "" )
    {
        setdvar( "scr_spawn_enemyavoidweight", "0" );
    }
    
    /#
        if ( getdvarstring( "<dev string:x96>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x96>", "<dev string:xa6>" );
        }
        
        if ( getdvarstring( "<dev string:xa8>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:xa8>", "<dev string:xa6>" );
        }
        
        if ( getdvarint( "<dev string:xa8>" ) > 0 )
        {
            thread show_deaths_debug();
            thread update_death_info_debug();
            thread profile_debug();
        }
        
        if ( level.storespawndata )
        {
            thread allow_spawn_data_reading();
        }
        
        if ( getdvarstring( "<dev string:xbc>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:xbc>", "<dev string:xa6>" );
        }
        
        thread watch_spawn_profile();
        thread spawn_graph_check();
    #/
}

// Namespace spawnlogic
// Params 2
// Checksum 0x5b22b67b, Offset: 0x1128
// Size: 0x1ea
function add_spawn_points_internal( team, spawnpoints )
{
    oldspawnpoints = [];
    
    if ( level.teamspawnpoints[ team ].size )
    {
        oldspawnpoints = level.teamspawnpoints[ team ];
    }
    
    if ( isdefined( level.filter_spawnpoints ) )
    {
        spawnpoints = [[ level.filter_spawnpoints ]]( spawnpoints );
    }
    
    level.teamspawnpoints[ team ] = spawnpoints;
    
    if ( !isdefined( level.spawnpoints ) )
    {
        level.spawnpoints = [];
    }
    
    for ( index = 0; index < level.teamspawnpoints[ team ].size ; index++ )
    {
        spawnpoint = level.teamspawnpoints[ team ][ index ];
        
        if ( !isdefined( spawnpoint.inited ) )
        {
            spawnpoint spawnpoint_init();
            level.spawnpoints[ level.spawnpoints.size ] = spawnpoint;
        }
    }
    
    for ( index = 0; index < oldspawnpoints.size ; index++ )
    {
        origin = oldspawnpoints[ index ].origin;
        level.spawnmins = math::expand_mins( level.spawnmins, origin );
        level.spawnmaxs = math::expand_maxs( level.spawnmaxs, origin );
        level.teamspawnpoints[ team ][ level.teamspawnpoints[ team ].size ] = oldspawnpoints[ index ];
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xafcda111, Offset: 0x1320
// Size: 0x9a
function clear_spawn_points()
{
    foreach ( team in level.teams )
    {
        level.teamspawnpoints[ team ] = [];
    }
    
    level.spawnpoints = [];
    level.unified_spawn_points = undefined;
}

// Namespace spawnlogic
// Params 2
// Checksum 0x67d58d2f, Offset: 0x13c8
// Size: 0xd4
function add_spawn_points( team, spawnpointname )
{
    add_spawn_point_classname( spawnpointname );
    add_spawn_point_team_classname( team, spawnpointname );
    add_spawn_points_internal( team, get_spawnpoint_array( spawnpointname ) );
    
    if ( !level.teamspawnpoints[ team ].size )
    {
        /#
            if ( !isdefined( level.var_a6f85f47 ) )
            {
                assert( level.teamspawnpoints[ team ].size, "<dev string:xcd>" + spawnpointname + "<dev string:xda>" );
            }
        #/
        
        wait 1;
        return;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x66a6eb92, Offset: 0x14a8
// Size: 0x86
function rebuild_spawn_points( team )
{
    level.teamspawnpoints[ team ] = [];
    
    for ( index = 0; index < level.spawn_point_team_class_names[ team ].size ; index++ )
    {
        add_spawn_points_internal( team, get_spawnpoint_array( level.spawn_point_team_class_names[ team ][ index ] ) );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3dd5c882, Offset: 0x1538
// Size: 0x138
function place_spawn_points( spawnpointname )
{
    add_spawn_point_classname( spawnpointname );
    spawnpoints = get_spawnpoint_array( spawnpointname );
    
    /#
        if ( !isdefined( level.extraspawnpointsused ) )
        {
            level.extraspawnpointsused = [];
        }
    #/
    
    if ( !spawnpoints.size )
    {
        println( "<dev string:x12b>" + spawnpointname + "<dev string:x131>" );
        callback::abort_level();
        wait 1;
        return;
    }
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        spawnpoints[ index ] spawnpoint_init();
        
        /#
            spawnpoints[ index ].fakeclassname = spawnpointname;
            level.extraspawnpointsused[ level.extraspawnpointsused.size ] = spawnpoints[ index ];
        #/
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xec46e7f9, Offset: 0x1678
// Size: 0xae
function drop_spawn_points( spawnpointname )
{
    spawnpoints = get_spawnpoint_array( spawnpointname );
    
    if ( !spawnpoints.size )
    {
        println( "<dev string:x12b>" + spawnpointname + "<dev string:x131>" );
        return;
    }
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        spawnpoints[ index ] place_spawn();
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x908dfe4, Offset: 0x1730
// Size: 0x44
function add_spawn_point_classname( spawnpointclassname )
{
    if ( !isdefined( level.spawn_point_class_names ) )
    {
        level.spawn_point_class_names = [];
    }
    
    array::add( level.spawn_point_class_names, spawnpointclassname, 0 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0xfa8e2e9f, Offset: 0x1780
// Size: 0x3c
function add_spawn_point_team_classname( team, spawnpointclassname )
{
    array::add( level.spawn_point_team_class_names[ team ], spawnpointclassname, 0 );
}

// Namespace spawnlogic
// Params 2
// Checksum 0x7b09a86b, Offset: 0x17c8
// Size: 0x21a
function get_spawnpoint_array( classname, b_include_disabled )
{
    if ( !isdefined( b_include_disabled ) )
    {
        b_include_disabled = 0;
    }
    
    a_all_spawn_points = arraycombine( struct::get_array( classname, "targetname" ), getentarray( classname, "targetname" ), 0, 0 );
    a_spawn_points = [];
    
    if ( !b_include_disabled )
    {
        foreach ( spawn_point in a_all_spawn_points )
        {
            if ( !( isdefined( spawn_point.disabled ) && spawn_point.disabled ) )
            {
                if ( !isdefined( a_spawn_points ) )
                {
                    a_spawn_points = [];
                }
                else if ( !isarray( a_spawn_points ) )
                {
                    a_spawn_points = array( a_spawn_points );
                }
                
                a_spawn_points[ a_spawn_points.size ] = spawn_point;
            }
        }
    }
    else
    {
        a_spawn_points = a_all_spawn_points;
    }
    
    if ( !isdefined( level.extraspawnpoints ) || !isdefined( level.extraspawnpoints[ classname ] ) )
    {
        return a_spawn_points;
    }
    
    for ( i = 0; i < level.extraspawnpoints[ classname ].size ; i++ )
    {
        a_spawn_points[ a_spawn_points.size ] = level.extraspawnpoints[ classname ][ i ];
    }
    
    return a_spawn_points;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x50b264b5, Offset: 0x19f0
// Size: 0x160
function spawnpoint_init()
{
    spawnpoint = self;
    origin = spawnpoint.origin;
    
    if ( !level.spawnminsmaxsprimed )
    {
        level.spawnmins = origin;
        level.spawnmaxs = origin;
        level.spawnminsmaxsprimed = 1;
    }
    else
    {
        level.spawnmins = math::expand_mins( level.spawnmins, origin );
        level.spawnmaxs = math::expand_maxs( level.spawnmaxs, origin );
    }
    
    spawnpoint place_spawn();
    
    if ( !isdefined( spawnpoint.angles ) )
    {
        spawnpoint.angles = ( 0, 0, 0 );
    }
    
    spawnpoint.forward = anglestoforward( spawnpoint.angles );
    spawnpoint.sighttracepoint = spawnpoint.origin + ( 0, 0, 50 );
    spawnpoint.inited = 1;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xc09f1e89, Offset: 0x1b58
// Size: 0x18
function get_team_spawnpoints( team )
{
    return level.teamspawnpoints[ team ];
}

// Namespace spawnlogic
// Params 2
// Checksum 0xad6892b3, Offset: 0x1b78
// Size: 0x240
function get_spawnpoint_final( spawnpoints, useweights )
{
    bestspawnpoint = undefined;
    
    if ( !isdefined( spawnpoints ) || spawnpoints.size == 0 )
    {
        return undefined;
    }
    
    if ( !isdefined( useweights ) )
    {
        useweights = 1;
    }
    
    if ( useweights )
    {
        bestspawnpoint = get_best_weighted_spawnpoint( spawnpoints );
        thread spawn_weight_debug( spawnpoints );
    }
    else
    {
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            if ( isdefined( self.lastspawnpoint ) && self.lastspawnpoint == spawnpoints[ i ] )
            {
                continue;
            }
            
            if ( positionwouldtelefrag( spawnpoints[ i ].origin ) )
            {
                continue;
            }
            
            bestspawnpoint = spawnpoints[ i ];
            break;
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            if ( isdefined( self.lastspawnpoint ) && !positionwouldtelefrag( self.lastspawnpoint.origin ) )
            {
                for ( i = 0; i < spawnpoints.size ; i++ )
                {
                    if ( spawnpoints[ i ] == self.lastspawnpoint )
                    {
                        bestspawnpoint = spawnpoints[ i ];
                        break;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( bestspawnpoint ) )
    {
        if ( useweights )
        {
            bestspawnpoint = spawnpoints[ randomint( spawnpoints.size ) ];
        }
        else
        {
            bestspawnpoint = spawnpoints[ 0 ];
        }
    }
    
    self finalize_spawnpoint_choice( bestspawnpoint );
    
    /#
        self store_spawn_data( spawnpoints, useweights, bestspawnpoint );
    #/
    
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x8ee68e39, Offset: 0x1dc0
// Size: 0x58
function finalize_spawnpoint_choice( spawnpoint )
{
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3b7b2e63, Offset: 0x1e20
// Size: 0x2b6
function get_best_weighted_spawnpoint( spawnpoints )
{
    maxsighttracedspawnpoints = 3;
    
    for ( try = 0; try <= maxsighttracedspawnpoints ; try++ )
    {
        bestspawnpoints = [];
        bestweight = undefined;
        bestspawnpoint = undefined;
        
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            if ( !isdefined( bestweight ) || spawnpoints[ i ].weight > bestweight )
            {
                if ( positionwouldtelefrag( spawnpoints[ i ].origin ) )
                {
                    continue;
                }
                
                bestspawnpoints = [];
                bestspawnpoints[ 0 ] = spawnpoints[ i ];
                bestweight = spawnpoints[ i ].weight;
                continue;
            }
            
            if ( spawnpoints[ i ].weight == bestweight )
            {
                if ( positionwouldtelefrag( spawnpoints[ i ].origin ) )
                {
                    continue;
                }
                
                bestspawnpoints[ bestspawnpoints.size ] = spawnpoints[ i ];
            }
        }
        
        if ( bestspawnpoints.size == 0 )
        {
            return undefined;
        }
        
        bestspawnpoint = bestspawnpoints[ randomint( bestspawnpoints.size ) ];
        
        if ( try == maxsighttracedspawnpoints )
        {
            return bestspawnpoint;
        }
        
        if ( isdefined( bestspawnpoint.lastsighttracetime ) && bestspawnpoint.lastsighttracetime == gettime() )
        {
            return bestspawnpoint;
        }
        
        if ( !last_minute_sight_traces( bestspawnpoint ) )
        {
            return bestspawnpoint;
        }
        
        penalty = get_los_penalty();
        
        /#
            if ( level.storespawndata || level.debugspawning )
            {
                bestspawnpoint.spawndata[ bestspawnpoint.spawndata.size ] = "<dev string:x14e>" + penalty;
            }
        #/
        
        bestspawnpoint.weight -= penalty;
        bestspawnpoint.lastsighttracetime = gettime();
    }
}

/#

    // Namespace spawnlogic
    // Params 1
    // Checksum 0x14975231, Offset: 0x20e0
    // Size: 0x156, Type: dev
    function check_bad( spawnpoint )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( !isalive( player ) || player.sessionstate != "<dev string:x169>" )
            {
                continue;
            }
            
            if ( level.teambased && player.team == self.team )
            {
                continue;
            }
            
            losexists = bullettracepassed( player.origin + ( 0, 0, 50 ), spawnpoint.sighttracepoint, 0, undefined );
            
            if ( losexists )
            {
                thread bad_spawn_line( spawnpoint.sighttracepoint, player.origin + ( 0, 0, 50 ), self.name, player.name );
            }
        }
    }

    // Namespace spawnlogic
    // Params 4
    // Checksum 0x3c3150c6, Offset: 0x2240
    // Size: 0xe6, Type: dev
    function bad_spawn_line( start, end, name1, name2 )
    {
        dist = distance( start, end );
        
        for ( i = 0; i < 200 ; i++ )
        {
            line( start, end, ( 1, 0, 0 ) );
            print3d( start, "<dev string:x171>" + name1 + "<dev string:x17d>" + dist );
            print3d( end, name2 );
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 3
    // Checksum 0x6a7e6551, Offset: 0x2330
    // Size: 0x88c, Type: dev
    function store_spawn_data( spawnpoints, useweights, bestspawnpoint )
    {
        if ( !isdefined( level.storespawndata ) || !level.storespawndata )
        {
            return;
        }
        
        level.storespawndata = getdvarint( "<dev string:x64>" );
        
        if ( !level.storespawndata )
        {
            return;
        }
        
        if ( !isdefined( level.spawnid ) )
        {
            level.spawngameid = randomint( 100 );
            level.spawnid = 0;
        }
        
        if ( bestspawnpoint.targetname == "<dev string:x187>" )
        {
            return;
        }
        
        level.spawnid++;
        file = openfile( "<dev string:x19e>", "<dev string:x1ac>" );
        fprintfields( file, level.spawngameid + "<dev string:x1b3>" + level.spawnid + "<dev string:x1b5>" + spawnpoints.size + "<dev string:x1b5>" + self.name );
        
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            str = vec_to_str( spawnpoints[ i ].origin ) + "<dev string:x1b5>";
            
            if ( spawnpoints[ i ] == bestspawnpoint )
            {
                str += "<dev string:x1b7>";
            }
            else
            {
                str += "<dev string:x1ba>";
            }
            
            if ( !useweights )
            {
                str += "<dev string:x1ba>";
            }
            else
            {
                str += spawnpoints[ i ].weight + "<dev string:x1b5>";
            }
            
            if ( !isdefined( spawnpoints[ i ].spawndata ) )
            {
                spawnpoints[ i ].spawndata = [];
            }
            
            if ( !isdefined( spawnpoints[ i ].sightchecks ) )
            {
                spawnpoints[ i ].sightchecks = [];
            }
            
            str += spawnpoints[ i ].spawndata.size + "<dev string:x1b5>";
            
            for ( j = 0; j < spawnpoints[ i ].spawndata.size ; j++ )
            {
                str += spawnpoints[ i ].spawndata[ j ] + "<dev string:x1b5>";
            }
            
            str += spawnpoints[ i ].sightchecks.size + "<dev string:x1b5>";
            
            for ( j = 0; j < spawnpoints[ i ].sightchecks.size ; j++ )
            {
                str += spawnpoints[ i ].sightchecks[ j ].penalty + "<dev string:x1b5>" + vec_to_str( spawnpoints[ i ].origin ) + "<dev string:x1b5>";
            }
            
            fprintfields( file, str );
        }
        
        obj = spawnstruct();
        get_all_allied_and_enemy_players( obj );
        numallies = 0;
        numenemies = 0;
        str = "<dev string:x37>";
        
        for ( i = 0; i < obj.allies.size ; i++ )
        {
            if ( obj.allies[ i ] == self )
            {
                continue;
            }
            
            numallies++;
            str += vec_to_str( obj.allies[ i ].origin ) + "<dev string:x1b5>";
        }
        
        for ( i = 0; i < obj.enemies.size ; i++ )
        {
            numenemies++;
            str += vec_to_str( obj.enemies[ i ].origin ) + "<dev string:x1b5>";
        }
        
        str = numallies + "<dev string:x1b5>" + numenemies + "<dev string:x1b5>" + str;
        fprintfields( file, str );
        otherdata = [];
        
        if ( isdefined( level.bombguy ) )
        {
            index = otherdata.size;
            otherdata[ index ] = spawnstruct();
            otherdata[ index ].origin = level.bombguy.origin + ( 0, 0, 20 );
            otherdata[ index ].text = "<dev string:x1bd>";
        }
        else if ( isdefined( level.bombpos ) )
        {
            index = otherdata.size;
            otherdata[ index ] = spawnstruct();
            otherdata[ index ].origin = level.bombpos;
            otherdata[ index ].text = "<dev string:x1c9>";
        }
        
        if ( isdefined( level.flags ) )
        {
            for ( i = 0; i < level.flags.size ; i++ )
            {
                index = otherdata.size;
                otherdata[ index ] = spawnstruct();
                otherdata[ index ].origin = level.flags[ i ].origin;
                otherdata[ index ].text = level.flags[ i ].useobj gameobjects::get_owner_team() + "<dev string:x1ce>";
            }
        }
        
        str = otherdata.size + "<dev string:x1b5>";
        
        for ( i = 0; i < otherdata.size ; i++ )
        {
            str += vec_to_str( otherdata[ i ].origin ) + "<dev string:x1b5>" + otherdata[ i ].text + "<dev string:x1b5>";
        }
        
        fprintfields( file, str );
        closefile( file );
        thisspawnid = level.spawngameid + "<dev string:x1b3>" + level.spawnid;
        
        if ( isdefined( self.thisspawnid ) )
        {
        }
        
        self.thisspawnid = thisspawnid;
    }

    // Namespace spawnlogic
    // Params 2
    // Checksum 0x11e58333, Offset: 0x2bc8
    // Size: 0xb34, Type: dev
    function read_spawn_data( desiredid, relativepos )
    {
        file = openfile( "<dev string:x19e>", "<dev string:x1d4>" );
        
        if ( file < 0 )
        {
            return;
        }
        
        oldspawndata = level.curspawndata;
        level.curspawndata = undefined;
        prev = undefined;
        prevthisplayer = undefined;
        lookingfornextthisplayer = 0;
        lookingfornext = 0;
        
        if ( isdefined( relativepos ) && !isdefined( oldspawndata ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( freadln( file ) <= 0 )
            {
                break;
            }
            
            data = spawnstruct();
            data.id = fgetarg( file, 0 );
            numspawns = int( fgetarg( file, 1 ) );
            
            if ( numspawns > 256 )
            {
                break;
            }
            
            data.playername = fgetarg( file, 2 );
            data.spawnpoints = [];
            data.friends = [];
            data.enemies = [];
            data.otherdata = [];
            
            for ( i = 0; i < numspawns ; i++ )
            {
                if ( freadln( file ) <= 0 )
                {
                    break;
                }
                
                spawnpoint = spawnstruct();
                spawnpoint.origin = str_to_vec( fgetarg( file, 0 ) );
                spawnpoint.winner = int( fgetarg( file, 1 ) );
                spawnpoint.weight = int( fgetarg( file, 2 ) );
                spawnpoint.data = [];
                spawnpoint.sightchecks = [];
                
                if ( i == 0 )
                {
                    data.minweight = spawnpoint.weight;
                    data.maxweight = spawnpoint.weight;
                }
                else
                {
                    if ( spawnpoint.weight < data.minweight )
                    {
                        data.minweight = spawnpoint.weight;
                    }
                    
                    if ( spawnpoint.weight > data.maxweight )
                    {
                        data.maxweight = spawnpoint.weight;
                    }
                }
                
                argnum = 4;
                numdata = int( fgetarg( file, 3 ) );
                
                if ( numdata > 256 )
                {
                    break;
                }
                
                for ( j = 0; j < numdata ; j++ )
                {
                    spawnpoint.data[ spawnpoint.data.size ] = fgetarg( file, argnum );
                    argnum++;
                }
                
                numsightchecks = int( fgetarg( file, argnum ) );
                argnum++;
                
                if ( numsightchecks > 256 )
                {
                    break;
                }
                
                for ( j = 0; j < numsightchecks ; j++ )
                {
                    index = spawnpoint.sightchecks.size;
                    spawnpoint.sightchecks[ index ] = spawnstruct();
                    spawnpoint.sightchecks[ index ].penalty = int( fgetarg( file, argnum ) );
                    argnum++;
                    spawnpoint.sightchecks[ index ].origin = str_to_vec( fgetarg( file, argnum ) );
                    argnum++;
                }
                
                data.spawnpoints[ data.spawnpoints.size ] = spawnpoint;
            }
            
            if ( !isdefined( data.minweight ) )
            {
                data.minweight = -1;
                data.maxweight = 0;
            }
            
            if ( data.minweight == data.maxweight )
            {
                data.minweight -= 1;
            }
            
            if ( freadln( file ) <= 0 )
            {
                break;
            }
            
            numfriends = int( fgetarg( file, 0 ) );
            numenemies = int( fgetarg( file, 1 ) );
            
            if ( numfriends > 32 || numenemies > 32 )
            {
                break;
            }
            
            argnum = 2;
            
            for ( i = 0; i < numfriends ; i++ )
            {
                data.friends[ data.friends.size ] = str_to_vec( fgetarg( file, argnum ) );
                argnum++;
            }
            
            for ( i = 0; i < numenemies ; i++ )
            {
                data.enemies[ data.enemies.size ] = str_to_vec( fgetarg( file, argnum ) );
                argnum++;
            }
            
            if ( freadln( file ) <= 0 )
            {
                break;
            }
            
            numotherdata = int( fgetarg( file, 0 ) );
            argnum = 1;
            
            for ( i = 0; i < numotherdata ; i++ )
            {
                otherdata = spawnstruct();
                otherdata.origin = str_to_vec( fgetarg( file, argnum ) );
                argnum++;
                otherdata.text = fgetarg( file, argnum );
                argnum++;
                data.otherdata[ data.otherdata.size ] = otherdata;
            }
            
            if ( isdefined( relativepos ) )
            {
                if ( relativepos == "<dev string:x1d9>" )
                {
                    if ( data.id == oldspawndata.id )
                    {
                        level.curspawndata = prevthisplayer;
                        break;
                    }
                }
                else if ( relativepos == "<dev string:x1e8>" )
                {
                    if ( data.id == oldspawndata.id )
                    {
                        level.curspawndata = prev;
                        break;
                    }
                }
                else if ( relativepos == "<dev string:x1ed>" )
                {
                    if ( lookingfornextthisplayer )
                    {
                        level.curspawndata = data;
                        break;
                    }
                    else if ( data.id == oldspawndata.id )
                    {
                        lookingfornextthisplayer = 1;
                    }
                }
                else if ( relativepos == "<dev string:x1fc>" )
                {
                    if ( lookingfornext )
                    {
                        level.curspawndata = data;
                        break;
                    }
                    else if ( data.id == oldspawndata.id )
                    {
                        lookingfornext = 1;
                    }
                }
            }
            else if ( data.id == desiredid )
            {
                level.curspawndata = data;
                break;
            }
            
            prev = data;
            
            if ( isdefined( oldspawndata ) && data.playername == oldspawndata.playername )
            {
                prevthisplayer = data;
            }
        }
        
        closefile( file );
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xa688ec78, Offset: 0x3708
    // Size: 0x474, Type: dev
    function draw_spawn_data()
    {
        level notify( #"drawing_spawn_data" );
        level endon( #"drawing_spawn_data" );
        textoffset = ( 0, 0, -12 );
        
        while ( true )
        {
            if ( !isdefined( level.curspawndata ) )
            {
                wait 0.5;
                continue;
            }
            
            for ( i = 0; i < level.curspawndata.friends.size ; i++ )
            {
                print3d( level.curspawndata.friends[ i ], "<dev string:x201>", ( 0.5, 1, 0.5 ), 1, 5 );
            }
            
            for ( i = 0; i < level.curspawndata.enemies.size ; i++ )
            {
                print3d( level.curspawndata.enemies[ i ], "<dev string:x204>", ( 1, 0.5, 0.5 ), 1, 5 );
            }
            
            for ( i = 0; i < level.curspawndata.otherdata.size ; i++ )
            {
                print3d( level.curspawndata.otherdata[ i ].origin, level.curspawndata.otherdata[ i ].text, ( 0.5, 0.75, 1 ), 1, 2 );
            }
            
            for ( i = 0; i < level.curspawndata.spawnpoints.size ; i++ )
            {
                sp = level.curspawndata.spawnpoints[ i ];
                orig = sp.sighttracepoint;
                
                if ( sp.winner )
                {
                    print3d( orig, level.curspawndata.playername + "<dev string:x207>", ( 0.5, 0.5, 1 ), 1, 2 );
                    orig += textoffset;
                }
                
                amnt = ( sp.weight - level.curspawndata.minweight ) / ( level.curspawndata.maxweight - level.curspawndata.minweight );
                print3d( orig, "<dev string:x215>" + sp.weight, ( 1 - amnt, amnt, 0.5 ) );
                orig += textoffset;
                
                for ( j = 0; j < sp.data.size ; j++ )
                {
                    print3d( orig, sp.data[ j ], ( 1, 1, 1 ) );
                    orig += textoffset;
                }
                
                for ( j = 0; j < sp.sightchecks.size ; j++ )
                {
                    print3d( orig, "<dev string:x21e>" + sp.sightchecks[ j ].penalty, ( 1, 0.5, 0.5 ) );
                    orig += textoffset;
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 1
    // Checksum 0x877cabc6, Offset: 0x3b88
    // Size: 0x7e, Type: dev
    function vec_to_str( vec )
    {
        return int( vec[ 0 ] ) + "<dev string:x22d>" + int( vec[ 1 ] ) + "<dev string:x22d>" + int( vec[ 2 ] );
    }

    // Namespace spawnlogic
    // Params 1
    // Checksum 0x88d89be4, Offset: 0x3c10
    // Size: 0x9e, Type: dev
    function str_to_vec( str )
    {
        parts = strtok( str, "<dev string:x22d>" );
        
        if ( parts.size != 3 )
        {
            return ( 0, 0, 0 );
        }
        
        return ( int( parts[ 0 ] ), int( parts[ 1 ] ), int( parts[ 2 ] ) );
    }

#/

// Namespace spawnlogic
// Params 1
// Checksum 0x7bdf592f, Offset: 0x3cb8
// Size: 0xc2
function get_spawnpoint_random( spawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        j = randomint( spawnpoints.size );
        spawnpoint = spawnpoints[ i ];
        spawnpoints[ i ] = spawnpoints[ j ];
        spawnpoints[ j ] = spawnpoint;
    }
    
    return get_spawnpoint_final( spawnpoints, 0 );
}

// Namespace spawnlogic
// Params 0
// Checksum 0xacb256ab, Offset: 0x3d88
// Size: 0xb4
function get_all_other_players()
{
    aliveplayers = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( !isdefined( level.players[ i ] ) )
        {
            continue;
        }
        
        player = level.players[ i ];
        
        if ( player.sessionstate != "playing" || player == self )
        {
            continue;
        }
        
        aliveplayers[ aliveplayers.size ] = player;
    }
    
    return aliveplayers;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xe24f2998, Offset: 0x3e48
// Size: 0x1ec
function get_all_allied_and_enemy_players( obj )
{
    if ( level.teambased )
    {
        assert( isdefined( level.teams[ self.team ] ) );
        obj.allies = level.aliveplayers[ self.team ];
        obj.enemies = undefined;
        
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            if ( !isdefined( obj.enemies ) )
            {
                obj.enemies = level.aliveplayers[ team ];
                continue;
            }
            
            foreach ( player in level.aliveplayers[ team ] )
            {
                obj.enemies[ obj.enemies.size ] = player;
            }
        }
        
        return;
    }
    
    obj.allies = [];
    obj.enemies = level.activeplayers;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xafbe77a0, Offset: 0x4040
// Size: 0xba
function init_weights( spawnpoints )
{
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        spawnpoints[ i ].weight = 0;
    }
    
    /#
        if ( level.storespawndata || level.debugspawning )
        {
            for ( i = 0; i < spawnpoints.size ; i++ )
            {
                spawnpoints[ i ].spawndata = [];
                spawnpoints[ i ].sightchecks = [];
            }
        }
    #/
}

// Namespace spawnlogic
// Params 2
// Checksum 0x845bccb9, Offset: 0x4108
// Size: 0x540
function get_spawnpoint_near_team( spawnpoints, favoredspawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    /#
        if ( getdvarstring( "<dev string:x22f>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x22f>", "<dev string:xa6>" );
        }
        
        if ( getdvarstring( "<dev string:x22f>" ) == "<dev string:x242>" )
        {
            return get_spawnpoint_random( spawnpoints );
        }
    #/
    
    if ( getdvarint( "scr_spawnsimple" ) > 0 )
    {
        return get_spawnpoint_random( spawnpoints );
    }
    
    begin();
    k_favored_spawn_point_bonus = 25000;
    init_weights( spawnpoints );
    obj = spawnstruct();
    get_all_allied_and_enemy_players( obj );
    numplayers = obj.allies.size + obj.enemies.size;
    allieddistanceweight = 2;
    myteam = self.team;
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        spawnpoint = spawnpoints[ i ];
        
        if ( !isdefined( spawnpoint.numplayersatlastupdate ) )
        {
            spawnpoint.numplayersatlastupdate = 0;
        }
        
        if ( spawnpoint.numplayersatlastupdate > 0 )
        {
            allydistsum = spawnpoint.distsum[ myteam ];
            enemydistsum = spawnpoint.enemydistsum[ myteam ];
            spawnpoint.weight = ( enemydistsum - allieddistanceweight * allydistsum ) / spawnpoint.numplayersatlastupdate;
            
            /#
                if ( level.storespawndata || level.debugspawning )
                {
                    spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x244>" + int( spawnpoint.weight ) + "<dev string:x252>" + int( enemydistsum ) + "<dev string:x257>" + allieddistanceweight + "<dev string:x25b>" + int( allydistsum ) + "<dev string:x25d>" + spawnpoint.numplayersatlastupdate;
                }
            #/
            
            continue;
        }
        
        spawnpoint.weight = 0;
        
        /#
            if ( level.storespawndata || level.debugspawning )
            {
                spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x262>";
            }
        #/
    }
    
    if ( isdefined( favoredspawnpoints ) )
    {
        for ( i = 0; i < favoredspawnpoints.size ; i++ )
        {
            if ( isdefined( favoredspawnpoints[ i ].weight ) )
            {
                favoredspawnpoints[ i ].weight += k_favored_spawn_point_bonus;
                continue;
            }
            
            favoredspawnpoints[ i ].weight = k_favored_spawn_point_bonus;
        }
    }
    
    avoid_same_spawn( spawnpoints );
    avoid_spawn_reuse( spawnpoints, 1 );
    avoid_weapon_damage( spawnpoints );
    avoid_visible_enemies( spawnpoints, 1 );
    result = get_spawnpoint_final( spawnpoints );
    
    /#
        if ( getdvarstring( "<dev string:x271>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x271>", "<dev string:xa6>" );
        }
        
        if ( getdvarstring( "<dev string:x271>" ) == "<dev string:x242>" )
        {
            check_bad( result );
        }
    #/
    
    return result;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xfa1ae4f7, Offset: 0x4650
// Size: 0x29a
function get_spawnpoint_dm( spawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    begin();
    init_weights( spawnpoints );
    aliveplayers = get_all_other_players();
    idealdist = 1600;
    baddist = 1200;
    
    if ( aliveplayers.size > 0 )
    {
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            totaldistfromideal = 0;
            nearbybadamount = 0;
            
            for ( j = 0; j < aliveplayers.size ; j++ )
            {
                dist = distance( spawnpoints[ i ].origin, aliveplayers[ j ].origin );
                
                if ( dist < baddist )
                {
                    nearbybadamount += ( baddist - dist ) / baddist;
                }
                
                distfromideal = abs( dist - idealdist );
                totaldistfromideal += distfromideal;
            }
            
            avgdistfromideal = totaldistfromideal / aliveplayers.size;
            welldistancedamount = ( idealdist - avgdistfromideal ) / idealdist;
            spawnpoints[ i ].weight = welldistancedamount - nearbybadamount * 2 + randomfloat( 0.2 );
        }
    }
    
    avoid_same_spawn( spawnpoints );
    avoid_spawn_reuse( spawnpoints, 0 );
    avoid_weapon_damage( spawnpoints );
    avoid_visible_enemies( spawnpoints, 0 );
    return get_spawnpoint_final( spawnpoints );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x7a324981, Offset: 0x48f8
// Size: 0x50
function begin()
{
    /#
        level.storespawndata = getdvarint( "<dev string:x64>" );
        level.debugspawning = getdvarint( "<dev string:xa8>" ) > 0;
    #/
}

/#

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x1a1ae24f, Offset: 0x4950
    // Size: 0xa6, Type: dev
    function watch_spawn_profile()
    {
        while ( true )
        {
            while ( true )
            {
                if ( getdvarint( "<dev string:xbc>" ) > 0 )
                {
                    break;
                }
                
                wait 0.05;
            }
            
            thread spawn_profile();
            
            while ( true )
            {
                if ( getdvarint( "<dev string:xbc>" ) <= 0 )
                {
                    break;
                }
                
                wait 0.05;
            }
            
            level notify( #"stop_spawn_profile" );
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x12ca3ac, Offset: 0x4a00
    // Size: 0x110, Type: dev
    function spawn_profile()
    {
        level endon( #"stop_spawn_profile" );
        
        while ( true )
        {
            if ( level.players.size > 0 && level.spawnpoints.size > 0 )
            {
                playernum = randomint( level.players.size );
                player = level.players[ playernum ];
                attempt = 1;
                
                while ( !isdefined( player ) && attempt < level.players.size )
                {
                    playernum = ( playernum + 1 ) % level.players.size;
                    attempt++;
                    player = level.players[ playernum ];
                }
                
                player get_spawnpoint_near_team( level.spawnpoints );
            }
            
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xa2f3901c, Offset: 0x4b18
    // Size: 0x5a, Type: dev
    function spawn_graph_check()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x283>" ) < 1 )
            {
                wait 3;
                continue;
            }
            
            thread spawn_graph();
            return;
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x8a7da13b, Offset: 0x4b80
    // Size: 0x650, Type: dev
    function spawn_graph()
    {
        w = 20;
        h = 20;
        weightscale = 0.1;
        fakespawnpoints = [];
        corners = getentarray( "<dev string:x292>", "<dev string:x2a1>" );
        
        if ( corners.size != 2 )
        {
            println( "<dev string:x2ac>" );
            return;
        }
        
        min = corners[ 0 ].origin;
        max = corners[ 0 ].origin;
        
        if ( corners[ 1 ].origin[ 0 ] > max[ 0 ] )
        {
            max = ( corners[ 1 ].origin[ 0 ], max[ 1 ], max[ 2 ] );
        }
        else
        {
            min = ( corners[ 1 ].origin[ 0 ], min[ 1 ], min[ 2 ] );
        }
        
        if ( corners[ 1 ].origin[ 1 ] > max[ 1 ] )
        {
            max = ( max[ 0 ], corners[ 1 ].origin[ 1 ], max[ 2 ] );
        }
        else
        {
            min = ( min[ 0 ], corners[ 1 ].origin[ 1 ], min[ 2 ] );
        }
        
        i = 0;
        
        for ( y = 0; y < h ; y++ )
        {
            yamnt = y / ( h - 1 );
            
            for ( x = 0; x < w ; x++ )
            {
                xamnt = x / ( w - 1 );
                fakespawnpoints[ i ] = spawnstruct();
                fakespawnpoints[ i ].origin = ( min[ 0 ] * xamnt + max[ 0 ] * ( 1 - xamnt ), min[ 1 ] * yamnt + max[ 1 ] * ( 1 - yamnt ), min[ 2 ] );
                fakespawnpoints[ i ].angles = ( 0, 0, 0 );
                fakespawnpoints[ i ].forward = anglestoforward( fakespawnpoints[ i ].angles );
                fakespawnpoints[ i ].sighttracepoint = fakespawnpoints[ i ].origin;
                i++;
            }
        }
        
        didweights = 0;
        
        while ( true )
        {
            spawni = 0;
            numiters = 5;
            
            for ( i = 0; i < numiters ; i++ )
            {
                if ( !level.players.size || !isdefined( level.players[ 0 ].team ) || level.players[ 0 ].team == "<dev string:x2d5>" || !isdefined( level.players[ 0 ].curclass ) )
                {
                    break;
                }
                
                endspawni = spawni + fakespawnpoints.size / numiters;
                
                if ( i == numiters - 1 )
                {
                    endspawni = fakespawnpoints.size;
                }
                
                while ( spawni < endspawni )
                {
                    spawnpoint_update( fakespawnpoints[ spawni ] );
                    spawni++;
                }
                
                if ( didweights )
                {
                    level.players[ 0 ] draw_spawn_graph( fakespawnpoints, w, h, weightscale );
                }
                
                wait 0.05;
            }
            
            if ( !level.players.size || !isdefined( level.players[ 0 ].team ) || level.players[ 0 ].team == "<dev string:x2d5>" || !isdefined( level.players[ 0 ].curclass ) )
            {
                wait 1;
                continue;
            }
            
            level.players[ 0 ] get_spawnpoint_near_team( fakespawnpoints );
            
            for ( i = 0; i < fakespawnpoints.size ; i++ )
            {
                setup_spawn_graph_point( fakespawnpoints[ i ], weightscale );
            }
            
            didweights = 1;
            level.players[ 0 ] draw_spawn_graph( fakespawnpoints, w, h, weightscale );
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 4
    // Checksum 0xe87546d, Offset: 0x51d8
    // Size: 0x146, Type: dev
    function draw_spawn_graph( fakespawnpoints, w, h, weightscale )
    {
        i = 0;
        
        for ( y = 0; y < h ; y++ )
        {
            yamnt = y / ( h - 1 );
            
            for ( x = 0; x < w ; x++ )
            {
                xamnt = x / ( w - 1 );
                
                if ( y > 0 )
                {
                    spawn_graph_line( fakespawnpoints[ i ], fakespawnpoints[ i - w ], weightscale );
                }
                
                if ( x > 0 )
                {
                    spawn_graph_line( fakespawnpoints[ i ], fakespawnpoints[ i - 1 ], weightscale );
                }
                
                i++;
            }
        }
    }

    // Namespace spawnlogic
    // Params 2
    // Checksum 0xdaa8bdaa, Offset: 0x5328
    // Size: 0x5c, Type: dev
    function setup_spawn_graph_point( s1, weightscale )
    {
        s1.visible = 1;
        
        if ( s1.weight < -1000 / weightscale )
        {
            s1.visible = 0;
        }
    }

    // Namespace spawnlogic
    // Params 3
    // Checksum 0x658a4ea6, Offset: 0x5390
    // Size: 0xdc, Type: dev
    function spawn_graph_line( s1, s2, weightscale )
    {
        if ( !s1.visible || !s2.visible )
        {
            return;
        }
        
        p1 = s1.origin + ( 0, 0, s1.weight * weightscale + 100 );
        p2 = s2.origin + ( 0, 0, s2.weight * weightscale + 100 );
        line( p1, p2, ( 1, 1, 1 ) );
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xc305282a, Offset: 0x5478
    // Size: 0x374, Type: dev
    function loop_bot_spawns()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x78>" ) < 1 )
            {
                wait 3;
                continue;
            }
            
            if ( !isdefined( level.players ) )
            {
                wait 0.05;
                continue;
            }
            
            bots = [];
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                if ( !isdefined( level.players[ i ] ) )
                {
                    continue;
                }
                
                if ( level.players[ i ].sessionstate == "<dev string:x169>" && issubstr( level.players[ i ].name, "<dev string:x2df>" ) )
                {
                    bots[ bots.size ] = level.players[ i ];
                }
            }
            
            if ( bots.size > 0 )
            {
                if ( getdvarint( "<dev string:x78>" ) == 1 )
                {
                    killer = bots[ randomint( bots.size ) ];
                    victim = bots[ randomint( bots.size ) ];
                    victim thread [[ level.callbackplayerdamage ]]( killer, killer, 1000, 0, "<dev string:x2e3>", level.weaponnone, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x2f4>", ( 0, 0, 0 ), 0, 0, ( 1, 0, 0 ) );
                }
                else
                {
                    numkills = getdvarint( "<dev string:x78>" );
                    lastvictim = undefined;
                    
                    for ( index = 0; index < numkills ; index++ )
                    {
                        killer = bots[ randomint( bots.size ) ];
                        
                        for ( victim = bots[ randomint( bots.size ) ]; isdefined( lastvictim ) && victim == lastvictim ; victim = bots[ randomint( bots.size ) ] )
                        {
                        }
                        
                        victim thread [[ level.callbackplayerdamage ]]( killer, killer, 1000, 0, "<dev string:x2e3>", level.weaponnone, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x2f4>", ( 0, 0, 0 ), 0, 0, ( 1, 0, 0 ) );
                        lastvictim = victim;
                    }
                }
            }
            
            if ( getdvarstring( "<dev string:x85>" ) != "<dev string:x37>" )
            {
                wait getdvarfloat( "<dev string:x85>" );
                continue;
            }
            
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x4656ee6c, Offset: 0x57f8
    // Size: 0x1e8, Type: dev
    function allow_spawn_data_reading()
    {
        setdvar( "<dev string:x2f9>", "<dev string:x37>" );
        prevval = getdvarstring( "<dev string:x2f9>" );
        prevrelval = getdvarstring( "<dev string:x309>" );
        readthistime = 0;
        
        while ( true )
        {
            val = getdvarstring( "<dev string:x2f9>" );
            relval = undefined;
            
            if ( !isdefined( val ) || val == prevval )
            {
                relval = getdvarstring( "<dev string:x309>" );
                
                if ( isdefined( relval ) && relval != "<dev string:x37>" )
                {
                    setdvar( "<dev string:x309>", "<dev string:x37>" );
                }
                else
                {
                    wait 0.5;
                    continue;
                }
            }
            
            prevval = val;
            readthistime = 0;
            read_spawn_data( val, relval );
            
            if ( !isdefined( level.curspawndata ) )
            {
                println( "<dev string:x31a>" );
            }
            else
            {
                println( "<dev string:x331>" + level.curspawndata.id );
            }
            
            thread draw_spawn_data();
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xe7ee5738, Offset: 0x59e8
    // Size: 0x4b0, Type: dev
    function show_deaths_debug()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:xa8>" ) == "<dev string:xa6>" )
            {
                wait 3;
                continue;
            }
            
            time = gettime();
            
            for ( i = 0; i < level.spawnlogic_deaths.size ; i++ )
            {
                if ( isdefined( level.spawnlogic_deaths[ i ].los ) )
                {
                    line( level.spawnlogic_deaths[ i ].org, level.spawnlogic_deaths[ i ].killorg, ( 1, 0, 0 ) );
                }
                else
                {
                    line( level.spawnlogic_deaths[ i ].org, level.spawnlogic_deaths[ i ].killorg, ( 1, 1, 1 ) );
                }
                
                killer = level.spawnlogic_deaths[ i ].killer;
                
                if ( isdefined( killer ) && isalive( killer ) )
                {
                    line( level.spawnlogic_deaths[ i ].killorg, killer.origin, ( 0.4, 0.4, 0.8 ) );
                }
            }
            
            for ( p = 0; p < level.players.size ; p++ )
            {
                if ( !isdefined( level.players[ p ] ) )
                {
                    continue;
                }
                
                if ( isdefined( level.players[ p ].spawnlogic_killdist ) )
                {
                    print3d( level.players[ p ].origin + ( 0, 0, 64 ), level.players[ p ].spawnlogic_killdist, ( 1, 1, 1 ) );
                }
            }
            
            oldspawnkills = level.spawnlogic_spawnkills;
            level.spawnlogic_spawnkills = [];
            
            for ( i = 0; i < oldspawnkills.size ; i++ )
            {
                spawnkill = oldspawnkills[ i ];
                
                if ( spawnkill.dierwasspawner )
                {
                    line( spawnkill.spawnpointorigin, spawnkill.dierorigin, ( 0.4, 0.5, 0.4 ) );
                    line( spawnkill.dierorigin, spawnkill.killerorigin, ( 0, 1, 1 ) );
                    print3d( spawnkill.dierorigin + ( 0, 0, 32 ), "<dev string:x343>", ( 0, 1, 1 ) );
                }
                else
                {
                    line( spawnkill.spawnpointorigin, spawnkill.killerorigin, ( 0.4, 0.5, 0.4 ) );
                    line( spawnkill.killerorigin, spawnkill.dierorigin, ( 0, 1, 1 ) );
                    print3d( spawnkill.dierorigin + ( 0, 0, 32 ), "<dev string:x350>", ( 0, 1, 1 ) );
                }
                
                if ( time - spawnkill.time < 60000 )
                {
                    level.spawnlogic_spawnkills[ level.spawnlogic_spawnkills.size ] = oldspawnkills[ i ];
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 0
// Checksum 0x63dd92ba, Offset: 0x5ea0
// Size: 0x56
function update_death_info_debug()
{
    while ( true )
    {
        if ( getdvarstring( "scr_spawnpointdebug" ) == "0" )
        {
            wait 3;
            continue;
        }
        
        update_death_info();
        wait 3;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x94f24a10, Offset: 0x5f00
// Size: 0x314
function spawn_weight_debug( spawnpoints )
{
    level notify( #"stop_spawn_weight_debug" );
    level endon( #"stop_spawn_weight_debug" );
    
    /#
        while ( true )
        {
            if ( getdvarstring( "<dev string:xa8>" ) == "<dev string:xa6>" )
            {
                wait 3;
                continue;
            }
            
            textoffset = ( 0, 0, -12 );
            
            for ( i = 0; i < spawnpoints.size ; i++ )
            {
                amnt = 1 * ( 1 - spawnpoints[ i ].weight / -100000 );
                
                if ( amnt < 0 )
                {
                    amnt = 0;
                }
                
                if ( amnt > 1 )
                {
                    amnt = 1;
                }
                
                orig = spawnpoints[ i ].origin + ( 0, 0, 80 );
                print3d( orig, int( spawnpoints[ i ].weight ), ( 1, amnt, 0.5 ) );
                orig += textoffset;
                
                if ( isdefined( spawnpoints[ i ].spawndata ) )
                {
                    for ( j = 0; j < spawnpoints[ i ].spawndata.size ; j++ )
                    {
                        print3d( orig, spawnpoints[ i ].spawndata[ j ], ( 0.5, 0.5, 0.5 ) );
                        orig += textoffset;
                    }
                }
                
                if ( isdefined( spawnpoints[ i ].sightchecks ) )
                {
                    for ( j = 0; j < spawnpoints[ i ].sightchecks.size ; j++ )
                    {
                        if ( spawnpoints[ i ].sightchecks[ j ].penalty == 0 )
                        {
                            continue;
                        }
                        
                        print3d( orig, "<dev string:x35b>" + spawnpoints[ i ].sightchecks[ j ].penalty, ( 0.5, 0.5, 0.5 ) );
                        orig += textoffset;
                    }
                }
            }
            
            wait 0.05;
        }
    #/
}

// Namespace spawnlogic
// Params 0
// Checksum 0xfd9796c0, Offset: 0x6220
// Size: 0xf0
function profile_debug()
{
    while ( true )
    {
        if ( getdvarstring( "scr_spawnpointprofile" ) != "1" )
        {
            wait 3;
            continue;
        }
        
        for ( i = 0; i < level.spawnpoints.size ; i++ )
        {
            level.spawnpoints[ i ].weight = randomint( 10000 );
        }
        
        if ( level.players.size > 0 )
        {
            level.players[ randomint( level.players.size ) ] get_spawnpoint_near_team( level.spawnpoints );
        }
        
        wait 0.05;
    }
}

/#

    // Namespace spawnlogic
    // Params 2
    // Checksum 0xc2a22c43, Offset: 0x6318
    // Size: 0xe0, Type: dev
    function debug_nearby_players( players, origin )
    {
        if ( getdvarstring( "<dev string:xa8>" ) == "<dev string:xa6>" )
        {
            return;
        }
        
        starttime = gettime();
        
        while ( true )
        {
            for ( i = 0; i < players.size ; i++ )
            {
                line( players[ i ].origin, origin, ( 0.5, 1, 0.5 ) );
            }
            
            if ( gettime() - starttime > 5000 )
            {
                return;
            }
            
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 2
// Checksum 0xc5612788, Offset: 0x6400
// Size: 0x14
function death_occured( dier, killer )
{
    
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd976df9e, Offset: 0x6420
// Size: 0x122
function check_for_similar_deaths( deathinfo )
{
    for ( i = 0; i < level.spawnlogic_deaths.size ; i++ )
    {
        if ( level.spawnlogic_deaths[ i ].killer == deathinfo.killer )
        {
            dist = distance( level.spawnlogic_deaths[ i ].org, deathinfo.org );
            
            if ( dist > 200 )
            {
                continue;
            }
            
            dist = distance( level.spawnlogic_deaths[ i ].killorg, deathinfo.killorg );
            
            if ( dist > 200 )
            {
                continue;
            }
            
            level.spawnlogic_deaths[ i ].remove = 1;
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x3f01d1a8, Offset: 0x6550
// Size: 0x1e4
function update_death_info()
{
    time = gettime();
    
    for ( i = 0; i < level.spawnlogic_deaths.size ; i++ )
    {
        deathinfo = level.spawnlogic_deaths[ i ];
        
        if ( time - deathinfo.time > 90000 || !isdefined( deathinfo.killer ) || !isalive( deathinfo.killer ) || !isdefined( level.teams[ deathinfo.killer.team ] ) || distance( deathinfo.killer.origin, deathinfo.killorg ) > 400 )
        {
            level.spawnlogic_deaths[ i ].remove = 1;
        }
    }
    
    oldarray = level.spawnlogic_deaths;
    level.spawnlogic_deaths = [];
    start = 0;
    
    if ( oldarray.size - 1024 > 0 )
    {
        start = oldarray.size - 1024;
    }
    
    for ( i = start; i < oldarray.size ; i++ )
    {
        if ( !isdefined( oldarray[ i ].remove ) )
        {
            level.spawnlogic_deaths[ level.spawnlogic_deaths.size ] = oldarray[ i ];
        }
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x73fbdd1b, Offset: 0x6740
// Size: 0x128, Type: bool
function is_point_vulnerable( playerorigin )
{
    pos = self.origin + level.bettymodelcenteroffset;
    playerpos = playerorigin + ( 0, 0, 32 );
    distsqrd = distancesquared( pos, playerpos );
    forward = anglestoforward( self.angles );
    
    if ( distsqrd < level.bettydetectionradius * level.bettydetectionradius )
    {
        playerdir = vectornormalize( playerpos - pos );
        angle = acos( vectordot( playerdir, forward ) );
        
        if ( angle < level.bettydetectionconeangle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x9bf393c4, Offset: 0x6870
// Size: 0x212
function avoid_weapon_damage( spawnpoints )
{
    if ( getdvarstring( "scr_spawnpointnewlogic" ) == "0" )
    {
        return;
    }
    
    weapondamagepenalty = 100000;
    
    if ( getdvarstring( "scr_spawnpointweaponpenalty" ) != "" && getdvarstring( "scr_spawnpointweaponpenalty" ) != "0" )
    {
        weapondamagepenalty = getdvarfloat( "scr_spawnpointweaponpenalty" );
    }
    
    mingrenadedistsquared = 62500;
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        for ( j = 0; j < level.grenades.size ; j++ )
        {
            if ( !isdefined( level.grenades[ j ] ) )
            {
                continue;
            }
            
            if ( distancesquared( spawnpoints[ i ].origin, level.grenades[ j ].origin ) < mingrenadedistsquared )
            {
                spawnpoints[ i ].weight -= weapondamagepenalty;
                
                /#
                    if ( level.storespawndata || level.debugspawning )
                    {
                        spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x36d>" + int( weapondamagepenalty );
                    }
                #/
            }
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xaf74b47f, Offset: 0x6a90
// Size: 0x80
function spawn_per_frame_update()
{
    spawnpointindex = 0;
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( level.spawnpoints ) )
        {
            return;
        }
        
        spawnpointindex = ( spawnpointindex + 1 ) % level.spawnpoints.size;
        spawnpoint = level.spawnpoints[ spawnpointindex ];
        spawnpoint_update( spawnpoint );
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0x8422b618, Offset: 0x6b18
// Size: 0xc0
function get_non_team_sum( skip_team, sums )
{
    value = 0;
    
    foreach ( team in level.teams )
    {
        if ( team == skip_team )
        {
            continue;
        }
        
        value += sums[ team ];
    }
    
    return value;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xb500b02f, Offset: 0x6be0
// Size: 0xd2
function get_non_team_min_dist( skip_team, mindists )
{
    dist = 9999999;
    
    foreach ( team in level.teams )
    {
        if ( team == skip_team )
        {
            continue;
        }
        
        if ( dist > mindists[ team ] )
        {
            dist = mindists[ team ];
        }
    }
    
    return dist;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd5f0d82f, Offset: 0x6cc0
// Size: 0x6ea
function spawnpoint_update( spawnpoint )
{
    if ( level.teambased )
    {
        sights = [];
        
        foreach ( team in level.teams )
        {
            spawnpoint.enemysights[ team ] = 0;
            sights[ team ] = 0;
            spawnpoint.nearbyplayers[ team ] = [];
        }
    }
    else
    {
        spawnpoint.enemysights = 0;
        spawnpoint.nearbyplayers[ "all" ] = [];
    }
    
    spawnpointdir = spawnpoint.forward;
    debug = 0;
    
    /#
        debug = getdvarint( "<dev string:xa8>" ) > 0;
    #/
    
    mindist = [];
    distsum = [];
    
    if ( !level.teambased )
    {
        mindist[ "all" ] = 9999999;
    }
    
    foreach ( team in level.teams )
    {
        spawnpoint.distsum[ team ] = 0;
        spawnpoint.enemydistsum[ team ] = 0;
        spawnpoint.minenemydist[ team ] = 9999999;
        mindist[ team ] = 9999999;
    }
    
    spawnpoint.numplayersatlastupdate = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        diff = player.origin - spawnpoint.origin;
        diff = ( diff[ 0 ], diff[ 1 ], 0 );
        dist = length( diff );
        team = "all";
        
        if ( level.teambased )
        {
            team = player.team;
        }
        
        if ( dist < 1024 )
        {
            spawnpoint.nearbyplayers[ team ][ spawnpoint.nearbyplayers[ team ].size ] = player;
        }
        
        if ( dist < mindist[ team ] )
        {
            mindist[ team ] = dist;
        }
        
        distsum[ team ] += dist;
        spawnpoint.numplayersatlastupdate++;
        pdir = anglestoforward( player.angles );
        
        if ( vectordot( spawnpointdir, diff ) < 0 && vectordot( pdir, diff ) > 0 )
        {
            continue;
        }
        
        losexists = bullettracepassed( player.origin + ( 0, 0, 50 ), spawnpoint.sighttracepoint, 0, undefined );
        spawnpoint.lastsighttracetime = gettime();
        
        if ( losexists )
        {
            if ( level.teambased )
            {
                sights[ player.team ]++;
            }
            else
            {
                spawnpoint.enemysights++;
            }
            
            /#
                if ( debug )
                {
                    line( player.origin + ( 0, 0, 50 ), spawnpoint.sighttracepoint, ( 0.5, 1, 0.5 ) );
                }
            #/
        }
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            spawnpoint.enemysights[ team ] = get_non_team_sum( team, sights );
            spawnpoint.minenemydist[ team ] = get_non_team_min_dist( team, mindist );
            spawnpoint.distsum[ team ] = distsum[ team ];
            spawnpoint.enemydistsum[ team ] = get_non_team_sum( team, distsum );
        }
        
        return;
    }
    
    spawnpoint.distsum[ "all" ] = distsum[ "all" ];
    spawnpoint.enemydistsum[ "all" ] = distsum[ "all" ];
    spawnpoint.minenemydist[ "all" ] = mindist[ "all" ];
}

// Namespace spawnlogic
// Params 0
// Checksum 0x18ba0e18, Offset: 0x73b8
// Size: 0x72
function get_los_penalty()
{
    if ( getdvarstring( "scr_spawnpointlospenalty" ) != "" && getdvarstring( "scr_spawnpointlospenalty" ) != "0" )
    {
        return getdvarfloat( "scr_spawnpointlospenalty" );
    }
    
    return 100000;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xf13fb75b, Offset: 0x7438
// Size: 0x2de, Type: bool
function last_minute_sight_traces( spawnpoint )
{
    if ( !isdefined( spawnpoint.nearbyplayers ) )
    {
        return false;
    }
    
    closest = undefined;
    closestdistsq = undefined;
    secondclosest = undefined;
    secondclosestdistsq = undefined;
    
    foreach ( team in spawnpoint.nearbyplayers )
    {
        if ( team == self.team )
        {
            continue;
        }
        
        for ( i = 0; i < spawnpoint.nearbyplayers[ team ].size ; i++ )
        {
            player = spawnpoint.nearbyplayers[ team ][ i ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( player == self )
            {
                continue;
            }
            
            distsq = distancesquared( spawnpoint.origin, player.origin );
            
            if ( !isdefined( closest ) || distsq < closestdistsq )
            {
                secondclosest = closest;
                secondclosestdistsq = closestdistsq;
                closest = player;
                closestdistsq = distsq;
                continue;
            }
            
            if ( !isdefined( secondclosest ) || distsq < secondclosestdistsq )
            {
                secondclosest = player;
                secondclosestdistsq = distsq;
            }
        }
    }
    
    if ( isdefined( closest ) )
    {
        if ( bullettracepassed( closest.origin + ( 0, 0, 50 ), spawnpoint.sighttracepoint, 0, undefined ) )
        {
            return true;
        }
    }
    
    if ( isdefined( secondclosest ) )
    {
        if ( bullettracepassed( secondclosest.origin + ( 0, 0, 50 ), spawnpoint.sighttracepoint, 0, undefined ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xc988b060, Offset: 0x7720
// Size: 0x570
function avoid_visible_enemies( spawnpoints, teambased )
{
    if ( getdvarstring( "scr_spawnpointnewlogic" ) == "0" )
    {
        return;
    }
    
    lospenalty = get_los_penalty();
    mindistteam = self.team;
    
    if ( teambased )
    {
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            if ( !isdefined( spawnpoints[ i ].enemysights ) )
            {
                continue;
            }
            
            penalty = lospenalty * spawnpoints[ i ].enemysights[ self.team ];
            spawnpoints[ i ].weight -= penalty;
            
            /#
                if ( level.storespawndata || level.debugspawning )
                {
                    index = spawnpoints[ i ].sightchecks.size;
                    spawnpoints[ i ].sightchecks[ index ] = spawnstruct();
                    spawnpoints[ i ].sightchecks[ index ].penalty = penalty;
                }
            #/
        }
    }
    else
    {
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            if ( !isdefined( spawnpoints[ i ].enemysights ) )
            {
                continue;
            }
            
            penalty = lospenalty * spawnpoints[ i ].enemysights;
            spawnpoints[ i ].weight -= penalty;
            
            /#
                if ( level.storespawndata || level.debugspawning )
                {
                    index = spawnpoints[ i ].sightchecks.size;
                    spawnpoints[ i ].sightchecks[ index ] = spawnstruct();
                    spawnpoints[ i ].sightchecks[ index ].penalty = penalty;
                }
            #/
        }
        
        mindistteam = "all";
    }
    
    avoidweight = getdvarfloat( "scr_spawn_enemyavoidweight" );
    
    if ( avoidweight != 0 )
    {
        nearbyenemyouterrange = getdvarfloat( "scr_spawn_enemyavoiddist" );
        nearbyenemyouterrangesq = nearbyenemyouterrange * nearbyenemyouterrange;
        nearbyenemypenalty = 1500 * avoidweight;
        nearbyenemyminorpenalty = 800 * avoidweight;
        lastattackerorigin = ( -99999, -99999, -99999 );
        lastdeathpos = ( -99999, -99999, -99999 );
        
        if ( isalive( self.lastattacker ) )
        {
            lastattackerorigin = self.lastattacker.origin;
        }
        
        if ( isdefined( self.lastdeathpos ) )
        {
            lastdeathpos = self.lastdeathpos;
        }
        
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            mindist = spawnpoints[ i ].minenemydist[ mindistteam ];
            
            if ( mindist < nearbyenemyouterrange * 2 )
            {
                penalty = nearbyenemyminorpenalty * ( 1 - mindist / nearbyenemyouterrange * 2 );
                
                if ( mindist < nearbyenemyouterrange )
                {
                    penalty += nearbyenemypenalty * ( 1 - mindist / nearbyenemyouterrange );
                }
                
                if ( penalty > 0 )
                {
                    spawnpoints[ i ].weight -= penalty;
                    
                    /#
                        if ( level.storespawndata || level.debugspawning )
                        {
                            spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x381>" + int( spawnpoints[ i ].minenemydist[ mindistteam ] ) + "<dev string:x393>" + int( penalty );
                        }
                    #/
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0xdd3d43b9, Offset: 0x7c98
// Size: 0x28c
function avoid_spawn_reuse( spawnpoints, teambased )
{
    if ( getdvarstring( "scr_spawnpointnewlogic" ) == "0" )
    {
        return;
    }
    
    time = gettime();
    maxtime = 10000;
    maxdistsq = 1048576;
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        spawnpoint = spawnpoints[ i ];
        
        if ( !isdefined( spawnpoint.lastspawnedplayer ) || !isdefined( spawnpoint.lastspawntime ) || !isalive( spawnpoint.lastspawnedplayer ) )
        {
            continue;
        }
        
        if ( spawnpoint.lastspawnedplayer == self )
        {
            continue;
        }
        
        if ( teambased && spawnpoint.lastspawnedplayer.team == self.team )
        {
            continue;
        }
        
        timepassed = time - spawnpoint.lastspawntime;
        
        if ( timepassed < maxtime )
        {
            distsq = distancesquared( spawnpoint.lastspawnedplayer.origin, spawnpoint.origin );
            
            if ( distsq < maxdistsq )
            {
                worsen = 5000 * ( 1 - distsq / maxdistsq ) * ( 1 - timepassed / maxtime );
                spawnpoint.weight -= worsen;
                
                /#
                    if ( level.storespawndata || level.debugspawning )
                    {
                        spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x39d>" + worsen;
                    }
                #/
            }
            else
            {
                spawnpoint.lastspawnedplayer = undefined;
            }
            
            continue;
        }
        
        spawnpoint.lastspawnedplayer = undefined;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x37ecbe93, Offset: 0x7f30
// Size: 0x104
function avoid_same_spawn( spawnpoints )
{
    if ( getdvarstring( "scr_spawnpointnewlogic" ) == "0" )
    {
        return;
    }
    
    if ( !isdefined( self.lastspawnpoint ) )
    {
        return;
    }
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        if ( spawnpoints[ i ] == self.lastspawnpoint )
        {
            spawnpoints[ i ].weight -= 50000;
            
            /#
                if ( level.storespawndata || level.debugspawning )
                {
                    spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x3b2>";
                }
            #/
            
            break;
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xc84b4010, Offset: 0x8040
// Size: 0xa4
function get_random_intermission_point()
{
    spawnpoints = struct::get_array( "cp_global_intermission", "targetname" );
    
    if ( !spawnpoints.size )
    {
        spawnpoints = struct::get_array( "cp_coop_spawn", "targetname" );
    }
    
    assert( spawnpoints.size );
    spawnpoint = get_spawnpoint_random( spawnpoints );
    return spawnpoint;
}

// Namespace spawnlogic
// Params 0
// Checksum 0x99ec1590, Offset: 0x80f0
// Size: 0x4
function place_spawn()
{
    
}

