#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_misdirection;

// Namespace _gadget_misdirection
// Params 0, eflags: 0x2
// Checksum 0x366f72b5, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_misdirection", &__init__, undefined, undefined );
}

// Namespace _gadget_misdirection
// Params 0
// Checksum 0xba529d87, Offset: 0x240
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 37, &gadget_misdirection_on, &gadget_misdirection_off );
    ability_player::register_gadget_possession_callbacks( 37, &gadget_misdirection_on_give, &gadget_misdirection_on_take );
    ability_player::register_gadget_flicker_callbacks( 37, &gadget_misdirection_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 37, &gadget_misdirection_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 37, &gadget_misdirection_is_flickering );
    ability_player::register_gadget_primed_callbacks( 37, &gadget_misdirection_is_primed );
    callback::on_connect( &gadget_misdirection_on_connect );
}

// Namespace _gadget_misdirection
// Params 1
// Checksum 0x810594ca, Offset: 0x350
// Size: 0x2a
function gadget_misdirection_is_inuse( slot )
{
    return self flagsys::get( "gadget_misdirection_on" );
}

// Namespace _gadget_misdirection
// Params 1
// Checksum 0xb6ba7d7e, Offset: 0x388
// Size: 0x52
function gadget_misdirection_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        return self [[ level.cybercom.misdirection._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0xd2b46ed1, Offset: 0x3e8
// Size: 0x5c
function gadget_misdirection_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0xcd4741d1, Offset: 0x450
// Size: 0x5c
function gadget_misdirection_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0x77169789, Offset: 0x4b8
// Size: 0x5c
function gadget_misdirection_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_misdirection
// Params 0
// Checksum 0xa5f3ae98, Offset: 0x520
// Size: 0x44
function gadget_misdirection_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._on_connect ]]();
    }
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0xc4a7ca46, Offset: 0x570
// Size: 0x7c
function gadget_misdirection_on( slot, weapon )
{
    self flagsys::set( "gadget_misdirection_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._on ]]( slot, weapon );
    }
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0xdbba940, Offset: 0x5f8
// Size: 0x7c
function gadget_misdirection_off( slot, weapon )
{
    self flagsys::clear( "gadget_misdirection_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._off ]]( slot, weapon );
    }
}

// Namespace _gadget_misdirection
// Params 2
// Checksum 0x852be4f8, Offset: 0x680
// Size: 0x5c
function gadget_misdirection_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.misdirection ) )
    {
        self [[ level.cybercom.misdirection._is_primed ]]( slot, weapon );
    }
}

