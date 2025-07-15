#namespace debug_menu;

/#

    // Namespace debug_menu
    // Params 2
    // Checksum 0x4da4d193, Offset: 0x70
    // Size: 0xb8, Type: dev
    function add_menu( menu_name, title )
    {
        if ( isdefined( level.menu_sys[ menu_name ] ) )
        {
            println( "<dev string:x28>" + menu_name + "<dev string:x3a>" );
            return;
        }
        
        level.menu_sys[ menu_name ] = spawnstruct();
        level.menu_sys[ menu_name ].title = "<dev string:x61>";
        level.menu_sys[ menu_name ].title = title;
    }

    // Namespace debug_menu
    // Params 4
    // Checksum 0x9c1b5cfb, Offset: 0x130
    // Size: 0x132, Type: dev
    function add_menuoptions( menu_name, option_text, func, key )
    {
        if ( !isdefined( level.menu_sys[ menu_name ].options ) )
        {
            level.menu_sys[ menu_name ].options = [];
        }
        
        num = level.menu_sys[ menu_name ].options.size;
        level.menu_sys[ menu_name ].options[ num ] = option_text;
        level.menu_sys[ menu_name ].func[ num ] = func;
        
        if ( isdefined( key ) )
        {
            if ( !isdefined( level.menu_sys[ menu_name ].func_key ) )
            {
                level.menu_sys[ menu_name ].func_key = [];
            }
            
            level.menu_sys[ menu_name ].func_key[ num ] = key;
        }
    }

    // Namespace debug_menu
    // Params 5
    // Checksum 0xab49b5d0, Offset: 0x270
    // Size: 0x176, Type: dev
    function add_menu_child( parent_menu, child_menu, child_title, child_number_override, func )
    {
        if ( !isdefined( level.menu_sys[ child_menu ] ) )
        {
            add_menu( child_menu, child_title );
        }
        
        level.menu_sys[ child_menu ].parent_menu = parent_menu;
        
        if ( !isdefined( level.menu_sys[ parent_menu ].children_menu ) )
        {
            level.menu_sys[ parent_menu ].children_menu = [];
        }
        
        if ( !isdefined( child_number_override ) )
        {
            size = level.menu_sys[ parent_menu ].children_menu.size;
        }
        else
        {
            size = child_number_override;
        }
        
        level.menu_sys[ parent_menu ].children_menu[ size ] = child_menu;
        
        if ( isdefined( func ) )
        {
            if ( !isdefined( level.menu_sys[ parent_menu ].children_func ) )
            {
                level.menu_sys[ parent_menu ].children_func = [];
            }
            
            level.menu_sys[ parent_menu ].children_func[ size ] = func;
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xa8aeb386, Offset: 0x3f0
    // Size: 0x2c, Type: dev
    function set_no_back_menu( menu_name )
    {
        level.menu_sys[ menu_name ].no_back = 1;
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xdc9fd09d, Offset: 0x428
    // Size: 0x276, Type: dev
    function enable_menu( menu_name )
    {
        disable_menu( "<dev string:x66>" );
        
        if ( isdefined( level.menu_cursor ) )
        {
            level.menu_cursor.y = 130;
            level.menu_cursor.current_pos = 0;
        }
        
        level.menu_sys[ "<dev string:x66>" ].title = set_menu_hudelem( level.menu_sys[ menu_name ].title, "<dev string:x73>" );
        level.menu_sys[ "<dev string:x66>" ].menu_name = menu_name;
        back_option_num = 0;
        
        if ( isdefined( level.menu_sys[ menu_name ].options ) )
        {
            options = level.menu_sys[ menu_name ].options;
            
            for ( i = 0; i < options.size ; i++ )
            {
                text = i + 1 + "<dev string:x79>" + options[ i ];
                level.menu_sys[ "<dev string:x66>" ].options[ i ] = set_menu_hudelem( text, "<dev string:x7c>", 20 * i );
                back_option_num = i;
            }
        }
        
        if ( isdefined( level.menu_sys[ menu_name ].parent_menu ) && !isdefined( level.menu_sys[ menu_name ].no_back ) )
        {
            back_option_num++;
            text = back_option_num + 1 + "<dev string:x79>" + "<dev string:x84>";
            level.menu_sys[ "<dev string:x66>" ].options[ back_option_num ] = set_menu_hudelem( text, "<dev string:x7c>", 20 * back_option_num );
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xb94bf3f, Offset: 0x6a8
    // Size: 0x128, Type: dev
    function disable_menu( menu_name )
    {
        if ( isdefined( level.menu_sys[ menu_name ] ) )
        {
            if ( isdefined( level.menu_sys[ menu_name ].title ) )
            {
                level.menu_sys[ menu_name ].title destroy();
            }
            
            if ( isdefined( level.menu_sys[ menu_name ].options ) )
            {
                options = level.menu_sys[ menu_name ].options;
                
                for ( i = 0; i < options.size ; i++ )
                {
                    options[ i ] destroy();
                }
            }
        }
        
        level.menu_sys[ menu_name ].title = undefined;
        level.menu_sys[ menu_name ].options = [];
    }

    // Namespace debug_menu
    // Params 3
    // Checksum 0x8ab091b4, Offset: 0x7d8
    // Size: 0xcc, Type: dev
    function set_menu_hudelem( text, type, y_offset )
    {
        y = 100;
        
        if ( isdefined( type ) && type == "<dev string:x73>" )
        {
            scale = 2;
        }
        else
        {
            scale = 1.3;
            y += 30;
        }
        
        if ( !isdefined( y_offset ) )
        {
            y_offset = 0;
        }
        
        y += y_offset;
        return set_hudelem( text, 10, y, scale );
    }

    // Namespace debug_menu
    // Params 7
    // Checksum 0xec09d14, Offset: 0x8b0
    // Size: 0x1d2, Type: dev
    function set_hudelem( text, x, y, scale, alpha, sort, debug_hudelem )
    {
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
        
        if ( isdefined( level.player ) && !isdefined( debug_hudelem ) )
        {
            hud = newclienthudelem( level.player );
        }
        else
        {
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        
        hud.location = 0;
        hud.alignx = "<dev string:x89>";
        hud.aligny = "<dev string:x8e>";
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
    }

    // Namespace debug_menu
    // Params 0
    // Checksum 0x19b1b57a, Offset: 0xa90
    // Size: 0x820, Type: dev
    function menu_input()
    {
        while ( true )
        {
            level waittill( #"menu_button_pressed", keystring );
            menu_name = level.menu_sys[ "<dev string:x66>" ].menu_name;
            
            if ( keystring == "<dev string:x95>" || keystring == "<dev string:x9d>" )
            {
                if ( level.menu_cursor.current_pos > 0 )
                {
                    level.menu_cursor.y -= 20;
                    level.menu_cursor.current_pos--;
                }
                else if ( level.menu_cursor.current_pos == 0 )
                {
                    level.menu_cursor.y += ( level.menu_sys[ "<dev string:x66>" ].options.size - 1 ) * 20;
                    level.menu_cursor.current_pos = level.menu_sys[ "<dev string:x66>" ].options.size - 1;
                }
                
                wait 0.1;
                continue;
            }
            else if ( keystring == "<dev string:xa5>" || keystring == "<dev string:xaf>" )
            {
                if ( level.menu_cursor.current_pos < level.menu_sys[ "<dev string:x66>" ].options.size - 1 )
                {
                    level.menu_cursor.y += 20;
                    level.menu_cursor.current_pos++;
                }
                else if ( level.menu_cursor.current_pos == level.menu_sys[ "<dev string:x66>" ].options.size - 1 )
                {
                    level.menu_cursor.y += level.menu_cursor.current_pos * -20;
                    level.menu_cursor.current_pos = 0;
                }
                
                wait 0.1;
                continue;
            }
            else if ( keystring == "<dev string:xb9>" || keystring == "<dev string:xc2>" )
            {
                key = level.menu_cursor.current_pos;
            }
            else
            {
                key = int( keystring ) - 1;
            }
            
            if ( key > level.menu_sys[ menu_name ].options.size )
            {
                continue;
            }
            else if ( isdefined( level.menu_sys[ menu_name ].parent_menu ) && key == level.menu_sys[ menu_name ].options.size )
            {
                level notify( "<dev string:xc8>" + menu_name );
                level enable_menu( level.menu_sys[ menu_name ].parent_menu );
            }
            else if ( isdefined( level.menu_sys[ menu_name ].func ) && isdefined( level.menu_sys[ menu_name ].func[ key ] ) )
            {
                level.menu_sys[ "<dev string:x66>" ].options[ key ] thread hud_selector( level.menu_sys[ "<dev string:x66>" ].options[ key ].x, level.menu_sys[ "<dev string:x66>" ].options[ key ].y );
                
                if ( isdefined( level.menu_sys[ menu_name ].func_key ) && isdefined( level.menu_sys[ menu_name ].func_key[ key ] ) && level.menu_sys[ menu_name ].func_key[ key ] == keystring )
                {
                    error_msg = level [[ level.menu_sys[ menu_name ].func[ key ] ]]();
                }
                else
                {
                    error_msg = level [[ level.menu_sys[ menu_name ].func[ key ] ]]();
                }
                
                level thread hud_selector_fade_out();
                
                if ( isdefined( error_msg ) )
                {
                    level thread selection_error( error_msg, level.menu_sys[ "<dev string:x66>" ].options[ key ].x, level.menu_sys[ "<dev string:x66>" ].options[ key ].y );
                }
            }
            
            if ( !isdefined( level.menu_sys[ menu_name ].children_menu ) )
            {
                println( "<dev string:xd1>" + menu_name + "<dev string:xd5>" );
                continue;
            }
            else if ( !isdefined( level.menu_sys[ menu_name ].children_menu[ key ] ) )
            {
                println( "<dev string:xd1>" + menu_name + "<dev string:x101>" + key + "<dev string:x11f>" );
                continue;
            }
            else if ( !isdefined( level.menu_sys[ level.menu_sys[ menu_name ].children_menu[ key ] ] ) )
            {
                println( "<dev string:xd1>" + level.menu_sys[ menu_name ].options[ key ] + "<dev string:x130>" );
                continue;
            }
            
            if ( isdefined( level.menu_sys[ menu_name ].children_func ) && isdefined( level.menu_sys[ menu_name ].children_func[ key ] ) )
            {
                func = level.menu_sys[ menu_name ].children_func[ key ];
                error_msg = [[ func ]]();
                
                if ( isdefined( error_msg ) )
                {
                    level thread selection_error( error_msg, level.menu_sys[ "<dev string:x66>" ].options[ key ].x, level.menu_sys[ "<dev string:x66>" ].options[ key ].y );
                    continue;
                }
            }
            
            level enable_menu( level.menu_sys[ menu_name ].children_menu[ key ] );
            wait 0.1;
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0x6a25ed7, Offset: 0x12b8
    // Size: 0x1ae, Type: dev
    function force_menu_back( waittill_msg )
    {
        if ( isdefined( waittill_msg ) )
        {
            level waittill( waittill_msg );
        }
        
        wait 0.1;
        menu_name = level.menu_sys[ "<dev string:x66>" ].menu_name;
        key = level.menu_sys[ menu_name ].options.size;
        key++;
        
        if ( key == 1 )
        {
            key = "<dev string:x14a>";
        }
        else if ( key == 2 )
        {
            key = "<dev string:x14c>";
        }
        else if ( key == 3 )
        {
            key = "<dev string:x14e>";
        }
        else if ( key == 4 )
        {
            key = "<dev string:x150>";
        }
        else if ( key == 5 )
        {
            key = "<dev string:x152>";
        }
        else if ( key == 6 )
        {
            key = "<dev string:x154>";
        }
        else if ( key == 7 )
        {
            key = "<dev string:x156>";
        }
        else if ( key == 8 )
        {
            key = "<dev string:x158>";
        }
        else if ( key == 9 )
        {
            key = "<dev string:x15a>";
        }
        
        level notify( #"menu_button_pressed", key );
    }

    // Namespace debug_menu
    // Params 7
    // Checksum 0xa83f6979, Offset: 0x1470
    // Size: 0x46c, Type: dev
    function list_menu( list, x, y, scale, func, sort, start_num )
    {
        if ( !isdefined( list ) || list.size == 0 )
        {
            return -1;
        }
        
        hud_array = [];
        
        for ( i = 0; i < 5 ; i++ )
        {
            if ( i == 0 )
            {
                alpha = 0.3;
            }
            else if ( i == 1 )
            {
                alpha = 0.6;
            }
            else if ( i == 2 )
            {
                alpha = 1;
            }
            else if ( i == 3 )
            {
                alpha = 0.6;
            }
            else
            {
                alpha = 0.3;
            }
            
            hud = set_hudelem( list[ i ], x, y + ( i - 2 ) * 15, scale, alpha, sort );
            
            if ( !isdefined( hud_array ) )
            {
                hud_array = [];
            }
            else if ( !isarray( hud_array ) )
            {
                hud_array = array( hud_array );
            }
            
            hud_array[ hud_array.size ] = hud;
        }
        
        if ( isdefined( start_num ) )
        {
            new_move_list_menu( hud_array, list, start_num );
        }
        
        current_num = 0;
        old_num = 0;
        selected = 0;
        level.menu_list_selected = 0;
        
        if ( isdefined( func ) )
        {
            [[ func ]]( list[ current_num ] );
        }
        
        while ( true )
        {
            level waittill( #"menu_button_pressed", key );
            level.menu_list_selected = 1;
            
            if ( any_button_hit( key, "<dev string:x15c>" ) )
            {
                break;
            }
            else if ( key == "<dev string:xaf>" || key == "<dev string:xa5>" )
            {
                if ( current_num >= list.size - 1 )
                {
                    continue;
                }
                
                current_num++;
                new_move_list_menu( hud_array, list, current_num );
            }
            else if ( key == "<dev string:x9d>" || key == "<dev string:x95>" )
            {
                if ( current_num <= 0 )
                {
                    continue;
                }
                
                current_num--;
                new_move_list_menu( hud_array, list, current_num );
            }
            else if ( key == "<dev string:xc2>" || key == "<dev string:xb9>" )
            {
                selected = 1;
                break;
            }
            else if ( key == "<dev string:x164>" || key == "<dev string:x168>" )
            {
                selected = 0;
                break;
            }
            
            level notify( #"scroll_list" );
            
            if ( current_num != old_num )
            {
                old_num = current_num;
                
                if ( isdefined( func ) )
                {
                    [[ func ]]( list[ current_num ] );
                }
            }
            
            wait 0.1;
        }
        
        for ( i = 0; i < hud_array.size ; i++ )
        {
            hud_array[ i ] destroy();
        }
        
        if ( selected )
        {
            return current_num;
        }
    }

    // Namespace debug_menu
    // Params 3
    // Checksum 0xc724ff64, Offset: 0x18e8
    // Size: 0xbe, Type: dev
    function new_move_list_menu( hud_array, list, num )
    {
        for ( i = 0; i < hud_array.size ; i++ )
        {
            if ( isdefined( list[ i + num - 2 ] ) )
            {
                text = list[ i + num - 2 ];
            }
            else
            {
                text = "<dev string:x171>";
            }
            
            hud_array[ i ] settext( text );
        }
    }

    // Namespace debug_menu
    // Params 6
    // Checksum 0x6b6da306, Offset: 0x19b0
    // Size: 0x27e, Type: dev
    function move_list_menu( hud_array, dir, space, num, min_alpha, num_of_fades )
    {
        if ( !isdefined( min_alpha ) )
        {
            min_alpha = 0;
        }
        
        if ( !isdefined( num_of_fades ) )
        {
            num_of_fades = 3;
        }
        
        side_movement = 0;
        
        if ( dir == "<dev string:x172>" )
        {
            side_movement = 1;
            movement = space;
        }
        else if ( dir == "<dev string:x89>" )
        {
            side_movement = 1;
            movement = space * -1;
        }
        else if ( dir == "<dev string:x178>" )
        {
            movement = space;
        }
        else
        {
            movement = space * -1;
        }
        
        for ( i = 0; i < hud_array.size ; i++ )
        {
            hud_array[ i ] moveovertime( 0.1 );
            
            if ( side_movement )
            {
                hud_array[ i ].x += movement;
            }
            else
            {
                hud_array[ i ].y += movement;
            }
            
            temp = i - num;
            
            if ( temp < 0 )
            {
                temp *= -1;
            }
            
            alpha = 1 / ( temp + 1 );
            
            if ( alpha < 1 / num_of_fades )
            {
                alpha = min_alpha;
            }
            
            if ( !isdefined( hud_array[ i ].debug_hudelem ) )
            {
                hud_array[ i ] fadeovertime( 0.1 );
            }
            
            hud_array[ i ].alpha = alpha;
        }
    }

    // Namespace debug_menu
    // Params 2
    // Checksum 0xc8e901a6, Offset: 0x1c38
    // Size: 0xf0, Type: dev
    function hud_selector( x, y )
    {
        if ( isdefined( level.hud_selector ) )
        {
            level thread hud_selector_fade_out();
        }
        
        level.menu_cursor.alpha = 0;
        level.hud_selector = set_hudelem( undefined, x - 10, y, 1 );
        level.hud_selector setshader( "<dev string:x17b>", 125, 20 );
        level.hud_selector.color = ( 1, 1, 0.5 );
        level.hud_selector.alpha = 0.5;
        level.hud_selector.sort = 10;
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xe3862b1a, Offset: 0x1d30
    // Size: 0xc4, Type: dev
    function hud_selector_fade_out( time )
    {
        if ( !isdefined( time ) )
        {
            time = 0.25;
        }
        
        level.menu_cursor.alpha = 0.5;
        hud = level.hud_selector;
        level.hud_selector = undefined;
        
        if ( !isdefined( hud.debug_hudelem ) )
        {
            hud fadeovertime( time );
        }
        
        hud.alpha = 0;
        wait time + 0.1;
        hud destroy();
    }

    // Namespace debug_menu
    // Params 3
    // Checksum 0x45385f29, Offset: 0x1e00
    // Size: 0x1a4, Type: dev
    function selection_error( msg, x, y )
    {
        hud = set_hudelem( undefined, x - 10, y, 1 );
        hud setshader( "<dev string:x17b>", 125, 20 );
        hud.color = ( 0.5, 0, 0 );
        hud.alpha = 0.7;
        error_hud = set_hudelem( msg, x + 125, y, 1 );
        error_hud.color = ( 1, 0, 0 );
        
        if ( !isdefined( hud.debug_hudelem ) )
        {
            hud fadeovertime( 3 );
        }
        
        hud.alpha = 0;
        
        if ( !isdefined( error_hud.debug_hudelem ) )
        {
            error_hud fadeovertime( 3 );
        }
        
        error_hud.alpha = 0;
        wait 3.1;
        hud destroy();
        error_hud destroy();
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xceed86e0, Offset: 0x1fb0
    // Size: 0xfa, Type: dev
    function hud_font_scaler( mult )
    {
        self notify( #"stop_fontscaler" );
        self endon( #"death" );
        self endon( #"stop_fontscaler" );
        og_scale = self.og_scale;
        
        if ( !isdefined( mult ) )
        {
            mult = 1.5;
        }
        
        self.fontscale = og_scale * mult;
        dif = og_scale - self.fontscale;
        dif /= 1 * 20;
        
        for ( i = 0; i < 1 * 20 ; i++ )
        {
            self.fontscale += dif;
            wait 0.05;
        }
    }

    // Namespace debug_menu
    // Params 0
    // Checksum 0x7296d8f, Offset: 0x20b8
    // Size: 0xbc, Type: dev
    function menu_cursor()
    {
        level.menu_cursor = set_hudelem( undefined, 0, 130, 1.3 );
        level.menu_cursor setshader( "<dev string:x17b>", 125, 20 );
        level.menu_cursor.color = ( 1, 0.5, 0 );
        level.menu_cursor.alpha = 0.5;
        level.menu_cursor.sort = 1;
        level.menu_cursor.current_pos = 0;
    }

    // Namespace debug_menu
    // Params 5
    // Checksum 0xe43fbaea, Offset: 0x2180
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

    // Namespace debug_menu
    // Params 1
    // Checksum 0xdb331f61, Offset: 0x2250
    // Size: 0x94, Type: dev
    function remove_hud( hud_name )
    {
        if ( !isdefined( level.hud_array[ hud_name ] ) )
        {
            return;
        }
        
        huds = level.hud_array[ hud_name ];
        
        for ( i = 0; i < huds.size ; i++ )
        {
            destroy_hud( huds[ i ] );
        }
        
        level.hud_array[ hud_name ] = undefined;
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0x9f867dca, Offset: 0x22f0
    // Size: 0x34, Type: dev
    function destroy_hud( hud )
    {
        if ( isdefined( hud ) )
        {
            hud destroy();
        }
    }

    // Namespace debug_menu
    // Params 7
    // Checksum 0x729d6a77, Offset: 0x2330
    // Size: 0x142, Type: dev
    function set_menus_pos_by_num( hud_array, num, x, y, space, min_alpha, num_of_fades )
    {
        if ( !isdefined( min_alpha ) )
        {
            min_alpha = 0.1;
        }
        
        if ( !isdefined( num_of_fades ) )
        {
            num_of_fades = 3;
        }
        
        for ( i = 0; i < hud_array.size ; i++ )
        {
            temp = i - num;
            hud_array[ i ].y = y + temp * space;
            
            if ( temp < 0 )
            {
                temp *= -1;
            }
            
            alpha = 1 / ( temp + 1 );
            
            if ( alpha < 1 / num_of_fades )
            {
                alpha = min_alpha;
            }
            
            hud_array[ i ].alpha = alpha;
        }
    }

    // Namespace debug_menu
    // Params 7
    // Checksum 0x57cd8107, Offset: 0x2480
    // Size: 0x360, Type: dev
    function popup_box( x, y, width, height, time, color, alpha )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 0.5;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0, 0, 0.5 );
        }
        
        if ( isdefined( level.player ) )
        {
            hud = newclienthudelem( level.player );
        }
        else
        {
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        
        hud.alignx = "<dev string:x89>";
        hud.aligny = "<dev string:x8e>";
        hud.foreground = 1;
        hud.sort = 30;
        hud.x = x;
        hud.y = y;
        hud.alpha = alpha;
        hud.color = color;
        
        if ( isdefined( level.player ) )
        {
            hud.background = newclienthudelem( level.player );
        }
        else
        {
            hud.background = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        
        hud.background.alignx = "<dev string:x89>";
        hud.background.aligny = "<dev string:x8e>";
        hud.background.foreground = 1;
        hud.background.sort = 25;
        hud.background.x = x + 2;
        hud.background.y = y + 2;
        hud.background.alpha = 0.75;
        hud.background.color = ( 0, 0, 0 );
        hud setshader( "<dev string:x17b>", 0, 0 );
        hud scaleovertime( time, width, height );
        hud.background setshader( "<dev string:x17b>", 0, 0 );
        hud.background scaleovertime( time, width, height );
        wait time;
        return hud;
    }

    // Namespace debug_menu
    // Params 0
    // Checksum 0x74c070b4, Offset: 0x27e8
    // Size: 0x9c, Type: dev
    function destroy_popup()
    {
        self.background scaleovertime( 0.25, 0, 0 );
        self scaleovertime( 0.25, 0, 0 );
        wait 0.1;
        
        if ( isdefined( self.background ) )
        {
            self.background destroy();
        }
        
        if ( isdefined( self ) )
        {
            self destroy();
        }
    }

    // Namespace debug_menu
    // Params 3
    // Checksum 0xd25c54b0, Offset: 0x2890
    // Size: 0x4e2, Type: dev
    function dialog_text_box( dialog_msg, dialog_msg2, word_length )
    {
        y = 100;
        hud = new_hud( "<dev string:x181>", undefined, 320 - 300 * 0.5, y, 1 );
        hud setshader( "<dev string:x17b>", 300, 100 );
        hud.aligny = "<dev string:x18c>";
        hud.color = ( 0, 0, 0.2 );
        hud.alpha = 0.85;
        hud.sort = 20;
        hud = new_hud( "<dev string:x181>", dialog_msg, 320 - 300 * 0.5 + 10, y + 10, 1.25 );
        hud.sort = 25;
        
        if ( isdefined( dialog_msg2 ) )
        {
            hud = new_hud( "<dev string:x181>", dialog_msg2, 320 - 300 * 0.5 + 10, y + 30, 1.1 );
            hud.sort = 25;
        }
        
        bg2_shader_width = 300 - 20;
        y = 150;
        hud = new_hud( "<dev string:x181>", undefined, 320 - bg2_shader_width * 0.5, y, 1 );
        hud setshader( "<dev string:x17b>", bg2_shader_width, 20 );
        hud.aligny = "<dev string:x18c>";
        hud.color = ( 0, 0, 0 );
        hud.alpha = 0.85;
        hud.sort = 30;
        cursor_x = 320 - bg2_shader_width * 0.5 + 2;
        cursor_y = y + 8;
        
        if ( level.xenon )
        {
            hud = new_hud( "<dev string:x181>", "<dev string:x190>", 320 - 50, y + 30, 1.25 );
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
            hud = new_hud( "<dev string:x181>", "<dev string:x19e>", 320 + 50, y + 30, 1.25 );
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
        }
        else
        {
            hud = new_hud( "<dev string:x181>", "<dev string:x1a9>", 320 - 50, y + 30, 1.25 );
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
            hud = new_hud( "<dev string:x181>", "<dev string:x1b4>", 320 + 50, y + 30, 1.25 );
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
        }
        
        result = dialog_text_box_input( cursor_x, cursor_y, word_length );
        remove_hud( "<dev string:x181>" );
        return result;
    }

    // Namespace debug_menu
    // Params 3
    // Checksum 0x60843bd4, Offset: 0x2d80
    // Size: 0x2ec, Type: dev
    function dialog_text_box_input( cursor_x, cursor_y, word_length )
    {
        level.dialog_box_cursor = new_hud( "<dev string:x181>", "<dev string:x1c1>", cursor_x, cursor_y, 1.25 );
        level.dialog_box_cursor.sort = 75;
        level thread dialog_text_box_cursor();
        dialog_text_box_buttons();
        hud_word = new_hud( "<dev string:x181>", "<dev string:x171>", cursor_x, cursor_y, 1.25 );
        hud_word.sort = 75;
        hud_letters = [];
        word = "<dev string:x171>";
        
        while ( true )
        {
            level waittill( #"dialog_box_button_pressed", button );
            
            if ( button == "<dev string:x164>" || button == "<dev string:x1c3>" )
            {
                word = "<dev string:x1cc>";
                break;
            }
            else if ( button == "<dev string:xc2>" || button == "<dev string:x1cf>" || button == "<dev string:xb9>" )
            {
                break;
            }
            else if ( button == "<dev string:x1d8>" || button == "<dev string:x1e2>" )
            {
                new_word = "<dev string:x171>";
                
                for ( i = 0; i < word.size - 1 ; i++ )
                {
                    new_word += word[ i ];
                }
                
                word = new_word;
            }
            else if ( word.size < word_length )
            {
                word += button;
            }
            
            hud_word settext( word );
            x = cursor_x;
            
            for ( i = 0; i < word.size ; i++ )
            {
                x += get_letter_space( word[ i ] );
            }
            
            level.dialog_box_cursor.x = x;
            wait 0.05;
        }
        
        level notify( #"stop_dialog_text_box_cursor" );
        level notify( #"stop_dialog_text_input" );
        return word;
    }

    // Namespace debug_menu
    // Params 0
    // Checksum 0xf5a974d8, Offset: 0x3078
    // Size: 0x5d4, Type: dev
    function dialog_text_box_buttons()
    {
        clear_universal_buttons( "<dev string:x1e6>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1fa>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1fc>" );
        add_universal_button( "<dev string:x181>", "<dev string:x14a>" );
        add_universal_button( "<dev string:x181>", "<dev string:x14c>" );
        add_universal_button( "<dev string:x181>", "<dev string:x14e>" );
        add_universal_button( "<dev string:x181>", "<dev string:x150>" );
        add_universal_button( "<dev string:x181>", "<dev string:x152>" );
        add_universal_button( "<dev string:x181>", "<dev string:x154>" );
        add_universal_button( "<dev string:x181>", "<dev string:x156>" );
        add_universal_button( "<dev string:x181>", "<dev string:x158>" );
        add_universal_button( "<dev string:x181>", "<dev string:x15a>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1fe>" );
        add_universal_button( "<dev string:x181>", "<dev string:x200>" );
        add_universal_button( "<dev string:x181>", "<dev string:x202>" );
        add_universal_button( "<dev string:x181>", "<dev string:x204>" );
        add_universal_button( "<dev string:x181>", "<dev string:x206>" );
        add_universal_button( "<dev string:x181>", "<dev string:x208>" );
        add_universal_button( "<dev string:x181>", "<dev string:x20a>" );
        add_universal_button( "<dev string:x181>", "<dev string:x20c>" );
        add_universal_button( "<dev string:x181>", "<dev string:x20e>" );
        add_universal_button( "<dev string:x181>", "<dev string:x210>" );
        add_universal_button( "<dev string:x181>", "<dev string:x212>" );
        add_universal_button( "<dev string:x181>", "<dev string:x214>" );
        add_universal_button( "<dev string:x181>", "<dev string:x216>" );
        add_universal_button( "<dev string:x181>", "<dev string:x218>" );
        add_universal_button( "<dev string:x181>", "<dev string:x21a>" );
        add_universal_button( "<dev string:x181>", "<dev string:x21c>" );
        add_universal_button( "<dev string:x181>", "<dev string:x21e>" );
        add_universal_button( "<dev string:x181>", "<dev string:x220>" );
        add_universal_button( "<dev string:x181>", "<dev string:x222>" );
        add_universal_button( "<dev string:x181>", "<dev string:x224>" );
        add_universal_button( "<dev string:x181>", "<dev string:x226>" );
        add_universal_button( "<dev string:x181>", "<dev string:x228>" );
        add_universal_button( "<dev string:x181>", "<dev string:x22a>" );
        add_universal_button( "<dev string:x181>", "<dev string:x22c>" );
        add_universal_button( "<dev string:x181>", "<dev string:x22e>" );
        add_universal_button( "<dev string:x181>", "<dev string:x230>" );
        add_universal_button( "<dev string:x181>", "<dev string:xc2>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1cf>" );
        add_universal_button( "<dev string:x181>", "<dev string:x164>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1d8>" );
        add_universal_button( "<dev string:x181>", "<dev string:x1e2>" );
        
        if ( level.xenon )
        {
            add_universal_button( "<dev string:x181>", "<dev string:xb9>" );
            add_universal_button( "<dev string:x181>", "<dev string:x1c3>" );
        }
        
        level thread universal_input_loop( "<dev string:x181>", "<dev string:x232>", undefined, undefined );
    }

    // Namespace debug_menu
    // Params 0
    // Checksum 0x8bdca92c, Offset: 0x3658
    // Size: 0x54, Type: dev
    function dialog_text_box_cursor()
    {
        level endon( #"stop_dialog_text_box_cursor" );
        
        while ( true )
        {
            level.dialog_box_cursor.alpha = 0;
            wait 0.5;
            level.dialog_box_cursor.alpha = 1;
            wait 0.5;
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0x3d9a7869, Offset: 0x36b8
    // Size: 0x166, Type: dev
    function get_letter_space( letter )
    {
        if ( letter == "<dev string:x216>" || letter == "<dev string:x22a>" || letter == "<dev string:x1fa>" )
        {
            space = 10;
        }
        else if ( letter == "<dev string:x206>" || letter == "<dev string:x20c>" || letter == "<dev string:x226>" || letter == "<dev string:x228>" || letter == "<dev string:x22c>" || letter == "<dev string:x21a>" )
        {
            space = 7;
        }
        else if ( letter == "<dev string:x208>" || letter == "<dev string:x220>" || letter == "<dev string:x224>" )
        {
            space = 5;
        }
        else if ( letter == "<dev string:x20e>" || letter == "<dev string:x214>" )
        {
            space = 4;
        }
        else if ( letter == "<dev string:x210>" )
        {
            space = 3;
        }
        else
        {
            space = 6;
        }
        
        return space;
    }

    // Namespace debug_menu
    // Params 2
    // Checksum 0xa0346b7c, Offset: 0x3828
    // Size: 0x84, Type: dev
    function add_universal_button( button_group, name )
    {
        if ( !isdefined( level.u_buttons[ button_group ] ) )
        {
            level.u_buttons[ button_group ] = [];
        }
        
        if ( !isinarray( level.u_buttons[ button_group ], name ) )
        {
            level.u_buttons[ button_group ][ level.u_buttons[ button_group ].size ] = name;
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xc9c28309, Offset: 0x38b8
    // Size: 0x22, Type: dev
    function clear_universal_buttons( button_group )
    {
        level.u_buttons[ button_group ] = [];
    }

    // Namespace debug_menu
    // Params 5
    // Checksum 0x22ec86c5, Offset: 0x38e8
    // Size: 0x1e0, Type: dev
    function universal_input_loop( button_group, end_on, use_attackbutton, mod_button, no_mod_button )
    {
        level endon( end_on );
        
        if ( !isdefined( use_attackbutton ) )
        {
            use_attackbutton = 0;
        }
        
        notify_name = button_group + "<dev string:x249>";
        buttons = level.u_buttons[ button_group ];
        level.u_buttons_disable[ button_group ] = 0;
        
        while ( true )
        {
            if ( level.u_buttons_disable[ button_group ] )
            {
                wait 0.05;
                continue;
            }
            
            if ( isdefined( mod_button ) && !level.player buttonpressed( mod_button ) )
            {
                wait 0.05;
                continue;
            }
            else if ( isdefined( no_mod_button ) && level.player buttonpressed( no_mod_button ) )
            {
                wait 0.05;
                continue;
            }
            
            if ( use_attackbutton && level.player attackbuttonpressed() )
            {
                level notify( notify_name, "<dev string:x259>" );
                wait 0.1;
                continue;
            }
            
            for ( i = 0; i < buttons.size ; i++ )
            {
                if ( level.player buttonpressed( buttons[ i ] ) )
                {
                    level notify( notify_name, buttons[ i ] );
                    wait 0.1;
                    break;
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0x4ec99fc1, Offset: 0x3ad0
    // Size: 0x22, Type: dev
    function disable_buttons( button_group )
    {
        level.u_buttons_disable[ button_group ] = 1;
    }

    // Namespace debug_menu
    // Params 1
    // Checksum 0xd9c67699, Offset: 0x3b00
    // Size: 0x26, Type: dev
    function enable_buttons( button_group )
    {
        wait 1;
        level.u_buttons_disable[ button_group ] = 0;
    }

    // Namespace debug_menu
    // Params 2
    // Checksum 0x11d4c4c4, Offset: 0x3b30
    // Size: 0x154, Type: dev
    function any_button_hit( button_hit, type )
    {
        buttons = [];
        
        if ( type == "<dev string:x15c>" )
        {
            buttons[ 0 ] = "<dev string:x1fc>";
            buttons[ 1 ] = "<dev string:x14a>";
            buttons[ 2 ] = "<dev string:x14c>";
            buttons[ 3 ] = "<dev string:x14e>";
            buttons[ 4 ] = "<dev string:x150>";
            buttons[ 5 ] = "<dev string:x152>";
            buttons[ 6 ] = "<dev string:x154>";
            buttons[ 7 ] = "<dev string:x156>";
            buttons[ 8 ] = "<dev string:x158>";
            buttons[ 9 ] = "<dev string:x15a>";
        }
        else
        {
            buttons = level.buttons;
        }
        
        for ( i = 0; i < buttons.size ; i++ )
        {
            if ( button_hit == buttons[ i ] )
            {
                return 1;
            }
        }
        
        return 0;
    }

#/
