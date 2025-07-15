#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_dragon_strike;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_stalingrad_dragon;
#using scripts/zm/zm_stalingrad_dragon_strike;
#using scripts/zm/zm_stalingrad_drop_pods;
#using scripts/zm/zm_stalingrad_ee_main;
#using scripts/zm/zm_stalingrad_finger_trap;
#using scripts/zm/zm_stalingrad_pap_quest;
#using scripts/zm/zm_stalingrad_util;

#namespace zm_stalingrad_devgui;

/#

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xa3b3488f, Offset: 0x338
    // Size: 0x434, Type: dev
    function function_91912a79()
    {
        zm_devgui::add_custom_devgui_callback( &function_17d8768b );
        adddebugcommand( "<dev string:x28>" );
        adddebugcommand( "<dev string:x78>" );
        adddebugcommand( "<dev string:xbf>" );
        adddebugcommand( "<dev string:x116>" );
        adddebugcommand( "<dev string:x16f>" );
        adddebugcommand( "<dev string:x1c6>" );
        adddebugcommand( "<dev string:x21b>" );
        adddebugcommand( "<dev string:x267>" );
        adddebugcommand( "<dev string:x2c3>" );
        adddebugcommand( "<dev string:x310>" );
        adddebugcommand( "<dev string:x35f>" );
        adddebugcommand( "<dev string:x3a7>" );
        adddebugcommand( "<dev string:x401>" );
        adddebugcommand( "<dev string:x45c>" );
        adddebugcommand( "<dev string:x4b3>" );
        adddebugcommand( "<dev string:x505>" );
        adddebugcommand( "<dev string:x559>" );
        adddebugcommand( "<dev string:x59c>" );
        adddebugcommand( "<dev string:x5de>" );
        adddebugcommand( "<dev string:x622>" );
        adddebugcommand( "<dev string:x674>" );
        adddebugcommand( "<dev string:x6c0>" );
        adddebugcommand( "<dev string:x706>" );
        adddebugcommand( "<dev string:x76c>" );
        adddebugcommand( "<dev string:x7c8>" );
        adddebugcommand( "<dev string:x81c>" );
        adddebugcommand( "<dev string:x870>" );
        adddebugcommand( "<dev string:x8b8>" );
        adddebugcommand( "<dev string:x904>" );
        adddebugcommand( "<dev string:x95d>" );
        adddebugcommand( "<dev string:x9b8>" );
        adddebugcommand( "<dev string:xa13>" );
        adddebugcommand( "<dev string:xa6e>" );
        adddebugcommand( "<dev string:xac9>" );
        adddebugcommand( "<dev string:xb24>" );
        adddebugcommand( "<dev string:xb77>" );
        adddebugcommand( "<dev string:xbd6>" );
        adddebugcommand( "<dev string:xc1e>" );
        adddebugcommand( "<dev string:xc66>" );
        adddebugcommand( "<dev string:xcbf>" );
        adddebugcommand( "<dev string:xd15>" );
        
        if ( getdvarint( "<dev string:xd77>" ) > 0 )
        {
            level thread function_867cb8b1();
        }
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xb8c147ca, Offset: 0x778
    // Size: 0x18c, Type: dev
    function function_867cb8b1()
    {
        adddebugcommand( "<dev string:xd84>" );
        adddebugcommand( "<dev string:xde8>" );
        adddebugcommand( "<dev string:xe4c>" );
        adddebugcommand( "<dev string:xe90>" );
        adddebugcommand( "<dev string:xed2>" );
        adddebugcommand( "<dev string:xf2c>" );
        adddebugcommand( "<dev string:xf83>" );
        adddebugcommand( "<dev string:xfdf>" );
        adddebugcommand( "<dev string:x103f>" );
        adddebugcommand( "<dev string:x10a5>" );
        adddebugcommand( "<dev string:x1107>" );
        adddebugcommand( "<dev string:x117b>" );
        adddebugcommand( "<dev string:x11db>" );
        adddebugcommand( "<dev string:x126e>" );
        adddebugcommand( "<dev string:x12c7>" );
        adddebugcommand( "<dev string:x131b>" );
    }

    // Namespace zm_stalingrad_devgui
    // Params 1
    // Checksum 0xe0e6b68, Offset: 0x910
    // Size: 0x7ae, Type: dev
    function function_17d8768b( cmd )
    {
        switch ( cmd )
        {
            case "<dev string:x136d>":
                level thread function_2b22d1f9();
                return 1;
            case "<dev string:x137a>":
                level thread function_a7e8b47b();
                return 1;
            case "<dev string:x1387>":
                level thread function_31f1d173( 0 );
                return 1;
            case "<dev string:x139c>":
                level thread function_31f1d173( 1 );
                return 1;
            case "<dev string:x13b2>":
                level thread function_31f1d173( 2 );
                return 1;
            case "<dev string:x13c7>":
                level thread function_31f1d173( 3 );
                return 1;
            case "<dev string:x13db>":
                level thread function_cc40b263();
                return 1;
            case "<dev string:x144e>":
            case "<dev string:x1449>":
            case "<dev string:x1440>":
            case "<dev string:x1456>":
            case "<dev string:x1437>":
            case "<dev string:x142d>":
            case "<dev string:x1423>":
            case "<dev string:x1419>":
            case "<dev string:x140f>":
            case "<dev string:x1406>":
            case "<dev string:x13fd>":
            case "<dev string:x13eb>":
                level.var_8cc024f2 = level.var_583e4a97.var_5d8406ed[ cmd ];
                level thread zm_stalingrad_drop_pod::function_d1a91c4f( level.var_8cc024f2 );
                return 1;
            case "<dev string:x145d>":
                level thread dragon::function_16734812();
                return 1;
            case "<dev string:x1466>":
                level thread dragon::function_e7982921();
                return 1;
            case "<dev string:x146c>":
                level thread dragon::function_cfe0d523();
                return 1;
            case "<dev string:x1482>":
                level thread dragon::function_5f0cb06e();
                return 1;
            case "<dev string:x1493>":
                level thread dragon::function_84bd37c8();
                return 1;
            case "<dev string:x14a0>":
                level thread dragon::dragon_hazard_library();
                return 1;
            case "<dev string:x14ad>":
                level thread dragon::function_7977857();
                return 1;
            case "<dev string:x14b6>":
                level thread dragon::function_b8de630a();
                return 1;
            case "<dev string:x14bd>":
                level thread dragon::function_941c2339();
                return 1;
            case "<dev string:x14c3>":
                level thread dragon::function_ef4a09c3();
                return 1;
            case "<dev string:x14c8>":
                level thread dragon::function_c09859f();
                return 1;
            case "<dev string:x14d9>":
                level thread dragon::function_372d0868();
                break;
            case "<dev string:x14e0>":
                level thread dragon::function_21b70393();
                break;
            case "<dev string:x14e8>":
                level thread dragon::function_482eea0f( 1 );
                break;
            case "<dev string:x14ef>":
                level thread dragon::function_482eea0f( 2 );
                break;
            case "<dev string:x14f6>":
                level thread dragon::function_482eea0f( 3 );
                break;
            case "<dev string:x14fd>":
                level thread dragon::function_482eea0f( 4 );
                break;
            case "<dev string:x1504>":
                level notify( #"hash_2b2c1420" );
                break;
            case "<dev string:x151e>":
                level thread function_4b210fe6();
                return 1;
            case "<dev string:x1536>":
                level thread function_4b210fe6( "<dev string:x154d>" );
                return 1;
            case "<dev string:x155f>":
                level thread function_4b210fe6( "<dev string:x1579>" );
                return 1;
            case "<dev string:x158e>":
                level thread function_4b210fe6( "<dev string:x15a8>" );
                return 1;
            case "<dev string:x15bd>":
                level thread function_a5a0adb4();
                return 1;
            case "<dev string:x15d5>":
                level thread function_bf490b3c();
                return 1;
            case "<dev string:x15f9>":
                level thread function_1b0d61c5();
                return 1;
            case "<dev string:x160c>":
                level thread function_fd68eee0();
                return 1;
            case "<dev string:x1628>":
                level thread zm_stalingrad_finger_trap::function_ddb9991b();
                return 1;
            case "<dev string:x1634>":
                level thread zm_stalingrad_finger_trap::function_fc99caf5();
                return 1;
            case "<dev string:x1646>":
                level flag::set( "<dev string:x165e>" );
                level flag::set( "<dev string:x1672>" );
                util::wait_network_frame();
                level notify( #"hash_68bf9f79" );
                util::wait_network_frame();
                level notify( #"hash_b227a45b" );
                util::wait_network_frame();
                level notify( #"hash_9b46a273" );
                return 1;
            case "<dev string:x167f>":
                level flag::set( "<dev string:x168d>" );
                level flag::set( "<dev string:x16a9>" );
                return 1;
            case "<dev string:x16c5>":
                level flag::set( "<dev string:x16d8>" );
                level flag::set( "<dev string:x16f9>" );
                return 1;
            case "<dev string:x171c>":
                level flag::set( "<dev string:x172f>" );
                level flag::set( "<dev string:x174a>" );
                level notify( #"hash_b7bed0ed" );
                return 1;
            case "<dev string:x1764>":
                function_c072d3dc();
                return 1;
            case "<dev string:x1775>":
                function_4be43f4d();
                return 1;
            case "<dev string:x1786>":
                function_354ff582();
                return 1;
            case "<dev string:x179e>":
                function_f0aaa402();
                return 1;
            case "<dev string:x17b0>":
                function_b221d46();
                return 1;
            default:
                return 0;
        }
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x39a2b7b6, Offset: 0x10c8
    // Size: 0x13c, Type: dev
    function function_2b22d1f9()
    {
        level flag::set( "<dev string:x17c8>" );
        s_pavlov_player = struct::get_array( "<dev string:x17db>", "<dev string:x17eb>" );
        var_9544a498 = 0;
        
        foreach ( player in level.activeplayers )
        {
            player setorigin( s_pavlov_player[ var_9544a498 ].origin );
            player setplayerangles( s_pavlov_player[ var_9544a498 ].angles );
        }
        
        level flag::set( "<dev string:x17f6>" );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xcf7324ab, Offset: 0x1210
    // Size: 0x44, Type: dev
    function function_cc40b263()
    {
        if ( isdefined( level.var_8cc024f2 ) )
        {
            iprintlnbold( "<dev string:x180f>" );
            return 0;
        }
        
        level zm_stalingrad_pap::function_809fbbff();
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x794c1ee5, Offset: 0x1260
    // Size: 0x7da, Type: dev
    function function_a7e8b47b()
    {
        var_1a0a3da9 = getentarray( "<dev string:x1831>", "<dev string:x17eb>" );
        var_ff1b68c0 = getent( "<dev string:x1848>", "<dev string:x17eb>" );
        a_e_collision = getentarray( "<dev string:x185b>", "<dev string:x17eb>" );
        var_50e0150f = getentarray( "<dev string:x1871>", "<dev string:x17eb>" );
        var_b9e116c5 = getentarray( "<dev string:x1884>", "<dev string:x17eb>" );
        var_6f3f4356 = getnodearray( "<dev string:x1891>", "<dev string:x17eb>" );
        
        if ( level.var_de98e3ce.gates_open )
        {
            level.var_de98e3ce.gates_open = 0;
            
            foreach ( e_collision in a_e_collision )
            {
                e_collision movez( 600, 0.1 );
                e_collision disconnectpaths();
            }
            
            foreach ( e_gate in var_50e0150f )
            {
                e_gate movez( 600, 0.25 );
            }
            
            foreach ( e_door in var_1a0a3da9 )
            {
                e_door movex( 114, 1 );
                e_door disconnectpaths();
            }
            
            foreach ( e_hatch in var_b9e116c5 )
            {
                e_hatch rotateroll( -90, 1 );
            }
            
            foreach ( nd_traverse in var_6f3f4356 )
            {
                unlinktraversal( nd_traverse );
            }
            
            var_ff1b68c0 movey( -84, 1 );
            level thread scene::play( "<dev string:x18b1>" );
        }
        else
        {
            level.var_de98e3ce.gates_open = 1;
            
            foreach ( e_collision in a_e_collision )
            {
                e_collision connectpaths();
                e_collision movez( -600, 0.1 );
            }
            
            foreach ( e_gate in var_50e0150f )
            {
                e_gate movez( -600, 0.25 );
            }
            
            foreach ( e_door in var_1a0a3da9 )
            {
                e_door movex( -114, 1 );
                e_door connectpaths();
            }
            
            foreach ( e_hatch in var_b9e116c5 )
            {
                e_hatch rotateroll( 90, 1 );
            }
            
            foreach ( nd_traverse in var_6f3f4356 )
            {
                linktraversal( nd_traverse );
            }
            
            var_ff1b68c0 movey( 84, 1 );
            var_21ce8765 = getent( "<dev string:x18da>", "<dev string:x17eb>" );
            var_21ce8765 thread scene::play( "<dev string:x18e5>" );
        }
        
        return 1;
    }

    // Namespace zm_stalingrad_devgui
    // Params 1
    // Checksum 0xc241e14c, Offset: 0x1a48
    // Size: 0x234, Type: dev
    function function_31f1d173( var_41ef115f )
    {
        level notify( #"hash_31f1d173" );
        wait 1;
        
        switch ( var_41ef115f )
        {
            case 0:
                var_e0320b0b = 1;
                var_6e2a9bd0 = 2;
                n_exploder = 1;
                break;
            case 1:
                var_e0320b0b = 0;
                var_6e2a9bd0 = 2;
                n_exploder = 2;
                break;
            case 2:
                var_e0320b0b = 0;
                var_6e2a9bd0 = 1;
                n_exploder = 3;
                break;
            case 3:
                var_e0320b0b = 0;
                var_6e2a9bd0 = 1;
                var_942d1639 = 2;
                n_exploder = 4;
                break;
        }
        
        level thread zm_stalingrad_pap::function_187a933f( var_e0320b0b );
        level thread zm_stalingrad_pap::function_187a933f( var_6e2a9bd0 );
        
        if ( isdefined( var_942d1639 ) )
        {
            level thread zm_stalingrad_pap::function_187a933f( var_942d1639 );
        }
        
        exploder::exploder( "<dev string:x190c>" );
        exploder::exploder( "<dev string:x1915>" + n_exploder );
        level util::waittill_any_timeout( 20, "<dev string:x191d>" );
        level thread zm_stalingrad_pap::function_a71517e1( var_e0320b0b );
        level thread zm_stalingrad_pap::function_a71517e1( var_6e2a9bd0 );
        
        if ( isdefined( var_942d1639 ) )
        {
            level thread zm_stalingrad_pap::function_a71517e1( var_942d1639 );
        }
        
        exploder::kill_exploder( "<dev string:x1915>" + n_exploder );
        exploder::kill_exploder( "<dev string:x190c>" );
    }

    // Namespace zm_stalingrad_devgui
    // Params 1
    // Checksum 0xba4a5a60, Offset: 0x1c88
    // Size: 0x144, Type: dev
    function function_4b210fe6( var_b87a2184 )
    {
        dragon::function_30560c4b();
        dragon::function_cf119cfd();
        level flag::set( "<dev string:x1934>" );
        level zm_stalingrad_util::function_3804dbf1();
        zm_stalingrad_util::function_adf4d1d0();
        
        if ( isdefined( level.var_ef9c43d7 ) )
        {
            if ( isdefined( level.var_ef9c43d7.var_fa4643fb ) )
            {
                level.var_ef9c43d7.var_fa4643fb delete();
            }
            
            level.var_ef9c43d7 delete();
            level.var_ef9c43d7 = undefined;
        }
        
        level zm_zonemgr::enable_zone( "<dev string:x1942>" );
        
        if ( isdefined( var_b87a2184 ) )
        {
            level flag::init( "<dev string:x1952>" );
            level flag::init( var_b87a2184, 1 );
        }
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x63b0c4f2, Offset: 0x1dd8
    // Size: 0x5c, Type: dev
    function function_a5a0adb4()
    {
        if ( level flag::get( "<dev string:x1934>" ) )
        {
            level zm_ai_raps::special_raps_spawn( 6 );
            return;
        }
        
        iprintlnbold( "<dev string:x195b>" );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x1ef3fc2c, Offset: 0x1e40
    // Size: 0xe8, Type: dev
    function function_bf490b3c()
    {
        level endon( #"_zombie_game_over" );
        level flag::wait_till( "<dev string:x1934>" );
        
        while ( !isdefined( level.var_cf6e9729 ) )
        {
            wait 0.05;
        }
        
        level.var_cf6e9729.var_65850094[ 1 ] = 1;
        level.var_cf6e9729.var_65850094[ 2 ] = 1;
        level.var_cf6e9729.var_65850094[ 3 ] = 1;
        level.var_cf6e9729.var_65850094[ 4 ] = 1;
        level.var_cf6e9729.var_65850094[ 5 ] = 1;
        level.var_cf6e9729.var_dad3d9bd = 9999999;
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xf200cbc8, Offset: 0x1f30
    // Size: 0xaa, Type: dev
    function function_1b0d61c5()
    {
        level flag::clear( "<dev string:x197d>" );
        
        foreach ( e_player in level.players )
        {
            e_player stalingrad_dragon_strike::function_8258d71c();
        }
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x3cbde1e7, Offset: 0x1fe8
    // Size: 0xaa, Type: dev
    function function_fd68eee0()
    {
        level flag::set( "<dev string:x197d>" );
        
        foreach ( e_player in level.players )
        {
            e_player stalingrad_dragon_strike::function_8258d71c();
        }
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xce313653, Offset: 0x20a0
    // Size: 0x2c, Type: dev
    function function_c072d3dc()
    {
        luinotifyevent( &"<dev string:x1991>", 1, 1 );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x9f30d1cd, Offset: 0x20d8
    // Size: 0x24, Type: dev
    function function_4be43f4d()
    {
        luinotifyevent( &"<dev string:x1991>", 1, 0 );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xacb0a3f5, Offset: 0x2108
    // Size: 0x7c, Type: dev
    function function_354ff582()
    {
        level clientfield::set( "<dev string:x19a2>", int( ( level.time - level.n_gameplay_start_time + 500 ) / 1000 ) );
        level clientfield::set( "<dev string:x19b6>", level.round_number );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0xcbaafd63, Offset: 0x2190
    // Size: 0x54, Type: dev
    function function_f0aaa402()
    {
        level clientfield::set( "<dev string:x19c9>", int( ( level.time - level.n_gameplay_start_time + 500 ) / 1000 ) );
    }

    // Namespace zm_stalingrad_devgui
    // Params 0
    // Checksum 0x27e7b5a8, Offset: 0x21f0
    // Size: 0x54, Type: dev
    function function_b221d46()
    {
        level clientfield::set( "<dev string:x19d7>", int( ( level.time - level.n_gameplay_start_time + 500 ) / 1000 ) );
    }

#/
