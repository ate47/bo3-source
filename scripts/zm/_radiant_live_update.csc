#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace radiant_live_udpate;

/#

    // Namespace radiant_live_udpate
    // Params 0, eflags: 0x2
    // Checksum 0x95b1ff47, Offset: 0xb8
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, undefined );
    }

    // Namespace radiant_live_udpate
    // Params 0
    // Checksum 0x689e53d2, Offset: 0xf8
    // Size: 0x1c, Type: dev
    function __init__()
    {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_udpate
    // Params 0
    // Checksum 0x536ea647, Offset: 0x120
    // Size: 0x62, Type: dev
    function scriptstruct_debug_render()
    {
        while ( true )
        {
            level waittill( #"liveupdate", selected_struct );
            
            if ( isdefined( selected_struct ) )
            {
                level thread render_struct( selected_struct );
                continue;
            }
            
            level notify( #"stop_struct_render" );
        }
    }

    // Namespace radiant_live_udpate
    // Params 1
    // Checksum 0x595b7e89, Offset: 0x190
    // Size: 0x80, Type: dev
    function render_struct( selected_struct )
    {
        self endon( #"stop_struct_render" );
        
        while ( isdefined( selected_struct ) )
        {
            box( selected_struct.origin, ( -16, -16, -16 ), ( 16, 16, 16 ), 0, ( 1, 0.4, 0.4 ) );
            wait 0.01;
        }
    }

#/
