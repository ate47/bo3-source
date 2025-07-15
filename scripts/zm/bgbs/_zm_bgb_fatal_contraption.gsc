#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_fatal_contraption;

// Namespace zm_bgb_fatal_contraption
// Params 0, eflags: 0x2
// Checksum 0x538f92b6, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_fatal_contraption", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_fatal_contraption
// Params 0
// Checksum 0x1f90d123, Offset: 0x1b8
// Size: 0x54
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_fatal_contraption", "activated", 2, undefined, undefined, undefined, &activation );
}

// Namespace zm_bgb_fatal_contraption
// Params 0
// Checksum 0xf14a24cb, Offset: 0x218
// Size: 0x24
function activation()
{
    self thread bgb::function_dea74fb0( "minigun" );
}

