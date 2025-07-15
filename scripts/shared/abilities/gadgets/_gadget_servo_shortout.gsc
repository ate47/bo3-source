#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_servo_shortout;

// Namespace _gadget_servo_shortout
// Params 0, eflags: 0x2
// Checksum 0xfc351738, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_servo_shortout", &__init__, undefined, undefined );
}

// Namespace _gadget_servo_shortout
// Params 0
// Checksum 0xf5ac2b60, Offset: 0x240
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 19, &gadget_servo_shortout_on, &gadget_servo_shortout_off );
    ability_player::register_gadget_possession_callbacks( 19, &gadget_servo_shortout_on_give, &gadget_servo_shortout_on_take );
    ability_player::register_gadget_flicker_callbacks( 19, &gadget_servo_shortout_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 19, &gadget_servo_shortout_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 19, &gadget_servo_shortout_is_flickering );
    ability_player::register_gadget_primed_callbacks( 19, &gadget_servo_shortout_is_primed );
    callback::on_connect( &gadget_servo_shortout_on_connect );
}

// Namespace _gadget_servo_shortout
// Params 1
// Checksum 0xa1947ce, Offset: 0x350
// Size: 0x2a
function gadget_servo_shortout_is_inuse( slot )
{
    return self flagsys::get( "gadget_servo_shortout_on" );
}

// Namespace _gadget_servo_shortout
// Params 1
// Checksum 0x7ce502bd, Offset: 0x388
// Size: 0x52
function gadget_servo_shortout_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        return self [[ level.cybercom.servo_shortout._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0x3ecd3087, Offset: 0x3e8
// Size: 0x5c
function gadget_servo_shortout_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0x8f975b93, Offset: 0x450
// Size: 0x5c
function gadget_servo_shortout_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0xa7719e19, Offset: 0x4b8
// Size: 0x5c
function gadget_servo_shortout_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_servo_shortout
// Params 0
// Checksum 0x1ab08158, Offset: 0x520
// Size: 0x44
function gadget_servo_shortout_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._on_connect ]]();
    }
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0xfe610ab3, Offset: 0x570
// Size: 0x7c
function gadget_servo_shortout_on( slot, weapon )
{
    self flagsys::set( "gadget_servo_shortout_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._on ]]( slot, weapon );
    }
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0x8e79dd3c, Offset: 0x5f8
// Size: 0x7c
function gadget_servo_shortout_off( slot, weapon )
{
    self flagsys::clear( "gadget_servo_shortout_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._off ]]( slot, weapon );
    }
}

// Namespace _gadget_servo_shortout
// Params 2
// Checksum 0x634bf8a0, Offset: 0x680
// Size: 0x5c
function gadget_servo_shortout_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.servo_shortout ) )
    {
        self [[ level.cybercom.servo_shortout._is_primed ]]( slot, weapon );
    }
}

