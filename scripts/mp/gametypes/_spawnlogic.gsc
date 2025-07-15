#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;

#namespace spawnlogic;

// Namespace spawnlogic
// Params 0, eflags: 0x2
// Checksum 0xccdc7de3, Offset: 0x288
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "spawnlogic", &__init__, undefined, undefined );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x8ad2cd24, Offset: 0x2c8
// Size: 0x24
function __init__()
{
    callback::on_start_gametype( &init );
}

// Namespace spawnlogic
// Params 0
// Checksum 0x7fbb5271, Offset: 0x2f8
// Size: 0x404
function init()
{
    /#
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x28>", 0 );
        }
        
        level.storespawndata = getdvarint( "<dev string:x28>" );
        
        if ( getdvarstring( "<dev string:x3d>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x3d>", 0 );
        }
        
        if ( getdvarstring( "<dev string:x4a>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x4a>", 0.25 );
        }
        
        thread loop_bot_spawns();
    #/
    
    level.spawnlogic_deaths = [];
    level.spawnlogic_spawnkills = [];
    level.players = [];
    level.grenades = [];
    level.pipebombs = [];
    level.numplayerswaitingtoenterkillcam = 0;
    level.convert_spawns_to_structs = getdvarint( "spawnsystem_convert_spawns_to_structs" );
    println( "<dev string:x5b>" );
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
        if ( getdvarstring( "<dev string:x8f>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x8f>", "<dev string:x9f>" );
        }
        
        if ( getdvarstring( "<dev string:xa1>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:xa1>", "<dev string:x9f>" );
        }
        
        if ( getdvarint( "<dev string:xa1>" ) > 0 )
        {
            thread show_deaths_debug();
            thread update_death_info_debug();
            thread profile_debug();
        }
        
        if ( level.storespawndata )
        {
            thread allow_spawn_data_reading();
        }
        
        if ( getdvarstring( "<dev string:xb5>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:xb5>", "<dev string:x9f>" );
        }
        
        thread watch_spawn_profile();
        thread spawn_graph_check();
    #/
}

