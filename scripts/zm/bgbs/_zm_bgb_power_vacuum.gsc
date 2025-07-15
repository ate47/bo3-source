#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_power_vacuum;

// Namespace zm_bgb_power_vacuum
// Params 0, eflags: 0x2
// Checksum 0xa3aebfb3, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_power_vacuum", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_power_vacuum
// Params 0
// Checksum 0x3550de5f, Offset: 0x1a8
// Size: 0x5c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_power_vacuum", "rounds", 4, &enable, &disable, undefined );
}

// Namespace zm_bgb_power_vacuum
// Params 0
// Checksum 0xf6c1e19d, Offset: 0x210
// Size: 0x6c
function enable()
{
    self endon( #"disconnect" );
    self endon( #"bled_out" );
    self endon( #"bgb_update" );
    level.powerup_drop_count = 0;
    
    while ( true )
    {
        level waittill( #"powerup_dropped" );
        self bgb::do_one_shot_use();
        level.powerup_drop_count = 0;
    }
}

// Namespace zm_bgb_power_vacuum
// Params 0
// Checksum 0x99ec1590, Offset: 0x288
// Size: 0x4
function disable()
{
    
}

