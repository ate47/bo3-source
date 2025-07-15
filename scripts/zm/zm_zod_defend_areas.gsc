#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_util;

#namespace zm_zod_defend_areas;

// Namespace zm_zod_defend_areas
// Method(s) 36 Total 36
class careadefend
{

    // Namespace careadefend
    // Params 0
    // Checksum 0xafc1ab88, Offset: 0x25c8
    // Size: 0x35c
    function function_a5e2032d()
    {
        var_7591ca03 = zm_zonemgr::get_zone_from_position( self.m_s_centerpoint.origin );
        
        if ( issubstr( var_7591ca03, "burlesque" ) )
        {
            var_b42fba6b = "burlesque";
        }
        else if ( issubstr( var_7591ca03, "gym" ) )
        {
            var_b42fba6b = "gym";
        }
        else if ( issubstr( var_7591ca03, "brothel" ) )
        {
            var_b42fba6b = "brothel";
        }
        else if ( issubstr( var_7591ca03, "magician" ) )
        {
            var_b42fba6b = "magician";
        }
        else
        {
            var_b42fba6b = "pap";
        }
        
        var_b5a606c0 = [];
        
        foreach ( str_zone_name in level.active_zone_names )
        {
            if ( issubstr( str_zone_name, var_b42fba6b ) )
            {
                if ( !isdefined( var_b5a606c0 ) )
                {
                    var_b5a606c0 = [];
                }
                else if ( !isarray( var_b5a606c0 ) )
                {
                    var_b5a606c0 = array( var_b5a606c0 );
                }
                
                var_b5a606c0[ var_b5a606c0.size ] = str_zone_name;
            }
        }
        
        a_ai_zombies = getaiteamarray( level.zombie_team );
        a_ai_zombies = arraysort( a_ai_zombies, self.m_s_centerpoint.origin );
        i = 0;
        
        while ( i < a_ai_zombies.size )
        {
            var_31a4faf3 = 0;
            
            foreach ( var_7da234a9 in var_b5a606c0 )
            {
                if ( a_ai_zombies[ i ] zm_zonemgr::entity_in_zone( var_7da234a9 ) )
                {
                    var_31a4faf3 = 1;
                    i++;
                    break;
                }
            }
            
            if ( !var_31a4faf3 )
            {
                arrayremovevalue( a_ai_zombies, a_ai_zombies[ i ] );
            }
        }
        
        return a_ai_zombies;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x4378e3f1, Offset: 0x2240
    // Size: 0x37a
    function ritual_nuke()
    {
        level lui::screen_flash( 0.2, 0.5, 1, 0.8, "white" );
        wait 0.2;
        a_ai_zombies = function_a5e2032d();
        var_6b1085eb = [];
        
        foreach ( ai_zombie in a_ai_zombies )
        {
            if ( isdefined( ai_zombie.ignore_nuke ) && ai_zombie.ignore_nuke )
            {
                continue;
            }
            
            if ( isdefined( ai_zombie.marked_for_death ) && ai_zombie.marked_for_death )
            {
                continue;
            }
            
            if ( isdefined( ai_zombie.nuke_damage_func ) )
            {
                ai_zombie thread [[ ai_zombie.nuke_damage_func ]]();
                continue;
            }
            
            if ( zm_utility::is_magic_bullet_shield_enabled( ai_zombie ) )
            {
                continue;
            }
            
            ai_zombie.marked_for_death = 1;
            ai_zombie.nuked = 1;
            var_6b1085eb[ var_6b1085eb.size ] = ai_zombie;
        }
        
        foreach ( i, var_f92b3d80 in var_6b1085eb )
        {
            if ( !isdefined( var_f92b3d80 ) )
            {
                continue;
            }
            
            if ( zm_utility::is_magic_bullet_shield_enabled( var_f92b3d80 ) )
            {
                continue;
            }
            
            if ( i < 5 && !( isdefined( var_f92b3d80.isdog ) && var_f92b3d80.isdog ) )
            {
                var_f92b3d80 thread zombie_death::flame_death_fx();
            }
            
            if ( !( isdefined( var_f92b3d80.isdog ) && var_f92b3d80.isdog ) )
            {
                if ( !( isdefined( var_f92b3d80.no_gib ) && var_f92b3d80.no_gib ) )
                {
                    var_f92b3d80 zombie_utility::zombie_head_gib();
                }
            }
            
            var_f92b3d80 dodamage( var_f92b3d80.health, var_f92b3d80.origin );
            
            if ( !level flag::get( "special_round" ) )
            {
                if ( var_f92b3d80.archetype == "margwa" )
                {
                    level.var_e0191376++;
                    continue;
                }
                
                level.zombie_total++;
            }
        }
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x835059c9, Offset: 0x2150
    // Size: 0xe2
    function reset_hud( player )
    {
        if ( isdefined( player ) && player.sessionstate === "spectator" )
        {
            return;
        }
        
        if ( isdefined( player ) && isdefined( player.defend_area_luimenu_status ) )
        {
            progress_menu_status = player getluimenu( self.m_str_luimenu_progress );
            return_menu_status = player getluimenu( self.m_str_luimenu_return );
            
            if ( isdefined( progress_menu_status ) || isdefined( return_menu_status ) )
            {
                player closeluimenu( player.defend_area_luimenu_status );
                player.defend_area_luimenu_status = undefined;
            }
        }
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x6908aeeb, Offset: 0x20d8
    // Size: 0x6c
    function defend_failed_hud( player )
    {
        self reset_hud( player );
        
        if ( isdefined( player ) && player.sessionstate === "spectator" )
        {
            return;
        }
        
        wait 3;
        self reset_hud( player );
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x30a4562c, Offset: 0x2050
    // Size: 0x7c
    function defend_succeeded_hud( player )
    {
        self reset_hud( player );
        
        if ( isdefined( player ) && isdefined( player.sessionstate ) && player.sessionstate == "spectator" )
        {
            return;
        }
        
        wait 3;
        self reset_hud( player );
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0xc02b5adb, Offset: 0x2038
    // Size: 0x10
    function get_current_progress()
    {
        return self.m_n_defend_current_progress / 100;
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x6ded2910, Offset: 0x1f28
    // Size: 0x102
    function is_player_in_defend_area( player )
    {
        if ( isdefined( self.m_e_defend_volume ) )
        {
            if ( zm_utility::is_player_valid( player, 1, 1 ) && player istouching( self.m_e_defend_volume ) )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        
        if ( zm_utility::is_player_valid( player, 1, 1 ) && distance2dsquared( player.origin, self.m_s_centerpoint.origin ) < self.m_n_defend_radius_sq && player.origin[ 2 ] > self.m_s_centerpoint.origin[ 2 ] + -20 )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x1a05b52f, Offset: 0x1e48
    // Size: 0xd6
    function get_players_in_defend_area()
    {
        a_players_in_defend_area = [];
        
        foreach ( player in level.activeplayers )
        {
            if ( zm_utility::is_player_valid( player ) && is_player_in_defend_area( player ) )
            {
                array::add( a_players_in_defend_area, player );
            }
        }
        
        return a_players_in_defend_area;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x14cbc257, Offset: 0x1e30
    // Size: 0xa
    function get_state()
    {
        return self.m_n_state;
    }

    // Namespace careadefend
    // Params 2
    // Checksum 0x50673fe9, Offset: 0x1de8
    // Size: 0x3a
    function get_progress_rate( n_players_in_defend_area, n_players_total )
    {
        n_current_update_rate = n_players_in_defend_area / n_players_total * self.m_n_defend_progress_per_update_interval;
        return n_current_update_rate;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0xb6c9e505, Offset: 0x1d10
    // Size: 0xca
    function kill_all_defend_event_zombies()
    {
        foreach ( zombie in self.m_a_defend_event_zombies )
        {
            if ( isdefined( zombie.allowdeath ) && isalive( zombie ) && zombie.allowdeath )
            {
                zombie kill();
            }
        }
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x1a3a4bd8, Offset: 0x1bc0
    // Size: 0x148
    function defend_failed()
    {
        println( "<dev string:x111>" );
        self.m_n_state = 1;
        update_usetrigger_hintstring();
        kill_all_defend_event_zombies();
        self.m_e_spawn_points = [];
        self thread populate_spawn_points();
        
        foreach ( player in self.m_a_players_involved )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player thread zm_zod_util::set_rumble_to_player( 0 );
            player.is_in_defend_area = undefined;
            self thread defend_failed_hud( player );
        }
        
        [[ self.m_func_fail ]]( self.m_arg1 );
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x421a8147, Offset: 0x19a0
    // Size: 0x216
    function defend_succeeded()
    {
        println( "<dev string:xf2>" );
        self.m_n_state = 3;
        kill_all_defend_event_zombies();
        
        foreach ( s_spawn_point in self.m_e_spawn_points )
        {
            s_spawn_point delete();
        }
        
        self.m_e_spawn_points = [];
        self thread ritual_nuke();
        zm_unitrigger::unregister_unitrigger( self.m_t_use );
        self.m_t_use = undefined;
        
        foreach ( player in self.m_a_players_involved )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player thread zm_zod_util::set_rumble_to_player( 6 );
            player.is_in_defend_area = undefined;
            self thread defend_succeeded_hud( player );
            player zm_score::add_to_player_score( 500 );
        }
        
        [[ self.m_func_succeed ]]( self.m_arg1, self.m_a_players_involved );
        self notify( #"area_defend_completed" );
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0xa8776fa2, Offset: 0x1850
    // Size: 0x148
    function get_unused_spawn_point()
    {
        a_valid_spawn_points = [];
        
        for ( b_all_points_used = 0; !a_valid_spawn_points.size ; b_all_points_used = 1 )
        {
            foreach ( s_spawn_point in self.m_e_spawn_points )
            {
                if ( !isdefined( s_spawn_point.spawned_zombie ) || b_all_points_used )
                {
                    s_spawn_point.spawned_zombie = 0;
                }
                
                if ( !s_spawn_point.spawned_zombie )
                {
                    array::add( a_valid_spawn_points, s_spawn_point, 0 );
                }
            }
            
            if ( !a_valid_spawn_points.size )
            {
            }
        }
        
        s_spawn_point = array::random( a_valid_spawn_points );
        s_spawn_point.spawned_zombie = 1;
        return s_spawn_point;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x726908e6, Offset: 0x1668
    // Size: 0x1e0
    function function_877a7365()
    {
        self endon( #"death" );
        
        while ( true )
        {
            var_c7ca004c = [];
            
            foreach ( player in level.activeplayers )
            {
                if ( isdefined( player.is_in_defend_area ) && zm_utility::is_player_valid( player ) && player.is_in_defend_area )
                {
                    if ( !isdefined( var_c7ca004c ) )
                    {
                        var_c7ca004c = [];
                    }
                    else if ( !isarray( var_c7ca004c ) )
                    {
                        var_c7ca004c = array( var_c7ca004c );
                    }
                    
                    var_c7ca004c[ var_c7ca004c.size ] = player;
                }
            }
            
            e_target_player = array::random( var_c7ca004c );
            
            while ( isalive( e_target_player ) && !( isdefined( e_target_player.beastmode ) && e_target_player.beastmode ) && !e_target_player laststand::player_is_in_laststand() )
            {
                self setgoal( e_target_player );
                self waittill( #"goal" );
            }
            
            wait 0.1;
        }
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0xdc74743c, Offset: 0x1620
    // Size: 0x3c
    function function_df5ae14e( ai_zombie )
    {
        ai_zombie waittill( #"death" );
        ai_zombie clientfield::set( "keeper_fx", 0 );
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x500ff50d, Offset: 0x1470
    // Size: 0x1a2
    function monitor_defend_event_zombies()
    {
        self.m_a_defend_event_zombies = [];
        
        while ( self.m_n_state == 2 )
        {
            self.m_a_defend_event_zombies = array::remove_dead( self.m_a_defend_event_zombies, 0 );
            n_defend_event_zombie_limit = 4;
            
            if ( level.round_number < 4 )
            {
                n_defend_event_zombie_limit = 6;
            }
            else if ( level.round_number < 6 )
            {
                n_defend_event_zombie_limit = 5;
            }
            
            if ( self.m_a_defend_event_zombies.size < n_defend_event_zombie_limit )
            {
                s_spawn_point = get_unused_spawn_point();
                ai = zombie_utility::spawn_zombie( self.m_a_e_zombie_spawners[ 0 ], "defend_event_zombie", s_spawn_point );
                
                if ( !isdefined( ai ) )
                {
                    println( "<dev string:xbb>" );
                    continue;
                }
                
                ai.var_81ac9e79 = 1;
                ai thread zm_zod_quest::function_2d0c5aa1( s_spawn_point );
                ai thread function_877a7365();
                array::add( self.m_a_defend_event_zombies, ai, 0 );
            }
            
            wait level.zombie_vars[ "zombie_spawn_delay" ];
        }
    }

    // Namespace careadefend
    // Params 2
    // Checksum 0x2d8c6303, Offset: 0x1308
    // Size: 0x15e
    function function_d9a5609b( n_players_total, n_players_in_defend_area )
    {
        if ( n_players_total == 1 )
        {
            return 20;
        }
        
        if ( n_players_total == 2 && n_players_in_defend_area == 1 )
        {
            return 30;
        }
        
        if ( n_players_total == 2 && n_players_in_defend_area == 2 )
        {
            return 20;
        }
        
        if ( n_players_total == 3 && n_players_in_defend_area == 1 )
        {
            return 40;
        }
        
        if ( n_players_total == 3 && n_players_in_defend_area == 2 )
        {
            return 30;
        }
        
        if ( n_players_total == 3 && n_players_in_defend_area == 3 )
        {
            return 20;
        }
        
        if ( n_players_total == 4 && n_players_in_defend_area == 1 )
        {
            return 60;
        }
        
        if ( n_players_total == 4 && n_players_in_defend_area == 2 )
        {
            return 40;
        }
        
        if ( n_players_total == 4 && n_players_in_defend_area == 3 )
        {
            return 30;
        }
        
        if ( n_players_total == 4 && n_players_in_defend_area == 4 )
        {
            return 20;
        }
        
        return 30;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x4eb6c0e1, Offset: 0xef8
    // Size: 0x404
    function progress_think()
    {
        println( "<dev string:x9e>" );
        self.m_n_defend_current_progress = 0;
        self.m_n_defend_grace_remaining = self.m_n_defend_grace_duration;
        self.m_a_players_involved = [];
        var_db69778c = level.activeplayers.size;
        a_players_in_defend_area = get_players_in_defend_area();
        n_players_in_defend_area = a_players_in_defend_area.size;
        self.m_n_defend_duration = function_d9a5609b( var_db69778c, n_players_in_defend_area );
        self.m_n_defend_progress_per_update_interval = 100 / self.m_n_defend_duration * 0.1;
        
        while ( self.m_n_defend_current_progress < 100 && self.m_n_defend_grace_remaining > 0 )
        {
            a_players_in_defend_area = get_players_in_defend_area();
            n_players_in_defend_area = a_players_in_defend_area.size;
            
            foreach ( player in level.activeplayers )
            {
                if ( !zm_utility::is_player_valid( player, 1, 1 ) )
                {
                    continue;
                }
                
                if ( is_player_in_defend_area( player ) )
                {
                    if ( !isdefined( player.is_in_defend_area ) )
                    {
                        player thread zm_zod_util::set_rumble_to_player( 5 );
                        array::add( self.m_a_players_involved, player, 0 );
                        player.is_in_defend_area = 1;
                    }
                    
                    if ( !player.is_in_defend_area )
                    {
                        player thread zm_zod_util::set_rumble_to_player( 5 );
                        player.is_in_defend_area = 1;
                        self reset_hud( player );
                    }
                    
                    continue;
                }
                
                if ( zm_utility::is_player_valid( player, 1, 1 ) )
                {
                    if ( isdefined( player.is_in_defend_area ) && player.is_in_defend_area )
                    {
                        player thread zm_zod_util::set_rumble_to_player( 0 );
                        player.is_in_defend_area = 0;
                        self reset_hud( player );
                        player.defend_area_luimenu_status = player openluimenu( self.m_str_luimenu_return );
                    }
                }
            }
            
            n_current_progress_rate = self.m_n_defend_progress_per_update_interval;
            self.m_n_defend_current_progress += n_current_progress_rate;
            
            if ( n_players_in_defend_area > 0 )
            {
                self.m_n_defend_current_progress = math::clamp( self.m_n_defend_current_progress, 0, 100 );
                self.m_n_defend_grace_remaining = self.m_n_defend_grace_duration;
            }
            else
            {
                self.m_n_defend_grace_remaining -= 0.1;
            }
            
            wait 0.1;
        }
        
        if ( self.m_n_defend_current_progress == 100 )
        {
            defend_succeeded();
            return;
        }
        
        defend_failed();
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x96cccb54, Offset: 0xd90
    // Size: 0x15c
    function usetrigger_think()
    {
        self endon( #"area_defend_completed" );
        
        while ( true )
        {
            self.m_t_use waittill( #"trigger", e_triggerer );
            
            if ( e_triggerer zm_utility::in_revive_trigger() )
            {
                continue;
            }
            
            if ( !zm_utility::is_player_valid( e_triggerer, 1, 1 ) )
            {
                continue;
            }
            
            if ( self.m_n_state != 1 )
            {
                continue;
            }
            
            if ( isdefined( self.m_func_prereq ) && [[ self.m_func_prereq ]]( self.m_arg1 ) == 0 )
            {
                continue;
            }
            
            self.m_n_state = 2;
            self.m_triggerer = e_triggerer;
            update_usetrigger_hintstring();
            [[ self.m_func_start ]]( self.m_arg1, self.m_triggerer );
            self thread progress_think();
            self thread monitor_defend_event_zombies();
            
            while ( self.m_n_state != 1 )
            {
                wait 1;
            }
        }
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0x8f9ff512, Offset: 0xd58
    // Size: 0x2c
    function update_usetrigger_hintstring()
    {
        if ( isdefined( self.m_t_use ) )
        {
            self.m_t_use zm_unitrigger::run_visibility_function_for_all_triggers();
        }
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x391efb7f, Offset: 0xc58
    // Size: 0xf4
    function function_4e035595( player )
    {
        self endon( #"disconnect" );
        
        if ( isdefined( player.var_b999c630 ) && player.var_b999c630 || !level flag::get( "ritual_in_progress" ) )
        {
            return;
        }
        
        player.var_b999c630 = 1;
        
        if ( zm_utility::is_player_valid( player ) )
        {
            player thread zm_zod_util::function_55f114f9( "zmInventory.widget_quest_items", 3.5 );
            player thread zm_zod_util::show_infotext_for_duration( "ZM_ZOD_UI_RITUAL_BUSY", 3.5 );
        }
        
        wait 3.5;
        player.var_b999c630 = 0;
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0xc818e23f, Offset: 0xb90
    // Size: 0xc0
    function ritual_start_prompt_and_visibility( player )
    {
        b_is_visible = [[ self.stub.o_defend_area ]]->ritual_start_visible_internal( player );
        
        if ( b_is_visible )
        {
            str_msg = [[ self.stub.o_defend_area ]]->ritual_start_message_internal( player );
            self sethintstring( str_msg );
            thread function_4e035595( player );
        }
        else
        {
            self sethintstring( &"" );
        }
        
        return b_is_visible;
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x8e2e5971, Offset: 0xaf0
    // Size: 0x98, Type: bool
    function ritual_start_visible_internal( player )
    {
        if ( isdefined( player.beastmode ) && player.beastmode )
        {
            return false;
        }
        
        if ( isdefined( level.var_522a1f61 ) && level.var_522a1f61 )
        {
            return false;
        }
        
        if ( self.m_b_started )
        {
            switch ( self.m_n_state )
            {
                case 0:
                case 1:
                    return true;
                default:
                    break;
            }
        }
        
        return false;
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x27e6d9f, Offset: 0xa80
    // Size: 0x46
    function ritual_start_message_internal( player )
    {
        if ( !self.m_b_started )
        {
            return &"";
        }
        
        switch ( self.m_n_state )
        {
            case 0:
                return self.m_str_area_defend_unavailable;
            case 1:
                return self.m_str_area_defend_available;
            default:
                return &"";
        }
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x2bce6b1e, Offset: 0xa08
    // Size: 0x6c
    function set_availability( b_is_available )
    {
        if ( b_is_available && self.m_n_state == 0 )
        {
            self.m_n_state = 1;
        }
        else if ( !b_is_available && self.m_n_state == 1 )
        {
            self.m_n_state = 0;
        }
        
        update_usetrigger_hintstring();
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0xd8419f75, Offset: 0x938
    // Size: 0xc4
    function start()
    {
        ritual_start_dims = ( 110, 110, 128 );
        self.m_t_use = zm_zod_util::spawn_trigger_box( self.m_s_centerpoint.origin, self.m_s_centerpoint.angles, ritual_start_dims, 1 );
        self.m_t_use.o_defend_area = self;
        self.m_t_use.prompt_and_visibility_func = self.m_func_trigger_visibility;
        self.m_b_started = 1;
        update_usetrigger_hintstring();
        self thread usetrigger_think();
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x82f5a088, Offset: 0x8f8
    // Size: 0x34
    function set_duration( n_duration )
    {
        self.m_n_defend_duration = n_duration;
        self.m_n_defend_progress_per_update_interval = 100 / self.m_n_defend_duration * 0.1;
    }

    // Namespace careadefend
    // Params 2
    // Checksum 0x58cbdd78, Offset: 0x838
    // Size: 0xb4
    function set_volumes( str_defend_volume, str_rumble_volume )
    {
        self.m_e_defend_volume = getent( str_defend_volume, "targetname" );
        self.m_e_rumble_volume = getent( str_rumble_volume, "targetname" );
        assert( isdefined( self.m_e_defend_volume ), "<dev string:x28>" );
        assert( isdefined( self.m_e_rumble_volume ), "<dev string:x63>" );
    }

    // Namespace careadefend
    // Params 4
    // Checksum 0x4d1abdb8, Offset: 0x7d8
    // Size: 0x54
    function set_luimenus( str_luimenu_progress, str_luimenu_return, str_luimenu_succeeded, str_luimenu_failed )
    {
        self.m_str_luimenu_progress = str_luimenu_progress;
        self.m_str_luimenu_return = str_luimenu_return;
        self.m_str_luimenu_succeeded = str_luimenu_succeeded;
        self.m_str_luimenu_failed = str_luimenu_failed;
    }

    // Namespace careadefend
    // Params 5
    // Checksum 0xf7e639a7, Offset: 0x768
    // Size: 0x68
    function set_external_functions( func_prereq, func_start, func_succeed, func_fail, arg1 )
    {
        self.m_func_prereq = func_prereq;
        self.m_func_start = func_start;
        self.m_func_succeed = func_succeed;
        self.m_func_fail = func_fail;
        self.m_arg1 = arg1;
    }

    // Namespace careadefend
    // Params 1
    // Checksum 0x71fd5a1d, Offset: 0x748
    // Size: 0x18
    function set_trigger_visibility_function( func_trigger_visibility )
    {
        self.m_func_trigger_visibility = func_trigger_visibility;
    }

    // Namespace careadefend
    // Params 0
    // Checksum 0xa0dbf1b5, Offset: 0x588
    // Size: 0x1b8
    function populate_spawn_points()
    {
        self.m_a_e_zombie_spawners = getentarray( "ritual_zombie_spawner", "targetname" );
        a_s_spawn_points = struct::get_array( self.m_str_spawn, "targetname" );
        
        foreach ( s_spawn_point in a_s_spawn_points )
        {
            e_deletable_spawn_point = spawn( "script_model", s_spawn_point.origin );
            e_deletable_spawn_point setmodel( "tag_origin" );
            e_deletable_spawn_point.origin = s_spawn_point.origin;
            e_deletable_spawn_point.angles = s_spawn_point.angles;
            
            if ( !isdefined( self.m_e_spawn_points ) )
            {
                self.m_e_spawn_points = [];
            }
            else if ( !isarray( self.m_e_spawn_points ) )
            {
                self.m_e_spawn_points = array( self.m_e_spawn_points );
            }
            
            self.m_e_spawn_points[ self.m_e_spawn_points.size ] = e_deletable_spawn_point;
        }
    }

    // Namespace careadefend
    // Params 2
    // Checksum 0x8ce06dde, Offset: 0x3f8
    // Size: 0x184
    function init( str_centerpoint, str_spawn )
    {
        self.m_s_centerpoint = struct::get( str_centerpoint, "targetname" );
        self.m_str_spawn = str_spawn;
        self.m_n_defend_duration = 30;
        self.m_n_defend_current_progress = 0;
        self.m_n_defend_progress_per_update_interval = 100 / self.m_n_defend_duration * 0.1;
        self.m_n_defend_grace_duration = 5;
        self.m_n_defend_grace_remaining = self.m_n_defend_grace_duration;
        self.m_n_defend_radius = 220;
        self.m_n_defend_radius_sq = self.m_n_defend_radius * self.m_n_defend_radius;
        self.m_n_rumble_radius = self.m_n_defend_radius;
        self.m_n_rumble_radius_sq = self.m_n_rumble_radius * self.m_n_rumble_radius;
        self.m_str_area_defend_unavailable = &"ZM_ZOD_DEFEND_AREA_UNAVAILABLE";
        self.m_str_area_defend_available = &"ZM_ZOD_DEFEND_AREA_AVAILABLE";
        self.m_str_area_defend_in_progress = &"ZM_ZOD_DEFEND_AREA_IN_PROGRESS";
        self.m_func_trigger_visibility = &ritual_start_prompt_and_visibility;
        m_func_trigger_thread = &usetrigger_think;
        populate_spawn_points();
        self.m_n_state = 0;
        self.m_b_started = 0;
        update_usetrigger_hintstring();
    }

}

