#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_aftertaste;

// Namespace zm_bgb_aftertaste
// Params 0, eflags: 0x2
// Checksum 0xcf8d4385, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_aftertaste", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_aftertaste
// Params 0
// Checksum 0xe0eca87a, Offset: 0x218
// Size: 0x7c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_aftertaste", "rounds", 3, &event, undefined, undefined, undefined );
    bgb::register_lost_perk_override( "zm_bgb_aftertaste", &lost_perk_override, 0 );
}

// Namespace zm_bgb_aftertaste
// Params 3
// Checksum 0x259233de, Offset: 0x2a0
// Size: 0x9c
function lost_perk_override( perk, var_2488e46a, var_24df4040 )
{
    if ( !isdefined( var_2488e46a ) )
    {
        var_2488e46a = undefined;
    }
    
    if ( !isdefined( var_24df4040 ) )
    {
        var_24df4040 = undefined;
    }
    
    if ( zm_perks::use_solo_revive() && perk == "specialty_quickrevive" )
    {
        return 0;
    }
    
    if ( isdefined( var_2488e46a ) && isdefined( var_24df4040 ) && var_2488e46a == var_24df4040 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_bgb_aftertaste
// Params 0
// Checksum 0x7705807e, Offset: 0x348
// Size: 0x58
function event()
{
    self endon( #"disconnect" );
    self endon( #"bled_out" );
    self endon( #"bgb_update" );
    
    while ( true )
    {
        self waittill( #"player_downed" );
        self bgb::do_one_shot_use( 1 );
    }
}

