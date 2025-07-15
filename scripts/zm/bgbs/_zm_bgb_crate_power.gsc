#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_crate_power;

// Namespace zm_bgb_crate_power
// Params 0, eflags: 0x2
// Checksum 0xcb70fb5b, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_crate_power", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_crate_power
// Params 0
// Checksum 0xdb6c86f1, Offset: 0x1b8
// Size: 0x54
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_crate_power", "event", &event, undefined, undefined, undefined );
}

// Namespace zm_bgb_crate_power
// Params 0
// Checksum 0x1345ac68, Offset: 0x218
// Size: 0x5c
function event()
{
    self endon( #"disconnect" );
    self endon( #"bgb_update" );
    self waittill( #"zm_bgb_crate_power_used" );
    self playsoundtoplayer( "zmb_bgb_crate_power", self );
    self bgb::do_one_shot_use();
}

