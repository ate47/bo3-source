#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace island_shield;

// Namespace island_shield
// Params 0, eflags: 0x2
// Checksum 0xf2a669b9, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_island_shield", &__init__, undefined, undefined );
}

// Namespace island_shield
// Params 0
// Checksum 0x99ec1590, Offset: 0x190
// Size: 0x4
function __init__()
{
    
}

