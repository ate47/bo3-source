#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/table_shared;
#using scripts/shared/util_shared;

#namespace zm_frontend_zm_bgb_chance;

/#

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0
    // Checksum 0xc27953be, Offset: 0x1a8
    // Size: 0x1c, Type: dev
    function zm_frontend_bgb_slots_logic()
    {
        level thread zm_frontend_bgb_devgui();
    }

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0
    // Checksum 0xaba81fc3, Offset: 0x1d0
    // Size: 0x1bc, Type: dev
    function zm_frontend_bgb_devgui()
    {
        setdvar( "<dev string:x28>", "<dev string:x44>" );
        setdvar( "<dev string:x45>", "<dev string:x44>" );
        bgb_devgui_base = "<dev string:x62>";
        a_n_amounts = array( 1, 5, 10, 100 );
        
        for ( i = 0; i < a_n_amounts.size ; i++ )
        {
            n_amount = a_n_amounts[ i ];
            adddebugcommand( bgb_devgui_base + i + "<dev string:x7c>" + n_amount + "<dev string:x84>" + n_amount + "<dev string:x95>" );
        }
        
        adddebugcommand( "<dev string:x99>" + "<dev string:xc6>" + "<dev string:x28>" + "<dev string:xca>" + 1 + "<dev string:xcc>" );
        adddebugcommand( "<dev string:xcf>" + "<dev string:xc6>" + "<dev string:x45>" + "<dev string:xca>" + 1 + "<dev string:xcc>" );
        level thread bgb_devgui_think();
    }

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0
    // Checksum 0x98c1dcc6, Offset: 0x398
    // Size: 0x1c0, Type: dev
    function bgb_devgui_think()
    {
        b_powerboost_toggle = 0;
        b_successfail_toggle = 0;
        
        for ( ;; )
        {
            n_val_powerboost = getdvarstring( "<dev string:x28>" );
            n_val_successfail = getdvarstring( "<dev string:x45>" );
            
            if ( n_val_powerboost != "<dev string:x44>" )
            {
                b_powerboost_toggle = !b_powerboost_toggle;
                level clientfield::set( "<dev string:xfd>", b_powerboost_toggle );
                
                if ( b_powerboost_toggle )
                {
                    iprintlnbold( "<dev string:x118>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x12e>" );
                }
            }
            
            if ( n_val_successfail != "<dev string:x44>" )
            {
                b_successfail_toggle = !b_successfail_toggle;
                level clientfield::set( "<dev string:x145>", b_successfail_toggle );
                
                if ( b_successfail_toggle )
                {
                    iprintlnbold( "<dev string:x161>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x16e>" );
                }
            }
            
            setdvar( "<dev string:x28>", "<dev string:x44>" );
            setdvar( "<dev string:x45>", "<dev string:x44>" );
            wait 0.5;
        }
    }

#/
