#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_challenges;
#using scripts/cp/_decorations;
#using scripts/cp/_laststand;
#using scripts/cp/_skipto;
#using scripts/cp/gametypes/_save;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/load_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace devgui;

/#

    // Namespace devgui
    // Params 0, eflags: 0x2
    // Checksum 0x56fc5155, Offset: 0x270
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, undefined );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x2e544098, Offset: 0x2b0
    // Size: 0x1bc, Type: dev
    function __init__()
    {
        setdvar( "<dev string:x2f>", "<dev string:x3b>" );
        setdvar( "<dev string:x3c>", "<dev string:x3b>" );
        setdvar( "<dev string:x4f>", "<dev string:x3b>" );
        setdvar( "<dev string:x5e>", 0 );
        setdvar( "<dev string:x72>", "<dev string:x3b>" );
        setdvar( "<dev string:x87>", 0 );
        setdvar( "<dev string:xaf>", 0 );
        setdvar( "<dev string:xd1>", "<dev string:x3b>" );
        thread devgui_think();
        thread devgui_weapon_think();
        thread devgui_weapon_asset_name_display_think();
        thread devgui_test_chart_think();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui( 2 );
        callback::on_start_gametype( &devgui_player_commands );
        callback::on_connect( &devgui_player_connect );
        callback::on_disconnect( &devgui_player_disconnect );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xe52f8091, Offset: 0x478
    // Size: 0x1ee, Type: dev
    function devgui_player_commands()
    {
        level flag::wait_till( "<dev string:xe7>" );
        rootclear = "<dev string:xfb>";
        adddebugcommand( rootclear );
        players = getplayers();
        
        foreach ( player in getplayers() )
        {
            rootclear = "<dev string:x118>" + player.playername + "<dev string:x12f>";
            adddebugcommand( rootclear );
        }
        
        thread devgui_player_weapons();
        level.player_devgui_base = "<dev string:x133>";
        devgui_add_player_commands( level.player_devgui_base, "<dev string:x147>", 0 );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            ip1 = i + 1;
            devgui_add_player_commands( level.player_devgui_base, players[ i ].playername, ip1 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xd1bd5f69, Offset: 0x670
    // Size: 0xae, Type: dev
    function devgui_player_connect()
    {
        if ( !isdefined( level.player_devgui_base ) )
        {
            return;
        }
        
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ] != self )
            {
                continue;
            }
            
            devgui_add_player_commands( level.player_devgui_base, players[ i ].playername, i + 1 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x2847c4cd, Offset: 0x728
    // Size: 0x54, Type: dev
    function devgui_player_disconnect()
    {
        if ( !isdefined( level.player_devgui_base ) )
        {
            return;
        }
        
        rootclear = "<dev string:x118>" + self.playername + "<dev string:x12f>";
        util::add_queued_debug_command( rootclear );
    }

    // Namespace devgui
    // Params 3
    // Checksum 0xabff2da0, Offset: 0x788
    // Size: 0x68c, Type: dev
    function devgui_add_player_commands( root, pname, index )
    {
        player_devgui_root = root + pname + "<dev string:x14d>";
        pid = "<dev string:x3b>" + index;
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x14f>", 1, "<dev string:x15c>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x165>", 2, "<dev string:x170>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x17a>", 3, "<dev string:x188>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x18f>", 4, "<dev string:x1a1>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x1a8>", 5, "<dev string:x1bd>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x1c2>", 6, "<dev string:x1c7>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x1cc>", 7, "<dev string:x1e2>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x1ef>", 8, "<dev string:x1f6>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x1fd>", 9, "<dev string:x20c>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x219>", 10, "<dev string:x229>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x237>", 11, "<dev string:x24c>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x25b>", 12, "<dev string:x271>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x281>", 13, "<dev string:x299>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x2af>", 14, "<dev string:x2c2>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x2d0>", 15, "<dev string:x2d9>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x2e1>", 16, "<dev string:x2f4>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x304>", 17, "<dev string:x317>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x327>", 18, "<dev string:x33a>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x34a>", 19, "<dev string:x35d>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x36d>", 20, "<dev string:x380>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x390>", 21, "<dev string:x3a3>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x3b3>", 22, "<dev string:x3c6>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x3d6>", 23, "<dev string:x3e9>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x3f9>", 24, "<dev string:x40c>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x41c>", 25, "<dev string:x42f>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x43f>", 26, "<dev string:x453>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x464>", 27, "<dev string:x47b>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x490>", 28, "<dev string:x4aa>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x4bf>", 29, "<dev string:x4de>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x4ee>", 30, "<dev string:x508>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x518>", 31, "<dev string:x527>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x534>", 32, "<dev string:x554>" );
        devgui_add_player_command( player_devgui_root, pid, "<dev string:x56e>", 33, "<dev string:x589>" );
    }

    // Namespace devgui
    // Params 5
    // Checksum 0x5ceecd41, Offset: 0xe20
    // Size: 0x94, Type: dev
    function devgui_add_player_command( root, pid, cmdname, cmdindex, cmddvar )
    {
        adddebugcommand( root + cmdname + "<dev string:x59a>" + "<dev string:x3c>" + "<dev string:x5a2>" + pid + "<dev string:x5a4>" + "<dev string:x2f>" + "<dev string:x5a2>" + cmddvar + "<dev string:x12f>" );
    }

    // Namespace devgui
    // Params 3
    // Checksum 0x26cfe2ce, Offset: 0xec0
    // Size: 0x10c, Type: dev
    function devgui_handle_player_command( cmd, playercallback, pcb_param )
    {
        pid = getdvarint( "<dev string:x3c>" );
        
        if ( pid > 0 )
        {
            player = getplayers()[ pid - 1 ];
            
            if ( isdefined( player ) )
            {
                if ( isdefined( pcb_param ) )
                {
                    player thread [[ playercallback ]]( pcb_param );
                }
                else
                {
                    player thread [[ playercallback ]]();
                }
            }
        }
        else
        {
            array::thread_all( getplayers(), playercallback, pcb_param );
        }
        
        setdvar( "<dev string:x3c>", "<dev string:x5aa>" );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xf24b2b68, Offset: 0xfd8
    // Size: 0x7a8, Type: dev
    function devgui_think()
    {
        for ( ;; )
        {
            cmd = getdvarstring( "<dev string:x2f>" );
            
            if ( cmd == "<dev string:x3b>" )
            {
                wait 0.05;
                continue;
            }
            
            switch ( cmd )
            {
                case "<dev string:x1a1>":
                    devgui_handle_player_command( cmd, &devgui_give_health );
                    break;
                case "<dev string:x1bd>":
                    devgui_handle_player_command( cmd, &devgui_toggle_ammo );
                    break;
                case "<dev string:x188>":
                    devgui_handle_player_command( cmd, &devgui_toggle_ignore );
                    break;
                case "<dev string:x15c>":
                    devgui_handle_player_command( cmd, &devgui_invulnerable, 1 );
                    break;
                case "<dev string:x170>":
                    devgui_handle_player_command( cmd, &devgui_invulnerable, 0 );
                    break;
                case "<dev string:x1c7>":
                    devgui_handle_player_command( cmd, &devgui_kill );
                    break;
                case "<dev string:x1f6>":
                    devgui_handle_player_command( cmd, &devgui_revive );
                    break;
                case "<dev string:x1e2>":
                    devgui_handle_player_command( cmd, &devgui_toggle_infinitesolo );
                    break;
                case "<dev string:x20c>":
                    devgui_handle_player_command( cmd, &function_cac73614, 100 );
                    break;
                case "<dev string:x229>":
                    devgui_handle_player_command( cmd, &function_cac73614, 1000 );
                    break;
                case "<dev string:x24c>":
                    devgui_handle_player_command( cmd, &function_9f78d70e, 100 );
                    break;
                case "<dev string:x271>":
                    devgui_handle_player_command( cmd, &function_9f78d70e, 1000 );
                    break;
                case "<dev string:x299>":
                    devgui_handle_player_command( cmd, &function_d7b26538 );
                case "<dev string:x2c2>":
                    devgui_handle_player_command( cmd, &function_fcd3cf3f );
                    break;
                case "<dev string:x2d9>":
                    devgui_handle_player_command( cmd, &function_192ef5eb );
                    break;
                case "<dev string:x2f4>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 0 );
                    break;
                case "<dev string:x317>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 1 );
                    break;
                case "<dev string:x33a>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 2 );
                    break;
                case "<dev string:x35d>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 3 );
                    break;
                case "<dev string:x380>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 4 );
                    break;
                case "<dev string:x3a3>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 5 );
                    break;
                case "<dev string:x3c6>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 6 );
                    break;
                case "<dev string:x3e9>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 7 );
                    break;
                case "<dev string:x40c>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 8 );
                    break;
                case "<dev string:x42f>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 9 );
                    break;
                case "<dev string:x453>":
                    devgui_handle_player_command( cmd, &function_b79fb0fe, 10 );
                    break;
                case "<dev string:x47b>":
                    devgui_handle_player_command( cmd, &function_f61fdbaf );
                    break;
                case "<dev string:x4aa>":
                    devgui_handle_player_command( cmd, &function_408729cd );
                    break;
                case "<dev string:x4de>":
                    devgui_handle_player_command( cmd, &function_4edb34ed );
                    break;
                case "<dev string:x508>":
                    devgui_handle_player_command( cmd, &function_4533d882 );
                    break;
                case "<dev string:x527>":
                    devgui_handle_player_command( cmd, &function_cac73614, 1000000 );
                    break;
                case "<dev string:x554>":
                    devgui_handle_player_command( cmd, &function_e2643869 );
                    break;
                case "<dev string:x589>":
                    devgui_handle_player_command( cmd, &function_9c35ef50, "<dev string:x589>" );
                case "<dev string:x3b>":
                    break;
                default:
                    if ( isdefined( level.custom_devgui ) )
                    {
                        if ( isarray( level.custom_devgui ) )
                        {
                            foreach ( devgui in level.custom_devgui )
                            {
                                if ( isdefined( [[ devgui ]]( cmd ) ) && [[ devgui ]]( cmd ) )
                                {
                                    break;
                                }
                            }
                        }
                        else
                        {
                            [[ level.custom_devgui ]]( cmd );
                        }
                    }
                    
                    break;
            }
            
            setdvar( "<dev string:x2f>", "<dev string:x3b>" );
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x925fbe7c, Offset: 0x1788
    // Size: 0x2c, Type: dev
    function function_9c35ef50( stat_name )
    {
        self challenges::function_96ed590f( stat_name, 50 );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xc82906ba, Offset: 0x17c0
    // Size: 0xe2, Type: dev
    function function_e2643869()
    {
        var_c02de660 = skipto::function_23eda99c();
        
        foreach ( mission in var_c02de660 )
        {
            self addplayerstat( "<dev string:x5ad>" + getsubstr( getmissionname( mission ), 0, 3 ), 1 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xa800f7e8, Offset: 0x18b0
    // Size: 0x6e, Type: dev
    function function_4533d882()
    {
        for ( itemindex = 1; itemindex < 76 ; itemindex++ )
        {
            self setdstat( "<dev string:x5bb>", itemindex, "<dev string:x5c5>", "<dev string:x5cb>", "<dev string:x5d1>", 999 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x2abeb0f6, Offset: 0x1928
    // Size: 0x66, Type: dev
    function function_4edb34ed()
    {
        for ( itemindex = 1; itemindex < 76 ; itemindex++ )
        {
            self setdstat( "<dev string:x5bb>", itemindex, "<dev string:x5db>", 1000000 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x16e5afec, Offset: 0x1998
    // Size: 0xca, Type: dev
    function function_408729cd()
    {
        if ( !isdefined( getrootmapname() ) )
        {
            return;
        }
        
        foreach ( mission in skipto::function_23eda99c() )
        {
            self setdstat( "<dev string:x5de>", mission, "<dev string:x5ef>", 4, 1 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xec45da43, Offset: 0x1a70
    // Size: 0xcc, Type: dev
    function function_192ef5eb()
    {
        if ( isdefined( self.var_f0080358 ) && self.var_f0080358 )
        {
            self closeluimenu( self.var_f0080358 );
        }
        
        self.var_f0080358 = self openluimenu( "<dev string:x605>" );
        self waittill( #"menuresponse", menu, response );
        
        while ( response != "<dev string:x616>" )
        {
            self waittill( #"menuresponse", menu, response );
        }
        
        self closeluimenu( self.var_f0080358 );
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x30b2578e, Offset: 0x1b48
    // Size: 0x74, Type: dev
    function function_b79fb0fe( var_b931f6fe )
    {
        a_decorations = self getdecorations();
        self givedecoration( a_decorations[ var_b931f6fe ].name );
        uploadstats( self );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x25b6ffaa, Offset: 0x1bc8
    // Size: 0xc2, Type: dev
    function function_f61fdbaf()
    {
        var_c02de660 = skipto::function_23eda99c();
        
        foreach ( mission_name in var_c02de660 )
        {
            self setdstat( "<dev string:x5de>", mission_name, "<dev string:x61d>", 1 );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x9756e50f, Offset: 0x1c98
    // Size: 0xec, Type: dev
    function function_d7b26538()
    {
        var_c02de660 = skipto::function_23eda99c();
        
        foreach ( mission in var_c02de660 )
        {
            for ( i = 0; i < 10 ; i++ )
            {
                self setdstat( "<dev string:x5de>", mission, "<dev string:x632>", i, 1 );
            }
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xc919a945, Offset: 0x1d90
    // Size: 0xc2, Type: dev
    function function_fcd3cf3f()
    {
        var_c02de660 = skipto::function_23eda99c();
        
        foreach ( mission_name in var_c02de660 )
        {
            self setdstat( "<dev string:x5de>", mission_name, "<dev string:x63f>", 1 );
        }
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x2ce7e4a4, Offset: 0x1e60
    // Size: 0x74, Type: dev
    function function_cac73614( var_735c65d7 )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        self addrankxpvalue( "<dev string:x650>", var_735c65d7 );
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x9b374b38, Offset: 0x1ee0
    // Size: 0x114, Type: dev
    function function_9f78d70e( var_735c65d7 )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        weaponnum = int( tablelookup( "<dev string:x659>", 3, self.currentweapon.rootweapon.displayname, 0 ) );
        var_b51b0d94 = self getdstat( "<dev string:x5bb>", weaponnum, "<dev string:x5db>" );
        self setdstat( "<dev string:x5bb>", weaponnum, "<dev string:x5db>", var_735c65d7 + var_b51b0d94 );
    }

    // Namespace devgui
    // Params 1
    // Checksum 0xcd32baf, Offset: 0x2000
    // Size: 0x44, Type: dev
    function devgui_invulnerable( onoff )
    {
        if ( onoff )
        {
            self enableinvulnerability();
            return;
        }
        
        self disableinvulnerability();
    }

    // Namespace devgui
    // Params 0
    // Checksum 0xd5803204, Offset: 0x2050
    // Size: 0xfc, Type: dev
    function devgui_kill()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        
        if ( isalive( self ) )
        {
            self disableinvulnerability();
            death_from = ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ) );
            self dodamage( self.health + 666, self.origin + death_from );
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x6a46ad73, Offset: 0x2158
    // Size: 0x156, Type: dev
    function devgui_toggle_ammo()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self notify( #"devgui_toggle_ammo" );
        self endon( #"devgui_toggle_ammo" );
        self.ammo4evah = !( isdefined( self.ammo4evah ) && self.ammo4evah );
        
        while ( isdefined( self ) && self.ammo4evah )
        {
            weapon = self getcurrentweapon();
            
            if ( weapon != level.weaponnone )
            {
                self setweaponoverheating( 0, 0 );
                max = weapon.maxammo;
                
                if ( isdefined( max ) )
                {
                    self setweaponammostock( weapon, max );
                }
            }
            
            wait 1;
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x4e997271, Offset: 0x22b8
    // Size: 0x84, Type: dev
    function devgui_toggle_ignore()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self.ignoreme = !self.ignoreme;
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x3472d07b, Offset: 0x2348
    // Size: 0x84, Type: dev
    function devgui_toggle_infinitesolo()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self.infinite_solo_revives = !self.infinite_solo_revives;
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x6d39044c, Offset: 0x23d8
    // Size: 0x13e, Type: dev
    function devgui_revive()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self reviveplayer();
        
        if ( isdefined( self.revivetrigger ) )
        {
            self.revivetrigger delete();
            self.revivetrigger = undefined;
        }
        
        self laststand::cleanup_suicide_hud();
        self laststand::laststand_enable_player_weapons();
        self allowjump( 1 );
        self.ignoreme = 0;
        self disableinvulnerability();
        self.laststand = undefined;
        self notify( #"player_revived", self );
    }

    // Namespace devgui
    // Params 1
    // Checksum 0xf0e202d3, Offset: 0x2520
    // Size: 0x64, Type: dev
    function maintain_maxhealth( maxhealth )
    {
        self endon( #"disconnect" );
        self endon( #"devgui_give_health" );
        
        while ( true )
        {
            wait 1;
            
            if ( self.maxhealth != maxhealth )
            {
                self.maxhealth = maxhealth;
                self.health = self.maxhealth;
            }
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x539c5ef2, Offset: 0x2590
    // Size: 0xfc, Type: dev
    function devgui_give_health()
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self notify( #"devgui_give_health" );
        
        if ( self.maxhealth >= 2000 && isdefined( self.orgmaxhealth ) )
        {
            self.maxhealth = self.orgmaxhealth;
        }
        else
        {
            self.orgmaxhealth = self.maxhealth;
            self.maxhealth = 2000;
            self thread maintain_maxhealth( self.maxhealth );
        }
        
        self.health = self.maxhealth;
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x290f738b, Offset: 0x2698
    // Size: 0x518, Type: dev
    function devgui_player_weapons()
    {
        if ( isdefined( game[ "<dev string:x67d>" ] ) && game[ "<dev string:x67d>" ] )
        {
            return;
        }
        
        level flag::wait_till( "<dev string:xe7>" );
        wait 0.1;
        a_weapons = enumerateweapons( "<dev string:x692>" );
        a_weapons_cp = [];
        a_grenades_cp = [];
        a_misc_cp = [];
        
        for ( i = 0; i < a_weapons.size ; i++ )
        {
            if ( weapons::is_primary_weapon( a_weapons[ i ] ) || weapons::is_side_arm( a_weapons[ i ] ) )
            {
                arrayinsert( a_weapons_cp, a_weapons[ i ], 0 );
                continue;
            }
            
            if ( weapons::is_grenade( a_weapons[ i ] ) )
            {
                arrayinsert( a_grenades_cp, a_weapons[ i ], 0 );
                continue;
            }
            
            arrayinsert( a_misc_cp, a_weapons[ i ], 0 );
        }
        
        player_devgui_base_cp = "<dev string:x133>";
        adddebugcommand( player_devgui_base_cp + "<dev string:x147>" + "<dev string:x699>" + "<dev string:x87>" + "<dev string:x6c0>" );
        adddebugcommand( player_devgui_base_cp + "<dev string:x147>" + "<dev string:x6c8>" + "<dev string:x5e>" + "<dev string:x6c0>" );
        adddebugcommand( player_devgui_base_cp + "<dev string:x147>" + "<dev string:x6f6>" + "<dev string:xaf>" + "<dev string:x6c0>" );
        devgui_add_player_weapons( player_devgui_base_cp, "<dev string:x147>", 0, a_grenades_cp, "<dev string:x72a>" );
        devgui_add_player_weapons( player_devgui_base_cp, "<dev string:x147>", 0, a_weapons_cp, "<dev string:x733>" );
        devgui_add_player_weapons( player_devgui_base_cp, "<dev string:x147>", 0, a_misc_cp, "<dev string:x738>" );
        devgui_add_player_gun_attachments( player_devgui_base_cp, "<dev string:x147>", 0, a_weapons_cp, "<dev string:x73d>" );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            ip1 = i + 1;
            adddebugcommand( player_devgui_base_cp + players[ i ].playername + "<dev string:x699>" + "<dev string:x87>" + "<dev string:x6c0>" );
            adddebugcommand( player_devgui_base_cp + players[ i ].playername + "<dev string:x6c8>" + "<dev string:x5e>" + "<dev string:x6c0>" );
            adddebugcommand( player_devgui_base_cp + players[ i ].playername + "<dev string:x6f6>" + "<dev string:xaf>" + "<dev string:x6c0>" );
            devgui_add_player_weapons( player_devgui_base_cp, players[ i ].playername, ip1, a_grenades_cp, "<dev string:x72a>" );
            devgui_add_player_weapons( player_devgui_base_cp, players[ i ].playername, ip1, a_weapons_cp, "<dev string:x733>" );
            devgui_add_player_weapons( player_devgui_base_cp, players[ i ].playername, ip1, a_misc_cp, "<dev string:x738>" );
            devgui_add_player_gun_attachments( player_devgui_base_cp, players[ i ].playername, ip1, a_weapons_cp, "<dev string:x73d>" );
        }
        
        game[ "<dev string:x67d>" ] = 1;
    }

    // Namespace devgui
    // Params 5
    // Checksum 0xadb12274, Offset: 0x2bb8
    // Size: 0x222, Type: dev
    function devgui_add_player_gun_attachments( root, pname, index, a_weapons, weapon_type )
    {
        player_devgui_root = root + pname + "<dev string:x14d>" + "<dev string:x749>" + weapon_type + "<dev string:x14d>";
        attachments = [];
        
        foreach ( weapon in a_weapons )
        {
            foreach ( supportedattachment in weapon.supportedattachments )
            {
                array::add( attachments, supportedattachment, 0 );
            }
        }
        
        pid = "<dev string:x3b>" + index;
        
        foreach ( att in attachments )
        {
            devgui_add_player_attachment_command( player_devgui_root, pid, att, 1 );
        }
    }

    // Namespace devgui
    // Params 5
    // Checksum 0xbf1495a4, Offset: 0x2de8
    // Size: 0x24e, Type: dev
    function devgui_add_player_weapons( root, pname, index, a_weapons, weapon_type )
    {
        player_devgui_root = root + pname + "<dev string:x14d>" + "<dev string:x749>" + weapon_type + "<dev string:x14d>";
        pid = "<dev string:x3b>" + index;
        
        if ( isdefined( a_weapons ) )
        {
            for ( i = 0; i < a_weapons.size ; i++ )
            {
                if ( weapon_type == "<dev string:x733>" )
                {
                    attachments = [];
                }
                else
                {
                    attachments = a_weapons[ i ].supportedattachments;
                }
                
                name = a_weapons[ i ].name;
                
                if ( attachments.size )
                {
                    devgui_add_player_weap_command( player_devgui_root + name + "<dev string:x14d>", pid, name, i + 1 );
                    
                    foreach ( att in attachments )
                    {
                        if ( att != "<dev string:x752>" )
                        {
                            devgui_add_player_weap_command( player_devgui_root + name + "<dev string:x14d>", pid, name + "<dev string:x757>" + att, i + 1 );
                        }
                    }
                }
                else
                {
                    devgui_add_player_weap_command( player_devgui_root, pid, name, i + 1 );
                }
                
                wait 0.05;
            }
        }
    }

    // Namespace devgui
    // Params 4
    // Checksum 0x2e75d6e, Offset: 0x3040
    // Size: 0x8c, Type: dev
    function devgui_add_player_weap_command( root, pid, weap_name, cmdindex )
    {
        adddebugcommand( root + weap_name + "<dev string:x59a>" + "<dev string:xd1>" + "<dev string:x5a2>" + pid + "<dev string:x5a4>" + "<dev string:x4f>" + "<dev string:x5a2>" + weap_name + "<dev string:x12f>" );
    }

    // Namespace devgui
    // Params 4
    // Checksum 0x65801849, Offset: 0x30d8
    // Size: 0x8c, Type: dev
    function devgui_add_player_attachment_command( root, pid, attachment_name, cmdindex )
    {
        adddebugcommand( root + attachment_name + "<dev string:x59a>" + "<dev string:xd1>" + "<dev string:x5a2>" + pid + "<dev string:x5a4>" + "<dev string:x72>" + "<dev string:x5a2>" + attachment_name + "<dev string:x12f>" );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x11a6e8f8, Offset: 0x3170
    // Size: 0x108, Type: dev
    function devgui_weapon_think()
    {
        for ( ;; )
        {
            weapon_name = getdvarstring( "<dev string:x4f>" );
            
            if ( weapon_name != "<dev string:x3b>" )
            {
                devgui_handle_player_command( weapon_name, &devgui_give_weapon, weapon_name );
                setdvar( "<dev string:x4f>", "<dev string:x3b>" );
            }
            
            attachmentname = getdvarstring( "<dev string:x72>" );
            
            if ( attachmentname != "<dev string:x3b>" )
            {
                devgui_handle_player_command( attachmentname, &devgui_give_attachment, attachmentname );
                setdvar( "<dev string:x72>", "<dev string:x3b>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x76befb20, Offset: 0x3280
    // Size: 0x3e0, Type: dev
    function devgui_weapon_asset_name_display_think()
    {
        update_time = 0.5;
        print_duration = int( update_time / 0.05 );
        printlnbold_update = int( 1 / update_time );
        printlnbold_counter = 0;
        colors = [];
        colors[ colors.size ] = ( 1, 1, 1 );
        colors[ colors.size ] = ( 1, 0, 0 );
        colors[ colors.size ] = ( 0, 1, 0 );
        colors[ colors.size ] = ( 1, 1, 0 );
        colors[ colors.size ] = ( 1, 0, 1 );
        colors[ colors.size ] = ( 0, 1, 1 );
        
        for ( ;; )
        {
            wait update_time;
            display = getdvarint( "<dev string:xaf>" );
            
            if ( !display )
            {
                continue;
            }
            
            if ( !printlnbold_counter )
            {
                iprintlnbold( level.players[ 0 ] getcurrentweapon().name );
            }
            
            printlnbold_counter++;
            
            if ( printlnbold_counter >= printlnbold_update )
            {
                printlnbold_counter = 0;
            }
            
            color_index = 0;
            
            for ( i = 1; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                weapon = player getcurrentweapon();
                
                if ( !isdefined( weapon ) || level.weaponnone == weapon )
                {
                    continue;
                }
                
                print3d( player gettagorigin( "<dev string:x759>" ), weapon.name, colors[ color_index ], 1, 0.15, print_duration );
                color_index++;
                
                if ( color_index >= colors.size )
                {
                    color_index = 0;
                }
            }
            
            color_index = 0;
            ai_list = getaiarray();
            
            for ( i = 0; i < ai_list.size ; i++ )
            {
                ai = ai_list[ i ];
                
                if ( isvehicle( ai ) )
                {
                    weapon = ai.turretweapon;
                }
                else
                {
                    weapon = ai.weapon;
                }
                
                if ( !isdefined( weapon ) || level.weaponnone == weapon )
                {
                    continue;
                }
                
                print3d( ai gettagorigin( "<dev string:x759>" ), weapon.name, colors[ color_index ], 1, 0.15, print_duration );
                color_index++;
                
                if ( color_index >= colors.size )
                {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x9149a16c, Offset: 0x3668
    // Size: 0x20c, Type: dev
    function devgui_test_chart_think()
    {
        wait 0.05;
        old_val = getdvarint( "<dev string:x763>" );
        
        for ( ;; )
        {
            val = getdvarint( "<dev string:x763>" );
            
            if ( old_val != val )
            {
                if ( isdefined( level.test_chart_model ) )
                {
                    level.test_chart_model delete();
                    level.test_chart_model = undefined;
                }
                
                if ( val )
                {
                    player = getplayers()[ 0 ];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward( ( 0, direction[ 1 ], 0 ) );
                    scale = 120;
                    direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
                    level.test_chart_model = spawn( "<dev string:x778>", player geteye() + direction_vec );
                    level.test_chart_model setmodel( "<dev string:x785>" );
                    level.test_chart_model.angles = ( 0, direction[ 1 ], 0 ) + ( 0, 90, 0 );
                }
            }
            
            old_val = val;
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 1
    // Checksum 0xe77ae077, Offset: 0x3880
    // Size: 0x324, Type: dev
    function devgui_give_weapon( weapon_name )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self notify( #"devgui_give_ammo" );
        self endon( #"devgui_give_ammo" );
        currentweapon = self getcurrentweapon();
        split = strtok( weapon_name, "<dev string:x757>" );
        
        switch ( split.size )
        {
            case 1:
            default:
                weapon = getweapon( split[ 0 ] );
                break;
            case 2:
                weapon = getweapon( split[ 0 ], split[ 1 ] );
                break;
            case 3:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ] );
                break;
            case 4:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ], split[ 3 ] );
                break;
            case 5:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ], split[ 3 ], split[ 4 ] );
                break;
        }
        
        if ( currentweapon != weapon )
        {
            if ( getdvarint( "<dev string:x87>" ) )
            {
                adddebugcommand( "<dev string:x796>" + weapon_name );
                wait 0.05;
            }
            else
            {
                self takeweapon( currentweapon );
                self giveweapon( weapon );
                self switchtoweapon( weapon );
            }
            
            max = weapon.maxammo;
            
            if ( max )
            {
                self setweaponammostock( weapon, max );
            }
        }
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x500d3027, Offset: 0x3bb0
    // Size: 0x46c, Type: dev
    function devgui_give_attachment( attachment_name )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self notify( #"devgui_give_attachment" );
        self endon( #"devgui_give_attachment" );
        currentweapon = self getcurrentweapon();
        attachmentsupported = 0;
        split = strtok( currentweapon.name, "<dev string:x757>" );
        
        foreach ( attachment in currentweapon.supportedattachments )
        {
            if ( attachment == attachment_name )
            {
                attachmentsupported = 1;
            }
        }
        
        if ( attachmentsupported == 0 )
        {
            iprintlnbold( "<dev string:x79c>" + attachment_name + "<dev string:x7a8>" + split[ 0 ] );
            attachmentsstring = "<dev string:x7bf>";
            
            if ( currentweapon.supportedattachments.size == 0 )
            {
                attachmentsstring += "<dev string:x7cb>";
            }
            
            foreach ( attachment in currentweapon.supportedattachments )
            {
                attachmentsstring += "<dev string:x757>" + attachment;
            }
            
            iprintlnbold( attachmentsstring );
            return;
        }
        
        foreach ( currentattachment in split )
        {
            if ( currentattachment == attachment_name )
            {
                iprintlnbold( "<dev string:x79c>" + attachment_name + "<dev string:x7d1>" + currentweapon.name );
                return;
            }
        }
        
        split[ split.size ] = attachment_name;
        
        for ( index = split.size; index < 9 ; index++ )
        {
            split[ index ] = "<dev string:x752>";
        }
        
        self takeweapon( currentweapon );
        newweapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ], split[ 3 ], split[ 4 ], split[ 5 ], split[ 6 ], split[ 7 ], split[ 8 ] );
        self giveweapon( newweapon );
        self switchtoweapon( newweapon );
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x40452b25, Offset: 0x4028
    // Size: 0x12c, Type: dev
    function init_debug_center_screen()
    {
        zero_idle_movement = "<dev string:x7ea>";
        
        for ( ;; )
        {
            if ( getdvarint( "<dev string:x5e>" ) )
            {
                if ( !isdefined( level.center_screen_debug_hudelem_active ) || level.center_screen_debug_hudelem_active == 0 )
                {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarstring( "<dev string:x7ec>" );
                    
                    if ( isdefined( zero_idle_movement ) && zero_idle_movement == "<dev string:x7ea>" )
                    {
                        setdvar( "<dev string:x7ec>", "<dev string:x7ff>" );
                        zero_idle_movement = "<dev string:x7ff>";
                    }
                }
            }
            else
            {
                level notify( #"hash_8e42baed" );
                
                if ( zero_idle_movement == "<dev string:x7ff>" )
                {
                    setdvar( "<dev string:x7ec>", "<dev string:x7ea>" );
                    zero_idle_movement = "<dev string:x7ea>";
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 0
    // Checksum 0x13c6fc57, Offset: 0x4160
    // Size: 0x228, Type: dev
    function debug_center_screen()
    {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newclienthudelem( level.players[ 0 ] );
        level.center_screen_debug_hudelem1.alignx = "<dev string:x801>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:x808>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader( "<dev string:x80f>", 1000, 1 );
        level.center_screen_debug_hudelem2 = newclienthudelem( level.players[ 0 ] );
        level.center_screen_debug_hudelem2.alignx = "<dev string:x801>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:x808>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader( "<dev string:x80f>", 1, 480 );
        level waittill( #"hash_8e42baed" );
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

#/
