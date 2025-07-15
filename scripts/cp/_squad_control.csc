#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace squad_control;

// Namespace squad_control
// Params 0, eflags: 0x2
// Checksum 0x50e7ec9, Offset: 0x618
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "squad_control", &__init__, undefined, undefined );
}

// Namespace squad_control
// Params 0
// Checksum 0xf4032903, Offset: 0x658
// Size: 0x39c
function __init__()
{
    level.keyline_outline_indices = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        str_name = "keyline_outline_p" + i;
        clientfield::register( "actor", str_name, 1, 2, "int", &ent_material_callback, 0, 0 );
        clientfield::register( "vehicle", str_name, 1, 2, "int", &ent_material_callback, 0, 0 );
        clientfield::register( "scriptmover", str_name, 1, 3, "int", &ent_material_callback, 0, 0 );
        level.keyline_outline_indices[ str_name ] = i;
    }
    
    level._effect[ "squad_waypoint_base_client" ] = "ui/fx_ui_flagbase_blue";
    level.squad_indicator_indices = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        str_name = "squad_indicator_p" + i;
        clientfield::register( "actor", str_name, 1, 1, "int", &squad_indicator_callback, 0, 0 );
        level.squad_indicator_indices[ str_name ] = i;
    }
    
    duplicate_render::set_dr_filter_offscreen( "sitrep_keyline_white", 25, "keyline_active_white", "keyfill_active_white", 2, "mc/hud_outline_model_z_white", 0 );
    duplicate_render::set_dr_filter_offscreen( "sitrep_keyline_red", 25, "keyline_active_red", "keyfill_active_red", 2, "mc/hud_outline_model_red", 0 );
    duplicate_render::set_dr_filter_offscreen( "sitrep_keyline_green", 25, "keyline_active_green", "keyfill_active_green", 2, "mc/hud_outline_model_green", 0 );
    duplicate_render::set_dr_filter_offscreen( "sitrep_keyline_white_through_walls", 25, "keyline_active_white_through_walls", "keyfill_active_white_through_walls", 2, "mc/hud_outline_model_white", 1 );
    clientfield::register( "actor", "robot_camo_shader", 1, 3, "int", &ent_camo_material_callback, 0, 1 );
    duplicate_render::set_dr_filter_framebuffer( "camo_fr", 90, "gadget_camo_on,gadget_camo_friend", "gadget_camo_flicker,gadget_camo_break", 0, "mc/hud_outline_predator_camo_active_ally" );
    duplicate_render::set_dr_filter_framebuffer( "camo_fr_fl", 80, "gadget_camo_on,gadget_camo_flicker,gadget_camo_friend", "gadget_camo_break", 0, "mc/hud_outline_predator_camo_disruption_ally" );
    duplicate_render::set_dr_filter_framebuffer( "camo_brk", 70, "gadget_camo_on,gadget_camo_break", undefined, 0, "mc/hud_outline_predator_break" );
}

// Namespace squad_control
// Params 7
// Checksum 0x4eb77184, Offset: 0xa00
// Size: 0x27c
function ent_material_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    n_index = level.keyline_outline_indices[ fieldname ];
    e_player = getlocalplayer( localclientnum );
    
    if ( !isdefined( e_player ) || n_index != e_player getentitynumber() )
    {
        return;
    }
    
    assert( isdefined( self ), "<dev string:x28>" );
    level flagsys::wait_till( "duplicaterender_registry_ready" );
    assert( isdefined( self ), "<dev string:x4e>" );
    
    if ( newval == 1 )
    {
        self duplicate_render::change_dr_flags( localclientnum, "keyline_active_white", "keyfill_active_white" );
        return;
    }
    
    if ( newval == 2 )
    {
        self duplicate_render::change_dr_flags( localclientnum, "keyline_active_red", "keyfill_active_red" );
        return;
    }
    
    if ( newval == 3 )
    {
        self duplicate_render::change_dr_flags( localclientnum, "keyline_active_green", "keyfill_active_green" );
        return;
    }
    
    if ( newval == 4 )
    {
        self duplicate_render::change_dr_flags( localclientnum, "keyline_active_white_through_walls", "keyfill_active_white_through_walls" );
        return;
    }
    
    self duplicate_render::change_dr_flags( localclientnum, undefined, "keyline_active_white,keyfill_active_white" );
    self duplicate_render::change_dr_flags( localclientnum, undefined, "keyline_active_red,keyfill_active_red" );
    self duplicate_render::change_dr_flags( localclientnum, undefined, "keyline_active_green,keyfill_active_green" );
    self duplicate_render::change_dr_flags( localclientnum, undefined, "keyline_active_white_through_walls,keyfill_active_white_through_walls" );
}

// Namespace squad_control
// Params 7
// Checksum 0x2c2f2c53, Offset: 0xc88
// Size: 0xcc
function ent_camo_material_callback( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::set_dr_flag( "gadget_camo_flicker", newval == 2 );
    self duplicate_render::set_dr_flag( "gadget_camo_break", newval == 3 );
    self duplicate_render::set_dr_flag( "gadget_camo_on", newval != 0 );
    self duplicate_render::change_dr_flags( local_client_num );
}

// Namespace squad_control
// Params 7
// Checksum 0xc0dab579, Offset: 0xd60
// Size: 0xf4
function squad_indicator_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    n_index = level.squad_indicator_indices[ fieldname ];
    e_player = getlocalplayer( localclientnum );
    
    if ( !isdefined( e_player ) || n_index != e_player getentitynumber() )
    {
        return;
    }
    
    if ( newval === 1 )
    {
        self thread draw_squad_indicator( localclientnum );
        return;
    }
    
    if ( newval === 0 )
    {
        self thread delete_squad_indicator( localclientnum );
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xb5a6f6e3, Offset: 0xe60
// Size: 0xac
function draw_squad_indicator( localclientnum )
{
    self.fx_indicator = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles + ( -90, 0, 0 ) );
    self.fx_indicator linkto( self );
    self.fx_indicator_handle = playfxontag( localclientnum, level._effect[ "squad_waypoint_base_client" ], self.fx_indicator, "tag_origin" );
}

// Namespace squad_control
// Params 1
// Checksum 0xbcc6f4f8, Offset: 0xf18
// Size: 0x64
function delete_squad_indicator( localclientnum )
{
    if ( isdefined( self.fx_indicator_handle ) )
    {
        deletefx( localclientnum, self.fx_indicator_handle, 1 );
    }
    
    if ( isdefined( self.fx_indicator ) )
    {
        self.fx_indicator delete();
    }
}

