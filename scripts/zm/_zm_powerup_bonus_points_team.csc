#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_bonus_points_team;

// Namespace zm_powerup_bonus_points_team
// Params 0, eflags: 0x2
// Checksum 0xbc35deb, Offset: 0x108
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_bonus_points_team", &__init__, undefined, undefined );
}

// Namespace zm_powerup_bonus_points_team
// Params 0
// Checksum 0x7fddc961, Offset: 0x148
// Size: 0x34
function __init__()
{
    zm_powerups::include_zombie_powerup( "bonus_points_team" );
    zm_powerups::add_zombie_powerup( "bonus_points_team" );
}

