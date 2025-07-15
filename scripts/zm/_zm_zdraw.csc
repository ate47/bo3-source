#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_zdraw;

/#

    // Namespace zm_zdraw
    // Params 0, eflags: 0x2
    // Checksum 0x40ae5d3, Offset: 0x198
    // Size: 0x44, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, &__main__, undefined );
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0xbcf0ce2d, Offset: 0x1e8
    // Size: 0x8c, Type: dev
    function __init__()
    {
        setdvar( "<dev string:x28>", "<dev string:x2e>" );
        level.zdraw = spawnstruct();
        function_3e630288();
        function_aa8545fe();
        function_404ac348();
        level thread function_41fec76e();
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0xeb8facf, Offset: 0x280
    // Size: 0x8, Type: dev
    function __main__()
    {
        
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0x634bd6e3, Offset: 0x290
    // Size: 0x3be, Type: dev
    function function_3e630288()
    {
        level.zdraw.colors = [];
        level.zdraw.colors[ "<dev string:x2f>" ] = ( 1, 0, 0 );
        level.zdraw.colors[ "<dev string:x33>" ] = ( 0, 1, 0 );
        level.zdraw.colors[ "<dev string:x39>" ] = ( 0, 0, 1 );
        level.zdraw.colors[ "<dev string:x3e>" ] = ( 1, 1, 0 );
        level.zdraw.colors[ "<dev string:x45>" ] = ( 1, 0.5, 0 );
        level.zdraw.colors[ "<dev string:x4c>" ] = ( 0, 1, 1 );
        level.zdraw.colors[ "<dev string:x51>" ] = ( 1, 0, 1 );
        level.zdraw.colors[ "<dev string:x58>" ] = ( 0, 0, 0 );
        level.zdraw.colors[ "<dev string:x5e>" ] = ( 1, 1, 1 );
        level.zdraw.colors[ "<dev string:x64>" ] = ( 0.75, 0.75, 0.75 );
        level.zdraw.colors[ "<dev string:x69>" ] = ( 0.1, 0.1, 0.1 );
        level.zdraw.colors[ "<dev string:x6f>" ] = ( 0.2, 0.2, 0.2 );
        level.zdraw.colors[ "<dev string:x75>" ] = ( 0.3, 0.3, 0.3 );
        level.zdraw.colors[ "<dev string:x7b>" ] = ( 0.4, 0.4, 0.4 );
        level.zdraw.colors[ "<dev string:x81>" ] = ( 0.5, 0.5, 0.5 );
        level.zdraw.colors[ "<dev string:x87>" ] = ( 0.6, 0.6, 0.6 );
        level.zdraw.colors[ "<dev string:x8d>" ] = ( 0.7, 0.7, 0.7 );
        level.zdraw.colors[ "<dev string:x93>" ] = ( 0.8, 0.8, 0.8 );
        level.zdraw.colors[ "<dev string:x99>" ] = ( 0.9, 0.9, 0.9 );
        level.zdraw.colors[ "<dev string:x9f>" ] = ( 0.439216, 0.501961, 0.564706 );
        level.zdraw.colors[ "<dev string:xa5>" ] = ( 1, 0.752941, 0.796078 );
        level.zdraw.colors[ "<dev string:xaa>" ] = ( 0.501961, 0.501961, 0 );
        level.zdraw.colors[ "<dev string:xb0>" ] = ( 0.545098, 0.270588, 0.0745098 );
        level.zdraw.colors[ "<dev string:xb6>" ] = ( 1, 1, 1 );
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0xf1be390b, Offset: 0x658
    // Size: 0x1d6, Type: dev
    function function_aa8545fe()
    {
        level.zdraw.commands = [];
        level.zdraw.commands[ "<dev string:xbe>" ] = &zdraw_color;
        level.zdraw.commands[ "<dev string:xc4>" ] = &zdraw_alpha;
        level.zdraw.commands[ "<dev string:xca>" ] = &zdraw_duration;
        level.zdraw.commands[ "<dev string:xd3>" ] = &function_8f04ad79;
        level.zdraw.commands[ "<dev string:xdb>" ] = &zdraw_scale;
        level.zdraw.commands[ "<dev string:xe1>" ] = &function_b3b92edc;
        level.zdraw.commands[ "<dev string:xe8>" ] = &function_8c2ca616;
        level.zdraw.commands[ "<dev string:xee>" ] = &zdraw_text;
        level.zdraw.commands[ "<dev string:xf3>" ] = &function_f36ec3d2;
        level.zdraw.commands[ "<dev string:xf8>" ] = &function_7bdd3089;
        level.zdraw.commands[ "<dev string:xff>" ] = &zdraw_line;
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0x6298ca10, Offset: 0x838
    // Size: 0xf4, Type: dev
    function function_404ac348()
    {
        level.zdraw.color = level.zdraw.colors[ "<dev string:xb6>" ];
        level.zdraw.alpha = 1;
        level.zdraw.scale = 1;
        level.zdraw.duration = int( 1 * 62.5 );
        level.zdraw.radius = 8;
        level.zdraw.sides = 10;
        level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
        level.zdraw.var_922ae5d = 0;
        level.zdraw.var_c1953771 = "<dev string:x2e>";
    }

    // Namespace zm_zdraw
    // Params 0
    // Checksum 0xc11a2415, Offset: 0x938
    // Size: 0xd8, Type: dev
    function function_41fec76e()
    {
        level notify( #"hash_15f14510" );
        level endon( #"hash_15f14510" );
        
        for ( ;; )
        {
            cmd = getdvarstring( "<dev string:x28>" );
            
            if ( cmd.size )
            {
                function_404ac348();
                params = strtok( cmd, "<dev string:x104>" );
                zdraw_command( params, 0, 1 );
                setdvar( "<dev string:x28>", "<dev string:x2e>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace zm_zdraw
    // Params 3
    // Checksum 0xe3d442e7, Offset: 0xa18
    // Size: 0xe4, Type: dev
    function zdraw_command( var_859cfb21, startat, toplevel )
    {
        if ( !isdefined( toplevel ) )
        {
            toplevel = 0;
        }
        
        while ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( isdefined( level.zdraw.commands[ var_859cfb21[ startat ] ] ) )
            {
                startat = [[ level.zdraw.commands[ var_859cfb21[ startat ] ] ]]( var_859cfb21, startat + 1 );
                continue;
            }
            
            if ( isdefined( toplevel ) && toplevel )
            {
                function_c69caf7e( "<dev string:x108>" + var_859cfb21[ startat ] );
            }
            
            return startat;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x3dcfcace, Offset: 0xb08
    // Size: 0x16c, Type: dev
    function function_7bdd3089( var_859cfb21, startat )
    {
        while ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                var_b78d9698 = zdraw_vector( var_859cfb21, startat );
                
                if ( var_b78d9698 > startat )
                {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    sphere( center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration );
                    level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
                }
                
                continue;
            }
            
            var_b78d9698 = zdraw_command( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                continue;
            }
            
            return startat;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x8c83621a, Offset: 0xc80
    // Size: 0x13c, Type: dev
    function function_f36ec3d2( var_859cfb21, startat )
    {
        while ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                var_b78d9698 = zdraw_vector( var_859cfb21, startat );
                
                if ( var_b78d9698 > startat )
                {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    debugstar( center, level.zdraw.duration, level.zdraw.color );
                    level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
                }
                
                continue;
            }
            
            var_b78d9698 = zdraw_command( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                continue;
            }
            
            return startat;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xd7519ba1, Offset: 0xdc8
    // Size: 0x19c, Type: dev
    function zdraw_line( var_859cfb21, startat )
    {
        level.zdraw.linestart = undefined;
        
        while ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                var_b78d9698 = zdraw_vector( var_859cfb21, startat );
                
                if ( var_b78d9698 > startat )
                {
                    startat = var_b78d9698;
                    lineend = level.zdraw.var_5f3c7817;
                    
                    if ( isdefined( level.zdraw.linestart ) )
                    {
                        line( level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration );
                    }
                    
                    level.zdraw.linestart = lineend;
                    level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
                }
                
                continue;
            }
            
            var_b78d9698 = zdraw_command( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                continue;
            }
            
            return startat;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x3f83e1b0, Offset: 0xf70
    // Size: 0x204, Type: dev
    function zdraw_text( var_859cfb21, startat )
    {
        level.zdraw.text = "<dev string:x2e>";
        
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = function_ce50bae5( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.text = level.zdraw.var_c1953771;
                level.zdraw.var_c1953771 = "<dev string:x2e>";
            }
        }
        
        while ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                var_b78d9698 = zdraw_vector( var_859cfb21, startat );
                
                if ( var_b78d9698 > startat )
                {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    print3d( center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration );
                    level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
                }
                
                continue;
            }
            
            var_b78d9698 = zdraw_command( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                continue;
            }
            
            return startat;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x28301e68, Offset: 0x1180
    // Size: 0x17a, Type: dev
    function zdraw_color( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                var_b78d9698 = zdraw_vector( var_859cfb21, startat );
                
                if ( var_b78d9698 > startat )
                {
                    startat = var_b78d9698;
                    level.zdraw.color = level.zdraw.var_5f3c7817;
                    level.zdraw.var_5f3c7817 = ( 0, 0, 0 );
                }
                else
                {
                    level.zdraw.color = ( 1, 1, 1 );
                }
            }
            else
            {
                if ( isdefined( level.zdraw.colors[ var_859cfb21[ startat ] ] ) )
                {
                    level.zdraw.color = level.zdraw.colors[ var_859cfb21[ startat ] ];
                }
                else
                {
                    level.zdraw.color = ( 1, 1, 1 );
                    function_c69caf7e( "<dev string:x11e>" + var_859cfb21[ startat ] );
                }
                
                startat += 1;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x22d4065c, Offset: 0x1308
    // Size: 0xba, Type: dev
    function zdraw_alpha( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.alpha = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.alpha = 1;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x51378d73, Offset: 0x13d0
    // Size: 0xba, Type: dev
    function zdraw_scale( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.scale = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.scale = 1;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xaecad868, Offset: 0x1498
    // Size: 0xea, Type: dev
    function zdraw_duration( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.duration = int( level.zdraw.var_922ae5d );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.duration = int( 1 * 62.5 );
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xfcc0d5ed, Offset: 0x1590
    // Size: 0xf2, Type: dev
    function function_8f04ad79( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.duration = int( 62.5 * level.zdraw.var_922ae5d );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.duration = int( 1 * 62.5 );
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xc3cbaee6, Offset: 0x1690
    // Size: 0xba, Type: dev
    function function_b3b92edc( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.radius = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.radius = 8;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xfe5106db, Offset: 0x1758
    // Size: 0xce, Type: dev
    function function_8c2ca616( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.sides = int( level.zdraw.var_922ae5d );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                level.zdraw.sides = 10;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 1
    // Checksum 0x1c3ee0d0, Offset: 0x1830
    // Size: 0x88, Type: dev
    function function_c0fb9425( param )
    {
        if ( isstring( param ) && ( isint( param ) || isfloat( param ) || isdefined( param ) && strisnumber( param ) ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0xb60484ea, Offset: 0x18c0
    // Size: 0x260, Type: dev
    function zdraw_vector( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = ( level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[ 1 ], level.zdraw.var_5f3c7817[ 2 ] );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                function_c69caf7e( "<dev string:x132>" );
                return startat;
            }
            
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = ( level.zdraw.var_5f3c7817[ 0 ], level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[ 2 ] );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                function_c69caf7e( "<dev string:x132>" );
                return startat;
            }
            
            var_b78d9698 = zdraw_number( var_859cfb21, startat );
            
            if ( var_b78d9698 > startat )
            {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = ( level.zdraw.var_5f3c7817[ 0 ], level.zdraw.var_5f3c7817[ 1 ], level.zdraw.var_922ae5d );
                level.zdraw.var_922ae5d = 0;
            }
            else
            {
                function_c69caf7e( "<dev string:x132>" );
                return startat;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x24066f26, Offset: 0x1b28
    // Size: 0x8a, Type: dev
    function zdraw_number( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            if ( function_c0fb9425( var_859cfb21[ startat ] ) )
            {
                level.zdraw.var_922ae5d = float( var_859cfb21[ startat ] );
                startat += 1;
            }
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2
    // Checksum 0x2f7f683f, Offset: 0x1bc0
    // Size: 0x5a, Type: dev
    function function_ce50bae5( var_859cfb21, startat )
    {
        if ( isdefined( var_859cfb21[ startat ] ) )
        {
            level.zdraw.var_c1953771 = var_859cfb21[ startat ];
            startat += 1;
        }
        
        return startat;
    }

    // Namespace zm_zdraw
    // Params 1
    // Checksum 0x8cafbd4a, Offset: 0x1c28
    // Size: 0x34, Type: dev
    function function_c69caf7e( msg )
    {
        println( "<dev string:x155>" + msg );
    }

#/
