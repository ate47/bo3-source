#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/gametypes/_globallogic;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_utils;

#namespace dev;

/#

    // Namespace dev
    // Params 0, eflags: 0x2
    // Checksum 0xac029f3c, Offset: 0x228
    // Size: 0x3c, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, "<dev string:x2c>" );
    }

    // Namespace dev
    // Params 0
    // Checksum 0xb8beaf42, Offset: 0x270
    // Size: 0x2c, Type: dev
    function __init__()
    {
        callback::on_start_gametype( &init );
    }

    // Namespace dev
    // Params 0
    // Checksum 0x8da1e1de, Offset: 0x2a8
    // Size: 0x400, Type: dev
    function init()
    {
        if ( getdvarstring( "<dev string:x37>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:x37>", "<dev string:x47>" );
        }
        
        if ( getdvarstring( "<dev string:x49>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:x49>", "<dev string:x47>" );
        }
        
        if ( getdvarstring( "<dev string:x5d>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:x5d>", "<dev string:x47>" );
        }
        
        if ( getdvarstring( "<dev string:x77>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:x77>", "<dev string:x47>" );
        }
        
        if ( getdvarstring( "<dev string:x95>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:x95>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:xa8>" ) == "<dev string:x46>" )
        {
            setdvar( "<dev string:xa8>", "<dev string:x47>" );
        }
        
        thread testscriptruntimeerror();
        thread testdvars();
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        thread globallogic_score::setplayermomentumdebug();
        setdvar( "<dev string:xc3>", "<dev string:x46>" );
        setdvar( "<dev string:xd0>", "<dev string:x46>" );
        setdvar( "<dev string:xdf>", "<dev string:x47>" );
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar( "<dev string:xf1>", "<dev string:x47>" );
        level.dem_spawns = [];
        
        if ( level.gametype == "<dev string:x10b>" )
        {
            extra_spawns = [];
            extra_spawns[ 0 ] = "<dev string:x10f>";
            extra_spawns[ 1 ] = "<dev string:x127>";
            extra_spawns[ 2 ] = "<dev string:x13f>";
            extra_spawns[ 3 ] = "<dev string:x157>";
            
            for ( i = 0; i < extra_spawns.size ; i++ )
            {
                points = getentarray( extra_spawns[ i ], "<dev string:x16f>" );
                
                if ( isdefined( points ) && points.size > 0 )
                {
                    level.dem_spawns = arraycombine( level.dem_spawns, points, 1, 0 );
                }
            }
        }
        
        callback::on_connect( &on_player_connect );
        
        for ( ;; )
        {
            updatedevsettings();
            wait 0.5;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x278095a5, Offset: 0x6b0
    // Size: 0x8, Type: dev
    function on_player_connect()
    {
        
    }

    // Namespace dev
    // Params 1
    // Checksum 0x73878099, Offset: 0x6c0
    // Size: 0x54, Type: dev
    function warpalltohost( team )
    {
        host = util::gethostplayer();
        warpalltoplayer( team, host.name );
    }

    // Namespace dev
    // Params 2
    // Checksum 0xac4b34d4, Offset: 0x720
    // Size: 0x374, Type: dev
    function warpalltoplayer( team, player )
    {
        players = getplayers();
        target = undefined;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ].name == player )
            {
                target = players[ i ];
                break;
            }
        }
        
        if ( isdefined( target ) )
        {
            origin = target.origin;
            nodes = getnodesinradius( origin, 128, 32, 128, "<dev string:x179>" );
            angles = target getplayerangles();
            yaw = ( 0, angles[ 1 ], 0 );
            forward = anglestoforward( yaw );
            spawn_origin = origin + forward * 128 + ( 0, 0, 16 );
            
            if ( !bullettracepassed( target geteye(), spawn_origin, 0, target ) )
            {
                spawn_origin = undefined;
            }
            
            for ( i = 0; i < players.size ; i++ )
            {
                if ( players[ i ] == target )
                {
                    continue;
                }
                
                if ( isdefined( team ) )
                {
                    if ( strstartswith( team, "<dev string:x17e>" ) && target.team == players[ i ].team )
                    {
                        continue;
                    }
                    
                    if ( strstartswith( team, "<dev string:x187>" ) && target.team != players[ i ].team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( spawn_origin ) )
                {
                    players[ i ] setorigin( spawn_origin );
                    continue;
                }
                
                if ( nodes.size > 0 )
                {
                    node = array::random( nodes );
                    players[ i ] setorigin( node.origin );
                    continue;
                }
                
                players[ i ] setorigin( origin );
            }
        }
        
        setdvar( "<dev string:x193>", "<dev string:x46>" );
    }

    // Namespace dev
    // Params 0
    // Checksum 0xc3aee491, Offset: 0xaa0
    // Size: 0x454, Type: dev
    function updatedevsettingszm()
    {
        if ( level.players.size > 0 )
        {
            if ( getdvarstring( "<dev string:x1a2>" ) == "<dev string:x1b7>" )
            {
                if ( !isdefined( level.streamdumpteamindex ) )
                {
                    level.streamdumpteamindex = 0;
                }
                else
                {
                    level.streamdumpteamindex++;
                }
                
                numpoints = 0;
                spawnpoints = [];
                location = level.scr_zm_map_start_location;
                
                if ( ( location == "<dev string:x1b9>" || location == "<dev string:x46>" ) && isdefined( level.default_start_location ) )
                {
                    location = level.default_start_location;
                }
                
                match_string = level.scr_zm_ui_gametype + "<dev string:x1c1>" + location;
                
                if ( level.streamdumpteamindex < level.teams.size )
                {
                    structs = struct::get_array( "<dev string:x1c3>", "<dev string:x1d1>" );
                    
                    if ( isdefined( structs ) )
                    {
                        foreach ( struct in structs )
                        {
                            if ( isdefined( struct.script_string ) )
                            {
                                tokens = strtok( struct.script_string, "<dev string:x1e3>" );
                                
                                foreach ( token in tokens )
                                {
                                    if ( token == match_string )
                                    {
                                        spawnpoints[ spawnpoints.size ] = struct;
                                    }
                                }
                            }
                        }
                    }
                    
                    if ( !isdefined( spawnpoints ) || spawnpoints.size == 0 )
                    {
                        spawnpoints = struct::get_array( "<dev string:x1e5>", "<dev string:x1fa>" );
                    }
                    
                    if ( isdefined( spawnpoints ) )
                    {
                        numpoints = spawnpoints.size;
                    }
                }
                
                if ( numpoints == 0 )
                {
                    setdvar( "<dev string:x1a2>", "<dev string:x47>" );
                    level.streamdumpteamindex = -1;
                    return;
                }
                
                averageorigin = ( 0, 0, 0 );
                averageangles = ( 0, 0, 0 );
                
                foreach ( spawnpoint in spawnpoints )
                {
                    averageorigin += spawnpoint.origin / numpoints;
                    averageangles += spawnpoint.angles / numpoints;
                }
                
                level.players[ 0 ] setplayerangles( averageangles );
                level.players[ 0 ] setorigin( averageorigin );
                wait 0.05;
                setdvar( "<dev string:x1a2>", "<dev string:x205>" );
            }
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xf469b382, Offset: 0xf00
    // Size: 0x1dc6, Type: dev
    function updatedevsettings()
    {
        show_spawns = getdvarint( "<dev string:x37>" );
        show_start_spawns = getdvarint( "<dev string:x49>" );
        player = util::gethostplayer();
        
        if ( show_spawns >= 1 )
        {
            show_spawns = 1;
        }
        else
        {
            show_spawns = 0;
        }
        
        if ( show_start_spawns >= 1 )
        {
            show_start_spawns = 1;
        }
        else
        {
            show_start_spawns = 0;
        }
        
        if ( !isdefined( level.show_spawns ) || level.show_spawns != show_spawns )
        {
            level.show_spawns = show_spawns;
            setdvar( "<dev string:x37>", level.show_spawns );
            
            if ( level.show_spawns )
            {
                showspawnpoints();
            }
            else
            {
                hidespawnpoints();
            }
        }
        
        if ( !isdefined( level.show_start_spawns ) || level.show_start_spawns != show_start_spawns )
        {
            level.show_start_spawns = show_start_spawns;
            setdvar( "<dev string:x49>", level.show_start_spawns );
            
            if ( level.show_start_spawns )
            {
                showstartspawnpoints();
            }
            else
            {
                hidestartspawnpoints();
            }
        }
        
        updateminimapsetting();
        
        if ( level.players.size > 0 )
        {
            if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x207>" )
            {
                warpalltohost();
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x20c>" )
            {
                warpalltohost( getdvarstring( "<dev string:x193>" ) );
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x219>" )
            {
                warpalltohost( getdvarstring( "<dev string:x193>" ) );
            }
            else if ( strstartswith( getdvarstring( "<dev string:x193>" ), "<dev string:x17e>" ) )
            {
                name = getsubstr( getdvarstring( "<dev string:x193>" ), 8 );
                warpalltoplayer( getdvarstring( "<dev string:x193>" ), name );
            }
            else if ( strstartswith( getdvarstring( "<dev string:x193>" ), "<dev string:x187>" ) )
            {
                name = getsubstr( getdvarstring( "<dev string:x193>" ), 11 );
                warpalltoplayer( getdvarstring( "<dev string:x193>" ), name );
            }
            else if ( strstartswith( getdvarstring( "<dev string:x193>" ), "<dev string:x229>" ) )
            {
                name = getsubstr( getdvarstring( "<dev string:x193>" ), 4 );
                warpalltoplayer( undefined, name );
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x22e>" )
            {
                players = getplayers();
                setdvar( "<dev string:x193>", "<dev string:x46>" );
                
                if ( !isdefined( level.devgui_start_spawn_index ) )
                {
                    level.devgui_start_spawn_index = 0;
                }
                
                player = util::gethostplayer();
                spawns = level.spawn_start[ player.pers[ "<dev string:x23f>" ] ];
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_start_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_start_spawn_index ].angles );
                }
                
                level.devgui_start_spawn_index++;
                
                if ( level.devgui_start_spawn_index >= spawns.size )
                {
                    level.devgui_start_spawn_index = 0;
                }
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x244>" )
            {
                players = getplayers();
                setdvar( "<dev string:x193>", "<dev string:x46>" );
                
                if ( !isdefined( level.devgui_start_spawn_index ) )
                {
                    level.devgui_start_spawn_index = 0;
                }
                
                player = util::gethostplayer();
                spawns = level.spawn_start[ player.pers[ "<dev string:x23f>" ] ];
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_start_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_start_spawn_index ].angles );
                }
                
                level.devgui_start_spawn_index--;
                
                if ( level.devgui_start_spawn_index < 0 )
                {
                    level.devgui_start_spawn_index = spawns.size - 1;
                }
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x255>" )
            {
                players = getplayers();
                setdvar( "<dev string:x193>", "<dev string:x46>" );
                
                if ( !isdefined( level.devgui_spawn_index ) )
                {
                    level.devgui_spawn_index = 0;
                }
                
                spawns = level.spawnpoints;
                spawns = arraycombine( spawns, level.dem_spawns, 1, 0 );
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_spawn_index ].angles );
                }
                
                level.devgui_spawn_index++;
                
                if ( level.devgui_spawn_index >= spawns.size )
                {
                    level.devgui_spawn_index = 0;
                }
            }
            else if ( getdvarstring( "<dev string:x193>" ) == "<dev string:x260>" )
            {
                players = getplayers();
                setdvar( "<dev string:x193>", "<dev string:x46>" );
                
                if ( !isdefined( level.devgui_spawn_index ) )
                {
                    level.devgui_spawn_index = 0;
                }
                
                spawns = level.spawnpoints;
                spawns = arraycombine( spawns, level.dem_spawns, 1, 0 );
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_spawn_index ].angles );
                }
                
                level.devgui_spawn_index--;
                
                if ( level.devgui_spawn_index < 0 )
                {
                    level.devgui_spawn_index = spawns.size - 1;
                }
            }
            else if ( getdvarstring( "<dev string:x26b>" ) != "<dev string:x46>" )
            {
                player = util::gethostplayer();
                
                if ( !isdefined( player.devgui_spawn_active ) )
                {
                    player.devgui_spawn_active = 0;
                }
                
                if ( !player.devgui_spawn_active )
                {
                    iprintln( "<dev string:x27c>" );
                    iprintln( "<dev string:x29f>" );
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                }
                else
                {
                    player notify( #"devgui_spawn_think" );
                    player.devgui_spawn_active = 0;
                    player setactionslot( 3, "<dev string:x2bf>" );
                }
                
                setdvar( "<dev string:x26b>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x2c7>" ) != "<dev string:x46>" )
            {
                players = getplayers();
                
                if ( !isdefined( level.devgui_unlimited_ammo ) )
                {
                    level.devgui_unlimited_ammo = 1;
                }
                else
                {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                
                if ( level.devgui_unlimited_ammo )
                {
                    iprintln( "<dev string:x2d7>" );
                }
                else
                {
                    iprintln( "<dev string:x2fc>" );
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    if ( level.devgui_unlimited_ammo )
                    {
                        players[ i ] thread devgui_unlimited_ammo();
                        continue;
                    }
                    
                    players[ i ] notify( #"devgui_unlimited_ammo" );
                }
                
                setdvar( "<dev string:x2c7>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x324>" ) != "<dev string:x46>" )
            {
                if ( !isdefined( level.devgui_unlimited_momentum ) )
                {
                    level.devgui_unlimited_momentum = 1;
                }
                else
                {
                    level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                }
                
                if ( level.devgui_unlimited_momentum )
                {
                    iprintln( "<dev string:x338>" );
                    level thread devgui_unlimited_momentum();
                }
                else
                {
                    iprintln( "<dev string:x361>" );
                    level notify( #"devgui_unlimited_momentum" );
                }
                
                setdvar( "<dev string:x324>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x38d>" ) != "<dev string:x46>" )
            {
                level thread devgui_increase_momentum( getdvarint( "<dev string:x38d>" ) );
                setdvar( "<dev string:x38d>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x3a3>" ) != "<dev string:x46>" )
            {
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    player = players[ i ];
                    weapons = player getweaponslist();
                    arrayremovevalue( weapons, level.weaponbasemelee );
                    
                    for ( j = 0; j < weapons.size ; j++ )
                    {
                        if ( weapons[ j ] == level.weaponnone )
                        {
                            continue;
                        }
                        
                        player setweaponammostock( weapons[ j ], 0 );
                        player setweaponammoclip( weapons[ j ], 0 );
                    }
                }
                
                setdvar( "<dev string:x3a3>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x3b8>" ) != "<dev string:x46>" )
            {
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    player = players[ i ];
                    
                    if ( getdvarstring( "<dev string:x3b8>" ) == "<dev string:x47>" )
                    {
                        player setempjammed( 0 );
                        continue;
                    }
                    
                    player setempjammed( 1 );
                }
                
                setdvar( "<dev string:x3b8>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x3c7>" ) != "<dev string:x46>" )
            {
                if ( !level.timerstopped )
                {
                    iprintln( "<dev string:x3d7>" );
                    globallogic_utils::pausetimer();
                }
                else
                {
                    iprintln( "<dev string:x3eb>" );
                    globallogic_utils::resumetimer();
                }
                
                setdvar( "<dev string:x3c7>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x400>" ) != "<dev string:x46>" )
            {
                level globallogic::forceend();
                setdvar( "<dev string:x400>", "<dev string:x46>" );
            }
            else if ( getdvarstring( "<dev string:x95>" ) != "<dev string:x46>" )
            {
                if ( !isdefined( level.devgui_show_hq ) )
                {
                    level.devgui_show_hq = 0;
                }
                
                if ( level.gametype == "<dev string:x40e>" && isdefined( level.radios ) )
                {
                    if ( !level.devgui_show_hq )
                    {
                        for ( i = 0; i < level.radios.size ; i++ )
                        {
                            color = ( 1, 0, 0 );
                            level showonespawnpoint( level.radios[ i ], color, "<dev string:x413>", 32, "<dev string:x422>" );
                        }
                    }
                    else
                    {
                        level notify( #"hide_hq_points" );
                    }
                    
                    level.devgui_show_hq = !level.devgui_show_hq;
                }
                
                setdvar( "<dev string:x95>", "<dev string:x46>" );
            }
            
            if ( getdvarstring( "<dev string:x1a2>" ) == "<dev string:x1b7>" )
            {
                if ( !isdefined( level.streamdumpteamindex ) )
                {
                    level.streamdumpteamindex = 0;
                }
                else
                {
                    level.streamdumpteamindex++;
                }
                
                numpoints = 0;
                
                if ( level.streamdumpteamindex < level.teams.size )
                {
                    teamname = getarraykeys( level.teams )[ level.streamdumpteamindex ];
                    
                    if ( isdefined( level.spawn_start[ teamname ] ) )
                    {
                        numpoints = level.spawn_start[ teamname ].size;
                    }
                }
                
                if ( numpoints == 0 )
                {
                    setdvar( "<dev string:x1a2>", "<dev string:x47>" );
                    level.streamdumpteamindex = -1;
                }
                else
                {
                    averageorigin = ( 0, 0, 0 );
                    averageangles = ( 0, 0, 0 );
                    
                    foreach ( spawnpoint in level.spawn_start[ teamname ] )
                    {
                        averageorigin += spawnpoint.origin / numpoints;
                        averageangles += spawnpoint.angles / numpoints;
                    }
                    
                    level.players[ 0 ] setplayerangles( averageangles );
                    level.players[ 0 ] setorigin( averageorigin );
                    wait 0.05;
                    setdvar( "<dev string:x1a2>", "<dev string:x205>" );
                }
            }
        }
        
        if ( getdvarstring( "<dev string:xc3>" ) == "<dev string:x47>" )
        {
            players = getplayers();
            iprintln( "<dev string:x42b>" );
            
            for ( i = 0; i < players.size ; i++ )
            {
                players[ i ] clearperks();
            }
            
            setdvar( "<dev string:xc3>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:xc3>" ) != "<dev string:x46>" )
        {
            perk = getdvarstring( "<dev string:xc3>" );
            specialties = strtok( perk, "<dev string:x44d>" );
            players = getplayers();
            iprintln( "<dev string:x44f>" + perk + "<dev string:x46a>" );
            
            for ( i = 0; i < players.size ; i++ )
            {
                for ( j = 0; j < specialties.size ; j++ )
                {
                    players[ i ] setperk( specialties[ j ] );
                    players[ i ].extraperks[ specialties[ j ] ] = 1;
                }
            }
            
            setdvar( "<dev string:xc3>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:xd0>" ) != "<dev string:x46>" )
        {
            event = getdvarstring( "<dev string:xd0>" );
            player = util::gethostplayer();
            forward = anglestoforward( player.angles );
            right = anglestoright( player.angles );
            
            if ( event == "<dev string:x46c>" )
            {
                player dodamage( 1, player.origin + forward );
            }
            else if ( event == "<dev string:x476>" )
            {
                player dodamage( 1, player.origin - forward );
            }
            else if ( event == "<dev string:x47f>" )
            {
                player dodamage( 1, player.origin - right );
            }
            else if ( event == "<dev string:x488>" )
            {
                player dodamage( 1, player.origin + right );
            }
            
            setdvar( "<dev string:xd0>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:x492>" ) != "<dev string:x46>" )
        {
            perk = getdvarstring( "<dev string:x492>" );
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] unsetperk( perk );
                level.players[ i ].extraperks[ perk ] = undefined;
            }
            
            setdvar( "<dev string:x492>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:x49f>" ) != "<dev string:x46>" )
        {
            nametokens = strtok( getdvarstring( "<dev string:x49f>" ), "<dev string:x1e3>" );
            
            if ( nametokens.size > 1 )
            {
                thread xkillsy( nametokens[ 0 ], nametokens[ 1 ] );
            }
            
            setdvar( "<dev string:x49f>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:x4ad>" ) != "<dev string:x46>" )
        {
        }
        
        if ( getdvarstring( "<dev string:x4bb>" ) != "<dev string:x46>" )
        {
        }
        
        if ( getdvarstring( "<dev string:x4c6>" ) != "<dev string:x46>" )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] hud_message::oldnotifymessage( getdvarstring( "<dev string:x4c6>" ), getdvarstring( "<dev string:x4c6>" ), game[ "<dev string:x4d4>" ][ "<dev string:x4da>" ] );
            }
            
            announcement( getdvarstring( "<dev string:x4c6>" ), 0 );
            setdvar( "<dev string:x4c6>", "<dev string:x46>" );
        }
        
        if ( getdvarstring( "<dev string:x4e1>" ) != "<dev string:x46>" )
        {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            
            for ( index = 0; index < ents.size ; index++ )
            {
                classname = ents[ index ].classname;
                
                if ( !issubstr( classname, "<dev string:x4ee>" ) )
                {
                    curent = ents[ index ];
                    level.entarray[ level.entarray.size ] = curent;
                    
                    if ( !isdefined( level.entcounts[ classname ] ) )
                    {
                        level.entcounts[ classname ] = 0;
                    }
                    
                    level.entcounts[ classname ]++;
                    
                    if ( !isdefined( level.entgroups[ classname ] ) )
                    {
                        level.entgroups[ classname ] = [];
                    }
                    
                    level.entgroups[ classname ][ level.entgroups[ classname ].size ] = curent;
                }
            }
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x7fef9bc0, Offset: 0x2cd0
    // Size: 0x18c, Type: dev
    function devgui_spawn_think()
    {
        self notify( #"devgui_spawn_think" );
        self endon( #"devgui_spawn_think" );
        self endon( #"disconnect" );
        dpad_left = 0;
        dpad_right = 0;
        
        for ( ;; )
        {
            self setactionslot( 3, "<dev string:x46>" );
            self setactionslot( 4, "<dev string:x46>" );
            
            if ( !dpad_left && self buttonpressed( "<dev string:x4f5>" ) )
            {
                setdvar( "<dev string:x193>", "<dev string:x260>" );
                dpad_left = 1;
            }
            else if ( !self buttonpressed( "<dev string:x4f5>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !dpad_right && self buttonpressed( "<dev string:x4ff>" ) )
            {
                setdvar( "<dev string:x193>", "<dev string:x255>" );
                dpad_right = 1;
            }
            else if ( !self buttonpressed( "<dev string:x4ff>" ) )
            {
                dpad_right = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xb80672c5, Offset: 0x2e68
    // Size: 0x14a, Type: dev
    function devgui_unlimited_ammo()
    {
        self notify( #"devgui_unlimited_ammo" );
        self endon( #"devgui_unlimited_ammo" );
        self endon( #"disconnect" );
        
        for ( ;; )
        {
            wait 1;
            primary_weapons = self getweaponslistprimaries();
            offhand_weapons_and_alts = array::exclude( self getweaponslist( 1 ), primary_weapons );
            weapons = arraycombine( primary_weapons, offhand_weapons_and_alts, 0, 0 );
            arrayremovevalue( weapons, level.weaponbasemelee );
            
            for ( i = 0; i < weapons.size ; i++ )
            {
                weapon = weapons[ i ];
                
                if ( weapon == level.weaponnone )
                {
                    continue;
                }
                
                self givemaxammo( weapon );
            }
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xc615b559, Offset: 0x2fc0
    // Size: 0x11e, Type: dev
    function devgui_unlimited_momentum()
    {
        level notify( #"devgui_unlimited_momentum" );
        level endon( #"devgui_unlimited_momentum" );
        
        for ( ;; )
        {
            wait 1;
            players = getplayers();
            
            foreach ( player in players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                if ( player.sessionstate != "<dev string:x50a>" )
                {
                    continue;
                }
                
                globallogic_score::_setplayermomentum( player, 5000 );
            }
        }
    }

    // Namespace dev
    // Params 1
    // Checksum 0x5de7df38, Offset: 0x30e8
    // Size: 0x112, Type: dev
    function devgui_increase_momentum( score )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate != "<dev string:x50a>" )
            {
                continue;
            }
            
            player globallogic_score::giveplayermomentumnotification( score, &"<dev string:x512>", "<dev string:x528>", 0 );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xf72ffc35, Offset: 0x3208
    // Size: 0x318, Type: dev
    function devgui_health_debug()
    {
        self notify( #"devgui_health_debug" );
        self endon( #"devgui_health_debug" );
        self endon( #"disconnect" );
        x = 80;
        y = 40;
        self.debug_health_bar = newclienthudelem( self );
        self.debug_health_bar.x = x + 80;
        self.debug_health_bar.y = y + 2;
        self.debug_health_bar.alignx = "<dev string:x535>";
        self.debug_health_bar.aligny = "<dev string:x53a>";
        self.debug_health_bar.horzalign = "<dev string:x53e>";
        self.debug_health_bar.vertalign = "<dev string:x53e>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader( "<dev string:x549>", 1, 8 );
        self.debug_health_text = newclienthudelem( self );
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<dev string:x535>";
        self.debug_health_text.aligny = "<dev string:x53a>";
        self.debug_health_text.horzalign = "<dev string:x53e>";
        self.debug_health_text.vertalign = "<dev string:x53e>";
        self.debug_health_text.alpha = 1;
        self.debug_health_text.fontscale = 1;
        self.debug_health_text.foreground = 1;
        
        if ( !isdefined( self.maxhealth ) || self.maxhealth <= 0 )
        {
            self.maxhealth = 100;
        }
        
        for ( ;; )
        {
            wait 0.05;
            width = self.health / self.maxhealth * 300;
            width = int( max( width, 1 ) );
            self.debug_health_bar setshader( "<dev string:x549>", width, 8 );
            self.debug_health_text setvalue( self.health );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x676a75fe, Offset: 0x3528
    // Size: 0xc6, Type: dev
    function giveextraperks()
    {
        if ( !isdefined( self.extraperks ) )
        {
            return;
        }
        
        perks = getarraykeys( self.extraperks );
        
        for ( i = 0; i < perks.size ; i++ )
        {
            println( "<dev string:x54f>" + self.name + "<dev string:x55a>" + perks[ i ] + "<dev string:x565>" );
            self setperk( perks[ i ] );
        }
    }

    // Namespace dev
    // Params 2
    // Checksum 0x6cc04f7a, Offset: 0x35f8
    // Size: 0x144, Type: dev
    function xkillsy( attackername, victimname )
    {
        attacker = undefined;
        victim = undefined;
        
        for ( index = 0; index < level.players.size ; index++ )
        {
            if ( level.players[ index ].name == attackername )
            {
                attacker = level.players[ index ];
                continue;
            }
            
            if ( level.players[ index ].name == victimname )
            {
                victim = level.players[ index ];
            }
        }
        
        if ( !isalive( attacker ) || !isalive( victim ) )
        {
            return;
        }
        
        victim thread [[ level.callbackplayerdamage ]]( attacker, attacker, 1000, 0, "<dev string:x573>", level.weaponnone, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x584>", 0, 0 );
    }

    // Namespace dev
    // Params 0
    // Checksum 0xb5a5361c, Offset: 0x3748
    // Size: 0x24, Type: dev
    function testscriptruntimeerrorassert()
    {
        wait 1;
        assert( 0 );
    }

    // Namespace dev
    // Params 0
    // Checksum 0x6c7aa9b3, Offset: 0x3778
    // Size: 0x44, Type: dev
    function testscriptruntimeerror2()
    {
        myundefined = "<dev string:x589>";
        
        if ( myundefined == 1 )
        {
            println( "<dev string:x58e>" );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xaf449b5, Offset: 0x37c8
    // Size: 0x1c, Type: dev
    function testscriptruntimeerror1()
    {
        testscriptruntimeerror2();
    }

    // Namespace dev
    // Params 0
    // Checksum 0x1dab855b, Offset: 0x37f0
    // Size: 0xcc, Type: dev
    function testscriptruntimeerror()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:xa8>" ) != "<dev string:x47>" )
            {
                break;
            }
            
            wait 1;
        }
        
        myerror = getdvarstring( "<dev string:xa8>" );
        setdvar( "<dev string:xa8>", "<dev string:x47>" );
        
        if ( myerror == "<dev string:x5b4>" )
        {
            testscriptruntimeerrorassert();
        }
        else
        {
            testscriptruntimeerror1();
        }
        
        thread testscriptruntimeerror();
    }

    // Namespace dev
    // Params 0
    // Checksum 0xd2497c9a, Offset: 0x38c8
    // Size: 0xf4, Type: dev
    function testdvars()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x5bb>" ) != "<dev string:x46>" )
            {
                break;
            }
            
            wait 1;
        }
        
        tokens = strtok( getdvarstring( "<dev string:x5bb>" ), "<dev string:x1e3>" );
        dvarname = tokens[ 0 ];
        dvarvalue = tokens[ 1 ];
        setdvar( dvarname, dvarvalue );
        setdvar( "<dev string:x5bb>", "<dev string:x46>" );
        thread testdvars();
    }

    // Namespace dev
    // Params 5
    // Checksum 0xf9836abd, Offset: 0x39c8
    // Size: 0x58e, Type: dev
    function showonespawnpoint( spawn_point, color, notification, height, print )
    {
        if ( !isdefined( height ) || height <= 0 )
        {
            height = util::get_player_height();
        }
        
        if ( !isdefined( print ) )
        {
            print = spawn_point.classname;
        }
        
        center = spawn_point.origin;
        forward = anglestoforward( spawn_point.angles );
        right = anglestoright( spawn_point.angles );
        forward = vectorscale( forward, 16 );
        right = vectorscale( right, 16 );
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( b, c, color, 0, notification );
        thread lineuntilnotified( c, d, color, 0, notification );
        thread lineuntilnotified( d, a, color, 0, notification );
        thread lineuntilnotified( a, a + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( b, b + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( c, c + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( d, d + ( 0, 0, height ), color, 0, notification );
        a += ( 0, 0, height );
        b += ( 0, 0, height );
        c += ( 0, 0, height );
        d += ( 0, 0, height );
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( b, c, color, 0, notification );
        thread lineuntilnotified( c, d, color, 0, notification );
        thread lineuntilnotified( d, a, color, 0, notification );
        center += ( 0, 0, height / 2 );
        arrow_forward = anglestoforward( spawn_point.angles );
        arrowhead_forward = anglestoforward( spawn_point.angles );
        arrowhead_right = anglestoright( spawn_point.angles );
        arrow_forward = vectorscale( arrow_forward, 32 );
        arrowhead_forward = vectorscale( arrowhead_forward, 24 );
        arrowhead_right = vectorscale( arrowhead_right, 8 );
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread lineuntilnotified( center, a, color, 0, notification );
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( a, c, color, 0, notification );
        thread print3duntilnotified( spawn_point.origin + ( 0, 0, height ), print, color, 1, 1, notification );
        return;
    }

    // Namespace dev
    // Params 0
    // Checksum 0xa1f683b7, Offset: 0x3f60
    // Size: 0xe8, Type: dev
    function showspawnpoints()
    {
        if ( isdefined( level.spawnpoints ) )
        {
            color = ( 1, 1, 1 );
            
            for ( spawn_point_index = 0; spawn_point_index < level.spawnpoints.size ; spawn_point_index++ )
            {
                showonespawnpoint( level.spawnpoints[ spawn_point_index ], color, "<dev string:x5c8>" );
            }
        }
        
        for ( i = 0; i < level.dem_spawns.size ; i++ )
        {
            color = ( 0, 1, 0 );
            showonespawnpoint( level.dem_spawns[ i ], color, "<dev string:x5c8>" );
        }
        
        return;
    }

    // Namespace dev
    // Params 0
    // Checksum 0xa335972a, Offset: 0x4050
    // Size: 0x18, Type: dev
    function hidespawnpoints()
    {
        level notify( #"hide_spawnpoints" );
        return;
    }

    // Namespace dev
    // Params 0
    // Checksum 0x565bebb1, Offset: 0x4070
    // Size: 0x222, Type: dev
    function showstartspawnpoints()
    {
        if ( !level.teambased )
        {
            return;
        }
        
        if ( !isdefined( level.spawn_start ) )
        {
            return;
        }
        
        team_colors = [];
        team_colors[ "<dev string:x5d9>" ] = ( 1, 0, 1 );
        team_colors[ "<dev string:x4da>" ] = ( 0, 1, 1 );
        team_colors[ "<dev string:x5de>" ] = ( 1, 1, 0 );
        team_colors[ "<dev string:x5e4>" ] = ( 0, 1, 0 );
        team_colors[ "<dev string:x5ea>" ] = ( 0, 0, 1 );
        team_colors[ "<dev string:x5f0>" ] = ( 1, 0.7, 0 );
        team_colors[ "<dev string:x5f6>" ] = ( 0.25, 0.25, 1 );
        team_colors[ "<dev string:x5fc>" ] = ( 0.88, 0, 1 );
        
        foreach ( team in level.teams )
        {
            color = team_colors[ team ];
            
            foreach ( spawnpoint in level.spawn_start[ team ] )
            {
                showonespawnpoint( spawnpoint, color, "<dev string:x602>" );
            }
        }
        
        return;
    }

    // Namespace dev
    // Params 0
    // Checksum 0x3320c390, Offset: 0x42a0
    // Size: 0x18, Type: dev
    function hidestartspawnpoints()
    {
        level notify( #"hide_startspawnpoints" );
        return;
    }

    // Namespace dev
    // Params 6
    // Checksum 0xbaf713b1, Offset: 0x42c0
    // Size: 0x70, Type: dev
    function print3duntilnotified( origin, text, color, alpha, scale, notification )
    {
        level endon( notification );
        
        for ( ;; )
        {
            print3d( origin, text, color, alpha, scale );
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 5
    // Checksum 0x5e25762e, Offset: 0x4338
    // Size: 0x68, Type: dev
    function lineuntilnotified( start, end, color, depthtest, notification )
    {
        level endon( notification );
        
        for ( ;; )
        {
            line( start, end, color, depthtest );
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 1
    // Checksum 0x7c627ada, Offset: 0x43a8
    // Size: 0x2a, Type: dev
    function dvar_turned_on( val )
    {
        if ( val <= 0 )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace dev
    // Params 5
    // Checksum 0x966535a, Offset: 0x43e0
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
        
        hud = set_hudelem( msg, x, y, scale );
        level.hud_array[ hud_name ][ level.hud_array[ hud_name ].size ] = hud;
        return hud;
    }

    // Namespace dev
    // Params 7
    // Checksum 0x16ddc577, Offset: 0x44b0
    // Size: 0x1a2, Type: dev
    function set_hudelem( text, x, y, scale, alpha, sort, debug_hudelem )
    {
        /#
            if ( !isdefined( alpha ) )
            {
                alpha = 1;
            }
            
            if ( !isdefined( scale ) )
            {
                scale = 1;
            }
            
            if ( !isdefined( sort ) )
            {
                sort = 20;
            }
            
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
            hud.location = 0;
            hud.alignx = "<dev string:x535>";
            hud.aligny = "<dev string:x618>";
            hud.foreground = 1;
            hud.fontscale = scale;
            hud.sort = sort;
            hud.alpha = alpha;
            hud.x = x;
            hud.y = y;
            hud.og_scale = scale;
            
            if ( isdefined( text ) )
            {
                hud settext( text );
            }
            
            return hud;
        #/
    }

    // Namespace dev
    // Params 0
    // Checksum 0xa797b16d, Offset: 0x4660
    // Size: 0x10, Type: dev
    function getattachmentchangemodifierbutton()
    {
        return "<dev string:x61f>";
    }

    // Namespace dev
    // Params 0
    // Checksum 0x48ef0a43, Offset: 0x4678
    // Size: 0x3ac, Type: dev
    function watchattachmentchange()
    {
        self endon( #"disconnect" );
        clientnum = self getentitynumber();
        
        if ( clientnum != 0 )
        {
            return;
        }
        
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        lstick_down = 0;
        dpad_modifier_button = getattachmentchangemodifierbutton();
        
        for ( ;; )
        {
            if ( self buttonpressed( dpad_modifier_button ) )
            {
                if ( !dpad_left && self buttonpressed( "<dev string:x4f5>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x628>" );
                    dpad_left = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_right && self buttonpressed( "<dev string:x4ff>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x62f>" );
                    dpad_right = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_up && self buttonpressed( "<dev string:x637>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x53a>" );
                    dpad_up = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_down && self buttonpressed( "<dev string:x63f>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x649>" );
                    dpad_down = 1;
                    self thread print_weapon_name();
                }
                
                if ( !lstick_down && self buttonpressed( "<dev string:x650>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x65e>" );
                    lstick_down = 1;
                    self thread print_weapon_name();
                }
            }
            
            if ( !self buttonpressed( "<dev string:x4f5>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !self buttonpressed( "<dev string:x4ff>" ) )
            {
                dpad_right = 0;
            }
            
            if ( !self buttonpressed( "<dev string:x637>" ) )
            {
                dpad_up = 0;
            }
            
            if ( !self buttonpressed( "<dev string:x63f>" ) )
            {
                dpad_down = 0;
            }
            
            if ( !self buttonpressed( "<dev string:x650>" ) )
            {
                lstick_down = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xfc0a9f7f, Offset: 0x4a30
    // Size: 0x11c, Type: dev
    function print_weapon_name()
    {
        self notify( #"print_weapon_name" );
        self endon( #"print_weapon_name" );
        wait 0.2;
        
        if ( self isswitchingweapons() )
        {
            self waittill( #"weapon_change_complete", weapon );
            fail_safe = 0;
            
            while ( weapon == level.weaponnone )
            {
                self waittill( #"weapon_change_complete", weapon );
                wait 0.05;
                fail_safe++;
                
                if ( fail_safe > 120 )
                {
                    break;
                }
            }
        }
        else
        {
            weapon = self getcurrentweapon();
        }
        
        printweaponname = getdvarint( "<dev string:x666>", 1 );
        
        if ( printweaponname )
        {
            iprintlnbold( weapon.name );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x99911c09, Offset: 0x4b58
    // Size: 0x18a, Type: dev
    function set_equipment_list()
    {
        if ( isdefined( level.dev_equipment ) )
        {
            return;
        }
        
        level.dev_equipment = [];
        level.dev_equipment[ 1 ] = getweapon( "<dev string:x67c>" );
        level.dev_equipment[ 2 ] = getweapon( "<dev string:x68c>" );
        level.dev_equipment[ 3 ] = getweapon( "<dev string:x699>" );
        level.dev_equipment[ 4 ] = getweapon( "<dev string:x6a2>" );
        level.dev_equipment[ 5 ] = getweapon( "<dev string:x6b1>" );
        level.dev_equipment[ 6 ] = getweapon( "<dev string:x6bb>" );
        level.dev_equipment[ 7 ] = getweapon( "<dev string:x6ce>" );
        level.dev_equipment[ 8 ] = getweapon( "<dev string:x6dc>" );
        level.dev_equipment[ 9 ] = getweapon( "<dev string:x6ea>" );
    }

    // Namespace dev
    // Params 0
    // Checksum 0xe61b4e5d, Offset: 0x4cf0
    // Size: 0x1b2, Type: dev
    function set_grenade_list()
    {
        if ( isdefined( level.dev_grenade ) )
        {
            return;
        }
        
        level.dev_grenade = [];
        level.dev_grenade[ 1 ] = getweapon( "<dev string:x6f3>" );
        level.dev_grenade[ 2 ] = getweapon( "<dev string:x700>" );
        level.dev_grenade[ 3 ] = getweapon( "<dev string:x70f>" );
        level.dev_grenade[ 4 ] = getweapon( "<dev string:x717>" );
        level.dev_grenade[ 5 ] = getweapon( "<dev string:x722>" );
        level.dev_grenade[ 6 ] = getweapon( "<dev string:x734>" );
        level.dev_grenade[ 7 ] = getweapon( "<dev string:x742>" );
        level.dev_grenade[ 8 ] = getweapon( "<dev string:x755>" );
        level.dev_grenade[ 9 ] = getweapon( "<dev string:x761>" );
        level.dev_grenade[ 10 ] = getweapon( "<dev string:x76d>" );
    }

    // Namespace dev
    // Params 1
    // Checksum 0x52574342, Offset: 0x4eb0
    // Size: 0xb6, Type: dev
    function take_all_grenades_and_equipment( player )
    {
        for ( i = 0; i < level.dev_equipment.size ; i++ )
        {
            player takeweapon( level.dev_equipment[ i + 1 ] );
        }
        
        for ( i = 0; i < level.dev_grenade.size ; i++ )
        {
            player takeweapon( level.dev_grenade[ i + 1 ] );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xde08c1bb, Offset: 0x4f70
    // Size: 0x128, Type: dev
    function equipment_dev_gui()
    {
        set_equipment_list();
        set_grenade_list();
        setdvar( "<dev string:x77c>", "<dev string:x46>" );
        
        while ( true )
        {
            wait 0.5;
            devgui_int = getdvarint( "<dev string:x77c>" );
            
            if ( devgui_int != 0 )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    take_all_grenades_and_equipment( level.players[ i ] );
                    level.players[ i ] giveweapon( level.dev_equipment[ devgui_int ] );
                }
                
                setdvar( "<dev string:x77c>", "<dev string:x47>" );
            }
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x1a1db87a, Offset: 0x50a0
    // Size: 0x128, Type: dev
    function grenade_dev_gui()
    {
        set_equipment_list();
        set_grenade_list();
        setdvar( "<dev string:x78f>", "<dev string:x46>" );
        
        while ( true )
        {
            wait 0.5;
            devgui_int = getdvarint( "<dev string:x78f>" );
            
            if ( devgui_int != 0 )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    take_all_grenades_and_equipment( level.players[ i ] );
                    level.players[ i ] giveweapon( level.dev_grenade[ devgui_int ] );
                }
                
                setdvar( "<dev string:x78f>", "<dev string:x47>" );
            }
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0xa0feab5d, Offset: 0x51d0
    // Size: 0x49a, Type: dev
    function devstraferunpathdebugdraw()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        violet = ( 0.4, 0, 0.6 );
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -50 );
        endonmsg = "<dev string:x7a0>";
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x77>" ) > 0 )
            {
                nodes = [];
                end = 0;
                node = getvehiclenode( "<dev string:x7be>", "<dev string:x1fa>" );
                
                if ( !isdefined( node ) )
                {
                    println( "<dev string:x7cc>" );
                    setdvar( "<dev string:x77>", "<dev string:x47>" );
                    continue;
                }
                
                while ( isdefined( node.target ) )
                {
                    new_node = getvehiclenode( node.target, "<dev string:x1fa>" );
                    
                    foreach ( n in nodes )
                    {
                        if ( n == new_node )
                        {
                            end = 1;
                        }
                    }
                    
                    textscale = 30;
                    
                    if ( drawtime == maxdrawtime )
                    {
                        node thread drawpathsegment( new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg );
                    }
                    
                    if ( isdefined( node.script_noteworthy ) )
                    {
                        textscale = 10;
                        
                        switch ( node.script_noteworthy )
                        {
                            case "<dev string:x7e5>":
                                textcolor = green;
                                textalpha = 1;
                                break;
                            default:
                                textcolor = red;
                                textalpha = 1;
                                break;
                            case "<dev string:x7fe>":
                                textcolor = white;
                                textalpha = 1;
                                break;
                        }
                        
                        switch ( node.script_noteworthy )
                        {
                            case "<dev string:x7fe>":
                            case "<dev string:x7e5>":
                            default:
                                sides = 10;
                                radius = 100;
                                
                                if ( drawtime == maxdrawtime )
                                {
                                    sphere( node.origin, radius, textcolor, textalpha, 1, sides, drawtime * 1000 );
                                }
                                
                                node draworiginlines();
                                node drawnoteworthytext( textcolor, textalpha, textscale );
                                break;
                        }
                    }
                    
                    if ( end )
                    {
                        break;
                    }
                    
                    nodes[ nodes.size ] = new_node;
                    node = new_node;
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
                
                wait 0.05;
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x49642bbd, Offset: 0x5678
    // Size: 0x3c0, Type: dev
    function devhelipathdebugdraw()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -50 );
        endonmsg = "<dev string:x80b>";
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x5d>" ) > 0 )
            {
                script_origins = getentarray( "<dev string:x825>", "<dev string:x16f>" );
                
                foreach ( ent in script_origins )
                {
                    if ( isdefined( ent.targetname ) )
                    {
                        switch ( ent.targetname )
                        {
                            default:
                                textcolor = blue;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case "<dev string:x83e>":
                                textcolor = green;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case "<dev string:x84e>":
                                textcolor = red;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case "<dev string:x85f>":
                                textcolor = white;
                                textalpha = 1;
                                textscale = 3;
                                break;
                        }
                        
                        switch ( ent.targetname )
                        {
                            case "<dev string:x84e>":
                            case "<dev string:x85f>":
                            case "<dev string:x83e>":
                            default:
                                if ( drawtime == maxdrawtime )
                                {
                                    ent thread drawpath( textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg );
                                }
                                
                                ent draworiginlines();
                                ent drawtargetnametext( textcolor, textalpha, textscale );
                                ent draworigintext( textcolor, textalpha, textscale, origintextoffset );
                                break;
                        }
                    }
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
            }
            
            if ( getdvarint( "<dev string:x5d>" ) == 0 )
            {
                level notify( endonmsg );
                drawtime = maxdrawtime;
                wait 1;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x2f4ef59e, Offset: 0x5a40
    // Size: 0x114, Type: dev
    function draworiginlines()
    {
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        line( self.origin, self.origin + anglestoforward( self.angles ) * 10, red );
        line( self.origin, self.origin + anglestoright( self.angles ) * 10, green );
        line( self.origin, self.origin + anglestoup( self.angles ) * 10, blue );
    }

    // Namespace dev
    // Params 4
    // Checksum 0x2250e984, Offset: 0x5b60
    // Size: 0x74, Type: dev
    function drawtargetnametext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        print3d( self.origin + textoffset, self.targetname, textcolor, textalpha, textscale );
    }

    // Namespace dev
    // Params 4
    // Checksum 0xe47be90, Offset: 0x5be0
    // Size: 0x74, Type: dev
    function drawnoteworthytext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        print3d( self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale );
    }

    // Namespace dev
    // Params 4
    // Checksum 0x4e1414b4, Offset: 0x5c60
    // Size: 0xc4, Type: dev
    function draworigintext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        originstring = "<dev string:x86a>" + self.origin[ 0 ] + "<dev string:x86c>" + self.origin[ 1 ] + "<dev string:x86c>" + self.origin[ 2 ] + "<dev string:x86f>";
        print3d( self.origin + textoffset, originstring, textcolor, textalpha, textscale );
    }

    // Namespace dev
    // Params 4
    // Checksum 0x6290d8ae, Offset: 0x5d30
    // Size: 0xdc, Type: dev
    function drawspeedacceltext( textcolor, textalpha, textscale, textoffset )
    {
        if ( isdefined( self.script_airspeed ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 2 ), "<dev string:x871>" + self.script_airspeed, textcolor, textalpha, textscale );
        }
        
        if ( isdefined( self.script_accel ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 3 ), "<dev string:x882>" + self.script_accel, textcolor, textalpha, textscale );
        }
    }

    // Namespace dev
    // Params 7
    // Checksum 0x70c8acfb, Offset: 0x5e18
    // Size: 0x154, Type: dev
    function drawpath( linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        ent = self;
        entfirsttarget = ent.targetname;
        
        while ( isdefined( ent.target ) )
        {
            enttarget = getent( ent.target, "<dev string:x1fa>" );
            ent thread drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg );
            
            if ( ent.targetname == "<dev string:x83e>" )
            {
                entfirsttarget = ent.target;
            }
            else if ( ent.target == entfirsttarget )
            {
                break;
            }
            
            ent = enttarget;
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 8
    // Checksum 0x6013eaa1, Offset: 0x5f78
    // Size: 0x124, Type: dev
    function drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        
        while ( drawtime > 0 )
        {
            if ( isdefined( self.targetname ) && self.targetname == "<dev string:x7be>" )
            {
                print3d( self.origin + textoffset, self.targetname, textcolor, textalpha, textscale );
            }
            
            line( self.origin, enttarget.origin, linecolor );
            self drawspeedacceltext( textcolor, textalpha, textscale, textoffset );
            drawtime -= 0.05;
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 1
    // Checksum 0x7b3efdb4, Offset: 0x60a8
    // Size: 0xc6, Type: dev
    function get_lookat_origin( player )
    {
        angles = player getplayerangles();
        forward = anglestoforward( angles );
        dir = vectorscale( forward, 8000 );
        eye = player geteye();
        trace = bullettrace( eye, eye + dir, 0, undefined );
        return trace[ "<dev string:x890>" ];
    }

    // Namespace dev
    // Params 2
    // Checksum 0x7ddcffeb, Offset: 0x6178
    // Size: 0x74, Type: dev
    function draw_pathnode( node, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 1 );
        }
        
        box( node.origin, ( -16, -16, 0 ), ( 16, 16, 16 ), 0, color, 1, 0, 1 );
    }

    // Namespace dev
    // Params 2
    // Checksum 0xdf9a0cfc, Offset: 0x61f8
    // Size: 0x48, Type: dev
    function draw_pathnode_think( node, color )
    {
        level endon( #"draw_pathnode_stop" );
        
        for ( ;; )
        {
            draw_pathnode( node, color );
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x3ba9e3fc, Offset: 0x6248
    // Size: 0x1a, Type: dev
    function draw_pathnodes_stop()
    {
        wait 5;
        level notify( #"draw_pathnode_stop" );
    }

    // Namespace dev
    // Params 1
    // Checksum 0xff2042af, Offset: 0x6270
    // Size: 0x120, Type: dev
    function node_get( player )
    {
        for ( ;; )
        {
            wait 0.05;
            origin = get_lookat_origin( player );
            node = getnearestnode( origin );
            
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            if ( player buttonpressed( "<dev string:x899>" ) )
            {
                return node;
            }
            else if ( player buttonpressed( "<dev string:x8a2>" ) )
            {
                return undefined;
            }
            
            if ( node.type == "<dev string:x179>" )
            {
                draw_pathnode( node, ( 1, 0, 1 ) );
                continue;
            }
            
            draw_pathnode( node, ( 0.85, 0.85, 0.1 ) );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x8619b1a7, Offset: 0x6398
    // Size: 0x1a8, Type: dev
    function dev_get_node_pair()
    {
        player = util::gethostplayer();
        start = undefined;
        
        while ( !isdefined( start ) )
        {
            start = node_get( player );
            
            if ( player buttonpressed( "<dev string:x8a2>" ) )
            {
                level notify( #"draw_pathnode_stop" );
                return undefined;
            }
        }
        
        level thread draw_pathnode_think( start, ( 0, 1, 0 ) );
        
        while ( player buttonpressed( "<dev string:x899>" ) )
        {
            wait 0.05;
        }
        
        end = undefined;
        
        while ( !isdefined( end ) )
        {
            end = node_get( player );
            
            if ( player buttonpressed( "<dev string:x8a2>" ) )
            {
                level notify( #"draw_pathnode_stop" );
                return undefined;
            }
        }
        
        level thread draw_pathnode_think( end, ( 0, 1, 0 ) );
        level thread draw_pathnodes_stop();
        array = [];
        array[ 0 ] = start;
        array[ 1 ] = end;
        return array;
    }

    // Namespace dev
    // Params 2
    // Checksum 0x98e37d0a, Offset: 0x6548
    // Size: 0x5c, Type: dev
    function draw_point( origin, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 1 );
        }
        
        sphere( origin, 16, color, 0.25, 0, 16, 1 );
    }

    // Namespace dev
    // Params 1
    // Checksum 0xa73e3740, Offset: 0x65b0
    // Size: 0xa0, Type: dev
    function point_get( player )
    {
        for ( ;; )
        {
            wait 0.05;
            origin = get_lookat_origin( player );
            
            if ( player buttonpressed( "<dev string:x899>" ) )
            {
                return origin;
            }
            else if ( player buttonpressed( "<dev string:x8a2>" ) )
            {
                return undefined;
            }
            
            draw_point( origin, ( 1, 0, 1 ) );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x510a2eae, Offset: 0x6658
    // Size: 0x120, Type: dev
    function dev_get_point_pair()
    {
        player = util::gethostplayer();
        start = undefined;
        points = [];
        
        while ( !isdefined( start ) )
        {
            start = point_get( player );
            
            if ( !isdefined( start ) )
            {
                return points;
            }
        }
        
        while ( player buttonpressed( "<dev string:x899>" ) )
        {
            wait 0.05;
        }
        
        end = undefined;
        
        while ( !isdefined( end ) )
        {
            end = point_get( player );
            
            if ( !isdefined( end ) )
            {
                return points;
            }
        }
        
        points[ 0 ] = start;
        points[ 1 ] = end;
        return points;
    }

#/
