#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_unbearable;

// Namespace zm_bgb_unbearable
// Params 0, eflags: 0x2
// Checksum 0x6a21cc2c, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_unbearable", &__init__, undefined, undefined );
}

// Namespace zm_bgb_unbearable
// Params 0
// Checksum 0x64aaf439, Offset: 0x1e0
// Size: 0x9e
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_unbearable", "event" );
    clientfield::register( "zbarrier", "zm_bgb_unbearable", 1, 1, "counter", &function_cd297226, 0, 0 );
    level._effect[ "zm_bgb_unbearable" ] = "zombie/fx_bgb_unbearable_box_flash_zmb";
}

// Namespace zm_bgb_unbearable
// Params 7
// Checksum 0x549d0cef, Offset: 0x288
// Size: 0x9c
function function_cd297226( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfx( localclientnum, level._effect[ "zm_bgb_unbearable" ], self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
}

