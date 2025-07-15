#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_smokescreen;

// Namespace _gadget_smokescreen
// Params 0, eflags: 0x2
// Checksum 0x950ef401, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_smokescreen", &__init__, undefined, undefined );
}

// Namespace _gadget_smokescreen
// Params 0
// Checksum 0x542e3f35, Offset: 0x238
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 36, &gadget_smokescreen_on, &gadget_smokescreen_off );
    ability_player::register_gadget_possession_callbacks( 36, &gadget_smokescreen_on_give, &gadget_smokescreen_on_take );
    ability_player::register_gadget_flicker_callbacks( 36, &gadget_smokescreen_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 36, &gadget_smokescreen_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 36, &gadget_smokescreen_is_flickering );
    ability_player::register_gadget_primed_callbacks( 36, &gadget_smokescreen_is_primed );
    callback::on_connect( &gadget_smokescreen_on_connect );
}

// Namespace _gadget_smokescreen
// Params 1
// Checksum 0x64d4ad85, Offset: 0x348
// Size: 0x2a
function gadget_smokescreen_is_inuse( slot )
{
    return self flagsys::get( "gadget_smokescreen_on" );
}

// Namespace _gadget_smokescreen
// Params 1
// Checksum 0x3162b952, Offset: 0x380
// Size: 0x52
function gadget_smokescreen_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        return self [[ level.cybercom.smokescreen._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0xfce089fb, Offset: 0x3e0
// Size: 0x5c
function gadget_smokescreen_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0xfee3f793, Offset: 0x448
// Size: 0x5c
function gadget_smokescreen_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0x475fc9d3, Offset: 0x4b0
// Size: 0x5c
function gadget_smokescreen_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_smokescreen
// Params 0
// Checksum 0xe9880bca, Offset: 0x518
// Size: 0x44
function gadget_smokescreen_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._on_connect ]]();
    }
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0xa7c80e55, Offset: 0x568
// Size: 0x7c
function gadget_smokescreen_on( slot, weapon )
{
    self flagsys::set( "gadget_smokescreen_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._on ]]( slot, weapon );
    }
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0xfc69ed78, Offset: 0x5f0
// Size: 0x7c
function gadget_smokescreen_off( slot, weapon )
{
    self flagsys::clear( "gadget_smokescreen_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._off ]]( slot, weapon );
    }
}

// Namespace _gadget_smokescreen
// Params 2
// Checksum 0x7c07e269, Offset: 0x678
// Size: 0x5c
function gadget_smokescreen_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.smokescreen ) )
    {
        self [[ level.cybercom.smokescreen._is_primed ]]( slot, weapon );
    }
}

