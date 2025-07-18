#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_flavor_hexed;

// Namespace zm_bgb_flavor_hexed
// Params 0, eflags: 0x2
// Checksum 0xd48d2f3e, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_flavor_hexed", &__init__, undefined, undefined );
}

// Namespace zm_bgb_flavor_hexed
// Params 0
// Checksum 0x156dda0c, Offset: 0x1b0
// Size: 0x3c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_flavor_hexed", "event" );
}

