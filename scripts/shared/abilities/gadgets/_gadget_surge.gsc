#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_surge;

// Namespace _gadget_surge
// Params 0, eflags: 0x2
// Checksum 0x5054829d, Offset: 0x1e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_surge", &__init__, undefined, undefined );
}

// Namespace _gadget_surge
// Params 0
// Checksum 0x4e01d168, Offset: 0x228
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 21, &gadget_surge_on, &gadget_surge_off );
    ability_player::register_gadget_possession_callbacks( 21, &gadget_surge_on_give, &gadget_surge_on_take );
    ability_player::register_gadget_flicker_callbacks( 21, &gadget_surge_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 21, &gadget_surge_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 21, &gadget_surge_is_flickering );
    ability_player::register_gadget_primed_callbacks( 21, &gadget_surge_is_primed );
    callback::on_connect( &gadget_surge_on_connect );
}

// Namespace _gadget_surge
// Params 1
// Checksum 0x479ba9b7, Offset: 0x338
// Size: 0x2a
function gadget_surge_is_inuse( slot )
{
    return self flagsys::get( "gadget_surge_on" );
}

// Namespace _gadget_surge
// Params 1
// Checksum 0xa3440021, Offset: 0x370
// Size: 0x50
function gadget_surge_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        return self [[ level.cybercom.surge._is_flickering ]]( slot );
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0xa3f92999, Offset: 0x3c8
// Size: 0x5c
function gadget_surge_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0xbd42d0e6, Offset: 0x430
// Size: 0x5c
function gadget_surge_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0x7aab1492, Offset: 0x498
// Size: 0x5c
function gadget_surge_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_surge
// Params 0
// Checksum 0xbe74f5e1, Offset: 0x500
// Size: 0x44
function gadget_surge_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._on_connect ]]();
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0xd4d2a9ec, Offset: 0x550
// Size: 0x7c
function gadget_surge_on( slot, weapon )
{
    self flagsys::set( "gadget_surge_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._on ]]( slot, weapon );
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0xba460725, Offset: 0x5d8
// Size: 0x7c
function gadget_surge_off( slot, weapon )
{
    self flagsys::clear( "gadget_surge_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._off ]]( slot, weapon );
    }
}

// Namespace _gadget_surge
// Params 2
// Checksum 0x53fe9c60, Offset: 0x660
// Size: 0x5c
function gadget_surge_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.surge ) )
    {
        self [[ level.cybercom.surge._is_primed ]]( slot, weapon );
    }
}

