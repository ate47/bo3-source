#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_surge;

// Namespace _gadget_surge
// Params 0, eflags: 0x2
// Checksum 0xbcc14f7b, Offset: 0x1e0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_surge", &__init__, undefined, undefined );
}

// Namespace _gadget_surge
// Params 0
// Checksum 0x99ec1590, Offset: 0x220
// Size: 0x4
function __init__()
{
    
}

