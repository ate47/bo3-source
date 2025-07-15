#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_security_breach;

// Namespace _gadget_security_breach
// Params 0, eflags: 0x2
// Checksum 0x325425cd, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_security_breach", &__init__, undefined, undefined );
}

// Namespace _gadget_security_breach
// Params 0
// Checksum 0x261418fb, Offset: 0x248
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 23, &gadget_security_breach_on, &gadget_security_breach_off );
    ability_player::register_gadget_possession_callbacks( 23, &gadget_security_breach_on_give, &gadget_security_breach_on_take );
    ability_player::register_gadget_flicker_callbacks( 23, &gadget_security_breach_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 23, &gadget_security_breach_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 23, &gadget_security_breach_is_flickering );
    ability_player::register_gadget_primed_callbacks( 23, &gadget_security_breach_is_primed );
    callback::on_connect( &gadget_security_breach_on_connect );
}

// Namespace _gadget_security_breach
// Params 1
// Checksum 0x59b207ff, Offset: 0x358
// Size: 0x2a
function gadget_security_breach_is_inuse( slot )
{
    return self flagsys::get( "gadget_security_breach_on" );
}

// Namespace _gadget_security_breach
// Params 1
// Checksum 0xe942b942, Offset: 0x390
// Size: 0x50
function gadget_security_breach_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._is_flickering ]]( slot );
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0xb4356e45, Offset: 0x3e8
// Size: 0x5c
function gadget_security_breach_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        self [[ level.cybercom.security_breach._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0x5b44aba4, Offset: 0x450
// Size: 0x5c
function gadget_security_breach_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0x1e55dfb7, Offset: 0x4b8
// Size: 0x5c
function gadget_security_breach_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_security_breach
// Params 0
// Checksum 0x60f5fc23, Offset: 0x520
// Size: 0x44
function gadget_security_breach_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._on_connect ]]();
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0xe829d52c, Offset: 0x570
// Size: 0x7c
function gadget_security_breach_on( slot, weapon )
{
    self flagsys::set( "gadget_security_breach_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._on ]]( slot, weapon );
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0x233804a1, Offset: 0x5f8
// Size: 0x7c
function gadget_security_breach_off( slot, weapon )
{
    self flagsys::clear( "gadget_security_breach_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        return self [[ level.cybercom.security_breach._off ]]( slot, weapon );
    }
}

// Namespace _gadget_security_breach
// Params 2
// Checksum 0xfc9f1239, Offset: 0x680
// Size: 0x5c
function gadget_security_breach_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.security_breach ) )
    {
        self [[ level.cybercom.security_breach._is_primed ]]( slot, weapon );
    }
}

