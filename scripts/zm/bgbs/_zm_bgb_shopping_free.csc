#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_shopping_free;

// Namespace zm_bgb_shopping_free
// Params 0, eflags: 0x2
// Checksum 0xa41f1d17, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_shopping_free", &__init__, undefined, undefined );
}

// Namespace zm_bgb_shopping_free
// Params 0
// Checksum 0x357a42e, Offset: 0x188
// Size: 0x3c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_shopping_free", "time" );
}

