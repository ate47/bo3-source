#using scripts/shared/stealth;
#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_debug;

/#

    // Namespace stealth_debug
    // Params 0
    // Checksum 0x8e310234, Offset: 0x110
    // Size: 0x84, Type: dev
    function init()
    {
        if ( isdefined( self.stealth ) )
        {
            self.stealth.debug_reason = "<dev string:x28>";
        }
        
        curdebug = getdvarint( "<dev string:x29>", -1 );
        
        if ( curdebug == -1 )
        {
            setdvar( "<dev string:x29>", 0 );
        }
    }

    // Namespace stealth_debug
    // Params 0
    // Checksum 0xa5846daa, Offset: 0x1a0
    // Size: 0x24, Type: dev
    function enabled()
    {
        return getdvarint( "<dev string:x29>", 0 );
    }

    // Namespace stealth_debug
    // Params 0
    // Checksum 0x234ae209, Offset: 0x1d0
    // Size: 0x84, Type: dev
    function init_debug()
    {
        if ( self == level )
        {
            self thread function_70b08fc4();
        }
        
        if ( isactor( self ) && enabled() )
        {
            self thread draw_awareness_thread();
            self thread draw_detect_cone_thread();
        }
    }

    // Namespace stealth_debug
    // Params 0
    // Checksum 0xe66d7c4f, Offset: 0x260
    // Size: 0x23a, Type: dev
    function function_70b08fc4()
    {
        self notify( #"hash_70b08fc4" );
        self endon( #"hash_70b08fc4" );
        prevvalue = enabled();
        
        while ( true )
        {
            if ( enabled() != prevvalue )
            {
                entities = getentarray();
                
                if ( enabled() )
                {
                    foreach ( entity in entities )
                    {
                        if ( isactor( entity ) && entity stealth_actor::enabled() )
                        {
                            entity thread draw_awareness_thread();
                            entity thread draw_detect_cone_thread();
                        }
                    }
                }
                else
                {
                    foreach ( entity in entities )
                    {
                        if ( isactor( entity ) && entity stealth_actor::enabled() )
                        {
                            entity notify( #"draw_awareness_thread" );
                            entity notify( #"draw_detect_cone_thread" );
                        }
                    }
                }
                
                prevvalue = enabled();
            }
            
            wait 1;
        }
    }

    // Namespace stealth_debug
    // Params 0
    // Checksum 0xee996c91, Offset: 0x4a8
    // Size: 0x398, Type: dev
    function draw_awareness_thread()
    {
        self notify( #"draw_awareness_thread" );
        self endon( #"draw_awareness_thread" );
        self endon( #"death" );
        self endon( #"stop_stealth" );
        
        while ( true )
        {
            if ( enabled() )
            {
                origin = self.origin;
                print3d( origin, "<dev string:x28>" + self.awarenesslevelcurrent, stealth::awareness_color( self.awarenesslevelcurrent ), 1, 0.5, 1 );
                origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + 15 );
                
                if ( isdefined( self.stealth.debug_reason ) && self.stealth.debug_reason != "<dev string:x28>" && self.awarenesslevelcurrent != "<dev string:x37>" )
                {
                    print3d( origin, self.stealth.debug_reason, stealth::awareness_color( self.awarenesslevelcurrent ), 1, 0.5, 1 );
                    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + 15 );
                }
                
                if ( isdefined( self.enemy ) )
                {
                    print3d( origin, "<dev string:x3f>" + self.enemy getentitynumber() + "<dev string:x48>", stealth::awareness_color( self.awarenesslevelcurrent ), 1, 0.5, 1 );
                    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + 15 );
                }
                
                if ( isdefined( self.stealth.debug_msg ) && self.stealth.debug_msg != "<dev string:x28>" )
                {
                    print3d( origin, self.stealth.debug_msg, stealth::awareness_color( self.awarenesslevelcurrent ), 1, 0.5, 1 );
                    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + 15 );
                }
                
                if ( isdefined( self.stealth.var_edba2e78 ) )
                {
                    box( self.stealth.var_edba2e78, ( -16, -16, 0 ), ( 16, 16, 60 ), 0, ( 1, 0, 1 ) );
                    line( self.origin + ( 0, 0, 80 ), self.stealth.var_edba2e78 + ( 0, 0, 60 ), ( 1, 0, 1 ) );
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace stealth_debug
    // Params 0
    // Checksum 0xc94171c7, Offset: 0x848
    // Size: 0x2f8, Type: dev
    function draw_detect_cone_thread()
    {
        self notify( #"draw_detect_cone_thread" );
        self endon( #"draw_detect_cone_thread" );
        self endon( #"death" );
        self endon( #"stop_stealth" );
        
        if ( !isactor( self ) )
        {
            return;
        }
        
        wait 0.05;
        
        while ( true )
        {
            wait 0.05;
            
            if ( enabled() )
            {
                awareness = self stealth_aware::get_awareness();
                parm = level.stealth.parm.awareness[ awareness ];
                
                if ( enabled() > 1 )
                {
                    v_eye_angles = ( 0, self gettagangles( "<dev string:x4b>" )[ 1 ], 0 );
                    color = ( 0.5, 0.5, 0.5 );
                    
                    foreach ( enemy in level.stealth.enemies[ self.team ] )
                    {
                        if ( self cansee( enemy ) )
                        {
                            color = ( 1, 0.5, 0 );
                            break;
                        }
                    }
                    
                    if ( awareness != "<dev string:x53>" )
                    {
                        self draw_detect_cone( self.origin + ( 0, 0, 16 ), v_eye_angles, self.fovcosine, self.fovcosinez, sqrt( self.maxsightdistsqrd ), color );
                    }
                }
                
                pointofinterest = self geteventpointofinterest();
                
                if ( isdefined( pointofinterest ) )
                {
                    color = stealth::awareness_color( awareness );
                    line( self.origin, pointofinterest, color, 0, 1 );
                    debugstar( pointofinterest, 1, color );
                }
            }
        }
    }

    // Namespace stealth_debug
    // Params 6
    // Checksum 0x65559ce3, Offset: 0xb48
    // Size: 0x3f8, Type: dev
    function draw_detect_cone( origin, angles, fovcosine, fovcosinez, viewdist, color )
    {
        v_fov_yaw = acos( fovcosine );
        v_fov_pitch = acos( fovcosinez );
        height = tan( v_fov_pitch ) * viewdist;
        fwd = anglestoforward( ( 0, angles[ 1 ], 0 ) );
        v_leftdir = anglestoforward( ( 0, angles[ 1 ] + v_fov_yaw, 0 ) );
        v_rightdir = anglestoforward( ( 0, angles[ 1 ] - v_fov_yaw, 0 ) );
        v_left_end = origin + v_leftdir * viewdist;
        v_right_end = origin + v_rightdir * viewdist;
        util::debug_line( origin, v_left_end, color, 1, 1, 1 );
        util::debug_line( origin, v_right_end, color, 1, 1, 1 );
        v_height0 = origin + fwd * viewdist;
        v_height1 = origin + fwd * viewdist + ( 0, 0, height );
        util::debug_line( v_height0, v_height1, color, 1, 1, 1 );
        util::debug_line( v_height1, origin, color, 1, 1, 1 );
        a_arcpoints = [];
        v_anglefrac = v_fov_yaw * 2 / 10;
        
        for ( j = 1; j < 10 - 1 ; j++ )
        {
            n_angle = angles[ 1 ] - v_fov_yaw + v_anglefrac * j;
            v_dir = anglestoforward( ( 0, n_angle, 0 ) );
            a_arcpoints[ a_arcpoints.size ] = v_dir * viewdist + origin;
        }
        
        a_arcpoints[ a_arcpoints.size ] = v_left_end;
        v_arc_seg_start = v_right_end;
        v_arc_seg_end = undefined;
        
        for ( j = 0; j < a_arcpoints.size ; j++ )
        {
            v_arc_seg_end = a_arcpoints[ j ];
            util::debug_line( v_arc_seg_start, v_arc_seg_end, color, 1, 1, 1 );
            v_arc_seg_start = v_arc_seg_end;
        }
    }

    // Namespace stealth_debug
    // Params 6
    // Checksum 0xc53de8f7, Offset: 0xf48
    // Size: 0x478, Type: dev
    function rising_text( text, color, alpha, scale, origin, life )
    {
        spacing = 10;
        riserate = 3;
        
        if ( !isdefined( origin ) || !isdefined( text ) )
        {
            return;
        }
        
        start = gettime();
        
        if ( !isdefined( self.stealth.debug_rising ) )
        {
            self.stealth.debug_rising = [];
            self.stealth.debug_rising_idx = -1;
        }
        
        self.stealth.debug_rising_idx++;
        myid = self.stealth.debug_rising_idx;
        self.stealth.debug_rising[ myid ] = origin;
        previd = myid - 1;
        
        while ( isdefined( self.stealth.debug_rising[ previd ] ) )
        {
            delta = self.stealth.debug_rising[ previd ][ 2 ] - self.stealth.debug_rising[ previd + 1 ][ 2 ];
            
            if ( delta >= spacing )
            {
                break;
            }
            
            self.stealth.debug_rising[ previd ] = ( self.stealth.debug_rising[ previd ][ 0 ], self.stealth.debug_rising[ previd ][ 1 ], self.stealth.debug_rising[ previd + 1 ][ 2 ] + spacing + delta );
            previd -= 1;
        }
        
        draworigin = self.stealth.debug_rising[ myid ];
        
        while ( gettime() - start < life * 1000 )
        {
            wait 0.05;
            
            if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
            {
                draworigin = self.stealth.debug_rising[ myid ];
            }
            
            print3d( draworigin, text, color, alpha, scale, 1 );
            draworigin = ( draworigin[ 0 ], draworigin[ 1 ], draworigin[ 2 ] + riserate );
            
            if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
            {
                self.stealth.debug_rising[ myid ] = ( self.stealth.debug_rising[ myid ][ 0 ], self.stealth.debug_rising[ myid ][ 1 ], self.stealth.debug_rising[ myid ][ 2 ] + riserate );
            }
        }
        
        if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
        {
            self.stealth.debug_rising[ myid ] = undefined;
        }
    }

    // Namespace stealth_debug
    // Params 1
    // Checksum 0x2db4fedc, Offset: 0x13c8
    // Size: 0xae, Type: dev
    function debug_text( varvalue )
    {
        if ( !isdefined( varvalue ) )
        {
            return "<dev string:x5a>";
        }
        
        if ( isweapon( varvalue ) )
        {
            return ( "<dev string:x66>" + varvalue.name + "<dev string:x6e>" );
        }
        
        if ( isentity( varvalue ) )
        {
            return ( "<dev string:x70>" + varvalue getentitynumber() + "<dev string:x6e>" );
        }
        
        return "<dev string:x28>" + varvalue;
    }

#/
