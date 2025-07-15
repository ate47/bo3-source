#namespace zm_moon_gravity;

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x99ec1590, Offset: 0x88
// Size: 0x4
function init()
{
    
}

// Namespace zm_moon_gravity
// Params 7
// Checksum 0xdb43cddc, Offset: 0x98
// Size: 0x78
function zombie_low_gravity( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        self.in_low_g = 1;
        return;
    }
    
    self.in_low_g = 0;
}

// Namespace zm_moon_gravity
// Params 7
// Checksum 0x20bb67be, Offset: 0x118
// Size: 0xc6
function function_20286238( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        if ( !isdefined( self.var_9f5aac3e ) )
        {
            self.var_9f5aac3e = self playloopsound( "zmb_moon_bg_airless" );
        }
        
        return;
    }
    
    if ( isdefined( self.var_9f5aac3e ) )
    {
        self stoploopsound( self.var_9f5aac3e );
        self.var_9f5aac3e = undefined;
    }
}

