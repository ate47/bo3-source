#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_ww_grenade;

// Namespace zm_powerup_ww_grenade
// Params 0, eflags: 0x2
// Checksum 0x4531185b, Offset: 0xf8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_ww_grenade", &__init__, undefined, undefined );
}

// Namespace zm_powerup_ww_grenade
// Params 0
// Checksum 0x71205521, Offset: 0x138
// Size: 0x34
function __init__()
{
    zm_powerups::include_zombie_powerup( "ww_grenade" );
    zm_powerups::add_zombie_powerup( "ww_grenade" );
}

