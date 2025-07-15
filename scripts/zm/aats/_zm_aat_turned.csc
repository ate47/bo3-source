#using scripts/shared/aat_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_aat_turned;

// Namespace zm_aat_turned
// Params 0, eflags: 0x2
// Checksum 0xf81d8648, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_aat_turned", &__init__, undefined, undefined );
}

// Namespace zm_aat_turned
// Params 0
// Checksum 0x392d117a, Offset: 0x1d0
// Size: 0x8c
function __init__()
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    aat::register( "zm_aat_turned", "zmui_zm_aat_turned", "t7_icon_zm_aat_turned" );
    clientfield::register( "actor", "zm_aat_turned", 1, 1, "int", &zm_aat_turned_cb, 0, 0 );
}

// Namespace zm_aat_turned
// Params 7
// Checksum 0xdf75bb67, Offset: 0x268
// Size: 0x166
function zm_aat_turned_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self setdrawname( makelocalizedstring( "zmui_zm_aat_turned" ), 1 );
        self.fx_aat_turned_eyes = playfxontag( localclientnum, "zombie/fx_glow_eye_green", self, "j_eyeball_le" );
        self.fx_aat_turned_torso = playfxontag( localclientnum, "zombie/fx_aat_turned_spore_torso_zmb", self, "j_spine4" );
        self playsound( localclientnum, "" );
        return;
    }
    
    if ( isdefined( self.fx_aat_turned_eyes ) )
    {
        stopfx( localclientnum, self.fx_aat_turned_eyes );
        self.fx_aat_turned_eyes = undefined;
    }
    
    if ( isdefined( self.fx_aat_turned_torso ) )
    {
        stopfx( localclientnum, self.fx_aat_turned_torso );
        self.fx_aat_turned_torso = undefined;
    }
}

