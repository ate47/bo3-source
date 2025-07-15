#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace teamgather;

// Namespace teamgather
// Method(s) 29 Total 29
class cteamgather
{

    var in_position_start_time;

    // Namespace cteamgather
    // Params 0
    // Checksum 0x582a1c21, Offset: 0x590
    // Size: 0x74
    function constructor()
    {
        self.e_gameobject = undefined;
        self.n_font_scale = 2;
        self.v_font_color = ( 1, 1, 1 );
        self.m_teamgather_complete = 0;
        self.m_num_players = 0;
        self.m_num_players_ready = 0;
        self.m_gather_fx = undefined;
        self.m_teamgather_complete = 0;
        self.m_success = 0;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xef59db9b, Offset: 0x25e0
    // Size: 0xa4
    function get_players_playing()
    {
        a_players = [];
        a_all_players = getplayers();
        
        for ( i = 0; i < a_all_players.size ; i++ )
        {
            e_player = a_all_players[ i ];
            
            if ( e_player.sessionstate == "playing" )
            {
                a_players[ a_players.size ] = e_player;
            }
        }
        
        return a_players;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xd67c85d1, Offset: 0x2540
    // Size: 0x98
    function get_time_remaining_in_seconds()
    {
        time_remaining = int( get_time_remaining() );
        time_remaining += 1;
        
        if ( time_remaining > 10 )
        {
            time_remaining = 10;
        }
        
        if ( time_remaining > 10 )
        {
            time_remaining = 10;
        }
        else if ( time_remaining < 1 )
        {
            time_remaining = 1;
        }
        
        return time_remaining;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0x6028b0f7, Offset: 0x24d0
    // Size: 0x62
    function get_time_remaining()
    {
        time = gettime();
        dt = ( time - self.e_gameobject.start_time ) / 1000;
        time_remaining = self.e_gameobject.total_time - dt;
        return time_remaining;
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x893d1dff, Offset: 0x2490
    // Size: 0x34
    function start_player_timer( total_time )
    {
        self.e_gameobject.start_time = gettime();
        self.e_gameobject.total_time = total_time;
    }

    // Namespace cteamgather
    // Params 9
    // Checksum 0xe2b8f3ae, Offset: 0x22d8
    // Size: 0x1b0
    function __create_client_hud_elem( alignx, aligny, horzalign, vertalign, xoffset, yoffset, fontscale, color, str_text )
    {
        hud_elem = newclienthudelem( self );
        hud_elem.elemtype = "font";
        hud_elem.font = "objective";
        hud_elem.alignx = alignx;
        hud_elem.aligny = aligny;
        hud_elem.horzalign = horzalign;
        hud_elem.vertalign = vertalign;
        hud_elem.x += xoffset;
        hud_elem.y += yoffset;
        hud_elem.foreground = 1;
        hud_elem.fontscale = fontscale;
        hud_elem.alpha = 1;
        hud_elem.color = color;
        hud_elem.hidewheninmenu = 1;
        hud_elem settext( str_text );
        return hud_elem;
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x9b300d72, Offset: 0x1ea8
    // Size: 0x424
    function display_hud_player_team_member( e_player )
    {
        e_player endon( #"disconnect" );
        y_start = 180;
        x_off = 0;
        y_off = y_start;
        starting_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        starting_hud_elem settext( &"TEAM_GATHER_PLAYER_STARTING_EVENT", self.m_e_player_leader );
        x_off = -118;
        y_off = y_start + 40;
        gathered_hud_elem = e_player __create_client_hud_elem( "left", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        x_off = 54;
        y_off = y_start + 40;
        start_in_hud_elem = e_player __create_client_hud_elem( "left", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        x_off = 0;
        y_off = y_start + 80;
        go_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        a_start_in = array( "0", &"TEAM_GATHER_START_IN_1", &"TEAM_GATHER_START_IN_2", &"TEAM_GATHER_START_IN_3", &"TEAM_GATHER_START_IN_4", &"TEAM_GATHER_START_IN_5", &"TEAM_GATHER_START_IN_6", &"TEAM_GATHER_START_IN_7", &"TEAM_GATHER_START_IN_8", &"TEAM_GATHER_START_IN_9", &"TEAM_GATHER_START_IN_10" );
        
        while ( !is_teamgather_complete() )
        {
            gathered_hud_elem settext( &"TEAM_GATHER_NUM_PLAYERS", int( self.m_num_players_ready ), int( self.m_num_players ) );
            time_remaining = get_time_remaining_in_seconds();
            start_in_hud_elem settext( a_start_in[ time_remaining ] );
            
            if ( isdefined( e_player.in_gather_position ) && e_player.in_gather_position )
            {
                go_hud_elem settext( "" );
            }
            else
            {
                go_hud_elem settext( &"TEAM_GATHER_HOLD_TO_GO_NOW" );
            }
            
            wait 0.05;
        }
        
        starting_hud_elem destroy();
        gathered_hud_elem destroy();
        start_in_hud_elem destroy();
        go_hud_elem destroy();
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x5a0c539c, Offset: 0x1bb0
    // Size: 0x2ec
    function display_hud_player_leader( e_player )
    {
        e_player endon( #"disconnect" );
        y_start = 180;
        x_off = 0;
        y_off = y_start;
        gather_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, &"TEAM_GATHER_TEAM_STEALTH_ENTER" );
        x_off = 0;
        y_off = y_start + 100;
        ready_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        x_off = -45;
        y_off = y_start + 130;
        execute_hud_elem = e_player __create_client_hud_elem( "left", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, "" );
        a_time_remaining = array( "0", &"TEAM_GATHER_TIME_REMAINING_1", &"TEAM_GATHER_TIME_REMAINING_2", &"TEAM_GATHER_TIME_REMAINING_3", &"TEAM_GATHER_TIME_REMAINING_4", &"TEAM_GATHER_TIME_REMAINING_5", &"TEAM_GATHER_TIME_REMAINING_6", &"TEAM_GATHER_TIME_REMAINING_7", &"TEAM_GATHER_TIME_REMAINING_8", &"TEAM_GATHER_TIME_REMAINING_9", &"TEAM_GATHER_TIME_REMAINING_10" );
        
        while ( !is_teamgather_complete() )
        {
            ready_hud_elem settext( &"TEAM_GATHER_PLAYERS_READY", self.m_num_players_ready, self.m_num_players );
            time_remaining = get_time_remaining_in_seconds();
            execute_hud_elem settext( a_time_remaining[ time_remaining ] );
            wait 0.05;
        }
        
        gather_hud_elem destroy();
        ready_hud_elem destroy();
        execute_hud_elem destroy();
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0xd45779a8, Offset: 0x1850
    // Size: 0x354
    function teleport_player_into_position( e_player )
    {
        a_players = get_players_playing();
        
        while ( true )
        {
            x_offset = randomfloatrange( ( 210 - 42 ) * -1, 210 - 42 );
            y_offset = randomfloatrange( ( 210 - 42 ) * -1, 210 - 42 );
            e_player.zoom_pos = ( self.m_v_gather_position[ 0 ] + x_offset, self.m_v_gather_position[ 1 ] + y_offset, self.m_v_gather_position[ 2 ] );
            reject = 0;
            
            for ( i = 0; i < a_players.size ; i++ )
            {
                if ( e_player != a_players[ i ] )
                {
                    dist = distance2d( e_player.origin, a_players[ i ].origin );
                    
                    if ( dist < 84 )
                    {
                        reject = 1;
                        break;
                    }
                }
            }
            
            if ( !reject )
            {
                v_forward = anglestoforward( self.m_v_interact_angles );
                v_dir = vectornormalize( e_player.zoom_pos - self.m_v_interact_position );
                dp = vectordot( v_forward, v_dir );
                
                if ( dp > -0.5 )
                {
                    reject = 1;
                }
            }
            
            if ( reject )
            {
                break;
            }
            
            if ( !positionwouldtelefrag( e_player.zoom_pos ) )
            {
                break;
            }
        }
        
        e_player setorigin( e_player.zoom_pos );
        v0 = ( self.m_v_interact_position[ 0 ], self.m_v_interact_position[ 1 ], self.m_v_interact_position[ 2 ] );
        v1 = ( e_player.zoom_pos[ 0 ], e_player.zoom_pos[ 1 ], self.m_v_interact_position[ 2 ] );
        v_dir = vectornormalize( v0 - v1 );
        v_angles = vectortoangles( v_dir );
        e_player setplayerangles( v_angles );
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0xc6eaad37, Offset: 0x1808
    // Size: 0x3c
    function team_member_zoom_button_check( e_player )
    {
        if ( e_player usebuttonpressed() )
        {
            teleport_player_into_position( e_player );
        }
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x492ec5ea, Offset: 0x1788
    // Size: 0x74
    function player_lowready_state( lower_weapon )
    {
        if ( lower_weapon )
        {
            if ( self util::isweaponenabled() )
            {
                self util::_disableweapon();
            }
            
            return;
        }
        
        if ( !self util::isweaponenabled() )
        {
            self util::_enableweapon();
        }
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x7a97be5a, Offset: 0x15c8
    // Size: 0x1b2
    function is_player_in_gather_position( e_player )
    {
        player_valid = 1;
        n_dist = distance2d( e_player.origin, self.m_v_gather_position );
        
        if ( n_dist > 210 )
        {
            player_valid = 0;
        }
        else
        {
            v_start_pos = ( e_player.origin[ 0 ], e_player.origin[ 1 ], e_player.origin[ 2 ] + 32 );
            v_end_pos = ( self.m_v_gather_position[ 0 ], self.m_v_gather_position[ 1 ], self.m_v_gather_position[ 2 ] );
            
            if ( e_player.origin[ 2 ] - v_end_pos[ 2 ] < -64 )
            {
                player_valid = 0;
            }
            
            v_trace = bullettrace( v_start_pos, v_end_pos, 0, undefined );
            v_trace_pos = v_trace[ "position" ];
            dz = abs( v_trace_pos[ 2 ] - self.m_v_gather_position[ 2 ] );
            
            if ( dz > 64 )
            {
                player_valid = 0;
            }
        }
        
        return player_valid;
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x82001d62, Offset: 0x1408
    // Size: 0x1b6
    function update_players_in_radius( force_player_into_position )
    {
        a_players = get_players_playing();
        self.m_num_players = a_players.size;
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            a_players[ i ].in_gather_position = undefined;
        }
        
        self.m_num_players_ready = 0;
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            e_player.in_gather_position = is_player_in_gather_position( e_player );
            
            if ( isdefined( force_player_into_position ) && force_player_into_position && !( isdefined( e_player.in_gather_position ) && e_player.in_gather_position ) )
            {
                teleport_player_into_position( e_player );
            }
            
            if ( isdefined( e_player.in_gather_position ) && e_player.in_gather_position )
            {
                e_player player_lowready_state( 1 );
                self.m_num_players_ready++;
                continue;
            }
            
            e_player player_lowready_state( 0 );
            
            if ( e_player != self.m_e_player_leader )
            {
                team_member_zoom_button_check( e_player );
            }
        }
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x2f62d74e, Offset: 0x1370
    // Size: 0x8c, Type: bool
    function players_in_position( in_position )
    {
        if ( isdefined( in_position ) && in_position )
        {
            if ( !isdefined( self.in_position_start_time ) )
            {
                self.in_position_start_time = gettime();
            }
            
            time = gettime();
            dt = ( time - self.in_position_start_time ) / 1000;
            
            if ( dt >= 0 )
            {
                return true;
            }
        }
        else
        {
            in_position_start_time = undefined;
        }
        
        return false;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xa39f96af, Offset: 0x1170
    // Size: 0x1f2
    function teamgather_main_update()
    {
        while ( !is_teamgather_complete() )
        {
            update_players_in_radius( 0 );
            
            if ( self.m_num_players_ready == 0 )
            {
                set_teamgather_complete( 0 );
                break;
            }
            
            if ( self.m_num_players > 0 && self.m_num_players_ready >= self.m_num_players )
            {
                if ( players_in_position( 1 ) )
                {
                    set_teamgather_complete( 1 );
                    break;
                }
            }
            else
            {
                players_in_position( 0 );
            }
            
            time_remaining = get_time_remaining();
            
            if ( time_remaining <= 0 )
            {
                set_teamgather_complete( 1 );
                break;
            }
            
            wait 0.05;
        }
        
        if ( self.m_success == 1 )
        {
            update_players_in_radius( 1 );
        }
        
        a_players = get_players_playing();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            
            if ( isdefined( e_player.in_gather_position ) && e_player.in_gather_position )
            {
                e_player util::_enableweapon();
            }
            
            e_player.in_gather_position = undefined;
        }
        
        return self.m_success;
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0x84696ff8, Offset: 0x1140
    // Size: 0x24
    function set_teamgather_complete( success )
    {
        self.m_teamgather_complete = 1;
        self.m_success = success;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0x6902c4b5, Offset: 0x1128
    // Size: 0xa
    function is_teamgather_complete()
    {
        return self.m_teamgather_complete;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xde8e0f5f, Offset: 0x1060
    // Size: 0xbe
    function create_player_huds()
    {
        a_players = get_players_playing();
        
        if ( a_players.size <= 1 )
        {
            return;
        }
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            
            if ( e_player == self.m_e_player_leader )
            {
                self thread display_hud_player_leader( e_player );
                continue;
            }
            
            self thread display_hud_player_team_member( e_player );
        }
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0x4bc46af0, Offset: 0x1008
    // Size: 0x4c
    function gather_players()
    {
        start_player_timer( 10 );
        create_player_huds();
        b_success = teamgather_main_update();
        return b_success;
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0xea81b126, Offset: 0xf88
    // Size: 0x74
    function interact_entity_highlight( highlight_object )
    {
        if ( isdefined( self.m_e_interact_entity ) )
        {
            if ( isdefined( highlight_object ) && highlight_object )
            {
                self.m_e_interact_entity clientfield::set( "teamgather_material", 1 );
                return;
            }
            
            self.m_e_interact_entity clientfield::set( "teamgather_material", 0 );
        }
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0x9ab9bf60, Offset: 0xf38
    // Size: 0x48
    function cleanup_floor_effect()
    {
        if ( !( isdefined( 0 ) && 0 ) )
        {
            return;
        }
        
        if ( isdefined( self.m_gather_fx ) )
        {
            self.m_gather_fx delete();
            self.m_gather_fx = undefined;
        }
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xd8e157f3, Offset: 0xe20
    // Size: 0x10c
    function spawn_floor_effect()
    {
        if ( !( isdefined( 0 ) && 0 ) )
        {
            return;
        }
        
        v_pos = self.m_v_gather_position;
        v_start = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] + 20 );
        v_end = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] - 94 );
        trace = bullettrace( v_start, v_end, 0, undefined );
        v_floor_pos = trace[ "position" ];
        self.m_gather_fx = spawnfx( "_t6/misc/fx_ui_flagbase_pmc", v_floor_pos );
        triggerfx( self.m_gather_fx );
    }

    // Namespace cteamgather
    // Params 1
    // Checksum 0xb2fa7dc5, Offset: 0xde8
    // Size: 0x2e
    function onusegameobject( player )
    {
        self.c_teamgather.m_e_player_leader = player;
        self notify( #"player_interaction" );
    }

    // Namespace cteamgather
    // Params 4
    // Checksum 0xaaac6ce8, Offset: 0xa78
    // Size: 0x368
    function setup_gameobject( v_pos, str_model, str_use_hint, e_los_ignore_me )
    {
        n_radius = 48;
        e_trigger = spawn( "trigger_radius_use", v_pos, 0, n_radius, 30 );
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger setteamfortrigger( "none" );
        e_trigger usetriggerrequirelookat();
        e_trigger setcursorhint( "HINT_NOICON" );
        gobj_model_offset = ( 0, 0, 0 );
        
        if ( isdefined( str_model ) )
        {
            gobj_visuals[ 0 ] = spawn( "script_model", v_pos + gobj_model_offset );
            gobj_visuals[ 0 ] setmodel( str_model );
        }
        else
        {
            gobj_visuals = [];
        }
        
        gobj_objective_name = undefined;
        gobj_team = "allies";
        gobj_trigger = e_trigger;
        gobj_offset = ( 0, 0, -5 );
        e_object = gameobjects::create_use_object( gobj_team, gobj_trigger, gobj_visuals, gobj_offset, gobj_objective_name );
        e_object gameobjects::allow_use( "any" );
        e_object gameobjects::set_use_time( 0 );
        e_object gameobjects::set_use_text( "" );
        e_object gameobjects::set_use_hint_text( str_use_hint );
        e_object gameobjects::set_visible_team( "any" );
        e_object.onuse = &onusegameobject;
        e_object gameobjects::set_3d_icon( "friendly", "T7_hud_prompt_press_64" );
        e_object gameobjects::set_3d_icon( "enemy", "T7_hud_prompt_press_64" );
        e_object gameobjects::set_2d_icon( "friendly", "T7_hud_prompt_press_64" );
        e_object gameobjects::set_2d_icon( "enemy", "T7_hud_prompt_press_64" );
        e_object thread gameobjects::hide_icon_distance_and_los( ( 1, 1, 1 ), 840, 1, e_los_ignore_me );
        return e_object;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0x577e6d7d, Offset: 0x930
    // Size: 0x13e
    function teamgather_failure()
    {
        x_off = 0;
        y_off = 180;
        a_players = get_players_playing();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            e_player.failure_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, &"TEAM_GATHER_TEAM_EVENT_ABORTED" );
        }
        
        wait 0;
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            e_player.failure_hud_elem destroy();
        }
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xc0fe96ea, Offset: 0x7e0
    // Size: 0x146
    function teamgather_success()
    {
        if ( 0 > 0 )
        {
            x_off = 0;
            y_off = 180;
            a_players = get_players_playing();
            
            for ( i = 0; i < a_players.size ; i++ )
            {
                e_player = a_players[ i ];
                e_player.success_hud_elem = e_player __create_client_hud_elem( "center", "middle", "center", "top", x_off, y_off, self.n_font_scale, self.v_font_color, &"TEAM_GATHER_GATHER_SUCCESS" );
            }
            
            wait 0;
            
            for ( i = 0; i < a_players.size ; i++ )
            {
                e_player = a_players[ i ];
                e_player.success_hud_elem destroy();
            }
        }
    }

    // Namespace cteamgather
    // Params 4
    // Checksum 0x88adeee4, Offset: 0x660
    // Size: 0x178
    function create_teamgather_event( v_interact_pos, v_interact_angles, v_gather_pos, e_interact_entity )
    {
        self.m_v_interact_position = v_interact_pos;
        self.m_v_interact_angles = v_interact_angles;
        self.m_e_interact_entity = e_interact_entity;
        self.m_v_gather_position = v_gather_pos;
        self.e_gameobject = setup_gameobject( v_interact_pos, undefined, &"TEAM_GATHER_HOLD_FOR_TEAM_ENTER", self.m_e_interact_entity );
        self.e_gameobject.c_teamgather = self;
        self.e_gameobject waittill( #"player_interaction" );
        self.e_gameobject gameobjects::disable_object();
        spawn_floor_effect();
        interact_entity_highlight( 1 );
        b_success = gather_players();
        cleanup_floor_effect();
        interact_entity_highlight( 0 );
        
        if ( isdefined( b_success ) && b_success )
        {
            teamgather_success();
        }
        else
        {
            teamgather_failure();
        }
        
        return b_success;
    }

    // Namespace cteamgather
    // Params 0
    // Checksum 0xfcafa201, Offset: 0x620
    // Size: 0x34
    function cleanup()
    {
        cleanup_floor_effect();
        self.e_gameobject gameobjects::destroy_object( 1, 1 );
    }

}

// Namespace teamgather
// Params 3
// Checksum 0x1e8f92ba, Offset: 0x2c30
// Size: 0x1c4
function setup_teamgather( v_interact_pos, v_interact_angles, e_interact_entity )
{
    v_forward = anglestoforward( v_interact_angles );
    v_gather_pos = v_interact_pos + v_forward * -100;
    v_start = ( v_gather_pos[ 0 ], v_gather_pos[ 1 ], v_gather_pos[ 2 ] + 20 );
    v_end = ( v_gather_pos[ 0 ], v_gather_pos[ 1 ], v_gather_pos[ 2 ] - 100 );
    v_trace = bullettrace( v_start, v_end, 0, undefined );
    v_floor_pos = v_trace[ "position" ];
    v_gather_pos = ( v_gather_pos[ 0 ], v_gather_pos[ 1 ], v_floor_pos[ 2 ] + 10 );
    c_teamgather = new cteamgather();
    success = [[ c_teamgather ]]->create_teamgather_event( v_interact_pos, v_interact_angles, v_gather_pos, e_interact_entity );
    
    if ( success )
    {
        e_player = c_teamgather.m_e_player_leader;
    }
    else
    {
        e_player = undefined;
    }
    
    [[ c_teamgather ]]->cleanup();
    return e_player;
}

// Namespace teamgather
// Params 2
// Checksum 0xe9e65ecd, Offset: 0x2e00
// Size: 0x68
function mike_debug_line( v1, v2 )
{
    level notify( #"hash_62ab67ff" );
    self endon( #"hash_62ab67ff" );
    
    while ( true )
    {
        /#
            line( v1, v2, ( 0, 0, 1 ) );
        #/
        
        wait 0.1;
    }
}

