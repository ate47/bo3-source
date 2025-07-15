#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_cacophany;

// Namespace _gadget_cacophany
// Params 0, eflags: 0x2
// Checksum 0xe4f7c4a2, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_cacophany", &__init__, undefined, undefined );
}

// Namespace _gadget_cacophany
// Params 0
// Checksum 0xdade025c, Offset: 0x238
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 25, &gadget_cacophany_on, &gadget_cacophany_off );
    ability_player::register_gadget_possession_callbacks( 25, &gadget_cacophany_on_give, &gadget_cacophany_on_take );
    ability_player::register_gadget_flicker_callbacks( 25, &gadget_cacophany_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 25, &gadget_cacophany_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 25, &gadget_cacophany_is_flickering );
    ability_player::register_gadget_primed_callbacks( 25, &gadget_cacophany_is_primed );
    callback::on_connect( &gadget_cacophany_on_connect );
}

// Namespace _gadget_cacophany
// Params 1
// Checksum 0x140b76fb, Offset: 0x348
// Size: 0x2a
function gadget_cacophany_is_inuse( slot )
{
    return self flagsys::get( "gadget_cacophany_on" );
}

// Namespace _gadget_cacophany
// Params 1
// Checksum 0xe45529d, Offset: 0x380
// Size: 0x50
function gadget_cacophany_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        return self [[ level.cybercom.cacophany._is_flickering ]]( slot );
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0x62a53a39, Offset: 0x3d8
// Size: 0x5c
function gadget_cacophany_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0xf34173e7, Offset: 0x440
// Size: 0x5c
function gadget_cacophany_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0xa18b2384, Offset: 0x4a8
// Size: 0x5c
function gadget_cacophany_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_cacophany
// Params 0
// Checksum 0xbdd3ca4b, Offset: 0x510
// Size: 0x44
function gadget_cacophany_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._on_connect ]]();
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0x814517fd, Offset: 0x560
// Size: 0x7c
function gadget_cacophany_on( slot, weapon )
{
    self flagsys::set( "gadget_cacophany_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._on ]]( slot, weapon );
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0x8afb5c82, Offset: 0x5e8
// Size: 0x7c
function gadget_cacophany_off( slot, weapon )
{
    self flagsys::clear( "gadget_cacophany_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._off ]]( slot, weapon );
    }
}

// Namespace _gadget_cacophany
// Params 2
// Checksum 0xeb357b7b, Offset: 0x670
// Size: 0x5c
function gadget_cacophany_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.cacophany ) )
    {
        self [[ level.cybercom.cacophany._is_primed ]]( slot, weapon );
    }
}

