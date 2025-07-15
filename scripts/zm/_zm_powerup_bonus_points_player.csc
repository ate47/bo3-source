#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player
// Params 0, eflags: 0x2
// Checksum 0xf22cb0ee, Offset: 0x110
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_bonus_points_player", &__init__, undefined, undefined );
}

// Namespace zm_powerup_bonus_points_player
// Params 0
// Checksum 0x2932e133, Offset: 0x150
// Size: 0x34
function __init__()
{
    zm_powerups::include_zombie_powerup( "bonus_points_player" );
    zm_powerups::add_zombie_powerup( "bonus_points_player" );
}

