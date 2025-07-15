#using scripts/cp/doa/_doa_arena;
#using scripts/shared/array_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace doa_camera;

// Namespace doa_camera
// Params 3
// Checksum 0xa988da5d, Offset: 0x118
// Size: 0xfc
function function_d22ceb57( angles, min_dist, max_dist )
{
    if ( !isdefined( max_dist ) )
    {
        max_dist = 0;
    }
    
    if ( isdefined( angles ) )
    {
        vectornormalize( angles );
        level.doa.camera_angles = angles;
        level.var_eb70931a = anglestoforward( angles ) * -1;
        level.var_7a2e3b7d = anglestoup( angles );
    }
    
    if ( min_dist < 1 )
    {
        min_dist = 1;
    }
    
    level.var_8e0085fe = min_dist;
    level.var_3e96d0bc = max_dist;
    
    if ( !isdefined( level.var_a32fbbc0 ) )
    {
        level.var_a32fbbc0 = level.doa.camera_angles;
    }
}

// Namespace doa_camera
// Params 2
// Checksum 0xe78fd80, Offset: 0x220
// Size: 0xce
function function_44a2ae85( vec, mins )
{
    if ( vec[ 0 ] < mins[ 0 ] )
    {
        mins = ( vec[ 0 ], mins[ 1 ], mins[ 2 ] );
    }
    
    if ( vec[ 1 ] < mins[ 1 ] )
    {
        mins = ( mins[ 0 ], vec[ 1 ], mins[ 2 ] );
    }
    
    if ( vec[ 2 ] < mins[ 2 ] )
    {
        mins = ( mins[ 0 ], mins[ 1 ], vec[ 2 ] );
    }
    
    return mins;
}

// Namespace doa_camera
// Params 2
// Checksum 0x86f9a1c4, Offset: 0x2f8
// Size: 0xce
function function_b72ba417( vec, maxs )
{
    if ( vec[ 0 ] > maxs[ 0 ] )
    {
        maxs = ( vec[ 0 ], maxs[ 1 ], maxs[ 2 ] );
    }
    
    if ( vec[ 1 ] > maxs[ 1 ] )
    {
        maxs = ( maxs[ 0 ], vec[ 1 ], maxs[ 2 ] );
    }
    
    if ( vec[ 2 ] > maxs[ 2 ] )
    {
        maxs = ( maxs[ 0 ], maxs[ 1 ], vec[ 2 ] );
    }
    
    return maxs;
}