// Namespace spawnlogic
// Params 3
// Checksum 0xd06f5337, Offset: 0x708
// Size: 0x27a
function add_spawn_points_internal( team, spawnpoints, list )
{
    if ( !isdefined( list ) )
    {
        list = 0;
    }
    
    oldspawnpoints = [];
    
    if ( level.teamspawnpoints[ team ].size )
    {
        oldspawnpoints = level.teamspawnpoints[ team ];
    }
    
    if ( isdefined( level.allowedgameobjects ) && level.convert_spawns_to_structs )
    {
        for ( i = spawnpoints.size - 1; i >= 0 ; i-- )
        {
            if ( !gameobjects::entity_is_allowed( spawnpoints[ i ], level.allowedgameobjects ) )
            {
                spawnpoints[ i ] = undefined;
            }
        }
        
        arrayremovevalue( spawnpoints, undefined );
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
// Checksum 0x1c2ee8af, Offset: 0x990
// Size: 0x9a
function clear_spawn_points()
{
    foreach ( team in level.teams )
    {
        level.teamspawnpoints[ team ] = [];
    }
    
    level.spawnpoints = [];
    level.player_spawn_points = undefined;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xb65cf197, Offset: 0xa38
// Size: 0xc4
function add_spawn_points( team, spawnpointname )
{
    add_spawn_point_classname( spawnpointname );
    add_spawn_point_team_classname( team, spawnpointname );
    add_spawn_points_internal( team, get_spawnpoint_array( spawnpointname ) );
    
    if ( !level.teamspawnpoints[ team ].size )
    {
        assert( level.teamspawnpoints[ team ].size, "<dev string:xc6>" + spawnpointname + "<dev string:xd3>" );
        wait 1;
        return;
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x725968ea, Offset: 0xb08
// Size: 0x7e
function rebuild_spawn_points( team )
{
    level.teamspawnpoints[ team ] = [];
    
    for ( index = 0; index < level.spawn_point_team_class_names[ team ].size ; index++ )
    {
        add_spawn_points_internal( team, level.spawn_point_team_class_names[ team ][ index ] );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0xb14c4d64, Offset: 0xb90
// Size: 0x168
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
        println( "<dev string:xf0>" + spawnpointname + "<dev string:xd3>" );
        assert( spawnpoints.size, "<dev string:xf0>" + spawnpointname + "<dev string:xd3>" );
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
// Checksum 0x4fad7985, Offset: 0xd00
// Size: 0xae
function drop_spawn_points( spawnpointname )
{
    spawnpoints = get_spawnpoint_array( spawnpointname );
    
    if ( !spawnpoints.size )
    {
        println( "<dev string:xf0>" + spawnpointname + "<dev string:xd3>" );
        return;
    }
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        placespawnpoint( spawnpoints[ index ] );
    }
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3a9a3eff, Offset: 0xdb8
// Size: 0x3a
function add_spawn_point_classname( spawnpointclassname )
{
    if ( !isdefined( level.spawn_point_class_names ) )
    {
        level.spawn_point_class_names = [];
    }
    
    level.spawn_point_class_names[ level.spawn_point_class_names.size ] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xe1aa8aa3, Offset: 0xe00
// Size: 0x38
function add_spawn_point_team_classname( team, spawnpointclassname )
{
    level.spawn_point_team_class_names[ team ][ level.spawn_point_team_class_names[ team ].size ] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3c321fe4, Offset: 0xe40
// Size: 0x5c
function _get_spawnpoint_array( spawnpoint_name )
{
    if ( isdefined( level.convert_spawns_to_structs ) && level.convert_spawns_to_structs )
    {
        return struct::get_array( spawnpoint_name, "targetname" );
    }
    
    return getentarray( spawnpoint_name, "classname" );
}

// Namespace spawnlogic
// Params 1
// Checksum 0x1a8700fc, Offset: 0xea8
// Size: 0xb2
function get_spawnpoint_array( classname )
{
    spawnpoints = _get_spawnpoint_array( classname );
    
    if ( !isdefined( level.extraspawnpoints ) || !isdefined( level.extraspawnpoints[ classname ] ) )
    {
        return spawnpoints;
    }
    
    for ( i = 0; i < level.extraspawnpoints[ classname ].size ; i++ )
    {
        spawnpoints[ spawnpoints.size ] = level.extraspawnpoints[ classname ][ i ];
    }
    
    return spawnpoints;
}

// Namespace spawnlogic
// Params 0
// Checksum 0xef0a480e, Offset: 0xf68
// Size: 0x138
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
    
    placespawnpoint( spawnpoint );
    spawnpoint.forward = anglestoforward( spawnpoint.angles );
    spawnpoint.sighttracepoint = spawnpoint.origin + ( 0, 0, 50 );
    spawnpoint.inited = 1;
}

// Namespace spawnlogic
// Params 1
// Checksum 0xd98edbb8, Offset: 0x10a8
// Size: 0x18
function get_team_spawnpoints( team )
{
    return level.teamspawnpoints[ team ];
}

// Namespace spawnlogic
// Params 4
// Checksum 0xd10b926d, Offset: 0x10c8
// Size: 0x360
function get_spawnpoint_final( spawnpoints, useweights, predictedspawn, isintermmissionspawn )
{
    if ( !isdefined( isintermmissionspawn ) )
    {
        isintermmissionspawn = 0;
    }
    
    bestspawnpoint = undefined;
    
    if ( !isdefined( spawnpoints ) || spawnpoints.size == 0 )
    {
        return undefined;
    }
    
    if ( !isdefined( useweights ) )
    {
        useweights = 1;
    }
    
    if ( !isdefined( predictedspawn ) )
    {
        predictedspawn = 0;
    }
    
    if ( useweights )
    {
        bestspawnpoint = get_best_weighted_spawnpoint( spawnpoints );
        thread spawn_weight_debug( spawnpoints );
    }
    else
    {
        if ( isdefined( self.lastspawnpoint ) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn )
        {
            if ( !positionwouldtelefrag( self.lastspawnpoint.origin ) )
            {
                bestspawnpoint = self.lastspawnpoint;
            }
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            for ( i = 0; i < spawnpoints.size ; i++ )
            {
                if ( isdefined( self.lastspawnpoint ) && self.lastspawnpoint == spawnpoints[ i ] && !self.lastspawnpoint.lastspawnpredicted )
                {
                    continue;
                }
                
                if ( positionwouldtelefrag( spawnpoints[ i ].origin ) )
                {
                    continue;
                }
                
                if ( isdefined( level.var_6f13f156 ) && ![[ level.var_6f13f156 ]]( spawnpoints[ i ], predictedspawn ) )
                {
                    continue;
                }
                
                bestspawnpoint = spawnpoints[ i ];
                break;
            }
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            if ( isdefined( self.lastspawnpoint ) && !positionwouldtelefrag( self.lastspawnpoint.origin ) )
            {
                for ( i = 0; i < spawnpoints.size ; i++ )
                {
                    if ( isdefined( level.var_6f13f156 ) && ![[ level.var_6f13f156 ]]( spawnpoints[ i ], predictedspawn ) )
                    {
                        continue;
                    }
                    
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
    
    self finalize_spawnpoint_choice( bestspawnpoint, predictedspawn );
    
    /#
        self store_spawn_data( spawnpoints, useweights, bestspawnpoint );
    #/
    
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 2
// Checksum 0xbab842c7, Offset: 0x1430
// Size: 0x74
function finalize_spawnpoint_choice( spawnpoint, predictedspawn )
{
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnpredicted = predictedspawn;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x3ec7a2f1, Offset: 0x14b0
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
                bestspawnpoint.spawndata[ bestspawnpoint.spawndata.size ] = "<dev string:xf6>" + penalty;
            }
        #/
        
        bestspawnpoint.weight -= penalty;
        bestspawnpoint.lastsighttracetime = gettime();
    }
}

/#

    // Namespace spawnlogic
    // Params 1
    // Checksum 0xd5c1c19b, Offset: 0x1770
    // Size: 0x156, Type: dev
    function check_bad( spawnpoint )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( !isalive( player ) || player.sessionstate != "<dev string:x111>" )
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
    // Checksum 0xbfe87f7e, Offset: 0x18d0
    // Size: 0xe6, Type: dev
    function bad_spawn_line( start, end, name1, name2 )
    {
        dist = distance( start, end );
        
        for ( i = 0; i < 200 ; i++ )
        {
            line( start, end, ( 1, 0, 0 ) );
            print3d( start, "<dev string:x119>" + name1 + "<dev string:x125>" + dist );
            print3d( end, name2 );
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 3
    // Checksum 0x7485eddf, Offset: 0x19c0
    // Size: 0x88c, Type: dev
    function store_spawn_data( spawnpoints, useweights, bestspawnpoint )
    {
        if ( !isdefined( level.storespawndata ) || !level.storespawndata )
        {
            return;
        }
        
        level.storespawndata = getdvarint( "<dev string:x28>" );
        
        if ( !level.storespawndata )
        {
            return;
        }
        
        if ( !isdefined( level.spawnid ) )
        {
            level.spawngameid = randomint( 100 );
            level.spawnid = 0;
        }
        
        if ( bestspawnpoint.classname == "<dev string:x12f>" )
        {
            return;
        }
        
        level.spawnid++;
        file = openfile( "<dev string:x146>", "<dev string:x154>" );
        fprintfields( file, level.spawngameid + "<dev string:x15b>" + level.spawnid + "<dev string:x15d>" + spawnpoints.size + "<dev string:x15d>" + self.name );
        
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            str = vec_to_str( spawnpoints[ i ].origin ) + "<dev string:x15d>";
            
            if ( spawnpoints[ i ] == bestspawnpoint )
            {
                str += "<dev string:x15f>";
            }
            else
            {
                str += "<dev string:x162>";
            }
            
            if ( !useweights )
            {
                str += "<dev string:x162>";
            }
            else
            {
                str += spawnpoints[ i ].weight + "<dev string:x15d>";
            }
            
            if ( !isdefined( spawnpoints[ i ].spawndata ) )
            {
                spawnpoints[ i ].spawndata = [];
            }
            
            if ( !isdefined( spawnpoints[ i ].sightchecks ) )
            {
                spawnpoints[ i ].sightchecks = [];
            }
            
            str += spawnpoints[ i ].spawndata.size + "<dev string:x15d>";
            
            for ( j = 0; j < spawnpoints[ i ].spawndata.size ; j++ )
            {
                str += spawnpoints[ i ].spawndata[ j ] + "<dev string:x15d>";
            }
            
            str += spawnpoints[ i ].sightchecks.size + "<dev string:x15d>";
            
            for ( j = 0; j < spawnpoints[ i ].sightchecks.size ; j++ )
            {
                str += spawnpoints[ i ].sightchecks[ j ].penalty + "<dev string:x15d>" + vec_to_str( spawnpoints[ i ].origin ) + "<dev string:x15d>";
            }
            
            fprintfields( file, str );
        }
        
        obj = spawnstruct();
        get_all_allied_and_enemy_players( obj );
        numallies = 0;
        numenemies = 0;
        str = "<dev string:x3c>";
        
        for ( i = 0; i < obj.allies.size ; i++ )
        {
            if ( obj.allies[ i ] == self )
            {
                continue;
            }
            
            numallies++;
            str += vec_to_str( obj.allies[ i ].origin ) + "<dev string:x15d>";
        }
        
        for ( i = 0; i < obj.enemies.size ; i++ )
        {
            numenemies++;
            str += vec_to_str( obj.enemies[ i ].origin ) + "<dev string:x15d>";
        }
        
        str = numallies + "<dev string:x15d>" + numenemies + "<dev string:x15d>" + str;
        fprintfields( file, str );
        otherdata = [];
        
        if ( isdefined( level.bombguy ) )
        {
            index = otherdata.size;
            otherdata[ index ] = spawnstruct();
            otherdata[ index ].origin = level.bombguy.origin + ( 0, 0, 20 );
            otherdata[ index ].text = "<dev string:x165>";
        }
        else if ( isdefined( level.bombpos ) )
        {
            index = otherdata.size;
            otherdata[ index ] = spawnstruct();
            otherdata[ index ].origin = level.bombpos;
            otherdata[ index ].text = "<dev string:x171>";
        }
        
        if ( isdefined( level.flags ) )
        {
            for ( i = 0; i < level.flags.size ; i++ )
            {
                index = otherdata.size;
                otherdata[ index ] = spawnstruct();
                otherdata[ index ].origin = level.flags[ i ].origin;
                otherdata[ index ].text = level.flags[ i ].useobj gameobjects::get_owner_team() + "<dev string:x176>";
            }
        }
        
        str = otherdata.size + "<dev string:x15d>";
        
        for ( i = 0; i < otherdata.size ; i++ )
        {
            str += vec_to_str( otherdata[ i ].origin ) + "<dev string:x15d>" + otherdata[ i ].text + "<dev string:x15d>";
        }
        
        fprintfields( file, str );
        closefile( file );
        thisspawnid = level.spawngameid + "<dev string:x15b>" + level.spawnid;
        
        if ( isdefined( self.thisspawnid ) )
        {
        }
        
        self.thisspawnid = thisspawnid;
    }

    // Namespace spawnlogic
    // Params 2
    // Checksum 0xa56dd7bf, Offset: 0x2258
    // Size: 0xb34, Type: dev
    function read_spawn_data( desiredid, relativepos )
    {
        file = openfile( "<dev string:x146>", "<dev string:x17c>" );
        
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
                if ( relativepos == "<dev string:x181>" )
                {
                    if ( data.id == oldspawndata.id )
                    {
                        level.curspawndata = prevthisplayer;
                        break;
                    }
                }
                else if ( relativepos == "<dev string:x190>" )
                {
                    if ( data.id == oldspawndata.id )
                    {
                        level.curspawndata = prev;
                        break;
                    }
                }
                else if ( relativepos == "<dev string:x195>" )
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
                else if ( relativepos == "<dev string:x1a4>" )
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
    // Checksum 0xbe5fe93e, Offset: 0x2d98
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
                print3d( level.curspawndata.friends[ i ], "<dev string:x1a9>", ( 0.5, 1, 0.5 ), 1, 5 );
            }
            
            for ( i = 0; i < level.curspawndata.enemies.size ; i++ )
            {
                print3d( level.curspawndata.enemies[ i ], "<dev string:x1ac>", ( 1, 0.5, 0.5 ), 1, 5 );
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
                    print3d( orig, level.curspawndata.playername + "<dev string:x1af>", ( 0.5, 0.5, 1 ), 1, 2 );
                    orig += textoffset;
                }
                
                amnt = ( sp.weight - level.curspawndata.minweight ) / ( level.curspawndata.maxweight - level.curspawndata.minweight );
                print3d( orig, "<dev string:x1bd>" + sp.weight, ( 1 - amnt, amnt, 0.5 ) );
                orig += textoffset;
                
                for ( j = 0; j < sp.data.size ; j++ )
                {
                    print3d( orig, sp.data[ j ], ( 1, 1, 1 ) );
                    orig += textoffset;
                }
                
                for ( j = 0; j < sp.sightchecks.size ; j++ )
                {
                    print3d( orig, "<dev string:x1c6>" + sp.sightchecks[ j ].penalty, ( 1, 0.5, 0.5 ) );
                    orig += textoffset;
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 1
    // Checksum 0x97659e9e, Offset: 0x3218
    // Size: 0x7e, Type: dev
    function vec_to_str( vec )
    {
        return int( vec[ 0 ] ) + "<dev string:x1d5>" + int( vec[ 1 ] ) + "<dev string:x1d5>" + int( vec[ 2 ] );
    }

    // Namespace spawnlogic
    // Params 1
    // Checksum 0xbb6b17a6, Offset: 0x32a0
    // Size: 0x9e, Type: dev
    function str_to_vec( str )
    {
        parts = strtok( str, "<dev string:x1d5>" );
        
        if ( parts.size != 3 )
        {
            return ( 0, 0, 0 );
        }
        
        return ( int( parts[ 0 ] ), int( parts[ 1 ] ), int( parts[ 2 ] ) );
    }

#/

// Namespace spawnlogic
// Params 3
// Checksum 0x59c18b75, Offset: 0x3348
// Size: 0xea
function get_spawnpoint_random( spawnpoints, predictedspawn, isintermissionspawn )
{
    if ( !isdefined( isintermissionspawn ) )
    {
        isintermissionspawn = 0;
    }
    
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
    
    return get_spawnpoint_final( spawnpoints, 0, predictedspawn, isintermissionspawn );
}

// Namespace spawnlogic
// Params 0
// Checksum 0xe761c03d, Offset: 0x3440
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
// Checksum 0x6e8ed900, Offset: 0x3500
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
// Checksum 0xac2e7438, Offset: 0x36f8
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
// Checksum 0xfafc988b, Offset: 0x37c0
// Size: 0x540
function get_spawnpoint_near_team( spawnpoints, favoredspawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    /#
        if ( getdvarstring( "<dev string:x1d7>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x1d7>", "<dev string:x9f>" );
        }
        
        if ( getdvarstring( "<dev string:x1d7>" ) == "<dev string:x1ea>" )
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
                    spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x1ec>" + int( spawnpoint.weight ) + "<dev string:x1fa>" + int( enemydistsum ) + "<dev string:x1ff>" + allieddistanceweight + "<dev string:x203>" + int( allydistsum ) + "<dev string:x205>" + spawnpoint.numplayersatlastupdate;
                }
            #/
            
            continue;
        }
        
        spawnpoint.weight = 0;
        
        /#
            if ( level.storespawndata || level.debugspawning )
            {
                spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x20a>";
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
        if ( getdvarstring( "<dev string:x219>" ) == "<dev string:x3c>" )
        {
            setdvar( "<dev string:x219>", "<dev string:x9f>" );
        }
        
        if ( getdvarstring( "<dev string:x219>" ) == "<dev string:x1ea>" )
        {
            check_bad( result );
        }
    #/
    
    return result;
}

// Namespace spawnlogic
// Params 1
// Checksum 0x37050f43, Offset: 0x3d08
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
// Checksum 0x68a17155, Offset: 0x3fb0
// Size: 0x50
function begin()
{
    /#
        level.storespawndata = getdvarint( "<dev string:x28>" );
        level.debugspawning = getdvarint( "<dev string:xa1>" ) > 0;
    #/
}

/#

    // Namespace spawnlogic
    // Params 0
    // Checksum 0x16050020, Offset: 0x4008
    // Size: 0xa6, Type: dev
    function watch_spawn_profile()
    {
        while ( true )
        {
            while ( true )
            {
                if ( getdvarint( "<dev string:xb5>" ) > 0 )
                {
                    break;
                }
                
                wait 0.05;
            }
            
            thread spawn_profile();
            
            while ( true )
            {
                if ( getdvarint( "<dev string:xb5>" ) <= 0 )
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
    // Checksum 0x976ad221, Offset: 0x40b8
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
    // Checksum 0x5d1962b6, Offset: 0x41d0
    // Size: 0x5a, Type: dev
    function spawn_graph_check()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x22b>" ) < 1 )
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
    // Checksum 0x230f8de1, Offset: 0x4238
    // Size: 0x650, Type: dev
    function spawn_graph()
    {
        w = 20;
        h = 20;
        weightscale = 0.1;
        fakespawnpoints = [];
        corners = getentarray( "<dev string:x23a>", "<dev string:x249>" );
        
        if ( corners.size != 2 )
        {
            println( "<dev string:x254>" );
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
                if ( !level.players.size || !isdefined( level.players[ 0 ].team ) || level.players[ 0 ].team == "<dev string:x27d>" || !isdefined( level.players[ 0 ].curclass ) )
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
            
            if ( !level.players.size || !isdefined( level.players[ 0 ].team ) || level.players[ 0 ].team == "<dev string:x27d>" || !isdefined( level.players[ 0 ].curclass ) )
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
    // Checksum 0x9afb7cc2, Offset: 0x4890
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
    // Checksum 0xcb776c98, Offset: 0x49e0
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
    // Checksum 0x67d8cace, Offset: 0x4a48
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
    // Checksum 0xe127d016, Offset: 0x4b30
    // Size: 0x374, Type: dev
    function loop_bot_spawns()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x3d>" ) < 1 )
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
                
                if ( level.players[ i ].sessionstate == "<dev string:x111>" && issubstr( level.players[ i ].name, "<dev string:x287>" ) )
                {
                    bots[ bots.size ] = level.players[ i ];
                }
            }
            
            if ( bots.size > 0 )
            {
                if ( getdvarint( "<dev string:x3d>" ) == 1 )
                {
                    killer = bots[ randomint( bots.size ) ];
                    victim = bots[ randomint( bots.size ) ];
                    victim thread [[ level.callbackplayerdamage ]]( killer, killer, 1000, 0, "<dev string:x28b>", level.weaponnone, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x29c>", ( 0, 0, 0 ), 0, 0, ( 1, 0, 0 ) );
                }
                else
                {
                    numkills = getdvarint( "<dev string:x3d>" );
                    lastvictim = undefined;
                    
                    for ( index = 0; index < numkills ; index++ )
                    {
                        killer = bots[ randomint( bots.size ) ];
                        
                        for ( victim = bots[ randomint( bots.size ) ]; isdefined( lastvictim ) && victim == lastvictim ; victim = bots[ randomint( bots.size ) ] )
                        {
                        }
                        
                        victim thread [[ level.callbackplayerdamage ]]( killer, killer, 1000, 0, "<dev string:x28b>", "<dev string:x29c>", ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x29c>", ( 0, 0, 0 ), 0, 0, ( 1, 0, 0 ) );
                        lastvictim = victim;
                    }
                }
            }
            
            if ( getdvarstring( "<dev string:x4a>" ) != "<dev string:x3c>" )
            {
                wait getdvarfloat( "<dev string:x4a>" );
                continue;
            }
            
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xd34b4281, Offset: 0x4eb0
    // Size: 0x1e8, Type: dev
    function allow_spawn_data_reading()
    {
        setdvar( "<dev string:x2a1>", "<dev string:x3c>" );
        prevval = getdvarstring( "<dev string:x2a1>" );
        prevrelval = getdvarstring( "<dev string:x2b1>" );
        readthistime = 0;
        
        while ( true )
        {
            val = getdvarstring( "<dev string:x2a1>" );
            relval = undefined;
            
            if ( !isdefined( val ) || val == prevval )
            {
                relval = getdvarstring( "<dev string:x2b1>" );
                
                if ( isdefined( relval ) && relval != "<dev string:x3c>" )
                {
                    setdvar( "<dev string:x2b1>", "<dev string:x3c>" );
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
                println( "<dev string:x2c2>" );
            }
            else
            {
                println( "<dev string:x2d9>" + level.curspawndata.id );
            }
            
            thread draw_spawn_data();
        }
    }

    // Namespace spawnlogic
    // Params 0
    // Checksum 0xdc9bc5c9, Offset: 0x50a0
    // Size: 0x4b0, Type: dev
    function show_deaths_debug()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:xa1>" ) == "<dev string:x9f>" )
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
                    print3d( spawnkill.dierorigin + ( 0, 0, 32 ), "<dev string:x2eb>", ( 0, 1, 1 ) );
                }
                else
                {
                    line( spawnkill.spawnpointorigin, spawnkill.killerorigin, ( 0.4, 0.5, 0.4 ) );
                    line( spawnkill.killerorigin, spawnkill.dierorigin, ( 0, 1, 1 ) );
                    print3d( spawnkill.dierorigin + ( 0, 0, 32 ), "<dev string:x2f8>", ( 0, 1, 1 ) );
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
// Checksum 0xb3476117, Offset: 0x5558
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
// Checksum 0xe24d1b1d, Offset: 0x55b8
// Size: 0x314
function spawn_weight_debug( spawnpoints )
{
    level notify( #"stop_spawn_weight_debug" );
    level endon( #"stop_spawn_weight_debug" );
    
    /#
        while ( true )
        {
            if ( getdvarstring( "<dev string:xa1>" ) == "<dev string:x9f>" )
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
                        
                        print3d( orig, "<dev string:x303>" + spawnpoints[ i ].sightchecks[ j ].penalty, ( 0.5, 0.5, 0.5 ) );
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
// Checksum 0xab27cc1d, Offset: 0x58d8
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
    // Checksum 0x496761bb, Offset: 0x59d0
    // Size: 0xe0, Type: dev
    function debug_nearby_players( players, origin )
    {
        if ( getdvarstring( "<dev string:xa1>" ) == "<dev string:x9f>" )
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
// Checksum 0xced99f97, Offset: 0x5ab8
// Size: 0x14
function death_occured( dier, killer )
{
    
}

// Namespace spawnlogic
// Params 1
// Checksum 0x4dca6c06, Offset: 0x5ad8
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
// Checksum 0xa4b2ddd7, Offset: 0x5c08
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
// Checksum 0x2614953a, Offset: 0x5df8
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
// Checksum 0x99383608, Offset: 0x5f28
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
                        spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x315>" + int( weapondamagepenalty );
                    }
                #/
            }
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0x61d2c811, Offset: 0x6148
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
// Checksum 0xa7f5ae27, Offset: 0x61d0
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
// Checksum 0x10445e96, Offset: 0x6298
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
// Checksum 0x2bac4930, Offset: 0x6378
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
        debug = getdvarint( "<dev string:xa1>" ) > 0;
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
// Checksum 0xbdf77552, Offset: 0x6a70
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
// Checksum 0x32b7c87, Offset: 0x6af0
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
// Checksum 0xc50913cc, Offset: 0x6dd8
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
                            spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x329>" + int( spawnpoints[ i ].minenemydist[ mindistteam ] ) + "<dev string:x33b>" + int( penalty );
                        }
                    #/
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 2
// Checksum 0xbfc7e854, Offset: 0x7350
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
                        spawnpoint.spawndata[ spawnpoint.spawndata.size ] = "<dev string:x345>" + worsen;
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
// Checksum 0x495230d9, Offset: 0x75e8
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
                    spawnpoints[ i ].spawndata[ spawnpoints[ i ].spawndata.size ] = "<dev string:x35a>";
                }
            #/
            
            break;
        }
    }
}

// Namespace spawnlogic
// Params 0
// Checksum 0xfea5faf9, Offset: 0x76f8
// Size: 0x9c
function get_random_intermission_point()
{
    spawnpoints = _get_spawnpoint_array( "mp_global_intermission" );
    
    if ( !spawnpoints.size )
    {
        spawnpoints = _get_spawnpoint_array( "info_player_start" );
    }
    
    assert( spawnpoints.size );
    spawnpoint = get_spawnpoint_random( spawnpoints, undefined, 1 );
    return spawnpoint;
}

// Namespace spawnlogic
// Params 4
// Checksum 0x9d50abb0, Offset: 0x77a0
// Size: 0x12c
function move_spawn_point( targetname, start_point, new_point, new_angles )
{
    if ( getdvarint( "spawnsystem_convert_spawns_to_structs" ) )
    {
        spawn_points = struct::get_array( targetname, "targetname" );
    }
    else
    {
        spawn_points = getentarray( targetname, "classname" );
    }
    
    for ( i = 0; i < spawn_points.size ; i++ )
    {
        if ( distancesquared( spawn_points[ i ].origin, start_point ) < 1 )
        {
            spawn_points[ i ].origin = new_point;
            
            if ( isdefined( new_angles ) )
            {
                spawn_points[ i ].angles = new_angles;
            }
            
            return;
        }
    }
}

