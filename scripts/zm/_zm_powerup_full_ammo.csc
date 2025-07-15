#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo
// Params 0, eflags: 0x2
// Checksum 0xf9f02082, Offset: 0x108
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_full_ammo", &__init__, undefined, undefined );
}

// Namespace zm_powerup_full_ammo
// Params 0
// Checksum 0xb1f6d697, Offset: 0x148
// Size: 0x6c
function __init__()
{
    zm_powerups::include_zombie_powerup( "full_ammo" );
    
    if ( tolower( getdvarstring( "g_gametype" ) ) != "zcleansed" )
    {
        zm_powerups::add_zombie_powerup( "full_ammo" );
    }
}

