#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_lucky_crit;

// Namespace zm_bgb_lucky_crit
// Params 0, eflags: 0x2
// Checksum 0xae8ac95e, Offset: 0x178
// Size: 0x4c
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_lucky_crit", &__init__, undefined, array( "aat", "bgb" ) );
}

// Namespace zm_bgb_lucky_crit
// Params 0
// Checksum 0xb37e3abf, Offset: 0x1d0
// Size: 0x94
function __init__()
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) || !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_lucky_crit", "rounds", 1, undefined, undefined, undefined );
    aat::register_reroll( "zm_bgb_lucky_crit", 2, &active, "t7_hud_zm_aat_bgb" );
}

// Namespace zm_bgb_lucky_crit
// Params 0
// Checksum 0xe867df8d, Offset: 0x270
// Size: 0x1a
function active()
{
    return bgb::is_enabled( "zm_bgb_lucky_crit" );
}

