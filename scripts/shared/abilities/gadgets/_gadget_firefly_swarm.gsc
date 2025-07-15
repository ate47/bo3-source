#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_firefly_swarm;

// Namespace _gadget_firefly_swarm
// Params 0, eflags: 0x2
// Checksum 0xed6c97b6, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_firefly_swarm", &__init__, undefined, undefined );
}

// Namespace _gadget_firefly_swarm
// Params 0
// Checksum 0xb4f0f09d, Offset: 0x240
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 35, &gadget_firefly_swarm_on, &gadget_firefly_swarm_off );
    ability_player::register_gadget_possession_callbacks( 35, &gadget_firefly_swarm_on_give, &gadget_firefly_swarm_on_take );
    ability_player::register_gadget_flicker_callbacks( 35, &gadget_firefly_swarm_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 35, &gadget_firefly_swarm_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 35, &gadget_firefly_swarm_is_flickering );
    ability_player::register_gadget_primed_callbacks( 35, &gadget_firefly_is_primed );
    callback::on_connect( &gadget_firefly_swarm_on_connect );
}

// Namespace _gadget_firefly_swarm
// Params 1
// Checksum 0xc4f078d8, Offset: 0x350
// Size: 0x2a
function gadget_firefly_swarm_is_inuse( slot )
{
    return self flagsys::get( "gadget_firefly_swarm_on" );
}

// Namespace _gadget_firefly_swarm
// Params 1
// Checksum 0x1279f92d, Offset: 0x388
// Size: 0x52
function gadget_firefly_swarm_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        return self [[ level.cybercom.firefly_swarm._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0xf7620f68, Offset: 0x3e8
// Size: 0x5c
function gadget_firefly_swarm_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0xbf0287b7, Offset: 0x450
// Size: 0x5c
function gadget_firefly_swarm_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0xd9bcdef9, Offset: 0x4b8
// Size: 0x5c
function gadget_firefly_swarm_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_firefly_swarm
// Params 0
// Checksum 0xe438e0c7, Offset: 0x520
// Size: 0x44
function gadget_firefly_swarm_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._on_connect ]]();
    }
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0xeb4fd8e, Offset: 0x570
// Size: 0x7c
function gadget_firefly_swarm_on( slot, weapon )
{
    self flagsys::set( "gadget_firefly_swarm_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._on ]]( slot, weapon );
    }
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0x4fc65ed3, Offset: 0x5f8
// Size: 0x7c
function gadget_firefly_swarm_off( slot, weapon )
{
    self flagsys::clear( "gadget_firefly_swarm_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._off ]]( slot, weapon );
    }
}

// Namespace _gadget_firefly_swarm
// Params 2
// Checksum 0xe7bee8a2, Offset: 0x680
// Size: 0x5c
function gadget_firefly_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.firefly_swarm ) )
    {
        self [[ level.cybercom.firefly_swarm._is_primed ]]( slot, weapon );
    }
}

