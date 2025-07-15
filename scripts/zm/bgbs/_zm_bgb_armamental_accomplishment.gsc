#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_armamental_accomplishment;

// Namespace zm_bgb_armamental_accomplishment
// Params 0, eflags: 0x2
// Checksum 0xb735fb7a, Offset: 0x1e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_armamental_accomplishment", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_armamental_accomplishment
// Params 0
// Checksum 0x75406cc4, Offset: 0x228
// Size: 0x5c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_armamental_accomplishment", "rounds", 3, &enable, &disable, undefined );
}

// Namespace zm_bgb_armamental_accomplishment
// Params 0
// Checksum 0x403e80bf, Offset: 0x290
// Size: 0x84
function enable()
{
    self setperk( "specialty_fastmeleerecovery" );
    self setperk( "specialty_fastweaponswitch" );
    self setperk( "specialty_fastequipmentuse" );
    self setperk( "specialty_fasttoss" );
}

// Namespace zm_bgb_armamental_accomplishment
// Params 0
// Checksum 0x7bba458a, Offset: 0x320
// Size: 0x84
function disable()
{
    self unsetperk( "specialty_fastmeleerecovery" );
    self unsetperk( "specialty_fastweaponswitch" );
    self unsetperk( "specialty_fastequipmentuse" );
    self unsetperk( "specialty_fasttoss" );
}

