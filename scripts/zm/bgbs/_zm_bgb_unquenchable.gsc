#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_unquenchable;

// Namespace zm_bgb_unquenchable
// Params 0, eflags: 0x2
// Checksum 0xc9aaf7e7, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_unquenchable", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_unquenchable
// Params 0
// Checksum 0x98f6e7ac, Offset: 0x188
// Size: 0x54
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_unquenchable", "event", &event, undefined, undefined, undefined );
}

// Namespace zm_bgb_unquenchable
// Params 0
// Checksum 0x23d1decd, Offset: 0x1e8
// Size: 0x64
function event()
{
    self endon( #"disconnect" );
    self endon( #"bgb_update" );
    
    do
    {
        self waittill( #"perk_purchased" );
    }
    while ( self.num_perks < self zm_utility::get_player_perk_purchase_limit() );
    
    self bgb::do_one_shot_use( 1 );
}

