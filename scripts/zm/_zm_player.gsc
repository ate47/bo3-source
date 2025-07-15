#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace zm_player;

// Namespace zm_player
// Params 0, eflags: 0x2
// Checksum 0xd4f4154d, Offset: 0xc0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_player", &__init__, undefined, undefined );
}

// Namespace zm_player
// Params 0
// Checksum 0x99ec1590, Offset: 0x100
// Size: 0x4
function __init__()
{
    
}

