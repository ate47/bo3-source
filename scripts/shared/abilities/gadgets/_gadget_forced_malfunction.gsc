#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_forced_malfunction;

// Namespace _gadget_forced_malfunction
// Params 0, eflags: 0x2
// Checksum 0xe82cb185, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_forced_malfunction", &__init__, undefined, undefined );
}

// Namespace _gadget_forced_malfunction
// Params 0
// Checksum 0x6c35a947, Offset: 0x250
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 26, &gadget_forced_malfunction_on, &gadget_forced_malfunction_off );
    ability_player::register_gadget_possession_callbacks( 26, &gadget_forced_malfunction_on_give, &gadget_forced_malfunction_on_take );
    ability_player::register_gadget_flicker_callbacks( 26, &gadget_forced_malfunction_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 26, &gadget_forced_malfunction_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 26, &gadget_forced_malfunction_is_flickering );
    ability_player::register_gadget_primed_callbacks( 26, &gadget_forced_malfunction_is_primed );
    callback::on_connect( &gadget_forced_malfunction_on_connect );
}

// Namespace _gadget_forced_malfunction
// Params 1
// Checksum 0x16e431eb, Offset: 0x360
// Size: 0x2a
function gadget_forced_malfunction_is_inuse( slot )
{
    return self flagsys::get( "gadget_forced_malfunction_on" );
}

// Namespace _gadget_forced_malfunction
// Params 1
// Checksum 0xde2d8b7b, Offset: 0x398
// Size: 0x52
function gadget_forced_malfunction_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        return self [[ level.cybercom.forced_malfunction._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0xf1a12940, Offset: 0x3f8
// Size: 0x5c
function gadget_forced_malfunction_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0x2c427bf9, Offset: 0x460
// Size: 0x5c
function gadget_forced_malfunction_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0x919a5368, Offset: 0x4c8
// Size: 0x5c
function gadget_forced_malfunction_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_forced_malfunction
// Params 0
// Checksum 0x3f4a58b0, Offset: 0x530
// Size: 0x44
function gadget_forced_malfunction_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._on_connect ]]();
    }
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0x538e7c3f, Offset: 0x580
// Size: 0x7c
function gadget_forced_malfunction_on( slot, weapon )
{
    self flagsys::set( "gadget_forced_malfunction_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._on ]]( slot, weapon );
    }
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0x568bc55, Offset: 0x608
// Size: 0x7c
function gadget_forced_malfunction_off( slot, weapon )
{
    self flagsys::clear( "gadget_forced_malfunction_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._off ]]( slot, weapon );
    }
}

// Namespace _gadget_forced_malfunction
// Params 2
// Checksum 0x72655020, Offset: 0x690
// Size: 0x5c
function gadget_forced_malfunction_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.forced_malfunction ) )
    {
        self [[ level.cybercom.forced_malfunction._is_primed ]]( slot, weapon );
    }
}

