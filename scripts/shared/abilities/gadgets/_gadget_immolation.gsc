#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_immolation;

// Namespace _gadget_immolation
// Params 0, eflags: 0x2
// Checksum 0x7386a8e4, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_immolation", &__init__, undefined, undefined );
}

// Namespace _gadget_immolation
// Params 0
// Checksum 0x59833e95, Offset: 0x238
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 34, &gadget_immolation_on, &gadget_immolation_off );
    ability_player::register_gadget_possession_callbacks( 34, &gadget_immolation_on_give, &gadget_immolation_on_take );
    ability_player::register_gadget_flicker_callbacks( 34, &gadget_immolation_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 34, &gadget_immolation_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 34, &gadget_immolation_is_flickering );
    ability_player::register_gadget_primed_callbacks( 34, &gadget_immolation_is_primed );
    callback::on_connect( &gadget_immolation_on_connect );
}

// Namespace _gadget_immolation
// Params 1
// Checksum 0x1e575ea3, Offset: 0x348
// Size: 0x2a
function gadget_immolation_is_inuse( slot )
{
    return self flagsys::get( "gadget_immolation_on" );
}

// Namespace _gadget_immolation
// Params 1
// Checksum 0x820d46fb, Offset: 0x380
// Size: 0x52
function gadget_immolation_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        return self [[ level.cybercom.immolation._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0x531734ba, Offset: 0x3e0
// Size: 0x5c
function gadget_immolation_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0xa6f7de5c, Offset: 0x448
// Size: 0x5c
function gadget_immolation_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0xb09f633c, Offset: 0x4b0
// Size: 0x5c
function gadget_immolation_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_immolation
// Params 0
// Checksum 0x628157dd, Offset: 0x518
// Size: 0x44
function gadget_immolation_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._on_connect ]]();
    }
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0x42c86d5e, Offset: 0x568
// Size: 0x7c
function gadget_immolation_on( slot, weapon )
{
    self flagsys::set( "gadget_immolation_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._on ]]( slot, weapon );
    }
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0xd44c22cd, Offset: 0x5f0
// Size: 0x7c
function gadget_immolation_off( slot, weapon )
{
    self flagsys::clear( "gadget_immolation_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._off ]]( slot, weapon );
    }
}

// Namespace _gadget_immolation
// Params 2
// Checksum 0x77610fcb, Offset: 0x678
// Size: 0x5c
function gadget_immolation_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.immolation ) )
    {
        self [[ level.cybercom.immolation._is_primed ]]( slot, weapon );
    }
}

