#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_sensory_overload;

// Namespace _gadget_sensory_overload
// Params 0, eflags: 0x2
// Checksum 0xf277f895, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_sensory_overload", &__init__, undefined, undefined );
}

// Namespace _gadget_sensory_overload
// Params 0
// Checksum 0x43aef0c1, Offset: 0x248
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 32, &gadget_sensory_overload_on, &gadget_sensory_overload_off );
    ability_player::register_gadget_possession_callbacks( 32, &gadget_sensory_overload_on_give, &gadget_sensory_overload_on_take );
    ability_player::register_gadget_flicker_callbacks( 32, &gadget_sensory_overload_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 32, &gadget_sensory_overload_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 32, &gadget_sensory_overload_is_flickering );
    ability_player::register_gadget_primed_callbacks( 32, &gadget_sensory_overload_is_primed );
    callback::on_connect( &gadget_sensory_overload_on_connect );
}

// Namespace _gadget_sensory_overload
// Params 1
// Checksum 0x7e9dcdfa, Offset: 0x358
// Size: 0x2a
function gadget_sensory_overload_is_inuse( slot )
{
    return self flagsys::get( "gadget_sensory_overload_on" );
}

// Namespace _gadget_sensory_overload
// Params 1
// Checksum 0x439f93ed, Offset: 0x390
// Size: 0x50
function gadget_sensory_overload_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        return self [[ level.cybercom.sensory_overload._is_flickering ]]( slot );
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0x703c057d, Offset: 0x3e8
// Size: 0x5c
function gadget_sensory_overload_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0x52cb46d2, Offset: 0x450
// Size: 0x5c
function gadget_sensory_overload_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0xd0450bbe, Offset: 0x4b8
// Size: 0x5c
function gadget_sensory_overload_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_sensory_overload
// Params 0
// Checksum 0xa60e45dd, Offset: 0x520
// Size: 0x44
function gadget_sensory_overload_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._on_connect ]]();
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0xac573097, Offset: 0x570
// Size: 0x7c
function gadget_sensory_overload_on( slot, weapon )
{
    self flagsys::set( "gadget_sensory_overload_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._on ]]( slot, weapon );
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0xfbc541f9, Offset: 0x5f8
// Size: 0x7c
function gadget_sensory_overload_off( slot, weapon )
{
    self flagsys::clear( "gadget_sensory_overload_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._off ]]( slot, weapon );
    }
}

// Namespace _gadget_sensory_overload
// Params 2
// Checksum 0xfd203c50, Offset: 0x680
// Size: 0x5c
function gadget_sensory_overload_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.sensory_overload ) )
    {
        self [[ level.cybercom.sensory_overload._is_primed ]]( slot, weapon );
    }
}

