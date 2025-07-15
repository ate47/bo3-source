#using scripts/cp/_debug_menu;
#using scripts/cp/_util;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/init;
#using scripts/shared/ai/systems/weaponlist;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace debug;

/#

    // Namespace debug
    // Params 0, eflags: 0x2
    // Checksum 0x48227b8, Offset: 0x220
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, undefined );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x6a97ce95, Offset: 0x260
    // Size: 0xb4, Type: dev
    function __init__()
    {
        level.animsound_hudlimit = 14;
        level.debugteamcolors = [];
        level.debugteamcolors[ "<dev string:x35>" ] = ( 1, 0, 0 );
        level.debugteamcolors[ "<dev string:x3a>" ] = ( 0, 1, 0 );
        level.debugteamcolors[ "<dev string:x41>" ] = ( 1, 1, 0 );
        level.debugteamcolors[ "<dev string:x47>" ] = ( 1, 1, 1 );
        thread debugdvars();
        thread engagement_distance_debug_toggle();
        thread debug_coop_bot_test();
    }

    // Namespace debug
    // Params 1
    // Checksum 0xbcdfa15d, Offset: 0x320
    // Size: 0xdc, Type: dev
    function drawenttag( num )
    {
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            if ( ai[ i ] getentnum() != num )
            {
                continue;
            }
            
            ai[ i ] thread dragtaguntildeath( getdvarstring( "<dev string:x4f>" ) );
        }
        
        /#
            setdvar( "<dev string:x59>", "<dev string:x66>" );
        #/
    }

    // Namespace debug
    // Params 2
    // Checksum 0x59ec0d79, Offset: 0x408
    // Size: 0x84, Type: dev
    function drawtag( tag, opcolor )
    {
        org = self gettagorigin( tag );
        ang = self gettagangles( tag );
        drawarrow( org, ang, opcolor );
    }

    // Namespace debug
    // Params 1
    // Checksum 0x3a943fff, Offset: 0x498
    // Size: 0x40, Type: dev
    function draworgforever( opcolor )
    {
        for ( ;; )
        {
            drawarrow( self.origin, self.angles, opcolor );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x3793b79c, Offset: 0x4e0
    // Size: 0x40, Type: dev
    function drawarrowforever( org, ang )
    {
        for ( ;; )
        {
            drawarrow( org, ang );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x93399b64, Offset: 0x528
    // Size: 0x38, Type: dev
    function draworiginforever()
    {
        for ( ;; )
        {
            drawarrow( self.origin, self.angles );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 3
    // Checksum 0xc0b4a71a, Offset: 0x568
    // Size: 0x2bc, Type: dev
    function drawarrow( org, ang, opcolor )
    {
        forward = anglestoforward( ang );
        forwardfar = vectorscale( forward, 50 );
        forwardclose = vectorscale( forward, 50 * 0.8 );
        right = anglestoright( ang );
        leftdraw = vectorscale( right, 50 * -0.2 );
        rightdraw = vectorscale( right, 50 * 0.2 );
        up = anglestoup( ang );
        right = vectorscale( right, 50 );
        up = vectorscale( up, 50 );
        red = ( 0.9, 0.2, 0.2 );
        green = ( 0.2, 0.9, 0.2 );
        blue = ( 0.2, 0.2, 0.9 );
        
        if ( isdefined( opcolor ) )
        {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        
        line( org, org + forwardfar, red, 0.9 );
        line( org + forwardfar, org + forwardclose + rightdraw, red, 0.9 );
        line( org + forwardfar, org + forwardclose + leftdraw, red, 0.9 );
        line( org, org + right, blue, 0.9 );
        line( org, org + up, green, 0.9 );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x81e515f0, Offset: 0x830
    // Size: 0x50, Type: dev
    function drawplayerviewforever()
    {
        for ( ;; )
        {
            drawarrow( level.player.origin, level.player getplayerangles(), ( 1, 1, 1 ) );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0xff551ff8, Offset: 0x888
    // Size: 0x48, Type: dev
    function drawtagforever( tag, opcolor )
    {
        self endon( #"death" );
        
        for ( ;; )
        {
            drawtag( tag, opcolor );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xf5055dba, Offset: 0x8d8
    // Size: 0x40, Type: dev
    function dragtaguntildeath( tag )
    {
        for ( ;; )
        {
            if ( !isdefined( self.origin ) )
            {
                break;
            }
            
            drawtag( tag );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0xae1589c0, Offset: 0x920
    // Size: 0x10e, Type: dev
    function viewtag( type, tag )
    {
        if ( type == "<dev string:x67>" )
        {
            ai = getaiarray();
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] drawtag( tag );
            }
            
            return;
        }
        
        vehicle = getentarray( "<dev string:x6a>", "<dev string:x79>" );
        
        for ( i = 0; i < vehicle.size ; i++ )
        {
            vehicle[ i ] drawtag( tag );
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xfe7db7d3, Offset: 0xa38
    // Size: 0x90, Type: dev
    function removeactivespawner( spawner )
    {
        newspawners = [];
        
        for ( p = 0; p < level.activenodes.size ; p++ )
        {
            if ( level.activenodes[ p ] == spawner )
            {
                continue;
            }
            
            newspawners[ newspawners.size ] = level.activenodes[ p ];
        }
        
        level.activenodes = newspawners;
    }

    // Namespace debug
    // Params 1
    // Checksum 0xebd5b11b, Offset: 0xad0
    // Size: 0x68, Type: dev
    function createline( org )
    {
        for ( ;; )
        {
            line( org + ( 0, 0, 35 ), org, ( 0.2, 0.5, 0.8 ), 0.5 );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xa2078325, Offset: 0xb40
    // Size: 0xa8, Type: dev
    function createlineconstantly( ent )
    {
        org = undefined;
        
        while ( isalive( ent ) )
        {
            org = ent.origin;
            wait 0.05;
        }
        
        for ( ;; )
        {
            line( org + ( 0, 0, 35 ), org, ( 1, 0.2, 0.1 ), 0.5 );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x988ee688, Offset: 0xbf0
    // Size: 0x118, Type: dev
    function debugmisstime()
    {
        self notify( #"stopdebugmisstime" );
        self endon( #"stopdebugmisstime" );
        self endon( #"death" );
        
        for ( ;; )
        {
            if ( self.a.misstime <= 0 )
            {
                print3d( self gettagorigin( "<dev string:x83>" ) + ( 0, 0, 15 ), "<dev string:x8b>", ( 0.3, 1, 1 ), 1 );
            }
            else
            {
                print3d( self gettagorigin( "<dev string:x83>" ) + ( 0, 0, 15 ), self.a.misstime / 20, ( 0.3, 1, 1 ), 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x6b45a073, Offset: 0xd10
    // Size: 0x16, Type: dev
    function debugmisstimeoff()
    {
        self notify( #"stopdebugmisstime" );
    }

    // Namespace debug
    // Params 2
    // Checksum 0xe3c73ac7, Offset: 0xd30
    // Size: 0x5c, Type: dev
    function setemptydvar( dvar, setting )
    {
        /#
            if ( getdvarstring( dvar ) == "<dev string:x66>" )
            {
                setdvar( dvar, setting );
            }
        #/
    }

    // Namespace debug
    // Params 1
    // Checksum 0x6f6d57c1, Offset: 0xd98
    // Size: 0xf0, Type: dev
    function debugjump( num )
    {
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            if ( ai[ i ] getentnum() != num )
            {
                continue;
            }
            
            players = getplayers();
            line( players[ 0 ].origin, ai[ i ].origin, ( 0.2, 0.3, 1 ) );
            return;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x63a43b57, Offset: 0xe90
    // Size: 0x1328, Type: dev
    function debugdvars()
    {
        if ( getdvarstring( "<dev string:x8f>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x8f>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:xa9>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:xa9>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:xbb>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:xbb>", "<dev string:xa5>" );
        }
        
        setemptydvar( "<dev string:xcb>", "<dev string:xa5>" );
        
        if ( getdvarstring( "<dev string:xe1>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:xe1>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:xf1>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:xf1>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x103>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x103>", "<dev string:x111>" );
        }
        
        if ( getdvarstring( "<dev string:x114>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x114>", "<dev string:x111>" );
        }
        
        if ( getdvarstring( "<dev string:x4f>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x4f>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x129>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x129>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x138>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x138>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x149>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x149>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x15a>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x15a>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x16f>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x16f>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x17c>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x17c>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x18d>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x18d>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x19d>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x19d>", "<dev string:x1ac>" );
        }
        
        if ( getdvarstring( "<dev string:x1af>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x1af>", "<dev string:xa5>" );
        }
        
        level.debug_badpath = 0;
        
        if ( getdvarstring( "<dev string:x1bb>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x1bb>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x1c9>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x1db>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x1ee>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x1ee>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x1fe>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x1fe>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x209>" ) == "<dev string:x1ac>" )
        {
            setdvar( "<dev string:x209>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x219>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x219>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x224>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x224>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x22f>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x22f>", "<dev string:xa5>" );
        }
        
        if ( getdvarstring( "<dev string:x239>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x239>", "<dev string:x66>" );
        }
        
        for ( i = 1; i <= level.animsound_hudlimit ; i++ )
        {
            if ( getdvarstring( "<dev string:x239>" + i ) == "<dev string:x66>" )
            {
                setdvar( "<dev string:x239>" + i, "<dev string:x66>" );
            }
        }
        
        if ( getdvarstring( "<dev string:x23d>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x23d>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x24c>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x24c>", "<dev string:x66>" );
        }
        
        if ( getdvarstring( "<dev string:x258>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x258>", "<dev string:x261>" );
            setdvar( "<dev string:x263>", "<dev string:x261>" );
            setdvar( "<dev string:x271>", "<dev string:x261>" );
        }
        
        if ( getdvarstring( "<dev string:x27e>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x27e>", "<dev string:x261>" );
        }
        
        level.last_threat_debug = -23430;
        
        if ( getdvarstring( "<dev string:x298>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x298>", "<dev string:x111>" );
        }
        
        waittillframeend();
        
        if ( getdvarstring( "<dev string:x2a5>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x2a5>", "<dev string:xa5>" );
        }
        
        noanimscripts = getdvarstring( "<dev string:x2bb>" ) == "<dev string:x1ac>";
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x219>" ) != "<dev string:x66>" )
            {
                debugjump( getdvarstring( "<dev string:x219>" ) );
            }
            
            if ( getdvarint( "<dev string:x2cf>" ) == 1 )
            {
                level thread function_2ceda325();
            }
            
            if ( getdvarstring( "<dev string:x4f>" ) != "<dev string:x66>" )
            {
                thread viewtag( "<dev string:x67>", getdvarstring( "<dev string:x4f>" ) );
                
                if ( getdvarstring( "<dev string:x59>" ) > 0 )
                {
                    thread drawenttag( getdvarstring( "<dev string:x59>" ) );
                }
            }
            
            if ( getdvarstring( "<dev string:x149>" ) == "<dev string:x1ac>" )
            {
                level thread debug_goalradius();
            }
            
            if ( getdvarstring( "<dev string:x15a>" ) == "<dev string:x1ac>" )
            {
                level thread debug_maxvisibledist();
            }
            
            if ( getdvarstring( "<dev string:x16f>" ) == "<dev string:x1ac>" )
            {
                level thread debug_health();
            }
            
            if ( getdvarstring( "<dev string:x17c>" ) == "<dev string:x1ac>" )
            {
                level thread debug_engagedist();
            }
            
            if ( getdvarstring( "<dev string:x138>" ) != "<dev string:x66>" )
            {
                thread viewtag( "<dev string:x2e5>", getdvarstring( "<dev string:x138>" ) );
            }
            
            thread debug_animsound();
            
            if ( getdvarstring( "<dev string:x239>" ) != "<dev string:x66>" )
            {
                thread debug_animsoundtagselected();
            }
            
            for ( i = 1; i <= level.animsound_hudlimit ; i++ )
            {
                if ( getdvarstring( "<dev string:x239>" + i ) != "<dev string:x66>" )
                {
                    thread debug_animsoundtag( i );
                }
            }
            
            if ( getdvarstring( "<dev string:x23d>" ) != "<dev string:x66>" )
            {
                thread debug_animsoundsave();
            }
            
            if ( getdvarstring( "<dev string:x1fe>" ) != "<dev string:xa5>" )
            {
                thread debug_nuke();
            }
            
            if ( getdvarstring( "<dev string:x2ed>" ) == "<dev string:x1ac>" )
            {
                setdvar( "<dev string:x2ed>", "<dev string:x2fc>" );
                array::thread_all( getaiarray(), &debugmisstime );
            }
            else if ( getdvarstring( "<dev string:x2ed>" ) == "<dev string:xa5>" )
            {
                setdvar( "<dev string:x2ed>", "<dev string:x2fc>" );
                array::thread_all( getaiarray(), &debugmisstimeoff );
            }
            
            if ( getdvarstring( "<dev string:x209>" ) == "<dev string:x1ac>" )
            {
                thread deathspawnerpreview();
            }
            
            if ( getdvarstring( "<dev string:x224>" ) == "<dev string:x1ac>" )
            {
                setdvar( "<dev string:x224>", "<dev string:xa5>" );
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] dodamage( 50, ( 324234, 3423423, 2323 ) );
                }
            }
            
            if ( getdvarstring( "<dev string:x224>" ) == "<dev string:x1ac>" )
            {
                setdvar( "<dev string:x224>", "<dev string:xa5>" );
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] dodamage( 50, ( 324234, 3423423, 2323 ) );
                }
            }
            
            if ( getdvarstring( "<dev string:x24c>" ) == "<dev string:x1ac>" )
            {
                thread fogcheck();
            }
            
            if ( getdvarstring( "<dev string:x298>" ) != "<dev string:x111>" && getdvarstring( "<dev string:x298>" ) != "<dev string:x66>" )
            {
                debugthreat();
            }
            
            level.debug_badpath = getdvarstring( "<dev string:x1bb>" ) == "<dev string:x1ac>";
            
            if ( !noanimscripts && getdvarstring( "<dev string:x2bb>" ) == "<dev string:x1ac>" )
            {
                noanimscripts = 1;
            }
            
            if ( noanimscripts && getdvarstring( "<dev string:x2bb>" ) == "<dev string:xa5>" )
            {
                anim.defaultexception = &util::empty;
                anim notify( #"hash_9a6633d5" );
                noanimscripts = 0;
            }
            
            if ( getdvarstring( "<dev string:x1af>" ) == "<dev string:x1ac>" )
            {
                if ( !isdefined( level.tracestart ) )
                {
                    thread showdebugtrace();
                }
                
                players = getplayers();
                level.tracestart = players[ 0 ] geteye();
                setdvar( "<dev string:x1af>", "<dev string:xa5>" );
            }
            
            if ( !isdefined( level.spawn_anywhere_active ) || getdvarstring( "<dev string:x27e>" ) == "<dev string:x302>" && level.spawn_anywhere_active == 0 )
            {
                level.spawn_anywhere_active = 1;
                thread dynamic_ai_spawner();
            }
            else if ( getdvarstring( "<dev string:x27e>" ) == "<dev string:x261>" && isdefined( level.spawn_anywhere_active ) && level.spawn_anywhere_active == 1 )
            {
                level.spawn_anywhere_active = 0;
                level notify( #"hash_d123a0a5" );
            }
            
            debug_ik_on_actors();
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xf64bc17f, Offset: 0x21c0
    // Size: 0x1a2, Type: dev
    function debug_ik_on_actors()
    {
        toggleon = getdvarstring( "<dev string:x258>" ) == "<dev string:x302>";
        
        if ( !toggleon )
        {
            return;
        }
        
        togglelegik = getdvarstring( "<dev string:x271>" ) == "<dev string:x302>";
        toggleheadik = getdvarstring( "<dev string:x263>" ) == "<dev string:x302>";
        ais = getactorarray();
        
        foreach ( ai in ais )
        {
            if ( togglelegik )
            {
                ai.enableterrainik = 1;
            }
            else
            {
                ai.enableterrainik = 0;
            }
            
            if ( toggleheadik )
            {
                ai lookatentity( level.players[ 0 ] );
                continue;
            }
            
            ai lookatentity();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xe4e1aa1a, Offset: 0x2370
    // Size: 0x180, Type: dev
    function showdebugtrace()
    {
        startoverride = undefined;
        endoverride = undefined;
        startoverride = ( 15.1859, -12.2822, 4.071 );
        endoverride = ( 947.2, -10918, 64.9514 );
        assert( !isdefined( level.traceend ) );
        
        for ( ;; )
        {
            players = getplayers();
            wait 0.05;
            start = startoverride;
            end = endoverride;
            
            if ( !isdefined( startoverride ) )
            {
                start = level.tracestart;
            }
            
            if ( !isdefined( endoverride ) )
            {
                end = players[ 0 ] geteye();
            }
            
            trace = bullettrace( start, end, 0, undefined );
            line( start, trace[ "<dev string:x304>" ], ( 0.9, 0.5, 0.8 ), 0.5 );
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x1e358ff9, Offset: 0x24f8
    // Size: 0x1de, Type: dev
    function hatmodel()
    {
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x19d>" ) == "<dev string:xa5>" )
            {
                return;
            }
            
            nohat = [];
            ai = getaiarray();
            
            for ( i = 0; i < ai.size ; i++ )
            {
                if ( isdefined( ai[ i ].hatmodel ) )
                {
                    continue;
                }
                
                alreadyknown = 0;
                
                for ( p = 0; p < nohat.size ; p++ )
                {
                    if ( nohat[ p ] != ai[ i ].classname )
                    {
                        continue;
                    }
                    
                    alreadyknown = 1;
                    break;
                }
                
                if ( !alreadyknown )
                {
                    nohat[ nohat.size ] = ai[ i ].classname;
                }
            }
            
            if ( nohat.size )
            {
                println( "<dev string:x30d>" );
                println( "<dev string:x30f>" );
                
                for ( i = 0; i < nohat.size ; i++ )
                {
                    println( "<dev string:x361>", nohat[ i ] );
                }
                
                println( "<dev string:x36d>" );
            }
            
            wait 15;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x5d08f0e2, Offset: 0x26e0
    // Size: 0x2f4, Type: dev
    function debug_nuke()
    {
        players = getplayers();
        player = players[ 0 ];
        dvar = getdvarstring( "<dev string:x1fe>" );
        
        if ( dvar == "<dev string:x1ac>" )
        {
            ai = getaiteamarray( "<dev string:x35>", "<dev string:x41>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ignore = 0;
                classname = ai[ i ].classname;
                
                if ( issubstr( classname, "<dev string:x39f>" ) || issubstr( classname, "<dev string:x3a4>" ) || isdefined( classname ) && issubstr( classname, "<dev string:x3a9>" ) )
                {
                    ignore = 1;
                }
                
                if ( !ignore )
                {
                    ai[ i ] dodamage( ai[ i ].health, ( 0, 0, 0 ), player );
                }
            }
        }
        else if ( dvar == "<dev string:x67>" )
        {
            ai = getaiteamarray( "<dev string:x35>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] dodamage( ai[ i ].health, ( 0, 0, 0 ), player );
            }
        }
        else if ( dvar == "<dev string:x3b3>" )
        {
            ai = getaispeciesarray( "<dev string:x35>", "<dev string:x3b8>" );
            
            for ( i = 0; i < ai.size ; i++ )
            {
                ai[ i ] dodamage( ai[ i ].health, ( 0, 0, 0 ), player );
            }
        }
        
        setdvar( "<dev string:x1fe>", "<dev string:xa5>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x39ffb43e, Offset: 0x29e0
    // Size: 0x8, Type: dev
    function debug_misstime()
    {
        
    }

    // Namespace debug
    // Params 0
    // Checksum 0xd558006, Offset: 0x29f0
    // Size: 0x2c, Type: dev
    function freeplayer()
    {
        setdvar( "<dev string:x3bc>", "<dev string:x261>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xfbdaf281, Offset: 0x2a28
    // Size: 0x160, Type: dev
    function deathspawnerpreview()
    {
        waittillframeend();
        
        for ( i = 0; i < 50 ; i++ )
        {
            if ( !isdefined( level.deathspawnerents[ i ] ) )
            {
                continue;
            }
            
            array = level.deathspawnerents[ i ];
            
            for ( p = 0; p < array.size ; p++ )
            {
                ent = array[ p ];
                
                if ( isdefined( ent.truecount ) )
                {
                    print3d( ent.origin, i + "<dev string:x3c8>" + ent.truecount, ( 0, 0.8, 0.6 ), 5 );
                    continue;
                }
                
                print3d( ent.origin, i + "<dev string:x3c8>" + "<dev string:x3cb>", ( 0, 0.8, 0.6 ), 5 );
            }
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xdacd9543, Offset: 0x2b90
    // Size: 0xa6, Type: dev
    function getchains()
    {
        chainarray = [];
        chainarray = getentarray( "<dev string:x3cd>", "<dev string:x3da>" );
        array = [];
        
        for ( i = 0; i < chainarray.size ; i++ )
        {
            array[ i ] = chainarray[ i ] getchain();
        }
        
        return array;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xb640be75, Offset: 0x2c40
    // Size: 0x126, Type: dev
    function getchain()
    {
        array = [];
        ent = self;
        
        while ( isdefined( ent ) )
        {
            array[ array.size ] = ent;
            
            if ( !isdefined( ent ) || !isdefined( ent.target ) )
            {
                break;
            }
            
            ent = getent( ent.target, "<dev string:x3ec>" );
            
            if ( isdefined( ent ) && ent == array[ 0 ] )
            {
                array[ array.size ] = ent;
                break;
            }
        }
        
        originarray = [];
        
        for ( i = 0; i < array.size ; i++ )
        {
            originarray[ i ] = array[ i ].origin;
        }
        
        return originarray;
    }

    // Namespace debug
    // Params 2
    // Checksum 0x63961390, Offset: 0x2d70
    // Size: 0x4a, Type: dev
    function vecscale( vec, scalar )
    {
        return ( vec[ 0 ] * scalar, vec[ 1 ] * scalar, vec[ 2 ] * scalar );
    }

    // Namespace debug
    // Params 1
    // Checksum 0x9bcc0140, Offset: 0x2dc8
    // Size: 0x12c, Type: dev
    function islookingatorigin( origin )
    {
        normalvec = vectornormalize( origin - self getshootatpos() );
        veccomp = vectornormalize( origin - ( 0, 0, 24 ) - self getshootatpos() );
        insidedot = vectordot( normalvec, veccomp );
        anglevec = anglestoforward( self getplayerangles() );
        vectordot = vectordot( anglevec, normalvec );
        
        if ( vectordot > insidedot )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xf53f8b38, Offset: 0x2f00
    // Size: 0x114, Type: dev
    function fogcheck()
    {
        if ( getdvarstring( "<dev string:x3f7>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x3f7>", "<dev string:x261>" );
        }
        
        if ( getdvarstring( "<dev string:x403>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x403>", "<dev string:x40d>" );
        }
        
        close = getdvarint( "<dev string:x3f7>" );
        far = getdvarint( "<dev string:x403>" );
        setexpfog( close, far, 1, 1, 1, 0 );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xe53222ec, Offset: 0x3020
    // Size: 0x24, Type: dev
    function debugthreat()
    {
        level.last_threat_debug = gettime();
        thread debugthreatcalc();
    }

    // Namespace debug
    // Params 0
    // Checksum 0x2411f664, Offset: 0x3050
    // Size: 0x18c, Type: dev
    function debugthreatcalc()
    {
        ai = getaiarray();
        entnum = getdvarstring( "<dev string:x298>" );
        entity = undefined;
        players = getplayers();
        
        if ( entnum == 0 )
        {
            entity = players[ 0 ];
        }
        else
        {
            for ( i = 0; i < ai.size ; i++ )
            {
                if ( entnum != ai[ i ] getentnum() )
                {
                    continue;
                }
                
                entity = ai[ i ];
                break;
            }
        }
        
        if ( !isalive( entity ) )
        {
            return;
        }
        
        entitygroup = entity getthreatbiasgroup();
        array::thread_all( ai, &displaythreat, entity, entitygroup );
        players[ 0 ] thread displaythreat( entity, entitygroup );
    }

    // Namespace debug
    // Params 2
    // Checksum 0x4b06f516, Offset: 0x31e8
    // Size: 0x3ce, Type: dev
    function displaythreat( entity, entitygroup )
    {
        self endon( #"death" );
        
        if ( self.team == entity.team )
        {
            return;
        }
        
        selfthreat = 0;
        selfthreat += self.threatbias;
        threat = 0;
        threat += entity.threatbias;
        mygroup = undefined;
        
        if ( isdefined( entitygroup ) )
        {
            mygroup = self getthreatbiasgroup();
            
            if ( isdefined( mygroup ) )
            {
                threat += getthreatbias( entitygroup, mygroup );
                selfthreat += getthreatbias( mygroup, entitygroup );
            }
        }
        
        if ( entity.ignoreme || threat < -900000 )
        {
            threat = "<dev string:x412>";
        }
        
        if ( self.ignoreme || selfthreat < -900000 )
        {
            selfthreat = "<dev string:x412>";
        }
        
        players = getplayers();
        col = ( 1, 0.5, 0.2 );
        col2 = ( 0.2, 0.5, 1 );
        pacifist = self != players[ 0 ] && self.pacifist;
        
        for ( i = 0; i <= 20 ; i++ )
        {
            print3d( self.origin + ( 0, 0, 65 ), "<dev string:x419>", col, 3 );
            print3d( self.origin + ( 0, 0, 50 ), threat, col, 5 );
            
            if ( isdefined( entitygroup ) )
            {
                print3d( self.origin + ( 0, 0, 35 ), entitygroup, col, 2 );
            }
            
            print3d( self.origin + ( 0, 0, 15 ), "<dev string:x424>", col2, 3 );
            print3d( self.origin + ( 0, 0, 0 ), selfthreat, col2, 5 );
            
            if ( isdefined( mygroup ) )
            {
                print3d( self.origin + ( 0, 0, -15 ), mygroup, col2, 2 );
            }
            
            if ( pacifist )
            {
                print3d( self.origin + ( 0, 0, 25 ), "<dev string:x42f>", col2, 5 );
            }
            
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x311d95c7, Offset: 0x35c0
    // Size: 0xe6, Type: dev
    function init_animsounds()
    {
        level.animsounds = [];
        level.animsound_aliases = [];
        waittillframeend();
        waittillframeend();
        animnames = getarraykeys( level.scr_notetrack );
        
        for ( i = 0; i < animnames.size ; i++ )
        {
            init_notetracks_for_animname( animnames[ i ] );
        }
        
        animnames = getarraykeys( level.scr_animsound );
        
        for ( i = 0; i < animnames.size ; i++ )
        {
            init_animsounds_for_animname( animnames[ i ] );
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x1f1a8413, Offset: 0x36b0
    // Size: 0x16e, Type: dev
    function init_notetracks_for_animname( animname )
    {
        notetracks = getarraykeys( level.scr_notetrack[ animname ] );
        
        for ( i = 0; i < notetracks.size ; i++ )
        {
            soundalias = level.scr_notetrack[ animname ][ i ][ "<dev string:x43c>" ];
            
            if ( !isdefined( soundalias ) )
            {
                continue;
            }
            
            anime = level.scr_notetrack[ animname ][ i ][ "<dev string:x442>" ];
            notetrack = level.scr_notetrack[ animname ][ i ][ "<dev string:x448>" ];
            level.animsound_aliases[ animname ][ anime ][ notetrack ][ "<dev string:x452>" ] = soundalias;
            
            if ( isdefined( level.scr_notetrack[ animname ][ i ][ "<dev string:x45d>" ] ) )
            {
                level.animsound_aliases[ animname ][ anime ][ notetrack ][ "<dev string:x45d>" ] = 1;
            }
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x741f5161, Offset: 0x3828
    // Size: 0x102, Type: dev
    function init_animsounds_for_animname( animname )
    {
        animes = getarraykeys( level.scr_animsound[ animname ] );
        
        for ( i = 0; i < animes.size ; i++ )
        {
            anime = animes[ i ];
            soundalias = level.scr_animsound[ animname ][ anime ];
            level.animsound_aliases[ animname ][ anime ][ "<dev string:x472>" + anime ][ "<dev string:x452>" ] = soundalias;
            level.animsound_aliases[ animname ][ anime ][ "<dev string:x472>" + anime ][ "<dev string:x45d>" ] = 1;
        }
    }

    // Namespace debug
    // Params 3
    // Checksum 0x33a0efe9, Offset: 0x3938
    // Size: 0xe8, Type: dev
    function add_hud_line( x, y, msg )
    {
        hudelm = newhudelem();
        hudelm.alignx = "<dev string:x474>";
        hudelm.aligny = "<dev string:x479>";
        hudelm.x = x;
        hudelm.y = y;
        hudelm.alpha = 1;
        hudelm.fontscale = 1;
        hudelm.label = msg;
        level.animsound_hud_extralines[ level.animsound_hud_extralines.size ] = hudelm;
        return hudelm;
    }

    // Namespace debug
    // Params 0
    // Checksum 0x9a542a82, Offset: 0x3a28
    // Size: 0x96c, Type: dev
    function debug_animsound()
    {
        enabled = getdvarstring( "<dev string:x22f>" ) == "<dev string:x1ac>";
        
        if ( !isdefined( level.animsound_hud ) )
        {
            if ( !enabled )
            {
                return;
            }
            
            level.animsound_selected = 0;
            level.animsound_input = "<dev string:x480>";
            level.animsound_hud = [];
            level.animsound_hud_timer = [];
            level.animsound_hud_alias = [];
            level.animsound_hud_extralines = [];
            level.animsound_locked = 0;
            level.animsound_locked_pressed = 0;
            level.animsound_hud_animname = add_hud_line( -30, 180, "<dev string:x485>" );
            level.animsound_hud_anime = add_hud_line( 100, 180, "<dev string:x48d>" );
            add_hud_line( 10, 190, "<dev string:x494>" );
            add_hud_line( -30, 190, "<dev string:x4a7>" );
            add_hud_line( -30, 160, "<dev string:x4af>" );
            add_hud_line( -30, 150, "<dev string:x4cf>" );
            add_hud_line( -30, 140, "<dev string:x4e3>" );
            level.animsound_hud_locked = add_hud_line( -30, 170, "<dev string:x513>" );
            level.animsound_hud_locked.alpha = 0;
            
            for ( i = 0; i < level.animsound_hudlimit ; i++ )
            {
                hudelm = newhudelem();
                hudelm.alignx = "<dev string:x474>";
                hudelm.aligny = "<dev string:x479>";
                hudelm.x = 10;
                hudelm.y = 200 + i * 10;
                hudelm.alpha = 1;
                hudelm.fontscale = 1;
                hudelm.label = "<dev string:x66>";
                level.animsound_hud[ level.animsound_hud.size ] = hudelm;
                hudelm = newhudelem();
                hudelm.alignx = "<dev string:x51c>";
                hudelm.aligny = "<dev string:x479>";
                hudelm.x = -10;
                hudelm.y = 200 + i * 10;
                hudelm.alpha = 1;
                hudelm.fontscale = 1;
                hudelm.label = "<dev string:x66>";
                level.animsound_hud_timer[ level.animsound_hud_timer.size ] = hudelm;
                hudelm = newhudelem();
                hudelm.alignx = "<dev string:x51c>";
                hudelm.aligny = "<dev string:x479>";
                hudelm.x = 210;
                hudelm.y = 200 + i * 10;
                hudelm.alpha = 1;
                hudelm.fontscale = 1;
                hudelm.label = "<dev string:x66>";
                level.animsound_hud_alias[ level.animsound_hud_alias.size ] = hudelm;
            }
            
            level.animsound_hud[ 0 ].color = ( 1, 1, 0 );
            level.animsound_hud_timer[ 0 ].color = ( 1, 1, 0 );
        }
        else if ( !enabled )
        {
            for ( i = 0; i < level.animsound_hudlimit ; i++ )
            {
                level.animsound_hud[ i ] destroy();
                level.animsound_hud_timer[ i ] destroy();
                level.animsound_hud_alias[ i ] destroy();
            }
            
            for ( i = 0; i < level.animsound_hud_extralines.size ; i++ )
            {
                level.animsound_hud_extralines[ i ] destroy();
            }
            
            level.animsound_hud = undefined;
            level.animsound_hud_timer = undefined;
            level.animsound_hud_alias = undefined;
            level.animsound_hud_extralines = undefined;
            level.animsounds = undefined;
            return;
        }
        
        if ( !isdefined( level.animsound_tagged ) )
        {
            level.animsound_locked = 0;
        }
        
        if ( level.animsound_locked )
        {
            level.animsound_hud_locked.alpha = 1;
        }
        else
        {
            level.animsound_hud_locked.alpha = 0;
        }
        
        if ( !isdefined( level.animsounds ) )
        {
            init_animsounds();
        }
        
        level.animsounds_thisframe = [];
        arrayremovevalue( level.animsounds, undefined );
        array::thread_all( level.animsounds, &display_animsound );
        players = getplayers();
        
        if ( level.animsound_locked )
        {
            for ( i = 0; i < level.animsounds_thisframe.size ; i++ )
            {
                animsound = level.animsounds_thisframe[ i ];
                animsound.animsound_color = ( 0.5, 0.5, 0.5 );
            }
        }
        else if ( players.size > 0 )
        {
            dot = 0.85;
            forward = anglestoforward( players[ 0 ] getplayerangles() );
            
            for ( i = 0; i < level.animsounds_thisframe.size ; i++ )
            {
                animsound = level.animsounds_thisframe[ i ];
                animsound.animsound_color = ( 0.25, 1, 0.5 );
                difference = vectornormalize( animsound.origin + ( 0, 0, 40 ) - players[ 0 ].origin + ( 0, 0, 55 ) );
                newdot = vectordot( forward, difference );
                
                if ( newdot < dot )
                {
                    continue;
                }
                
                dot = newdot;
                level.animsound_tagged = animsound;
            }
        }
        
        if ( isdefined( level.animsound_tagged ) )
        {
            level.animsound_tagged.animsound_color = ( 1, 1, 0 );
        }
        
        is_tagged = isdefined( level.animsound_tagged );
        
        for ( i = 0; i < level.animsounds_thisframe.size ; i++ )
        {
            animsound = level.animsounds_thisframe[ i ];
            msg = "<dev string:x522>";
            
            if ( level.animsound_locked )
            {
                msg = "<dev string:x524>";
            }
            
            print3d( animsound.origin + ( 0, 0, 40 ), msg + animsound.animsounds.size, animsound.animsound_color, 1, 1 );
        }
        
        if ( is_tagged )
        {
            draw_animsounds_in_hud();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x62ffed0b, Offset: 0x43a0
    // Size: 0x6ec, Type: dev
    function draw_animsounds_in_hud()
    {
        guy = level.animsound_tagged;
        animsounds = guy.animsounds;
        animname = "<dev string:x52a>";
        
        if ( isdefined( guy.animname ) )
        {
            animname = guy.animname;
        }
        
        level.animsound_hud_animname.label = "<dev string:x485>" + animname;
        players = getplayers();
        
        if ( players[ 0 ] buttonpressed( "<dev string:x532>" ) )
        {
            if ( !level.animsound_locked_pressed )
            {
                level.animsound_locked = !level.animsound_locked;
                level.animsound_locked_pressed = 1;
            }
        }
        else
        {
            level.animsound_locked_pressed = 0;
        }
        
        if ( players[ 0 ] buttonpressed( "<dev string:x536>" ) )
        {
            if ( level.animsound_input != "<dev string:x53e>" )
            {
                level.animsound_selected--;
            }
            
            level.animsound_input = "<dev string:x53e>";
        }
        else if ( players[ 0 ] buttonpressed( "<dev string:x541>" ) )
        {
            if ( level.animsound_input != "<dev string:x54b>" )
            {
                level.animsound_selected++;
            }
            
            level.animsound_input = "<dev string:x54b>";
        }
        else
        {
            level.animsound_input = "<dev string:x480>";
        }
        
        for ( i = 0; i < level.animsound_hudlimit ; i++ )
        {
            hudelm = level.animsound_hud[ i ];
            hudelm.label = "<dev string:x66>";
            hudelm.color = ( 1, 1, 1 );
            hudelm = level.animsound_hud_timer[ i ];
            hudelm.label = "<dev string:x66>";
            hudelm.color = ( 1, 1, 1 );
            hudelm = level.animsound_hud_alias[ i ];
            hudelm.label = "<dev string:x66>";
            hudelm.color = ( 1, 1, 1 );
        }
        
        keys = getarraykeys( animsounds );
        highest = -1;
        
        for ( i = 0; i < keys.size ; i++ )
        {
            if ( keys[ i ] > highest )
            {
                highest = keys[ i ];
            }
        }
        
        if ( highest == -1 )
        {
            return;
        }
        
        if ( level.animsound_selected > highest )
        {
            level.animsound_selected = highest;
        }
        
        if ( level.animsound_selected < 0 )
        {
            level.animsound_selected = 0;
        }
        
        for ( ;; )
        {
            if ( isdefined( animsounds[ level.animsound_selected ] ) )
            {
                break;
            }
            
            level.animsound_selected--;
            
            if ( level.animsound_selected < 0 )
            {
                level.animsound_selected = highest;
            }
        }
        
        level.animsound_hud_anime.label = "<dev string:x48d>" + animsounds[ level.animsound_selected ].anime;
        level.animsound_hud[ level.animsound_selected ].color = ( 1, 1, 0 );
        level.animsound_hud_timer[ level.animsound_selected ].color = ( 1, 1, 0 );
        level.animsound_hud_alias[ level.animsound_selected ].color = ( 1, 1, 0 );
        time = gettime();
        
        for ( i = 0; i < keys.size ; i++ )
        {
            key = keys[ i ];
            animsound = animsounds[ key ];
            hudelm = level.animsound_hud[ key ];
            soundalias = get_alias_from_stored( animsound );
            hudelm.label = key + 1 + "<dev string:x550>" + animsound.notetrack;
            hudelm = level.animsound_hud_timer[ key ];
            hudelm.label = int( ( time - animsound.end_time - 60000 ) * 0.001 );
            
            if ( isdefined( soundalias ) )
            {
                hudelm = level.animsound_hud_alias[ key ];
                hudelm.label = soundalias;
                
                if ( !is_from_animsound( animsound.animname, animsound.anime, animsound.notetrack ) )
                {
                    hudelm.color = ( 0.7, 0.7, 0.7 );
                }
            }
        }
        
        players = getplayers();
        
        if ( players[ 0 ] buttonpressed( "<dev string:x553>" ) )
        {
            animsound = animsounds[ level.animsound_selected ];
            soundalias = get_alias_from_stored( animsound );
            
            if ( !isdefined( soundalias ) )
            {
                return;
            }
            
            if ( !is_from_animsound( animsound.animname, animsound.anime, animsound.notetrack ) )
            {
                return;
            }
            
            level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ] = undefined;
            debug_animsoundsave();
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xe89da0a4, Offset: 0x4a98
    // Size: 0xd4, Type: dev
    function get_alias_from_stored( animsound )
    {
        if ( !isdefined( level.animsound_aliases[ animsound.animname ] ) )
        {
            return;
        }
        
        if ( !isdefined( level.animsound_aliases[ animsound.animname ][ animsound.anime ] ) )
        {
            return;
        }
        
        if ( !isdefined( level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ] ) )
        {
            return;
        }
        
        return level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "<dev string:x452>" ];
    }

    // Namespace debug
    // Params 3
    // Checksum 0x64bf1628, Offset: 0x4b78
    // Size: 0x46, Type: dev
    function is_from_animsound( animname, anime, notetrack )
    {
        return isdefined( level.animsound_aliases[ animname ][ anime ][ notetrack ][ "<dev string:x45d>" ] );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x200114fd, Offset: 0x4bc8
    // Size: 0x72, Type: dev
    function display_animsound()
    {
        players = getplayers();
        
        if ( distance( players[ 0 ].origin, self.origin ) > 1500 )
        {
            return;
        }
        
        level.animsounds_thisframe[ level.animsounds_thisframe.size ] = self;
    }

    // Namespace debug
    // Params 1
    // Checksum 0x50d81a90, Offset: 0x4c48
    // Size: 0xb4, Type: dev
    function debug_animsoundtag( tagnum )
    {
        tag = getdvarstring( "<dev string:x239>" + tagnum );
        
        if ( tag == "<dev string:x66>" )
        {
            iprintlnbold( "<dev string:x557>" );
            return;
        }
        
        tag_sound( tag, tagnum - 1 );
        setdvar( "<dev string:x239>" + tagnum, "<dev string:x66>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x711905be, Offset: 0x4d08
    // Size: 0x9c, Type: dev
    function debug_animsoundtagselected()
    {
        tag = getdvarstring( "<dev string:x239>" );
        
        if ( tag == "<dev string:x66>" )
        {
            iprintlnbold( "<dev string:x581>" );
            return;
        }
        
        tag_sound( tag, level.animsound_selected );
        setdvar( "<dev string:x239>", "<dev string:x66>" );
    }

    // Namespace debug
    // Params 2
    // Checksum 0x71ec5da1, Offset: 0x4db0
    // Size: 0x164, Type: dev
    function tag_sound( tag, tagnum )
    {
        if ( !isdefined( level.animsound_tagged ) )
        {
            return;
        }
        
        if ( !isdefined( level.animsound_tagged.animsounds[ tagnum ] ) )
        {
            return;
        }
        
        animsound = level.animsound_tagged.animsounds[ tagnum ];
        soundalias = get_alias_from_stored( animsound );
        
        if ( !isdefined( soundalias ) || is_from_animsound( animsound.animname, animsound.anime, animsound.notetrack ) )
        {
            level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "<dev string:x452>" ] = tag;
            level.animsound_aliases[ animsound.animname ][ animsound.anime ][ animsound.notetrack ][ "<dev string:x45d>" ] = 1;
            debug_animsoundsave();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x591a8f25, Offset: 0x4f20
    // Size: 0x10c, Type: dev
    function debug_animsoundsave()
    {
        filename = "<dev string:x5aa>" + level.script + "<dev string:x5b4>";
        file = openfile( filename, "<dev string:x5bf>" );
        
        if ( file == -1 )
        {
            iprintlnbold( "<dev string:x5c5>" + filename + "<dev string:x5d8>" );
            return;
        }
        
        iprintlnbold( "<dev string:x5f9>" + filename );
        print_aliases_to_file( file );
        saved = closefile( file );
        setdvar( "<dev string:x23d>", "<dev string:x66>" );
    }

    // Namespace debug
    // Params 1
    // Checksum 0x43768076, Offset: 0x5038
    // Size: 0x4b4, Type: dev
    function print_aliases_to_file( file )
    {
        tab = "<dev string:x603>";
        fprintln( file, "<dev string:x608>" );
        fprintln( file, "<dev string:x620>" );
        fprintln( file, "<dev string:x627>" );
        fprintln( file, tab + "<dev string:x629>" );
        fprintln( file, tab + "<dev string:x6a8>" );
        fprintln( file, "<dev string:x6c2>" );
        fprintln( file, "<dev string:x66>" );
        fprintln( file, "<dev string:x6c4>" );
        fprintln( file, "<dev string:x627>" );
        fprintln( file, tab + "<dev string:x6d6>" );
        animnames = getarraykeys( level.animsound_aliases );
        
        for ( i = 0; i < animnames.size ; i++ )
        {
            animes = getarraykeys( level.animsound_aliases[ animnames[ i ] ] );
            
            for ( p = 0; p < animes.size ; p++ )
            {
                anime = animes[ p ];
                notetracks = getarraykeys( level.animsound_aliases[ animnames[ i ] ][ anime ] );
                
                for ( z = 0; z < notetracks.size ; z++ )
                {
                    notetrack = notetracks[ z ];
                    
                    if ( !is_from_animsound( animnames[ i ], anime, notetrack ) )
                    {
                        continue;
                    }
                    
                    alias = level.animsound_aliases[ animnames[ i ] ][ anime ][ notetrack ][ "<dev string:x452>" ];
                    
                    if ( notetrack == "<dev string:x472>" + anime )
                    {
                        fprintln( file, tab + "<dev string:x6e8>" + tostr( animnames[ i ] ) + "<dev string:x6ff>" + tostr( anime ) + "<dev string:x6ff>" + tostr( alias ) + "<dev string:x702>" );
                    }
                    else
                    {
                        fprintln( file, tab + "<dev string:x707>" + tostr( animnames[ i ] ) + "<dev string:x6ff>" + tostr( anime ) + "<dev string:x6ff>" + tostr( notetrack ) + "<dev string:x6ff>" + tostr( alias ) + "<dev string:x702>" );
                    }
                    
                    println( "<dev string:x720>" + alias + "<dev string:x731>" + notetrack );
                }
            }
        }
        
        fprintln( file, "<dev string:x6c2>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xba2242b3, Offset: 0x54f8
    // Size: 0x2f4, Type: dev
    function function_2ceda325()
    {
        setdvar( "<dev string:x2cf>", 0 );
        
        if ( !isdefined( level.a_npcdeaths ) || getdvarint( "<dev string:x744>" ) != 1 )
        {
            return;
        }
        
        players = getplayers();
        filename = "<dev string:x75b>" + level.savename + "<dev string:x771>" + players[ 0 ].playername + "<dev string:x773>";
        
        /#
            file = openfile( filename, "<dev string:x778>" );
            
            if ( file == -1 )
            {
                iprintlnbold( "<dev string:x5c5>" + filename + "<dev string:x77f>" );
                return;
            }
            
            if ( isdefined( level.current_skipto ) )
            {
                fprintln( file, "<dev string:x7bd>" + level.current_skipto + "<dev string:x7c7>" );
            }
            else
            {
                fprintln( file, "<dev string:x7e7>" );
            }
            
            if ( level.a_npcdeaths.size <= 0 )
            {
                fprintln( file, "<dev string:x818>" );
            }
            
            foreach ( deadnpctypecount in level.a_npcdeaths )
            {
                fprintln( file, deadnpctypecount.strscoretype + "<dev string:x839>" + deadnpctypecount.icount + "<dev string:x839>" + deadnpctypecount.ikilledbyplayercount + "<dev string:x839>" + deadnpctypecount.ixpvaluesum );
            }
            
            fprintln( file, "<dev string:x66>" );
            iprintlnbold( "<dev string:x83b>" + filename );
            saved = closefile( file );
        #/
        
        level.a_npcdeaths = [];
    }

    // Namespace debug
    // Params 1
    // Checksum 0x94437a62, Offset: 0x57f8
    // Size: 0xc0, Type: dev
    function tostr( str )
    {
        newstr = "<dev string:x853>";
        
        for ( i = 0; i < str.size ; i++ )
        {
            if ( str[ i ] == "<dev string:x853>" )
            {
                newstr += "<dev string:x855>";
                newstr += "<dev string:x853>";
                continue;
            }
            
            newstr += str[ i ];
        }
        
        newstr += "<dev string:x853>";
        return newstr;
    }

    // Namespace debug
    // Params 4
    // Checksum 0x7edd907c, Offset: 0x58c0
    // Size: 0x76, Type: dev
    function drawdebuglineinternal( frompoint, topoint, color, durationframes )
    {
        for ( i = 0; i < durationframes ; i++ )
        {
            line( frompoint, topoint, color );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 4
    // Checksum 0x8c49236a, Offset: 0x5940
    // Size: 0x4c, Type: dev
    function drawdebugline( frompoint, topoint, color, durationframes )
    {
        thread drawdebuglineinternal( frompoint, topoint, color, durationframes );
    }

    // Namespace debug
    // Params 4
    // Checksum 0xdafa6d3a, Offset: 0x5998
    // Size: 0x9e, Type: dev
    function drawdebugenttoentinternal( ent1, ent2, color, durationframes )
    {
        for ( i = 0; i < durationframes ; i++ )
        {
            if ( !isdefined( ent1 ) || !isdefined( ent2 ) )
            {
                return;
            }
            
            line( ent1.origin, ent2.origin, color );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 4
    // Checksum 0x2aaa9b33, Offset: 0x5a40
    // Size: 0x4c, Type: dev
    function drawdebuglineenttoent( ent1, ent2, color, durationframes )
    {
        thread drawdebugenttoentinternal( ent1, ent2, color, durationframes );
    }

    // Namespace debug
    // Params 5
    // Checksum 0x68479a06, Offset: 0x5a98
    // Size: 0xc2, Type: dev
    function new_hud( hud_name, msg, x, y, scale )
    {
        if ( !isdefined( level.hud_array ) )
        {
            level.hud_array = [];
        }
        
        if ( !isdefined( level.hud_array[ hud_name ] ) )
        {
            level.hud_array[ hud_name ] = [];
        }
        
        hud = debug_menu::set_hudelem( msg, x, y, scale );
        level.hud_array[ hud_name ][ level.hud_array[ hud_name ].size ] = hud;
        return hud;
    }

    // Namespace debug
    // Params 0
    // Checksum 0x4d031f93, Offset: 0x5b68
    // Size: 0x534, Type: dev
    function debug_show_viewpos()
    {
        hud_title = newdebughudelem();
        hud_title.x = 10;
        hud_title.y = 300;
        hud_title.alpha = 0;
        hud_title.alignx = "<dev string:x474>";
        hud_title.fontscale = 1.2;
        hud_title settext( &"<dev string:x857>" );
        x_pos = hud_title.x + 50;
        hud_x = newdebughudelem();
        hud_x.x = x_pos;
        hud_x.y = 300;
        hud_x.alpha = 0;
        hud_x.alignx = "<dev string:x474>";
        hud_x.fontscale = 1.2;
        hud_x setvalue( 0 );
        hud_y = newdebughudelem();
        hud_y.x = 10;
        hud_y.y = 300;
        hud_y.alpha = 0;
        hud_y.alignx = "<dev string:x474>";
        hud_y.fontscale = 1.2;
        hud_y setvalue( 0 );
        hud_z = newdebughudelem();
        hud_z.x = 10;
        hud_z.y = 300;
        hud_z.alpha = 0;
        hud_z.alignx = "<dev string:x474>";
        hud_z.fontscale = 1.2;
        hud_z setvalue( 0 );
        setdvar( "<dev string:x866>", "<dev string:x261>" );
        players = getplayers();
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x866>" ) > 0 )
            {
                hud_title.alpha = 1;
                hud_x.alpha = 1;
                hud_y.alpha = 1;
                hud_z.alpha = 1;
                x = players[ 0 ].origin[ 0 ];
                y = players[ 0 ].origin[ 1 ];
                z = players[ 0 ].origin[ 2 ];
                spacing1 = ( 2 + number_before_decimal( x ) ) * 8 + 10;
                spacing2 = ( 2 + number_before_decimal( y ) ) * 8 + 10;
                hud_y.x = x_pos + spacing1;
                hud_z.x = x_pos + spacing1 + spacing2;
                hud_x setvalue( round_to( x, 100 ) );
                hud_y setvalue( round_to( y, 100 ) );
                hud_z setvalue( round_to( z, 100 ) );
            }
            else
            {
                hud_title.alpha = 0;
                hud_x.alpha = 0;
                hud_y.alpha = 0;
                hud_z.alpha = 0;
            }
            
            wait 0.5;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x83971edf, Offset: 0x60a8
    // Size: 0x82, Type: dev
    function number_before_decimal( num )
    {
        abs_num = abs( num );
        count = 0;
        
        while ( true )
        {
            abs_num *= 0.1;
            count += 1;
            
            if ( abs_num < 1 )
            {
                return count;
            }
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x30a54370, Offset: 0x6138
    // Size: 0x3a, Type: dev
    function round_to( val, num )
    {
        return int( val * num ) / num;
    }

    // Namespace debug
    // Params 2
    // Checksum 0xa31bdebb, Offset: 0x6180
    // Size: 0x320, Type: dev
    function set_event_printname_thread( text, focus )
    {
        level notify( #"stop_event_name_thread" );
        level endon( #"stop_event_name_thread" );
        
        if ( getdvarint( "<dev string:x879>" ) > 0 )
        {
            return;
        }
        
        if ( !isdefined( focus ) )
        {
            focus = 0;
        }
        
        suffix = "<dev string:x66>";
        
        if ( focus )
        {
            suffix = "<dev string:x886>";
        }
        
        setdvar( "<dev string:x895>", text );
        text = "<dev string:x8a1>" + text + suffix;
        
        if ( !isdefined( level.event_hudelem ) )
        {
            hud = newhudelem();
            hud.horzalign = "<dev string:x8a9>";
            hud.alignx = "<dev string:x8a9>";
            hud.aligny = "<dev string:x8b0>";
            hud.foreground = 1;
            hud.fontscale = 1.5;
            hud.sort = 50;
            hud.alpha = 1;
            hud.y = 15;
            level.event_hudelem = hud;
        }
        
        if ( focus )
        {
            level.event_hudelem.color = ( 1, 1, 0 );
        }
        else
        {
            level.event_hudelem.color = ( 1, 1, 1 );
        }
        
        if ( getdvarstring( "<dev string:x8b4>" ) == "<dev string:x66>" )
        {
            setdvar( "<dev string:x8b4>", "<dev string:x302>" );
        }
        
        level.event_hudelem settext( text );
        enabled = 1;
        
        while ( true )
        {
            toggle = 0;
            
            if ( getdvarint( "<dev string:x8b4>" ) < 1 )
            {
                toggle = 1;
                enabled = 0;
            }
            else if ( getdvarint( "<dev string:x8b4>" ) > 0 )
            {
                toggle = 1;
                enabled = 1;
            }
            
            if ( toggle && enabled )
            {
                level.event_hudelem.alpha = 1;
            }
            else if ( toggle )
            {
                level.event_hudelem.alpha = 0;
            }
            
            wait 0.5;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xe60d16c2, Offset: 0x64a8
    // Size: 0x16, Type: dev
    function get_playerone()
    {
        return level.players[ 0 ];
    }

    // Namespace debug
    // Params 0
    // Checksum 0xe9b3d32d, Offset: 0x64c8
    // Size: 0x130, Type: dev
    function engagement_distance_debug_toggle()
    {
        level endon( #"kill_engage_dist_debug_toggle_watcher" );
        laststate = getdvarint( "<dev string:x8c5>" );
        
        while ( true )
        {
            currentstate = getdvarint( "<dev string:x8c5>" );
            
            if ( dvar_turned_on( currentstate ) && !dvar_turned_on( laststate ) )
            {
                weapon_engage_dists_init();
                thread debug_realtime_engage_dist();
                thread debug_ai_engage_dist();
                laststate = currentstate;
            }
            else if ( !dvar_turned_on( currentstate ) && dvar_turned_on( laststate ) )
            {
                level notify( #"kill_all_engage_dist_debug" );
                laststate = currentstate;
            }
            
            wait 0.3;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x8df10036, Offset: 0x6600
    // Size: 0x2a, Type: dev
    function dvar_turned_on( val )
    {
        if ( val <= 0 )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace debug
    // Params 1
    // Checksum 0xd87d2c89, Offset: 0x6638
    // Size: 0x34c, Type: dev
    function engagement_distance_debug_init( player )
    {
        level.realtimeengagedist = newclienthudelem( player );
        level.realtimeengagedist.alignx = "<dev string:x474>";
        level.realtimeengagedist.fontscale = 1.5;
        level.realtimeengagedist.x = -50;
        level.realtimeengagedist.y = 250;
        level.realtimeengagedist.color = ( 1, 1, 1 );
        level.realtimeengagedist settext( "<dev string:x8d8>" );
        xpos = 157;
        level.realtimeengagedist_value = newclienthudelem( player );
        level.realtimeengagedist_value.alignx = "<dev string:x474>";
        level.realtimeengagedist_value.fontscale = 1.5;
        level.realtimeengagedist_value.x = xpos;
        level.realtimeengagedist_value.y = 250;
        level.realtimeengagedist_value.color = ( 1, 1, 1 );
        level.realtimeengagedist_value setvalue( 0 );
        xpos += 37;
        level.realtimeengagedist_middle = newclienthudelem( player );
        level.realtimeengagedist_middle.alignx = "<dev string:x474>";
        level.realtimeengagedist_middle.fontscale = 1.5;
        level.realtimeengagedist_middle.x = xpos;
        level.realtimeengagedist_middle.y = 250;
        level.realtimeengagedist_middle.color = ( 1, 1, 1 );
        level.realtimeengagedist_middle settext( "<dev string:x8f6>" );
        xpos += 105;
        level.realtimeengagedist_offvalue = newclienthudelem( player );
        level.realtimeengagedist_offvalue.alignx = "<dev string:x474>";
        level.realtimeengagedist_offvalue.fontscale = 1.5;
        level.realtimeengagedist_offvalue.x = xpos;
        level.realtimeengagedist_offvalue.y = 250;
        level.realtimeengagedist_offvalue.color = ( 1, 1, 1 );
        level.realtimeengagedist_offvalue setvalue( 0 );
        hudobjarray = [];
        hudobjarray[ 0 ] = level.realtimeengagedist;
        hudobjarray[ 1 ] = level.realtimeengagedist_value;
        hudobjarray[ 2 ] = level.realtimeengagedist_middle;
        hudobjarray[ 3 ] = level.realtimeengagedist_offvalue;
        return hudobjarray;
    }

    // Namespace debug
    // Params 2
    // Checksum 0x64ce37d8, Offset: 0x6990
    // Size: 0x66, Type: dev
    function engage_dist_debug_hud_destroy( hudarray, killnotify )
    {
        level waittill( killnotify );
        
        for ( i = 0; i < hudarray.size ; i++ )
        {
            hudarray[ i ] destroy();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x1532f400, Offset: 0x6a00
    // Size: 0x35c, Type: dev
    function weapon_engage_dists_init()
    {
        level.engagedists = [];
        genericpistol = spawnstruct();
        genericpistol.engagedistmin = 125;
        genericpistol.engagedistoptimal = 400;
        genericpistol.engagedistmulligan = 100;
        genericpistol.engagedistmax = 600;
        shotty = spawnstruct();
        shotty.engagedistmin = 0;
        shotty.engagedistoptimal = 300;
        shotty.engagedistmulligan = 100;
        shotty.engagedistmax = 600;
        genericsmg = spawnstruct();
        genericsmg.engagedistmin = 100;
        genericsmg.engagedistoptimal = 500;
        genericsmg.engagedistmulligan = 150;
        genericsmg.engagedistmax = 1000;
        genericriflesa = spawnstruct();
        genericriflesa.engagedistmin = 325;
        genericriflesa.engagedistoptimal = 800;
        genericriflesa.engagedistmulligan = 300;
        genericriflesa.engagedistmax = 1600;
        generichmg = spawnstruct();
        generichmg.engagedistmin = 500;
        generichmg.engagedistoptimal = 700;
        generichmg.engagedistmulligan = 300;
        generichmg.engagedistmax = 1400;
        genericsniper = spawnstruct();
        genericsniper.engagedistmin = 950;
        genericsniper.engagedistoptimal = 2000;
        genericsniper.engagedistmulligan = 500;
        genericsniper.engagedistmax = 3000;
        engage_dists_add( "<dev string:x90d>", genericpistol );
        engage_dists_add( "<dev string:x914>", genericsmg );
        engage_dists_add( "<dev string:x918>", shotty );
        engage_dists_add( "<dev string:x91f>", generichmg );
        engage_dists_add( "<dev string:x922>", genericriflesa );
        level thread engage_dists_watcher();
    }

    // Namespace debug
    // Params 2
    // Checksum 0x7b928b11, Offset: 0x6d68
    // Size: 0x2a, Type: dev
    function engage_dists_add( weaponname, values )
    {
        level.engagedists[ weaponname ] = values;
    }

    // Namespace debug
    // Params 1
    // Checksum 0x56c43de2, Offset: 0x6da0
    // Size: 0x3a, Type: dev
    function get_engage_dists( weapon )
    {
        if ( isdefined( level.engagedists[ weapon ] ) )
        {
            return level.engagedists[ weapon ];
        }
        
        return undefined;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xeb02a8ad, Offset: 0x6de8
    // Size: 0x124, Type: dev
    function engage_dists_watcher()
    {
        level endon( #"kill_all_engage_dist_debug" );
        level endon( #"kill_engage_dists_watcher" );
        
        while ( true )
        {
            player = get_playerone();
            playerweapon = player getcurrentweapon();
            
            if ( !isdefined( player.lastweapon ) )
            {
                player.lastweapon = playerweapon;
            }
            else if ( player.lastweapon == playerweapon )
            {
                wait 0.05;
                continue;
            }
            
            values = get_engage_dists( playerweapon.weapclass );
            
            if ( isdefined( values ) )
            {
                level.weaponengagedistvalues = values;
            }
            else
            {
                level.weaponengagedistvalues = undefined;
            }
            
            player.lastweapon = playerweapon;
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x9d0f0847, Offset: 0x6f18
    // Size: 0x450, Type: dev
    function debug_realtime_engage_dist()
    {
        level endon( #"kill_all_engage_dist_debug" );
        level endon( #"kill_realtime_engagement_distance_debug" );
        player = get_playerone();
        hudobjarray = engagement_distance_debug_init( player );
        level thread engage_dist_debug_hud_destroy( hudobjarray, "<dev string:x928>" );
        level.debugrtengagedistcolor = ( 0, 1, 0 );
        
        while ( true )
        {
            lasttracepos = ( 0, 0, 0 );
            direction = player getplayerangles();
            direction_vec = anglestoforward( direction );
            eye = player geteye();
            trace = bullettrace( eye, eye + vectorscale( direction_vec, 10000 ), 1, player );
            tracepoint = trace[ "<dev string:x304>" ];
            tracenormal = trace[ "<dev string:x943>" ];
            tracedist = int( distance( eye, tracepoint ) );
            
            if ( tracepoint != lasttracepos )
            {
                lasttracepos = tracepoint;
                
                if ( !isdefined( level.weaponengagedistvalues ) )
                {
                    hudobj_changecolor( hudobjarray, ( 1, 1, 1 ) );
                    hudobjarray engagedist_hud_changetext( "<dev string:x94a>", tracedist );
                }
                else
                {
                    engagedistmin = level.weaponengagedistvalues.engagedistmin;
                    engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
                    engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
                    engagedistmax = level.weaponengagedistvalues.engagedistmax;
                    
                    if ( tracedist >= engagedistmin && tracedist <= engagedistmax )
                    {
                        if ( tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan )
                        {
                            hudobjarray engagedist_hud_changetext( "<dev string:x951>", tracedist );
                            hudobj_changecolor( hudobjarray, ( 0, 1, 0 ) );
                        }
                        else
                        {
                            hudobjarray engagedist_hud_changetext( "<dev string:x959>", tracedist );
                            hudobj_changecolor( hudobjarray, ( 1, 1, 0 ) );
                        }
                    }
                    else if ( tracedist < engagedistmin )
                    {
                        hudobj_changecolor( hudobjarray, ( 1, 0, 0 ) );
                        hudobjarray engagedist_hud_changetext( "<dev string:x95c>", tracedist );
                    }
                    else if ( tracedist > engagedistmax )
                    {
                        hudobj_changecolor( hudobjarray, ( 1, 0, 0 ) );
                        hudobjarray engagedist_hud_changetext( "<dev string:x962>", tracedist );
                    }
                }
            }
            
            thread plot_circle_fortime( 1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal );
            thread plot_circle_fortime( 1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x2b95fe36, Offset: 0x7370
    // Size: 0x92, Type: dev
    function hudobj_changecolor( hudobjarray, newcolor )
    {
        for ( i = 0; i < hudobjarray.size ; i++ )
        {
            hudobj = hudobjarray[ i ];
            
            if ( hudobj.color != newcolor )
            {
                hudobj.color = newcolor;
                level.debugrtengagedistcolor = newcolor;
            }
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0xe1b5e4e9, Offset: 0x7410
    // Size: 0x2ec, Type: dev
    function engagedist_hud_changetext( engagedisttype, units )
    {
        if ( !isdefined( level.lastdisttype ) )
        {
            level.lastdisttype = "<dev string:x480>";
        }
        
        if ( engagedisttype == "<dev string:x951>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x967>" );
            self[ 3 ].alpha = 0;
        }
        else if ( engagedisttype == "<dev string:x959>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x977>" );
            self[ 3 ].alpha = 0;
        }
        else if ( engagedisttype == "<dev string:x95c>" )
        {
            amountunder = level.weaponengagedistvalues.engagedistmin - units;
            self[ 1 ] setvalue( units );
            self[ 3 ] setvalue( amountunder );
            self[ 3 ].alpha = 1;
            
            if ( level.lastdisttype != engagedisttype )
            {
                self[ 2 ] settext( "<dev string:x982>" );
            }
        }
        else if ( engagedisttype == "<dev string:x962>" )
        {
            amountover = units - level.weaponengagedistvalues.engagedistmax;
            self[ 1 ] setvalue( units );
            self[ 3 ] setvalue( amountover );
            self[ 3 ].alpha = 1;
            
            if ( level.lastdisttype != engagedisttype )
            {
                self[ 2 ] settext( "<dev string:x993>" );
            }
        }
        else if ( engagedisttype == "<dev string:x94a>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x9a3>" );
            self[ 3 ].alpha = 0;
        }
        
        level.lastdisttype = engagedisttype;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xefd0ce04, Offset: 0x7708
    // Size: 0x374, Type: dev
    function debug_ai_engage_dist()
    {
        level endon( #"kill_all_engage_dist_debug" );
        level endon( #"kill_ai_engagement_distance_debug" );
        player = get_playerone();
        
        while ( true )
        {
            axis = getaiteamarray( "<dev string:x35>" );
            
            if ( isdefined( axis ) && axis.size > 0 )
            {
                playereye = player geteye();
                
                for ( i = 0; i < axis.size ; i++ )
                {
                    ai = axis[ i ];
                    aieye = ai geteye();
                    
                    if ( sighttracepassed( playereye, aieye, 0, player ) && !isvehicle( ai ) )
                    {
                        dist = distance( playereye, aieye );
                        drawcolor = ( 1, 1, 1 );
                        drawstring = "<dev string:x771>";
                        engagedistmin = ai.engagemindist;
                        engagedistfalloffmin = ai.engageminfalloffdist;
                        engagedistfalloffmax = ai.engagemaxfalloffdist;
                        engagedistmax = ai.engagemaxdist;
                        
                        if ( dist >= engagedistmin && dist <= engagedistmax )
                        {
                            drawcolor = ( 0, 1, 0 );
                            drawstring = "<dev string:x9c6>";
                        }
                        else if ( dist < engagedistmin && dist >= engagedistfalloffmin )
                        {
                            drawcolor = ( 1, 1, 0 );
                            drawstring = "<dev string:x9cb>";
                        }
                        else if ( dist > engagedistmax && dist <= engagedistfalloffmax )
                        {
                            drawcolor = ( 1, 1, 0 );
                            drawstring = "<dev string:x9d9>";
                        }
                        else if ( dist > engagedistfalloffmax )
                        {
                            drawcolor = ( 1, 0, 0 );
                            drawstring = "<dev string:x9e5>";
                        }
                        else if ( dist < engagedistfalloffmin )
                        {
                            drawcolor = ( 1, 0, 0 );
                            drawstring = "<dev string:x9ed>";
                        }
                        
                        scale = dist / 1000;
                        print3d( ai.origin + ( 0, 0, 67 ), drawstring + "<dev string:x30d>" + dist, drawcolor, 1, scale );
                    }
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x46dae5d1, Offset: 0x7a88
    // Size: 0xb0, Type: dev
    function bot_count()
    {
        count = 0;
        
        foreach ( player in level.players )
        {
            if ( player istestclient() )
            {
                count++;
            }
        }
        
        return count;
    }

    // Namespace debug
    // Params 0
    // Checksum 0x1f218dc0, Offset: 0x7b40
    // Size: 0xb0, Type: dev
    function function_6a200458()
    {
        count = 0;
        
        foreach ( player in level.players )
        {
            if ( !player istestclient() )
            {
                count++;
            }
        }
        
        return count;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xd85d2e23, Offset: 0x7bf8
    // Size: 0x29a, Type: dev
    function debug_coop_bot_test()
    {
        adddebugcommand( "<dev string:x9f7>" );
        
        while ( !isdefined( level.players ) )
        {
            wait 0.5;
        }
        
        var_d49b0ff = 0;
        
        while ( true )
        {
            if ( getdvarint( "<dev string:xa7b>" ) > 0 )
            {
                while ( getdvarint( "<dev string:xa7b>" ) > 0 )
                {
                    var_7e4baf07 = 4 - function_6a200458();
                    botcount = bot_count();
                    
                    if ( botcount > 0 && randomint( 100 ) > 60 )
                    {
                        util::add_queued_debug_command( "<dev string:xa94>" );
                        wait 2;
                        debugmsg( "<dev string:xaaa>" + bot_count() );
                    }
                    else if ( botcount < var_7e4baf07 )
                    {
                        if ( botcount < getdvarint( "<dev string:xa7b>" ) && randomint( 100 ) > 50 )
                        {
                            var_d49b0ff = 1;
                            util::add_queued_debug_command( "<dev string:xac4>" );
                            wait 2;
                            debugmsg( "<dev string:xad7>" + bot_count() );
                        }
                    }
                    
                    wait randomintrange( 1, 3 );
                }
            }
            else if ( var_d49b0ff )
            {
                while ( bot_count() > 0 )
                {
                    util::add_queued_debug_command( "<dev string:xa94>" );
                    wait 2;
                    debugmsg( "<dev string:xaaa>" + bot_count() );
                }
                
                var_d49b0ff = 0;
            }
            
            wait 1;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x10ec1113, Offset: 0x7ea0
    // Size: 0x6c, Type: dev
    function debugmsg( str_txt )
    {
        /#
            iprintlnbold( str_txt );
            
            if ( isdefined( level.name ) )
            {
                println( "<dev string:xaee>" + level.name + "<dev string:xaf0>" + str_txt );
            }
        #/
    }

    // Namespace debug
    // Params 6
    // Checksum 0x9e05ff1f, Offset: 0x7f18
    // Size: 0x184, Type: dev
    function plot_circle_fortime( radius1, radius2, time, color, origin, normal )
    {
        if ( !isdefined( color ) )
        {
            color = ( 0, 1, 0 );
        }
        
        circleres = 6;
        circleinc = 360 / circleres;
        circleres++;
        plotpoints = [];
        rad = 0;
        radius = radius2;
        angletoplayer = vectortoangles( normal );
        
        for ( i = 0; i < circleres ; i++ )
        {
            plotpoints[ plotpoints.size ] = origin + vectorscale( anglestoforward( angletoplayer + ( rad, 90, 0 ) ), radius );
            rad += circleinc;
        }
        
        plot_points( plotpoints, color[ 0 ], color[ 1 ], color[ 2 ], time );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x5849e1f1, Offset: 0x80a8
    // Size: 0xac, Type: dev
    function dynamic_ai_spawner()
    {
        if ( !isdefined( level.debug_dynamic_ai_spawner ) )
        {
            dynamic_ai_spawner_find_spawners();
            level.debug_dynamic_ai_spawner = 1;
        }
        
        getplayers()[ 0 ] thread spawn_guy_placement();
        level waittill( #"hash_d123a0a5" );
        
        if ( isdefined( level.dynamic_spawn_hud ) )
        {
            level.dynamic_spawn_hud destroy();
        }
        
        if ( isdefined( level.dynamic_spawn_dummy_model ) )
        {
            level.dynamic_spawn_dummy_model delete();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x6710431c, Offset: 0x8160
    // Size: 0x1d8, Type: dev
    function dynamic_ai_spawner_find_spawners()
    {
        spawners = getspawnerarray();
        level.aitypes = [];
        level.aitype_index = 0;
        var_7b3173a8 = [];
        
        foreach ( spawner in spawners )
        {
            if ( !isdefined( var_7b3173a8[ spawner.classname ] ) )
            {
                var_7b3173a8[ spawner.classname ] = 1;
                struct = spawnstruct();
                classname = spawner.classname;
                vehicletype = spawner.vehicletype;
                
                if ( issubstr( classname, "<dev string:xaf3>" ) )
                {
                    struct.radius = 64;
                    struct.isvehicle = 0;
                    classname = getsubstr( classname, 6 );
                }
                else
                {
                    continue;
                }
                
                struct.classname = classname;
                level.aitypes[ level.aitypes.size ] = struct;
            }
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x91ae4d9f, Offset: 0x8340
    // Size: 0x640, Type: dev
    function spawn_guy_placement()
    {
        level endon( #"hash_d123a0a5" );
        assert( isdefined( level.aitypes ) && level.aitypes.size > 0, "<dev string:xafa>" );
        level.dynamic_spawn_hud = newclienthudelem( getplayers()[ 0 ] );
        level.dynamic_spawn_hud.alignx = "<dev string:x474>";
        level.dynamic_spawn_hud.x = 0;
        level.dynamic_spawn_hud.y = 245;
        level.dynamic_spawn_hud.fontscale = 1.5;
        level.dynamic_spawn_hud settext( "<dev string:xb14>" );
        level.dynamic_spawn_dummy_model = spawn( "<dev string:xb28>", ( 0, 0, 0 ) );
        wait 0.1;
        
        while ( true )
        {
            direction = self getplayerangles();
            direction_vec = anglestoforward( direction );
            eye = self geteye();
            trace_dist = 4000;
            trace = bullettrace( eye, eye + vectorscale( direction_vec, trace_dist ), 0, level.dynamic_spawn_dummy_model );
            dist = distance( eye, trace[ "<dev string:x304>" ] );
            position = eye + vectorscale( direction_vec, dist - level.aitypes[ level.aitype_index ].radius );
            origin = position;
            angles = self.angles + ( 0, 180, 0 );
            level.dynamic_spawn_dummy_model.origin = position;
            level.dynamic_spawn_dummy_model.angles = angles;
            level.dynamic_spawn_hud settext( "<dev string:xb35>" + level.aitype_index + "<dev string:xb4a>" + level.aitypes.size + "<dev string:xb4c>" + level.aitypes[ level.aitype_index ].classname );
            level.dynamic_spawn_dummy_model detachall();
            level.dynamic_spawn_dummy_model setmodel( level.aitypes[ level.aitype_index ].classname );
            level.dynamic_spawn_dummy_model show();
            level.dynamic_spawn_dummy_model notsolid();
            
            if ( self usebuttonpressed() )
            {
                level.dynamic_spawn_dummy_model hide();
                
                if ( level.aitypes[ level.aitype_index ].isvehicle )
                {
                    spawn = spawnvehicle( level.aitypes[ level.aitype_index ].classname, origin, angles, "<dev string:xb50>" );
                }
                else
                {
                    spawn = spawnactor( level.aitypes[ level.aitype_index ].classname, origin, angles, "<dev string:xb50>", 1 );
                }
                
                spawn.ignoreme = getdvarstring( "<dev string:xb61>" ) == "<dev string:x302>";
                spawn.ignoreall = getdvarstring( "<dev string:xb7b>" ) == "<dev string:x302>";
                spawn.pacifist = getdvarstring( "<dev string:xb96>" ) == "<dev string:x302>";
                spawn.fixednode = 0;
                wait 0.3;
            }
            else if ( self buttonpressed( "<dev string:xbb0>" ) )
            {
                level.dynamic_spawn_dummy_model hide();
                level.aitype_index++;
                
                if ( level.aitype_index >= level.aitypes.size )
                {
                    level.aitype_index = 0;
                }
                
                wait 0.3;
            }
            else if ( self buttonpressed( "<dev string:xbbb>" ) )
            {
                level.dynamic_spawn_dummy_model hide();
                level.aitype_index--;
                
                if ( level.aitype_index < 0 )
                {
                    level.aitype_index = level.aitypes.size - 1;
                }
                
                wait 0.3;
            }
            else if ( self buttonpressed( "<dev string:xbc5>" ) )
            {
                setdvar( "<dev string:x27e>", "<dev string:x261>" );
            }
            
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x535e3db2, Offset: 0x8988
    // Size: 0x3c, Type: dev
    function display_module_text()
    {
        wait 1;
        iprintlnbold( "<dev string:xbce>" + level.script + "<dev string:xbe4>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x6af5bfd4, Offset: 0x89d0
    // Size: 0x23e, Type: dev
    function debug_goalradius()
    {
        guys = getaiarray();
        
        for ( i = 0; i < guys.size ; i++ )
        {
            if ( guys[ i ].team == "<dev string:x35>" )
            {
                print3d( guys[ i ].origin + ( 0, 0, 70 ), isdefined( guys[ i ].goalradius ) ? "<dev string:x66>" + guys[ i ].goalradius : "<dev string:x66>", ( 1, 0, 0 ), 1, 1, 1 );
                record3dtext( "<dev string:x66>" + guys[ i ].goalradius, guys[ i ].origin + ( 0, 0, 70 ), ( 1, 0, 0 ), "<dev string:xc04>" );
                continue;
            }
            
            print3d( guys[ i ].origin + ( 0, 0, 70 ), isdefined( guys[ i ].goalradius ) ? "<dev string:x66>" + guys[ i ].goalradius : "<dev string:x66>", ( 0, 1, 0 ), 1, 1, 1 );
            record3dtext( "<dev string:x66>" + guys[ i ].goalradius, guys[ i ].origin + ( 0, 0, 70 ), ( 0, 1, 0 ), "<dev string:xc04>" );
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x54771798, Offset: 0x8c18
    // Size: 0x13c, Type: dev
    function debug_maxvisibledist()
    {
        guys = getaiarray();
        
        for ( i = 0; i < guys.size ; i++ )
        {
            recordenttext( isdefined( guys[ i ].maxvisibledist ) ? "<dev string:x66>" + guys[ i ].maxvisibledist : "<dev string:x66>", guys[ i ], level.debugteamcolors[ guys[ i ].team ], "<dev string:xc04>" );
        }
        
        recordenttext( isdefined( level.player.maxvisibledist ) ? "<dev string:x66>" + level.player.maxvisibledist : "<dev string:x66>", level.player, level.debugteamcolors[ "<dev string:x3a>" ], "<dev string:xc04>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x7ca263fb, Offset: 0x8d60
    // Size: 0x334, Type: dev
    function debug_health()
    {
        v_print_pos = ( 0, 0, 0 );
        guys = getaiarray();
        
        for ( i = 0; i < guys.size ; i++ )
        {
            if ( isdefined( guys[ i ] gettagorigin( "<dev string:xc0f>" ) ) )
            {
                v_print_pos = guys[ i ] gettagorigin( "<dev string:xc0f>" ) + ( 0, 0, 15 );
            }
            else
            {
                v_print_pos = guys[ i ] getorigin() + ( 0, 0, 70 );
            }
            
            print3d( v_print_pos, isdefined( guys[ i ].health ) ? "<dev string:x66>" + guys[ i ].health : "<dev string:x66>", level.debugteamcolors[ guys[ i ].team ], 1, 0.5 );
            recordenttext( isdefined( guys[ i ].health ) ? "<dev string:x66>" + guys[ i ].health : "<dev string:x66>", guys[ i ], level.debugteamcolors[ guys[ i ].team ], "<dev string:xc04>" );
        }
        
        vehicles = getvehiclearray();
        
        for ( i = 0; i < vehicles.size ; i++ )
        {
            recordenttext( isdefined( vehicles[ i ].health ) ? "<dev string:x66>" + vehicles[ i ].health : "<dev string:x66>", vehicles[ i ], level.debugteamcolors[ vehicles[ i ].team ], "<dev string:xc04>" );
        }
        
        if ( isdefined( level.player ) )
        {
            recordenttext( isdefined( level.player.health ) ? "<dev string:x66>" + level.player.health : "<dev string:x66>", level.player, level.debugteamcolors[ "<dev string:x3a>" ], "<dev string:xc04>" );
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x883f4570, Offset: 0x90a0
    // Size: 0x10e, Type: dev
    function debug_engagedist()
    {
        guys = getaiarray();
        
        for ( i = 0; i < guys.size ; i++ )
        {
            diststring = guys[ i ].engageminfalloffdist + "<dev string:xc17>" + guys[ i ].engagemindist + "<dev string:xc17>" + guys[ i ].engagemaxdist + "<dev string:xc17>" + guys[ i ].engagemaxfalloffdist;
            recordenttext( diststring, guys[ i ], level.debugteamcolors[ guys[ i ].team ], "<dev string:xc04>" );
        }
    }

    // Namespace debug
    // Params 5
    // Checksum 0x28ee4120, Offset: 0x91b8
    // Size: 0xcc, Type: dev
    function debug_sphere( origin, radius, color, alpha, time )
    {
        if ( !isdefined( time ) )
        {
            time = 1000;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        sides = int( 10 * ( 1 + int( radius ) % 100 ) );
        sphere( origin, radius, color, alpha, 1, sides, time );
    }

    // Namespace debug
    // Params 4
    // Checksum 0x51464e28, Offset: 0x9290
    // Size: 0x2b4, Type: dev
    function draw_arrow_time( start, end, color, frames )
    {
        level endon( #"newpath" );
        pts = [];
        angles = vectortoangles( start - end );
        right = anglestoright( angles );
        forward = anglestoforward( angles );
        up = anglestoup( angles );
        dist = distance( start, end );
        arrow = [];
        arrow[ 0 ] = start;
        arrow[ 1 ] = start + vectorscale( right, dist * 0.1 ) + vectorscale( forward, dist * -0.1 );
        arrow[ 2 ] = end;
        arrow[ 3 ] = start + vectorscale( right, dist * -1 * 0.1 ) + vectorscale( forward, dist * -0.1 );
        arrow[ 4 ] = start;
        arrow[ 5 ] = start + vectorscale( up, dist * 0.1 ) + vectorscale( forward, dist * -0.1 );
        arrow[ 6 ] = end;
        arrow[ 7 ] = start + vectorscale( up, dist * -1 * 0.1 ) + vectorscale( forward, dist * -0.1 );
        arrow[ 8 ] = start;
        r = color[ 0 ];
        g = color[ 1 ];
        b = color[ 2 ];
        plot_points( arrow, r, g, b, frames );
    }

    // Namespace debug
    // Params 3
    // Checksum 0x3d3ea8eb, Offset: 0x9550
    // Size: 0x1fe, Type: dev
    function draw_arrow( start, end, color )
    {
        level endon( #"newpath" );
        pts = [];
        angles = vectortoangles( start - end );
        right = anglestoright( angles );
        forward = anglestoforward( angles );
        dist = distance( start, end );
        arrow = [];
        arrow[ 0 ] = start;
        arrow[ 1 ] = start + vectorscale( right, dist * 0.05 ) + vectorscale( forward, dist * -0.2 );
        arrow[ 2 ] = end;
        arrow[ 3 ] = start + vectorscale( right, dist * -1 * 0.05 ) + vectorscale( forward, dist * -0.2 );
        
        for ( p = 0; p < 4 ; p++ )
        {
            nextpoint = p + 1;
            
            if ( nextpoint >= 4 )
            {
                nextpoint = 0;
            }
            
            line( arrow[ p ], arrow[ nextpoint ], color, 1 );
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xefd0d5c4, Offset: 0x9758
    // Size: 0x1d0, Type: dev
    function debugorigin()
    {
        self notify( #"hash_707e044" );
        self endon( #"hash_707e044" );
        self endon( #"death" );
        
        for ( ;; )
        {
            forward = anglestoforward( self.angles );
            forwardfar = vectorscale( forward, 30 );
            forwardclose = vectorscale( forward, 20 );
            right = anglestoright( self.angles );
            left = vectorscale( right, -10 );
            right = vectorscale( right, 10 );
            line( self.origin, self.origin + forwardfar, ( 0.9, 0.7, 0.6 ), 0.9 );
            line( self.origin + forwardfar, self.origin + forwardclose + right, ( 0.9, 0.7, 0.6 ), 0.9 );
            line( self.origin + forwardfar, self.origin + forwardclose + left, ( 0.9, 0.7, 0.6 ), 0.9 );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 5
    // Checksum 0x7d643086, Offset: 0x9930
    // Size: 0x106, Type: dev
    function plot_points( plotpoints, r, g, b, timer )
    {
        lastpoint = plotpoints[ 0 ];
        
        if ( !isdefined( r ) )
        {
            r = 1;
        }
        
        if ( !isdefined( g ) )
        {
            g = 1;
        }
        
        if ( !isdefined( b ) )
        {
            b = 1;
        }
        
        if ( !isdefined( timer ) )
        {
            timer = 0.05;
        }
        
        for ( i = 1; i < plotpoints.size ; i++ )
        {
            thread draw_line_for_time( lastpoint, plotpoints[ i ], r, g, b, timer );
            lastpoint = plotpoints[ i ];
        }
    }

    // Namespace debug
    // Params 6
    // Checksum 0x3ed2c25b, Offset: 0x9a40
    // Size: 0xb8, Type: dev
    function draw_line_for_time( org1, org2, r, g, b, timer )
    {
        timer = gettime() + timer * 1000;
        
        while ( gettime() < timer )
        {
            line( org1, org2, ( r, g, b ), 1 );
            recordline( org1, org2, ( 1, 1, 1 ), "<dev string:xc1b>" );
            wait 0.05;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xd41d2234, Offset: 0x9b00
    // Size: 0x11e, Type: dev
    function _get_debug_color( str_color )
    {
        switch ( str_color )
        {
            case "<dev string:xc22>":
                return ( 1, 0, 0 );
            case "<dev string:xc26>":
                return ( 0, 1, 0 );
            case "<dev string:xc2c>":
                return ( 0, 0, 1 );
            case "<dev string:xc31>":
                return ( 1, 1, 0 );
            case "<dev string:xc38>":
                return ( 1, 0.5, 0 );
            case "<dev string:xc3f>":
                return ( 0, 1, 1 );
            case "<dev string:xc44>":
                return ( 1, 1, 1 );
            case "<dev string:xc4a>":
                return ( 0.75, 0.75, 0.75 );
            case "<dev string:xc4f>":
                return ( 0, 0, 0 );
            default:
                println( "<dev string:xc55>" + str_color + "<dev string:xc62>" );
                return ( 0, 0, 0 );
        }
    }

    // Namespace debug
    // Params 8
    // Checksum 0x72b39d49, Offset: 0x9c28
    // Size: 0x79a, Type: dev
    function debug_info_screen( text_array, time, fade_in_bg_time, fade_out_bg_time, fade_in_text_time, fade_out_text_time, font_size, show_black_background )
    {
        if ( !isdefined( time ) )
        {
            time = 3;
        }
        
        if ( !isdefined( fade_in_bg_time ) )
        {
            fade_in_bg_time = 0;
        }
        
        if ( !isdefined( fade_out_bg_time ) )
        {
            fade_out_bg_time = 2;
        }
        
        if ( !isdefined( fade_in_text_time ) )
        {
            fade_in_text_time = 2;
        }
        
        if ( !isdefined( fade_out_text_time ) )
        {
            fade_out_text_time = 2;
        }
        
        if ( !isdefined( font_size ) )
        {
            font_size = 2;
        }
        
        if ( !isdefined( show_black_background ) )
        {
            show_black_background = 1;
        }
        
        if ( show_black_background )
        {
            if ( isplayer( self ) )
            {
                background = hud::createicon( "<dev string:xc4f>", 640, 480 );
            }
            else
            {
                background = hud::createservericon( "<dev string:xc4f>", 640, 480 );
            }
            
            background.horzalign = "<dev string:xca0>";
            background.vertalign = "<dev string:xca0>";
            background.foreground = 1;
            background.sort = 0;
            background.x = 320;
            background.y = 0;
            
            if ( fade_in_bg_time > 0 )
            {
                background.alpha = 0;
                background fadeovertime( fade_in_bg_time );
                background.alpha = 1;
                wait fade_in_bg_time;
            }
            else
            {
                background.alpha = 1;
            }
        }
        
        text_elems = [];
        spacing = int( level.fontheight * font_size ) + 2;
        start_y = 0;
        
        if ( isarray( text_array ) )
        {
            start_y = 0 - text_array.size * spacing / 2;
            
            foreach ( text in text_array )
            {
                if ( isplayer( self ) )
                {
                    text_elems[ text_elems.size ] = hud::createfontstring( "<dev string:xcab>", font_size );
                }
                else
                {
                    text_elems[ text_elems.size ] = hud::createserverfontstring( "<dev string:xcab>", font_size );
                }
                
                text_elems[ text_elems.size - 1 ] settext( text );
            }
        }
        else
        {
            if ( isplayer( self ) )
            {
                text_elems[ text_elems.size ] = hud::createfontstring( "<dev string:xcab>", font_size );
            }
            else
            {
                text_elems[ text_elems.size ] = hud::createserverfontstring( "<dev string:xcab>", font_size );
            }
            
            text_elems[ text_elems.size - 1 ] settext( text );
        }
        
        text_num = 0;
        
        foreach ( text_elem in text_elems )
        {
            text_elem.horzalign = "<dev string:x8a9>";
            text_elem.vertalign = "<dev string:x479>";
            text_elem.x = 0;
            text_elem.y = start_y + spacing * text_num;
            text_elem.color = ( 1, 1, 1 );
            text_elem.foreground = 1;
            text_elem.sort = 1;
            
            if ( fade_in_text_time > 0 )
            {
                text_elem.alpha = 0;
                text_elem fadeovertime( fade_in_text_time );
                text_elem.alpha = 1;
            }
            else
            {
                text_elem.alpha = 1;
            }
            
            text_num++;
        }
        
        if ( fade_in_text_time > 0 )
        {
            wait fade_in_text_time;
        }
        
        wait time;
        
        if ( fade_out_text_time > 0 )
        {
            foreach ( text_elem in text_elems )
            {
                text_elem fadeovertime( fade_out_text_time );
                text_elem.alpha = 0;
            }
            
            wait fade_out_text_time;
        }
        
        if ( show_black_background )
        {
            if ( fade_out_bg_time > 0 )
            {
                background fadeovertime( fade_out_bg_time );
                background.alpha = 0;
                wait fade_out_bg_time;
            }
            
            background destroy();
        }
        
        foreach ( text_elem in text_elems )
        {
            text_elem destroy();
        }
    }

#/
