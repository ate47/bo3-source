#using scripts/codescripts/struct;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;

#namespace _gadget_camo_render;

// Namespace _gadget_camo_render
// Params 0, eflags: 0x2
// Checksum 0x9a5421e1, Offset: 0x420
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_camo_render", &__init__, undefined, undefined );
}

// Namespace _gadget_camo_render
// Params 0
// Checksum 0xab0ec71b, Offset: 0x460
// Size: 0x184
function __init__()
{
    duplicate_render::set_dr_filter_framebuffer_duplicate( "camo_rev_dr", 90, "gadget_camo_reveal,", "gadget_camo_flicker,gadget_camo_break,hide_model", 1, "mc/hud_outline_predator", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_rev", 90, "gadget_camo_reveal,hide_model", "gadget_camo_flicker,gadget_camo_break", 0, "mc/hud_outline_predator", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_fr", 90, "gadget_camo_on,gadget_camo_friend,hide_model", "gadget_camo_flicker,gadget_camo_break", 0, "mc/hud_outline_predator_camo_active_ally", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_en", 90, "gadget_camo_on,hide_model", "gadget_camo_flicker,gadget_camo_break,gadget_camo_friend", 0, "mc/hud_outline_predator_camo_active_enemy", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_fr_fl", 80, "gadget_camo_on,gadget_camo_flicker,gadget_camo_friend", "gadget_camo_break", 0, "mc/hud_outline_predator_camo_disruption_ally", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_en_fl", 80, "gadget_camo_on,gadget_camo_flicker", "gadget_camo_break,gadget_camo_friend", 0, "mc/hud_outline_predator_camo_disruption_enemy", 0 );
    duplicate_render::set_dr_filter_framebuffer( "camo_brk", 70, "gadget_camo_on,gadget_camo_break", undefined, 0, "mc/hud_outline_predator_break", 0 );
}

#namespace gadget_camo_render;

// Namespace gadget_camo_render
// Params 1
// Checksum 0x29aa0b9f, Offset: 0x5f0
// Size: 0xbc
function forceon( local_client_num )
{
    self notify( #"kill_gadget_camo_render_doreveal" );
    self duplicate_render::update_dr_flag( local_client_num, "hide_model", 1 );
    self mapshaderconstant( local_client_num, 0, "scriptVector0", 1, 0, 0, 0 );
    self duplicate_render::set_dr_flag( "gadget_camo_reveal", 0 );
    self duplicate_render::set_dr_flag( "gadget_camo_on", 1 );
    self duplicate_render::update_dr_filters( local_client_num );
}

// Namespace gadget_camo_render
// Params 2
// Checksum 0xc14d6820, Offset: 0x6b8
// Size: 0x364
function doreveal( local_client_num, direction )
{
    self notify( #"kill_gadget_camo_render_doreveal" );
    self endon( #"kill_gadget_camo_render_doreveal" );
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    delta = 0.0457143;
    
    if ( direction )
    {
        self duplicate_render::update_dr_flag( local_client_num, "hide_model", 0 );
        self mapshaderconstant( local_client_num, 0, "scriptVector0", 0, 0, 0, 0 );
        model_hidden = 0;
        currentvalue = 0;
        
        while ( currentvalue < 1 )
        {
            self mapshaderconstant( local_client_num, 0, "scriptVector0", currentvalue, 0, 0, 0 );
            
            if ( currentvalue >= 0.5 && model_hidden == 0 )
            {
                model_hidden = 1;
                self duplicate_render::update_dr_flag( local_client_num, "hide_model", 1 );
            }
            
            wait 0.016;
            currentvalue += delta;
        }
        
        self mapshaderconstant( local_client_num, 0, "scriptVector0", 1, 0, 0, 0 );
        self duplicate_render::set_dr_flag( "gadget_camo_reveal", 0 );
        self duplicate_render::set_dr_flag( "gadget_camo_on", 1 );
        self duplicate_render::update_dr_filters( local_client_num );
        return;
    }
    
    self duplicate_render::update_dr_flag( local_client_num, "hide_model", 1 );
    self mapshaderconstant( local_client_num, 0, "scriptVector0", 1, 0, 0, 0 );
    model_hidden = 1;
    currentvalue = 1;
    
    while ( currentvalue > 0 )
    {
        self mapshaderconstant( local_client_num, 0, "scriptVector0", currentvalue, 0, 0, 0 );
        
        if ( currentvalue < 0.5 && model_hidden )
        {
            self duplicate_render::update_dr_flag( local_client_num, "hide_model", 0 );
            model_hidden = 0;
        }
        
        wait 0.016;
        currentvalue -= delta;
    }
    
    self mapshaderconstant( local_client_num, 0, "scriptVector0", 0, 0, 0, 0 );
    self duplicate_render::set_dr_flag( "gadget_camo_reveal", 0 );
    self duplicate_render::set_dr_flag( "gadget_camo_on", 0 );
    self duplicate_render::update_dr_filters( local_client_num );
}

