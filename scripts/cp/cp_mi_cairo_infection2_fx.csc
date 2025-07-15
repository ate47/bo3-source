#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace infection2_fx;

// Namespace infection2_fx
// Params 0, eflags: 0x2
// Checksum 0xbe4f708b, Offset: 0x120
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "infection2_fx", &__init__, undefined, undefined );
}

// Namespace infection2_fx
// Params 0
// Checksum 0x29bf35d9, Offset: 0x160
// Size: 0x24
function __init__()
{
    init_fx();
    init_clientfields();
}

// Namespace infection2_fx
// Params 0
// Checksum 0xd790ca4, Offset: 0x190
// Size: 0x1e
function init_fx()
{
    level._effect[ "water_motes" ] = "water/fx_underwater_debris_player_loop";
}

// Namespace infection2_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0x1b8
// Size: 0x4
function init_clientfields()
{
    
}

