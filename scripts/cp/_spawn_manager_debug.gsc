#using scripts/codescripts/struct;
#using scripts/cp/_spawn_manager;
#using scripts/shared/util_shared;

#namespace spawn_manager;

/#

    // Namespace spawn_manager
    // Params 0
    // Checksum 0x446e2b77, Offset: 0xd0
    // Size: 0x220, Type: dev
    function spawn_manager_debug()
    {
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
            {
                wait 0.1;
                continue;
            }
            
            managers = get_spawn_manager_array();
            manageractivecount = 0;
            managerpotentialspawncount = 0;
            level.debugactivemanagers = [];
            
            for ( i = 0; i < managers.size ; i++ )
            {
                if ( isdefined( managers[ i ] ) && isdefined( managers[ i ].enable ) )
                {
                    if ( !managers[ i ].enable && ( managers[ i ].enable || isdefined( managers[ i ].spawners ) ) )
                    {
                        if ( managers[ i ].count < 0 || managers[ i ].count > managers[ i ].spawncount )
                        {
                            if ( managers[ i ].enable && isdefined( managers[ i ].sm_active_count ) )
                            {
                                manageractivecount += 1;
                                managerpotentialspawncount += managers[ i ].sm_active_count;
                            }
                            
                            level.debugactivemanagers[ level.debugactivemanagers.size ] = managers[ i ];
                        }
                    }
                }
            }
            
            spawn_manager_debug_hud_update( level.spawn_manager_active_ai, level.spawn_manager_total_count, level.spawn_manager_max_ai, manageractivecount, managerpotentialspawncount );
            wait 0.05;
        }
    }

    // Namespace spawn_manager
    // Params 5
    // Checksum 0xf3c375e1, Offset: 0x2f8
    // Size: 0x636, Type: dev
    function spawn_manager_debug_hud_update( active_ai, spawn_ai, max_ai, active_managers, potential_ai )
    {
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x3d>" )
        {
            if ( !isdefined( level.spawn_manager_debug_hud_title ) )
            {
                level.spawn_manager_debug_hud_title = newhudelem();
                level.spawn_manager_debug_hud_title.alignx = "<dev string:x3f>";
                level.spawn_manager_debug_hud_title.x = 2;
                level.spawn_manager_debug_hud_title.y = 40;
                level.spawn_manager_debug_hud_title.fontscale = 1.5;
                level.spawn_manager_debug_hud_title.color = ( 1, 1, 1 );
            }
            
            if ( !isdefined( level.spawn_manager_debug_hud ) )
            {
                level.spawn_manager_debug_hud = [];
            }
            
            level.spawn_manager_debug_hud_title settext( "<dev string:x44>" + spawn_ai + "<dev string:x5e>" + active_ai + "<dev string:x6c>" + potential_ai + "<dev string:x6e>" + max_ai + "<dev string:x79>" + active_managers );
            
            for ( i = 0; i < level.debugactivemanagers.size ; i++ )
            {
                if ( !isdefined( level.spawn_manager_debug_hud[ i ] ) )
                {
                    level.spawn_manager_debug_hud[ i ] = newhudelem();
                    level.spawn_manager_debug_hud[ i ].alignx = "<dev string:x3f>";
                    level.spawn_manager_debug_hud[ i ].x = 0;
                    level.spawn_manager_debug_hud[ i ].fontscale = 1;
                    level.spawn_manager_debug_hud[ i ].y = level.spawn_manager_debug_hud_title.y + ( i + 1 ) * 15;
                }
                
                if ( isdefined( level.current_debug_spawn_manager ) && level.debugactivemanagers[ i ] == level.current_debug_spawn_manager )
                {
                    if ( !level.debugactivemanagers[ i ].enable )
                    {
                        level.spawn_manager_debug_hud[ i ].color = ( 0, 0.4, 0 );
                    }
                    else
                    {
                        level.spawn_manager_debug_hud[ i ].color = ( 0, 1, 0 );
                    }
                }
                else if ( level.debugactivemanagers[ i ].enable )
                {
                    level.spawn_manager_debug_hud[ i ].color = ( 1, 1, 1 );
                }
                else
                {
                    level.spawn_manager_debug_hud[ i ].color = ( 0.4, 0.4, 0.4 );
                }
                
                text = "<dev string:x8d>" + level.debugactivemanagers[ i ].sm_id + "<dev string:x8f>";
                text += "<dev string:x91>" + level.debugactivemanagers[ i ].spawncount;
                text += "<dev string:xa6>" + level.debugactivemanagers[ i ].activeai.size + "<dev string:xb7>" + level.debugactivemanagers[ i ].sm_active_count_min + "<dev string:xba>" + level.debugactivemanagers[ i ].sm_active_count_max + "<dev string:xbc>";
                text += "<dev string:xbe>" + level.debugactivemanagers[ i ].allspawners.size;
                
                if ( isdefined( level.debugactivemanagers[ i ].sm_group_size ) )
                {
                    text += "<dev string:xcb>" + level.debugactivemanagers[ i ].sm_group_size + "<dev string:xda>" + level.debugactivemanagers[ i ].sm_group_size_min + "<dev string:xba>" + level.debugactivemanagers[ i ].sm_group_size_max + "<dev string:xbc>";
                }
                
                level.spawn_manager_debug_hud[ i ] settext( text );
            }
            
            if ( level.debugactivemanagers.size < level.spawn_manager_debug_hud.size )
            {
                for ( i = level.debugactivemanagers.size; i < level.spawn_manager_debug_hud.size ; i++ )
                {
                    if ( isdefined( level.spawn_manager_debug_hud[ i ] ) )
                    {
                        level.spawn_manager_debug_hud[ i ] destroy();
                    }
                }
            }
        }
        
        if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
        {
            if ( isdefined( level.spawn_manager_debug_hud_title ) )
            {
                level.spawn_manager_debug_hud_title destroy();
            }
            
            if ( isdefined( level.spawn_manager_debug_hud ) )
            {
                for ( i = 0; i < level.spawn_manager_debug_hud.size ; i++ )
                {
                    if ( isdefined( level.spawn_manager_debug_hud ) && isdefined( level.spawn_manager_debug_hud[ i ] ) )
                    {
                        level.spawn_manager_debug_hud[ i ] destroy();
                    }
                }
                
                level.spawn_manager_debug_hud = undefined;
            }
        }
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0xdf8555b3, Offset: 0x938
    // Size: 0x1c, Type: dev
    function on_player_connect()
    {
        level thread spawn_manager_debug_spawn_manager();
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0xfbf28bc6, Offset: 0x960
    // Size: 0x328, Type: dev
    function spawn_manager_debug_spawn_manager()
    {
        level notify( #"spawn_manager_debug_spawn_manager" );
        level endon( #"spawn_manager_debug_spawn_manager" );
        level.current_debug_spawn_manager = undefined;
        level.current_debug_spawn_manager_targetname = undefined;
        level.test_player = getplayers()[ 0 ];
        current_spawn_manager_index = -1;
        old_spawn_manager_index = undefined;
        
        while ( true )
        {
            if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
            {
                destroy_tweak_hud_elements();
                wait 0.05;
                continue;
            }
            
            if ( isdefined( level.debugactivemanagers ) && level.debugactivemanagers.size > 0 )
            {
                if ( current_spawn_manager_index == -1 )
                {
                    current_spawn_manager_index = 0;
                    old_spawn_manager_index = 0;
                }
                
                if ( level.test_player buttonpressed( "<dev string:xdc>" ) )
                {
                    old_spawn_manager_index = current_spawn_manager_index;
                    
                    if ( level.test_player buttonpressed( "<dev string:xea>" ) )
                    {
                        current_spawn_manager_index--;
                        
                        if ( current_spawn_manager_index < 0 )
                        {
                            current_spawn_manager_index = 0;
                        }
                    }
                    
                    if ( level.test_player buttonpressed( "<dev string:xf2>" ) )
                    {
                        current_spawn_manager_index++;
                        
                        if ( current_spawn_manager_index > level.debugactivemanagers.size - 1 )
                        {
                            current_spawn_manager_index = level.debugactivemanagers.size - 1;
                        }
                    }
                }
                
                if ( isdefined( current_spawn_manager_index ) && current_spawn_manager_index != -1 )
                {
                    if ( isdefined( level.current_debug_spawn_manager ) && isdefined( level.debugactivemanagers[ current_spawn_manager_index ] ) )
                    {
                        if ( isdefined( old_spawn_manager_index ) && old_spawn_manager_index == current_spawn_manager_index )
                        {
                            if ( level.debugactivemanagers[ current_spawn_manager_index ].targetname != level.current_debug_spawn_manager_targetname )
                            {
                                for ( i = 0; i < level.debugactivemanagers.size ; i++ )
                                {
                                    if ( level.debugactivemanagers[ i ].targetname == level.current_debug_spawn_manager_targetname )
                                    {
                                        current_spawn_manager_index = i;
                                        old_spawn_manager_index = i;
                                    }
                                }
                            }
                        }
                    }
                    
                    if ( isdefined( level.debugactivemanagers[ current_spawn_manager_index ] ) )
                    {
                        level.current_debug_spawn_manager = level.debugactivemanagers[ current_spawn_manager_index ];
                        level.current_debug_spawn_manager_targetname = level.debugactivemanagers[ current_spawn_manager_index ].targetname;
                    }
                }
                
                if ( isdefined( level.current_debug_spawn_manager ) )
                {
                    level.current_debug_spawn_manager spawn_manager_debug_spawn_manager_values_dpad();
                }
            }
            else
            {
                destroy_tweak_hud_elements();
            }
            
            wait 0.25;
        }
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0x348bc46b, Offset: 0xc90
    // Size: 0x20c, Type: dev
    function spawn_manager_debug_spawner_values()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
            {
                wait 0.1;
                continue;
            }
            
            if ( isdefined( level.current_debug_spawn_manager ) )
            {
                spawn_manager = level.current_debug_spawn_manager;
                
                if ( isdefined( spawn_manager.spawners ) )
                {
                    for ( i = 0; i < spawn_manager.spawners.size ; i++ )
                    {
                        current_spawner = spawn_manager.spawners[ i ];
                        
                        if ( isdefined( current_spawner ) && current_spawner.count > 0 )
                        {
                            spawnerfree = current_spawner.sm_active_count - current_spawner.activeai.size;
                            print3d( current_spawner.origin + ( 0, 0, 65 ), "<dev string:xfc>" + current_spawner.count, ( 0, 1, 0 ), 1, 1.25, 2 );
                            print3d( current_spawner.origin + ( 0, 0, 85 ), "<dev string:x103>" + current_spawner.activeai.size + "<dev string:x6c>" + spawnerfree + "<dev string:x6c>" + current_spawner.sm_active_count, ( 0, 1, 0 ), 1, 1.25, 2 );
                        }
                    }
                }
                
                wait 0.05;
            }
            
            wait 0.05;
        }
    }

    // Namespace spawn_manager
    // Params 1
    // Checksum 0xa51ca00, Offset: 0xea8
    // Size: 0x78, Type: dev
    function ent_print( text )
    {
        self endon( #"death" );
        
        while ( true )
        {
            print3d( self.origin + ( 0, 0, 65 ), text, ( 0.48, 9.4, 0.76 ), 1, 1 );
            wait 0.05;
        }
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0xf35deb89, Offset: 0xf28
    // Size: 0xbcc, Type: dev
    function spawn_manager_debug_spawn_manager_values_dpad()
    {
        if ( !isdefined( level.current_debug_index ) )
        {
            level.current_debug_index = 0;
        }
        
        if ( !isdefined( level.spawn_manager_debug_hud2 ) )
        {
            level.spawn_manager_debug_hud2 = newhudelem();
            level.spawn_manager_debug_hud2.alignx = "<dev string:x3f>";
            level.spawn_manager_debug_hud2.x = 10;
            level.spawn_manager_debug_hud2.y = 150;
            level.spawn_manager_debug_hud2.fontscale = 1.25;
            level.spawn_manager_debug_hud2.color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( level.sm_active_count_title ) )
        {
            level.sm_active_count_title = newhudelem();
            level.sm_active_count_title.alignx = "<dev string:x3f>";
            level.sm_active_count_title.x = 10;
            level.sm_active_count_title.y = 165;
            level.sm_active_count_title.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_active_count_min_hud ) )
        {
            level.sm_active_count_min_hud = newhudelem();
            level.sm_active_count_min_hud.alignx = "<dev string:x3f>";
            level.sm_active_count_min_hud.x = 10;
            level.sm_active_count_min_hud.y = 180;
            level.sm_active_count_min_hud.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_active_count_max_hud ) )
        {
            level.sm_active_count_max_hud = newhudelem();
            level.sm_active_count_max_hud.alignx = "<dev string:x3f>";
            level.sm_active_count_max_hud.x = 10;
            level.sm_active_count_max_hud.y = 195;
            level.sm_active_count_max_hud.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_group_size_min_hud ) )
        {
            level.sm_group_size_min_hud = newhudelem();
            level.sm_group_size_min_hud.alignx = "<dev string:x3f>";
            level.sm_group_size_min_hud.x = 10;
            level.sm_group_size_min_hud.y = 210;
            level.sm_group_size_min_hud.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_group_size_max_hud ) )
        {
            level.sm_group_size_max_hud = newhudelem();
            level.sm_group_size_max_hud.alignx = "<dev string:x3f>";
            level.sm_group_size_max_hud.x = 10;
            level.sm_group_size_max_hud.y = 225;
            level.sm_group_size_max_hud.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_spawner_count_title ) )
        {
            level.sm_spawner_count_title = newhudelem();
            level.sm_spawner_count_title.alignx = "<dev string:x3f>";
            level.sm_spawner_count_title.x = 10;
            level.sm_spawner_count_title.y = 240;
            level.sm_spawner_count_title.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_spawner_count_min_hud ) )
        {
            level.sm_spawner_count_min_hud = newhudelem();
            level.sm_spawner_count_min_hud.alignx = "<dev string:x3f>";
            level.sm_spawner_count_min_hud.x = 10;
            level.sm_spawner_count_min_hud.y = 255;
            level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( level.sm_spawner_count_max_hud ) )
        {
            level.sm_spawner_count_max_hud = newhudelem();
            level.sm_spawner_count_max_hud.alignx = "<dev string:x3f>";
            level.sm_spawner_count_max_hud.x = 10;
            level.sm_spawner_count_max_hud.y = 270;
            level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
        }
        
        if ( level.test_player buttonpressed( "<dev string:x114>" ) )
        {
            if ( level.test_player buttonpressed( "<dev string:xf2>" ) )
            {
                level.current_debug_index++;
                
                if ( level.current_debug_index > 7 )
                {
                    level.current_debug_index = 7;
                }
            }
            
            if ( level.test_player buttonpressed( "<dev string:xea>" ) )
            {
                level.current_debug_index--;
                
                if ( level.current_debug_index < 0 )
                {
                    level.current_debug_index = 0;
                }
            }
        }
        
        set_debug_hud_colors();
        increase_value = 0;
        decrease_value = 0;
        
        if ( level.test_player buttonpressed( "<dev string:x114>" ) )
        {
            if ( level.test_player buttonpressed( "<dev string:x121>" ) )
            {
                decrease_value = 1;
            }
            
            if ( level.test_player buttonpressed( "<dev string:x12b>" ) )
            {
                increase_value = 1;
            }
        }
        
        should_run_set_up = 0;
        
        if ( increase_value || decrease_value )
        {
            if ( increase_value )
            {
                add = 1;
            }
            else
            {
                add = -1;
            }
            
            switch ( level.current_debug_index )
            {
                case 0:
                    if ( self.sm_active_count + add > self.sm_active_count_max )
                    {
                        self.sm_active_count_max = self.sm_active_count + add;
                    }
                    
                    if ( self.sm_active_count + add < self.sm_active_count_min )
                    {
                        if ( self.sm_active_count + add > 0 )
                        {
                            self.sm_active_count_min = self.sm_active_count + add;
                        }
                    }
                    
                    should_run_set_up = 1;
                    self.sm_active_count += add;
                    break;
                case 1:
                    if ( self.sm_active_count_min + add < self.sm_group_size_max )
                    {
                        modify_debug_hud2( "<dev string:x136>" );
                        break;
                    }
                    
                    if ( self.sm_active_count_min + add > self.sm_active_count_max )
                    {
                        modify_debug_hud2( "<dev string:x19a>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_active_count_min += add;
                    break;
                case 2:
                    if ( self.sm_active_count_max + add < self.sm_active_count_min )
                    {
                        modify_debug_hud2( "<dev string:x202>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_active_count_max += add;
                    break;
                case 3:
                    if ( self.sm_group_size_min + add > self.sm_group_size_max )
                    {
                        modify_debug_hud2( "<dev string:x26a>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_group_size_min += add;
                    break;
                case 4:
                    if ( self.sm_group_size_max + add < self.sm_group_size_min )
                    {
                        modify_debug_hud2( "<dev string:x2cc>" );
                        break;
                    }
                    
                    if ( self.sm_group_size_max + add > self.sm_active_count )
                    {
                        modify_debug_hud2( "<dev string:x32e>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_group_size_max += add;
                    break;
                case 5:
                    if ( self.sm_spawner_count + add > self.allspawners.size )
                    {
                        modify_debug_hud2( "<dev string:x38c>" );
                        break;
                    }
                    
                    if ( self.sm_spawner_count + add <= 0 )
                    {
                        modify_debug_hud2( "<dev string:x3ff>" );
                        break;
                    }
                    
                    if ( self.sm_spawner_count + add < self.sm_spawner_count_min )
                    {
                        if ( self.sm_spawner_count + add > 0 )
                        {
                            self.sm_spawner_count_min = self.sm_spawner_count + add;
                        }
                    }
                    
                    if ( self.sm_spawner_count + add > self.sm_spawner_count_max )
                    {
                        self.sm_spawner_count_max = self.sm_spawner_count + add;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_spawner_count += add;
                    break;
                case 6:
                    if ( self.sm_spawner_count_min + add > self.sm_spawner_count_max )
                    {
                        modify_debug_hud2( "<dev string:x425>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_spawner_count_min += add;
                    break;
                case 7:
                    if ( self.sm_spawner_count_max + add < self.sm_spawner_count_min )
                    {
                        modify_debug_hud2( "<dev string:x490>" );
                        break;
                    }
                    
                    should_run_set_up = 1;
                    self.sm_spawner_count_max += add;
                    break;
            }
        }
        
        if ( should_run_set_up )
        {
            level.current_debug_spawn_manager spawn_manager_debug_setup();
        }
        
        if ( isdefined( self ) )
        {
            level.sm_active_count_min_hud settext( "<dev string:x4fb>" + self.sm_active_count_min );
            level.sm_active_count_max_hud settext( "<dev string:x511>" + self.sm_active_count_max );
            level.sm_group_size_min_hud settext( "<dev string:x527>" + self.sm_group_size_min );
            level.sm_group_size_max_hud settext( "<dev string:x53c>" + self.sm_group_size_max );
            
            if ( isdefined( self.sm_spawner_count ) )
            {
                level.sm_spawner_count_title settext( "<dev string:x551>" + self.sm_spawner_count );
                level.sm_spawner_count_min_hud settext( "<dev string:x564>" + self.sm_spawner_count_min );
                level.sm_spawner_count_max_hud settext( "<dev string:x57b>" + self.sm_spawner_count_max );
            }
        }
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0x4c007a0d, Offset: 0x1b00
    // Size: 0x57e, Type: dev
    function set_debug_hud_colors()
    {
        switch ( level.current_debug_index )
        {
            case 0:
                level.sm_active_count_title.color = ( 0, 1, 0 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 1:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 0, 1, 0 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 2:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 0, 1, 0 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 3:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 0, 1, 0 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 4:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 0, 1, 0 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 5:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 0, 1, 0 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 6:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 0, 1, 0 );
                level.sm_spawner_count_max_hud.color = ( 1, 1, 1 );
                break;
            case 7:
                level.sm_active_count_title.color = ( 1, 1, 1 );
                level.sm_active_count_min_hud.color = ( 1, 1, 1 );
                level.sm_active_count_max_hud.color = ( 1, 1, 1 );
                level.sm_group_size_min_hud.color = ( 1, 1, 1 );
                level.sm_group_size_max_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_title.color = ( 1, 1, 1 );
                level.sm_spawner_count_min_hud.color = ( 1, 1, 1 );
                level.sm_spawner_count_max_hud.color = ( 0, 1, 0 );
                break;
        }
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0x6ade33d8, Offset: 0x2088
    // Size: 0x1ac, Type: dev
    function spawn_manager_debug_setup()
    {
        if ( isdefined( level.current_debug_index ) && level.current_debug_index != 5 )
        {
            self.sm_spawner_count = randomintrange( self.sm_spawner_count_min, self.sm_spawner_count_max + 1 );
        }
        
        if ( isdefined( level.current_debug_index ) && level.current_debug_index != 0 )
        {
            self.sm_active_count = randomintrange( self.sm_active_count_min, self.sm_active_count_max + 1 );
        }
        
        self.spawners = self spawn_manager_get_spawners();
        assert( self.count >= self.count_min );
        assert( self.count <= self.count_max );
        assert( self.sm_active_count >= self.sm_active_count_min );
        assert( self.sm_active_count <= self.sm_active_count_max );
        assert( self.sm_group_size_max <= self.sm_active_count );
        assert( self.sm_group_size_min <= self.sm_active_count );
    }

    // Namespace spawn_manager
    // Params 1
    // Checksum 0x35a09932, Offset: 0x2240
    // Size: 0x5c, Type: dev
    function modify_debug_hud2( text )
    {
        self notify( #"modified" );
        wait 0.05;
        level.spawn_manager_debug_hud2 settext( text );
        level.spawn_manager_debug_hud2 thread moniter_debug_hud2();
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0xce440999, Offset: 0x22a8
    // Size: 0x3c, Type: dev
    function moniter_debug_hud2()
    {
        self endon( #"modified" );
        wait 10;
        level.spawn_manager_debug_hud2 settext( "<dev string:x592>" );
    }

    // Namespace spawn_manager
    // Params 0
    // Checksum 0x8e345548, Offset: 0x22f0
    // Size: 0x144, Type: dev
    function destroy_tweak_hud_elements()
    {
        if ( isdefined( level.sm_active_count_title ) )
        {
            level.sm_active_count_title destroy();
        }
        
        if ( isdefined( level.sm_active_count_min_hud ) )
        {
            level.sm_active_count_min_hud destroy();
        }
        
        if ( isdefined( level.sm_active_count_max_hud ) )
        {
            level.sm_active_count_max_hud destroy();
        }
        
        if ( isdefined( level.sm_group_size_min_hud ) )
        {
            level.sm_group_size_min_hud destroy();
        }
        
        if ( isdefined( level.sm_group_size_max_hud ) )
        {
            level.sm_group_size_max_hud destroy();
        }
        
        if ( isdefined( level.sm_spawner_count_title ) )
        {
            level.sm_spawner_count_title destroy();
        }
        
        if ( isdefined( level.sm_spawner_count_min_hud ) )
        {
            level.sm_spawner_count_min_hud destroy();
        }
        
        if ( isdefined( level.sm_spawner_count_max_hud ) )
        {
            level.sm_spawner_count_max_hud destroy();
        }
    }

#/
