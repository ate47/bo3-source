#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_stock_option;

// Namespace zm_bgb_stock_option
// Params 0, eflags: 0x2
// Checksum 0x69aa66a0, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_stock_option", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_stock_option
// Params 0
// Checksum 0x60e3f36f, Offset: 0x1c8
// Size: 0x5c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_stock_option", "time", 180, &enable, &disable, undefined );
}

// Namespace zm_bgb_stock_option
// Params 0
// Checksum 0xc39de15c, Offset: 0x230
// Size: 0x24
function enable()
{
    self setperk( "specialty_ammodrainsfromstockfirst" );
}

// Namespace zm_bgb_stock_option
// Params 0
// Checksum 0x65f98b63, Offset: 0x260
// Size: 0x24
function disable()
{
    self unsetperk( "specialty_ammodrainsfromstockfirst" );
}