// Namespace doa_camera
// Params 2
// Checksum 0x142bcaa0, Offset: 0x3d0
// Size: 0x12dc
function function_d207ecc1( localclientnum, delta_time )
{
    mins = ( 1e+06, 1e+06, 1e+06 );
    maxs = ( -1e+06, -1e+06, -1e+06 );
    
    if ( level.localplayers.size == 0 )
    {
        cameramode = 2;
    }
    else if ( isdefined( level.localplayers[ 0 ] ) )
    {
        cameramode = level.localplayers[ 0 ].cameramode;
    }
    
    if ( level.localplayers.size > 0 && !isdefined( level.localplayers[ 0 ] ) )
    {
        return;
    }
    
    if ( isdefined( level.var_b62087b0 ) )
    {
        return;
    }
    
    if ( level.localplayers.size >= 2 )
    {
        if ( !isdefined( level.var_3d977189 ) )
        {
            setdvar( "r_deadOpsActive", 1 );
            setdvar( "r_splitScreenExpandFull", 1 );
            level.var_3d977189 = 1;
        }
    }
    
    if ( !isdefined( cameramode ) )
    {
        cameramode = 0;
    }
    
    if ( level.localplayers.size > 1 && isdefined( level.var_81528e19 ) )
    {
        cameramode = level.var_81528e19;
    }
    
    players = [];
    angles = level.doa.camera_angles;
    
    if ( cameramode == 4 )
    {
        cameramode = 0;
    }
    
    if ( isdefined( level.localplayers[ 0 ].var_bf81deea ) && level.localplayers.size && level.localplayers[ 0 ].var_bf81deea )
    {
        cameramode = 0;
    }
    
    if ( vrisactive() )
    {
        cameramode = 2;
    }
    
    if ( cameramode == 3 )
    {
        players[ 0 ] = level.localplayers[ 0 ];
        var_d5cac046 = level.localplayers[ 0 ];
        parentent = getplayervehicle( var_d5cac046 );
        
        if ( !isdefined( parentent ) || level.localplayers.size > 1 )
        {
            cameramode = 0;
        }
    }
    
    if ( cameramode == 0 )
    {
        if ( level.localplayers.size > 1 )
        {
            players = level.localplayers;
        }
        else
        {
            players[ 0 ] = level.localplayers[ 0 ];
        }
    }
    
    if ( cameramode == 1 )
    {
        players = getplayers( localclientnum );
        
        if ( players.size == 0 )
        {
            return;
        }
    }
    
    if ( cameramode == 2 )
    {
        var_2fda52e5 = level.doa.arenas[ level.doa.current_arena ].center + level.doa.arenas[ level.doa.current_arena ].var_7526f3f5;
        
        if ( vrisactive() )
        {
            var_2fda52e5 -= level.var_7a2e3b7d * 450;
            var_2fda52e5 += ( 0, 0, -500 );
        }
        
        foreach ( player in level.localplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player camerasetposition( var_2fda52e5 );
        }
        
        if ( isdefined( level.doa.arenas[ level.doa.current_arena ].var_790aac0e ) )
        {
            /#
                var_cf220b7b = level.doa.arenas[ level.doa.current_arena ].var_790aac0e[ 0 ] + level.var_83a34f19;
                var_a91f9112 = level.doa.arenas[ level.doa.current_arena ].var_790aac0e[ 1 ] + level.var_e9c73e06;
                var_831d16a9 = level.doa.arenas[ level.doa.current_arena ].var_790aac0e[ 2 ];
                level.doa.arenas[ level.doa.current_arena ].var_790aac0e = ( var_cf220b7b, var_a91f9112, var_831d16a9 );
            #/
            
            foreach ( player in level.localplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player camerasetlookat( level.doa.arenas[ level.doa.current_arena ].var_790aac0e );
            }
            
            level.var_a32fbbc0 = level.doa.arenas[ level.doa.current_arena ].var_790aac0e;
        }
        else
        {
            foreach ( player in level.localplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player camerasetlookat( level.doa.camera_angles );
            }
        }
        
        level.var_6383030e = var_2fda52e5;
        
        /#
            if ( getdvarint( "<dev string:x28>", 0 ) )
            {
                println( "<dev string:x40>" + int( level.doa.arenas[ level.doa.current_arena ].var_7526f3f5[ 0 ] ) + "<dev string:x58>" + int( level.doa.arenas[ level.doa.current_arena ].var_7526f3f5[ 1 ] ) + "<dev string:x58>" + int( level.doa.arenas[ level.doa.current_arena ].var_7526f3f5[ 2 ] ) + "<dev string:x5a>" );
                println( "<dev string:x5c>" + level.var_a32fbbc0[ 0 ] + "<dev string:x58>" + level.var_a32fbbc0[ 1 ] + "<dev string:x58>" + level.var_a32fbbc0[ 2 ] + "<dev string:x5a>" );
            }
            
            level.var_83a34f19 = 0;
            level.var_e9c73e06 = 0;
        #/
        
        return;
    }
    
    var_f51225df = level.var_eb70931a;
    var_aa43a214 = level.var_7a2e3b7d;
    
    if ( isdefined( level.doa.arenas[ level.doa.current_arena ].var_f4f1abf3 ) )
    {
        angles = level.doa.arenas[ level.doa.current_arena ].var_f4f1abf3;
        var_f51225df = anglestoforward( angles ) * -1;
        var_aa43a214 = anglestoup( angles );
    }
    
    foreach ( player in players )
    {
        origin = player.origin;
        vehicle = getplayervehicle( player );
        
        if ( isdefined( vehicle ) )
        {
            origin = vehicle.origin;
        }
        
        mins = function_44a2ae85( origin, mins );
        maxs = function_b72ba417( origin, maxs );
    }
    
    if ( isarray( level.var_172ed9a1 ) )
    {
        foreach ( target in level.var_172ed9a1 )
        {
            if ( !isdefined( target ) )
            {
                continue;
            }
            
            mins = function_44a2ae85( target.origin, mins );
            maxs = function_b72ba417( target.origin, maxs );
        }
    }
    
    dims = maxs - mins;
    playercenter = ( mins + maxs ) * 0.5;
    arena_center = doa_arena::function_61d60e0b();
    mins = function_44a2ae85( arena_center, mins );
    maxs = function_b72ba417( arena_center, maxs );
    center = mins + maxs;
    center *= 0.5;
    cam_pos = center;
    
    if ( players.size == 1 )
    {
        var_4d44f2a6 = doa_arena::function_be152c54();
        
        if ( var_4d44f2a6 == 99 )
        {
            cam_pos = ( players[ 0 ].origin[ 0 ], players[ 0 ].origin[ 1 ], arena_center[ 2 ] );
        }
        else
        {
            dir_to_player = center - arena_center;
            cam_pos = arena_center + dir_to_player * var_4d44f2a6;
        }
    }
    
    if ( level.localplayers.size > 1 )
    {
        cam_pos = playercenter;
        arena_center = playercenter;
    }
    
    cam_pos += var_f51225df * level.var_8e0085fe;
    cam_pos += var_aa43a214 * -20;
    var_aee49bea = 200;
    var_e147176c = 1800;
    var_ecd4ec49 = 450;
    var_4544d2a1 = abs( dims[ 1 ] );
    t_y = 0;
    
    if ( var_4544d2a1 > var_aee49bea )
    {
        t_y = ( var_4544d2a1 - var_aee49bea ) / ( var_e147176c - var_aee49bea );
    }
    
    var_de478449 = 50;
    var_967aec83 = 500;
    var_1f425838 = abs( dims[ 0 ] );
    t_x = 0;
    
    if ( var_1f425838 > var_de478449 )
    {
        t_x = ( var_1f425838 - var_de478449 ) / ( var_967aec83 - var_de478449 );
        frac = math::clamp( t_x, 0, 1 );
        center_y = arena_center[ 1 ];
        new_y = cam_pos[ 1 ] + ( center_y - cam_pos[ 1 ] ) * frac;
        cam_pos = ( cam_pos[ 0 ], new_y, cam_pos[ 2 ] );
    }
    
    t = t_y;
    
    if ( t_x > t )
    {
        t = t_x;
    }
    
    var_d5d07072 = var_ecd4ec49;
    
    if ( players.size > 1 && cameramode == 1 )
    {
        var_d69e684e = 200;
        
        if ( !isdefined( level.var_bff78e60 ) )
        {
            level.var_bff78e60 = var_d69e684e;
        }
        
        var_d5d07072 -= var_d69e684e;
        
        if ( t > 1 )
        {
            var_d69e684e *= t;
        }
        
        level.var_bff78e60 += ( var_d69e684e - level.var_bff78e60 ) * 3 * delta_time;
        cam_pos += var_f51225df * var_d69e684e;
    }
    
    var_d5d07072 *= t;
    var_d5d07072 = math::clamp( var_d5d07072, 0, var_ecd4ec49 );
    
    if ( !isdefined( level.var_d5d07072 ) )
    {
        level.var_d5d07072 = var_d5d07072;
    }
    
    level.var_d5d07072 += ( var_d5d07072 - level.var_d5d07072 ) * 2 * delta_time;
    cam_pos += var_f51225df * level.var_d5d07072;
    
    if ( level.localplayers.size > 0 )
    {
        if ( isdefined( level.var_6383030e ) )
        {
            lerp_rate = 2;
            dir = cam_pos - level.var_6383030e;
            
            if ( lengthsquared( dir ) < 1000000 )
            {
                cam_pos = level.var_6383030e + dir * lerp_rate * delta_time;
            }
        }
        
        if ( isdefined( level.var_a32fbbc0 ) )
        {
            lerp_rate = 3;
            dir = angles - level.var_a32fbbc0;
            angles = level.var_a32fbbc0 + dir * lerp_rate * delta_time;
        }
        
        if ( cam_pos[ 2 ] > 2000 )
        {
            cam_pos = ( cam_pos[ 0 ], cam_pos[ 1 ], 2000 );
        }
        
        if ( isdefined( level.doa.var_db180da ) )
        {
            cam_pos = level.doa.var_db180da.origin;
        }
        
        foreach ( player in level.localplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player camerasetposition( cam_pos );
            player camerasetlookat( angles );
        }
        
        level.var_6383030e = cam_pos;
        level.var_a32fbbc0 = angles;
    }
}

