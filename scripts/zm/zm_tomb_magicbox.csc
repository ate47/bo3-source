#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace tomb_magicbox;

// Namespace tomb_magicbox
// Params 0, eflags: 0x2
// Checksum 0x92f4c972, Offset: 0x220
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tomb_magicbox", &__init__, undefined, undefined );
}

// Namespace tomb_magicbox
// Params 0
// Checksum 0x16db8f03, Offset: 0x260
// Size: 0x124
function __init__()
{
    clientfield::register( "zbarrier", "magicbox_initial_fx", 21000, 1, "int", &magicbox_initial_closed_fx, 0, 0 );
    clientfield::register( "zbarrier", "magicbox_amb_fx", 21000, 2, "int", &magicbox_ambient_fx, 0, 0 );
    clientfield::register( "zbarrier", "magicbox_open_fx", 21000, 1, "int", &magicbox_open_fx, 0, 0 );
    clientfield::register( "zbarrier", "magicbox_leaving_fx", 21000, 1, "int", &magicbox_leaving_fx, 0, 0 );
}

// Namespace tomb_magicbox
// Params 7
// Checksum 0x8d02cd90, Offset: 0x390
// Size: 0x104
function magicbox_leaving_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( self.fx_obj ) )
    {
        self.fx_obj = spawn( localclientnum, self.origin, "script_model" );
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel( "tag_origin" );
    }
    
    if ( newval == 1 )
    {
        self.fx_obj.curr_leaving_fx = playfxontag( localclientnum, level._effect[ "box_is_leaving" ], self.fx_obj, "tag_origin" );
    }
}

// Namespace tomb_magicbox
// Params 7
// Checksum 0xe0cb8762, Offset: 0x4a0
// Size: 0x20c
function magicbox_open_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( self.fx_obj ) )
    {
        self.fx_obj = spawn( localclientnum, self.origin, "script_model" );
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel( "tag_origin" );
    }
    
    if ( !isdefined( self.fx_obj_2 ) )
    {
        self.fx_obj_2 = spawn( localclientnum, self.origin, "script_model" );
        self.fx_obj_2.angles = self.angles;
        self.fx_obj_2 setmodel( "tag_origin" );
    }
    
    if ( newval == 0 )
    {
        stopfx( localclientnum, self.fx_obj.curr_open_fx );
        self.fx_obj_2 stoploopsound( 1 );
        self notify( #"magicbox_portal_finished" );
        return;
    }
    
    if ( newval == 1 )
    {
        self.fx_obj.curr_open_fx = playfxontag( localclientnum, level._effect[ "box_is_open" ], self.fx_obj, "tag_origin" );
        self.fx_obj_2 playloopsound( "zmb_hellbox_open_effect" );
        self thread fx_magicbox_portal( localclientnum );
    }
}

// Namespace tomb_magicbox
// Params 1
// Checksum 0x56ec1106, Offset: 0x6b8
// Size: 0x8c
function fx_magicbox_portal( localclientnum )
{
    wait 0.5;
    self.fx_obj_2.curr_portal_fx = playfxontag( localclientnum, level._effect[ "box_portal" ], self.fx_obj_2, "tag_origin" );
    self waittill( #"magicbox_portal_finished" );
    stopfx( localclientnum, self.fx_obj_2.curr_portal_fx );
}

// Namespace tomb_magicbox
// Params 7
// Checksum 0xe6a4def0, Offset: 0x750
// Size: 0xe4
function magicbox_initial_closed_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( self.fx_obj ) )
    {
        self.fx_obj = spawn( localclientnum, self.origin, "script_model" );
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel( "tag_origin" );
    }
    else
    {
        return;
    }
    
    if ( newval == 1 )
    {
        self.fx_obj playloopsound( "zmb_hellbox_amb_low" );
    }
}

// Namespace tomb_magicbox
// Params 7
// Checksum 0x9fac0535, Offset: 0x840
// Size: 0x474
function magicbox_ambient_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( self.fx_obj ) )
    {
        self.fx_obj = spawn( localclientnum, self.origin, "script_model" );
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel( "tag_origin" );
    }
    
    if ( isdefined( self.fx_obj.curr_amb_fx ) )
    {
        stopfx( localclientnum, self.fx_obj.curr_amb_fx );
    }
    
    if ( isdefined( self.fx_obj.curr_amb_fx_power ) )
    {
        stopfx( localclientnum, self.fx_obj.curr_amb_fx_power );
    }
    
    if ( newval == 0 )
    {
        self.fx_obj playloopsound( "zmb_hellbox_amb_low" );
        playsound( 0, "zmb_hellbox_leave", self.fx_obj.origin );
        stopfx( localclientnum, self.fx_obj.curr_amb_fx );
        return;
    }
    
    if ( newval == 1 )
    {
        self.fx_obj.curr_amb_fx_power = playfxontag( localclientnum, level._effect[ "box_unpowered" ], self.fx_obj, "tag_origin" );
        self.fx_obj.curr_amb_fx = playfxontag( localclientnum, level._effect[ "box_here_ambient" ], self.fx_obj, "tag_origin" );
        self.fx_obj playloopsound( "zmb_hellbox_amb_low" );
        playsound( 0, "zmb_hellbox_arrive", self.fx_obj.origin );
        return;
    }
    
    if ( newval == 2 )
    {
        self.fx_obj.curr_amb_fx_power = playfxontag( localclientnum, level._effect[ "box_powered" ], self.fx_obj, "tag_origin" );
        self.fx_obj.curr_amb_fx = playfxontag( localclientnum, level._effect[ "box_here_ambient" ], self.fx_obj, "tag_origin" );
        self.fx_obj playloopsound( "zmb_hellbox_amb_high" );
        playsound( 0, "zmb_hellbox_arrive", self.fx_obj.origin );
        return;
    }
    
    if ( newval == 3 )
    {
        self.fx_obj.curr_amb_fx_power = playfxontag( localclientnum, level._effect[ "box_unpowered" ], self.fx_obj, "tag_origin" );
        self.fx_obj.curr_amb_fx = playfxontag( localclientnum, level._effect[ "box_gone_ambient" ], self.fx_obj, "tag_origin" );
        self.fx_obj playloopsound( "zmb_hellbox_amb_high" );
        playsound( 0, "zmb_hellbox_leave", self.fx_obj.origin );
    }
}

